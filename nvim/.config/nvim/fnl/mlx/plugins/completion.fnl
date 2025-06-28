(fn has-words-before []
    (global unpack (or unpack table.unpack))
    (local (line col) (unpack (vim.api.nvim_win_get_cursor 0)))
    (local lines (vim.api.nvim_buf_get_lines 0 (- line 1) line true))
    (and (not= col 0) (= (: (: (. lines 1) :sub col col) :match "%s") nil)))	

(local M [
    {1 :olimorris/codecompanion.nvim
      :opts {}
      :dependencies ["nvim-lua/plenary.nvim"
                    "nvim-treesitter/nvim-treesitter"]}
    ; {1 "zbirenbaum/copilot.lua" :config true}
    ; {1 "CopilotC-Nvim/CopilotChat.nvim"
    ;  :config true
    ;  ; :build "make tiktoken"
    ;  :opts {
    ;    :question_header "❯ " 
    ;    :answer_header "🤖 "
    ;    ; :window { :layout :float :border :none}        
    ;    ; :auto_insert_mode true
    ;    ; :selection (fn [] nil)
    ;    :show_help false
    ;    :mappings {
    ;      :complete {
    ;        ; :insert "" ; For some reason, this fixes tab completion
    ;      }
    ;    }
    ;  }
    ;  :dependencies [ 
    ;     "zbirenbaum/copilot.lua"
    ;     "nvim-lua/plenary.nvim"
    ; ]}
    ; {1 :yetone/avante.nvim
    ;   ;; if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    ;   ;; ⚠️ must add this setting! ! !
    ;   :build (fn []
    ;           ;; conditionally use the correct build system for the current OS
    ;           (if (= (vim.fn.has :win32) 1)
    ;               "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    ;               :make))
    ;   :event :VeryLazy
    ;   :version false
    ;   ;; Never set this value to "*"! Never!
    ;   :opts {:provider :copilot
    ;         :providers {:claude {:endpoint "https://api.anthropic.com"
    ;                               :model :claude-sonnet-4-20250514
    ;                               :timeout 30000
    ;                               :extra_request_body {:temperature 0.75
    ;                                                   :max_tokens 20480}}}}
    ;   :dependencies [:nvim-lua/plenary.nvim
    ;                 :MunifTanjim/nui.nvim
    ;                 ;; The below dependencies are optional,
    ;                 :hrsh7th/nvim-cmp
    ;                 :ibhagwan/fzf-lua
    ;                 :folke/snacks.nvim
    ;                 :nvim-tree/nvim-web-devicons
    ;                 :zbirenbaum/copilot.lua
    ;                 {1 :HakonHarnes/img-clip.nvim
    ;                   :event :VeryLazy
    ;                   :opts {:default {:embed_image_as_base64 false
    ;                                   :prompt_for_file_name false
    ;                                   :drag_and_drop {:insert_mode true}
    ;                                   :use_absolute_path true}}}
    ;                 {1 :MeanderingProgrammer/render-markdown.nvim
    ;                   :opts {:file_types [:markdown :Avante]}
    ;                   :ft [:markdown :Avante]}]}

    ; Very WIP
    ; {1 :saghen/blink.cmp
    ; ; optional: provides snippets for the snippet source
    ; :dependencies ["rafamadriz/friendly-snippets"]
    ; :version "1.*"
    ; :opts
    ; {:keymap {:preset "default"} 
    ;   ; :appearance {:nerd_font_variant "mono"} ; 'mono' for 'Nerd Font Mono'
    ;   :completion {:documentation {:auto_show false} :menu {:draw { 
    ;                                                                :padding [1 1]
    ;                                                                :columns [ {1 "kind_icon" 2 "label" :gap 5} ]}}} ; Only show the documentation popup when manually triggered
    ;   :sources {:default ["lsp" "path" "snippets" "buffer"]} ; Default list of enabled providers
    ;   :fuzzy {:implementation "prefer_rust_with_warning"}} ; Rust fuzzy matcher for typo resistance
    ;   :opts_extend ["sources.default"]}
    {1 "hrsh7th/nvim-cmp" 
        :dependencies [
            {1 "binhtran432k/cmp-nvim-lua" :branch "feature/fennel"}
            "hrsh7th/cmp-nvim-lsp"
            "hrsh7th/cmp-buffer"
            "hrsh7th/cmp-path"
            "hrsh7th/cmp-cmdline"
            "saadparwaiz1/cmp_luasnip"
            "L3MON4D3/LuaSnip"
            "rafamadriz/friendly-snippets"
            "onsails/lspkind.nvim"
        ]
        :lazy true
        :event [:InsertEnter :CmdLineEnter]
        :config (fn []
                (local cmp (require :cmp))
                (local luasnip (require :luasnip))
                (local lspkind (require :lspkind))
                (let [loader (require :luasnip.loaders.from_vscode)]
                    (loader.lazy_load)
                    (loader.lazy_load {:paths ["./snippets"]})) 
                (cmp.setup {
                    :sources (cmp.config.sources 
                                [{:name :luasnip} {:name :nvim_lsp} {:name :nvim_lua}]
                                [{:name :buffer} {:name :path}])
                    :snippet {
                        :expand (fn [args]
                                    (luasnip.lsp_expand args.body))
                    }
                    ; :window {
                    ;     :completion (cmp.config.window.bordered)
                    ; }
                    :formatting {
                        :fields {1 :kind 2 :abbr 3 :menu}
                        :format (lspkind.cmp_format {
                            :mode :symbol
                        ;     -- preset = 'codicons' requires vscode-codicons font
                            :ellipsis_char "..."
                            :maxwidth 32 
                        })
                    }
                    :mapping (cmp.mapping.preset.insert {
                        :<C-b> (cmp.mapping.scroll_docs -4)
                        :<C-f> (cmp.mapping.scroll_docs 4)
                        :<C-Space> (cmp.mapping.complete)
                        :<C-e> (cmp.mapping.abort)
                        :<CR> (cmp.mapping.confirm { :select true })
                        ; Messes with Copilot?
                        ; :<C-n> (cmp.mapping (fn [fallback]
                        ;         (if (luasnip.locally_jumpable 1) (luasnip.jump 1)
                        ;             (fallback)))
                        ;     [:i :s]
                        ; )
                        ; :<C-p> (cmp.mapping (fn [fallback]
                        ;         (if (luasnip.locally_jumpable -1) (luasnip.jump -1)
                        ;             (fallback)))
                        ;         [:i :s])	
                    })
                })
                ; (cmp.setup.cmdline [":" {
                ;             :mapping (cmp.mapping.preset.cmdline)
                ;             :sources (cmp.config.sources { :name "path" })}])
    )}
])

M
