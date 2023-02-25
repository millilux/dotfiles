(local M [;; "markonm/traces.vim"     ;; Highlight patterns & ranges in ex commands in commandline mode
          ;; {1 "glepnir/dashboard-nvim" :config (fn []
          ;;      (local dashboard (require :dashboard))
          ;;      (tset dashboard :custom_header {})
          ;;      (tset dashboard :custom_center [
          ;;         {
          ;;             :icon " "
          ;;             :desc "Recent                   "                   
          ;;             :action "DashboardFindHistory"
          ;;             :shortcut "SPC f h"
          ;;         }
          ;;      ])
          ;;      (tset dashboard :custom_footer {})
          ;; )}
          ;; {1 "nvim-lualine/lualine.nvim" :config { :theme "auto"}}
          ;; {1 "lukas-reineke/indent-blankline.nvim" }
          ;; {1 "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }
          {1 :folke/noice.nvim
           :dependencies [:rcarriga/nvim-notify :MunifTanjim/nui.nvim]
           :opts {:presets {:bottom_search true
                            ;; use a classic bottom cmdline for search
                            ;; :command_palette true ;; position the cmdline and popupmenu together
                            :long_message_to_split true
                            ;; long messages will be sent to a split
                            :inc_rename false
                            ;; enables an input dialog for inc-rename.nvim
                            :lsp_doc_border false
                            ;; add a border to hover docs and signature help
                            }
                  :cmdline {:view :cmdline}
                  :messages {:view :mini}
                  :lsp {:progress {:enabled false}}}}
          ;; {1 "folke/trouble.nvim"}
          {1 :onsails/lspkind.nvim}
          ;; {1 "kevinhwang91/nvim-bqf" :ft "qf"}
          ;; {1 "yamatsum/nvim-nonicons"}
          ;; {1 "anuvyklack/hydra.nvim"}
])

M
