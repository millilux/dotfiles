
(fn has-words-before []
    (global unpack (or unpack table.unpack))
    (local (line col) (unpack (vim.api.nvim_win_get_cursor 0)))
    (local lines (vim.api.nvim_buf_get_lines 0 (- line 1) line true))
    (and (not= col 0) (= (: (: (. lines 1) :sub col col) :match "%s") nil)))	

(local M [
    {1 "hrsh7th/nvim-cmp" :dependencies [
        "hrsh7th/cmp-nvim-lua"
        "hrsh7th/cmp-nvim-lsp"
        "hrsh7th/cmp-buffer"
        "hrsh7th/cmp-path"
        "saadparwaiz1/cmp_luasnip"
        "L3MON4D3/LuaSnip"
        "rafamadriz/friendly-snippets"
    ]
    :config (fn []
            (local cmp (require :cmp))
            (local lspkind (require :lspkind))
            (local luasnip (require :luasnip))
            (let [loader (require :luasnip.loaders.from_vscode)]
                (loader.lazy_load)) 

            (cmp.setup {
                :snippet {
                    :expand (fn [args]
                                (luasnip.lsp_expand args.body))
                }
                :window {
                    :completion (cmp.config.window.bordered)
                }
                :sources (cmp.config.sources 
                            [{:name :luasnip} {:name :nvim_lsp} {:name :nvim_lua}]
                            [{:name :buffer} {:name :path}])	
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

                    ;; formatting = {
                    ;;     fields = { 'kind', 'abbr' },
                    ;;     format = lspkind.cmp_format({
                    ;;         mode = 'symbol', -- show only symbol annotations
                    ;;         -- preset = 'codicons' requires vscode-codicons font
                    ;;         -- maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ;;         symbol_map = {
                    ;;             Class = '',
                    ;;         }
                    ;;
                    ;;         -- ﯟ   ﯨ   פּ
                    ;;
                    ;;
                    ;;         -- The function below will be called before any actual modifications from lspkind
                    ;;         -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    ;;         -- before = function (entry, vim_item)
                    ;;         --   vim_item.kind = ' ' .. vim_item.kind
                    ;;         --   vim_item.abbr = (vim_item.abbr or '') .. ' '
                    ;;         --   -- vim_item.menu = (vim_item.menu or '') .. ' '
                    ;;         --   return vim_item
                    ;;         -- end
                    ;;     })
                    ;; }
                })
            })
    )}
])

;; TODO
;; -- Set configuration for specific filetype.
;; cmp.setup.filetype('gitcommit', {
;;     sources = cmp.config.sources({
;;         { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
;;     }, {
;;         { name = 'buffer' },
;;     })
;; })
;;
;; -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
;; cmp.setup.cmdline({ '/', '?' }, {
;;     mapping = cmp.mapping.preset.cmdline(),
;;     sources = {
;;         { name = 'buffer' }
;;     }
;; })
;;
;; -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
;; cmp.setup.cmdline(':', {
;;     mapping = cmp.mapping.preset.cmdline(),
;;     sources = cmp.config.sources({
;;         { name = 'path' }
;;     }, {
;;         { name = 'cmdline' }
;;     })
;; })
;;
(print "Completion")

M
