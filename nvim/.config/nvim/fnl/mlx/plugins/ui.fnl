(local M [; {1 "glepnir/dashboard-nvim" :config (fn []
          ;      (local dashboard (require :dashboard))
          ;      (tset dashboard :custom_header {})
          ;      (tset dashboard :custom_center [
          ;         {
          ;             :icon " "
          ;             :desc "Recent                   "                   
          ;             :action "DashboardFindHistory"
          ;             :shortcut "SPC f h"
          ;         }
          ;      ])
          ;      (tset dashboard :custom_footer {})
          ; )}
          ; {1 "https://git.sr.ht/~"whynothugo/lsp_lines.nvim" :config true}
          {1 :HiPhish/rainbow-delimiters.nvim
           :config (fn [_]
                     (local rainbow (require :rainbow-delimiters.setup))
                     (rainbow.setup {:highlight ["@punctuation.bracket"
                                                 "@diff.plus"
                                                 "@diff.minus"
                                                 ; "@function"
                                                 ; "@variable"
                                                 ; "@constant"
                                                 ]
                                     :strategy {"" :rainbow-delimiters.strategy.local
                                                ; "fennel" :rainbow-delimiters.strategy.local
                                                }}))}
          ; Quite slow 
          {1 :junegunn/vim-peekaboo}
          {1 :folke/noice.nvim
           :lazy true
           :event :VeryLazy
           :dependencies [{1 :rcarriga/nvim-notify
                           :config (fn [_]
                                     (local notify (require :notify))
                                     (notify.setup {:background_colour "#000000"}))}
                          :MunifTanjim/nui.nvim]
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
                  ; :messages {:view :vsplit}
                  ; :messages {:view :mini}
                  :lsp {:progress {:enabled false}}}}
          {1 :onsails/lspkind.nvim
           :config (fn [opts]
                     (local lspkind (require :lspkind))
                     (lspkind.init {:default :symbol
                                    :mode :symbol
                                    :symbol_map {:Array "   "
                                                 :Boolean "   "
                                                 :Class "   "
                                                 :Color "   "
                                                 :Constant " 󰏿  "
                                                 :Constructor "   "
                                                 :Enum "   "
                                                 :EnumMember "   "
                                                 :Event "   "
                                                 :File "   "
                                                 :Folder "   "
                                                 :Field " 󰜢  "
                                                 :Function " 󰊕  "
                                                 :Interface "   "
                                                 :Keyword " 󰌋  "
                                                 :Method " 󰆧  "
                                                 :Namespace "   "
                                                 :Number "   "
                                                 :Module "   "
                                                 :Object "   "
                                                 :Operator " 󰆕  "
                                                 :Package "   "
                                                 :Property " 󰜢  "
                                                 :Reference " 󰈇  "
                                                 :Snippet "   "
                                                 :String "   "
                                                 :Struct " 󰙅  "
                                                 :Text "   "
                                                 :TypeParameter "   "
                                                 :Unit " 󰑭  "
                                                 ; :Value " 󰎠  "
                                                 :Value " λ  "
                                                 :Variable " 󰀫  "
                                                 ;;  ﯟ   ﯨ   פּ    
                                                 }}))}
          {1 :MeanderingProgrammer/render-markdown.nvim
           :ft [:markdown :codecompanion]}
          ; {1 :folke/snacks.nvim :opts {:indent {}}}
          ; {1 "folke/trouble.nvim"}
          ; {1 "kevinhwang91/nvim-bqf" :ft "qf"}
          ; {1 :sphamba/smear-cursor.nvim :opts {}}
          {1 :yorickpeterse/nvim-pqf :config true}
          ; {1 :chentoast/marks.nvim :config true}
          ; {1 :kevinhwang91/nvim-ufo
          ;  :dependencies [:kevinhwang91/promise-async]
          ;  :opts {:open_fold_hl_timeout 0
          ;         :provider_selector (fn [bufnr filetype buftype]
          ;                              [:treesitter :indent])}}
          ; {1 :b0o/incline.nvim :opts {
          ;       :hide {:cursorline true :focused_win false :only_win true}
          ;  }}
          ; {1 "yamatsum/nvim-nonicons"}
          ; {1 "anuvyklack/hydra.nvim"}
          ])

M
