(local M
       [{1 :kristijanhusak/vim-dadbod-ui
         :lazy true
         :cmd [:DBUI :DBUIToggle :DBUIAddConnection :DBUIFindBuffer]
         :init (fn []
                 (tset vim.g :db_ui_show_help 0)
                 (tset vim.g :db_ui_use_nerd_fonts 1)
                 (tset vim.g :db_ui_win_position :right))
         :dependencies [{1 :tpope/vim-dadbod :lazy true}
                        {1 :kristijanhusak/vim-dadbod-completion
                         :lazy true
                         :ft [:sql :mysql :plsql]
                         :init (fn []
                                 (vim.api.nvim_create_autocmd :FileType
                                                              {:desc "Dadbod Completion"
                                                               :group (vim.api.nvim_create_augroup :dadbod-completion
                                                                                                   {:clear true})
                                                               :pattern [:sql
                                                                         :mysql
                                                                         :plsql]
                                                               :callback (fn []
                                                                           (local cmp
                                                                                  (require :cmp))
                                                                           (cmp.setup.buffer {:sources [{:name :vim-dadbod-completion}]}))}))}]}])

M

