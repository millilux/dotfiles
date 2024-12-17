
(fn has-words-before []
    (global unpack (or unpack table.unpack))
    (local (line col) (unpack (vim.api.nvim_win_get_cursor 0)))
    (local lines (vim.api.nvim_buf_get_lines 0 (- line 1) line true))
    (and (not= col 0) (= (: (: (. lines 1) :sub col col) :match "%s") nil)))	

(local M [
    {1 "github/copilot.vim" }
    {1 "CopilotC-Nvim/CopilotChat.nvim"
     :config true
     :opts {
      :question_header "❯ " 
      :answer_header "🤖 "
      ; :window { :layout :float :border :none}        
      ; :auto_insert_mode true
      :selection (fn [] nil)
      :show_help false
      :mappings {
        :complete {
          :insert "" ; For some reason, this fixes tab completion
        }
      }
    }
    :dependencies [ 
      "github/copilot.vim"
      "nvim-lua/plenary.nvim"
    ]}
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
                    :snippet {
                        :expand (fn [args]
                                    (luasnip.lsp_expand args.body))
                    }
                    ; :window {
                    ;     :completion (cmp.config.window.bordered)
                    ; }
                    :sources (cmp.config.sources 
                                [{:name :luasnip} {:name :nvim_lsp} {:name :nvim_lua}]
                                [{:name :buffer} {:name :path}])	
                    :formatting {
                        :fields {1 :kind 2 :abbr 3 :menu}
                        :format (lspkind.cmp_format {
                            :mode :symbol
                        ;     -- preset = 'codicons' requires vscode-codicons font
                            :ellipsis_char "..."
                            :maxwidth 30 
                        })
                    }
                    :mapping (cmp.mapping.preset.insert {
                        :<C-b> (cmp.mapping.scroll_docs -4)
                        :<C-f> (cmp.mapping.scroll_docs 4)
                        :<C-Space> (cmp.mapping.complete)
                        :<C-e> (cmp.mapping.abort)
                        :<CR> (cmp.mapping.confirm { :select true })
                        :<C-n> (cmp.mapping (fn [fallback]
                                (if (luasnip.locally_jumpable 1) (luasnip.jump 1)
                                    (fallback)))
                            [:i :s]
                        )
                        :<C-p> (cmp.mapping (fn [fallback]
                                (if (luasnip.locally_jumpable -1) (luasnip.jump -1)
                                    (fallback)))
                                [:i :s])	
                    })
                })
                ; (cmp.setup.cmdline [":" {
                ;             :mapping (cmp.mapping.preset.cmdline)
                ;             :sources (cmp.config.sources { :name "path" })}])
    )}
])

M
