
(fn has-words-before []
    (global unpack (or unpack table.unpack))
    (local (line col) (unpack (vim.api.nvim_win_get_cursor 0)))
    (local lines (vim.api.nvim_buf_get_lines 0 (- line 1) line true))
    (and (not= col 0) (= (: (: (. lines 1) :sub col col) :match "%s") nil)))	

(local M [
    {1 "github/copilot.vim" }
    {1 "hrsh7th/nvim-cmp" 
        :dependencies [
            "hrsh7th/cmp-nvim-lua"
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
                        :<Tab> (cmp.mapping (fn [fallback]
                            (if (luasnip.expand_or_jumpable)
                                ;; You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                                ;; that way you will only jump inside the snippet region
                                (luasnip.expand_or_jump)
                                ;; (has-words-before) (cmp.complete)
                                (fallback))	
                            )
                            [:i :s]
                        )
                        :<S-Tab> (cmp.mapping (fn [fallback]
                                (if (luasnip.jumpable (- 1))
                                    (luasnip.jump (- 1))
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
