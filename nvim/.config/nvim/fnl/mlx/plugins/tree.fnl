(local M 
       [{1 :nvim-tree/nvim-tree.lua 
           :lazy true
           :keys [
                ["<leader>e" ":NvimTreeToggle<CR>"]
                ["<leader>l" ":NvimTreeFindFileToggle!<CR>"]
            ]
           :opts (fn [plugin opts] {
                :on_attach (fn [bufnr]
                    (local api (require :nvim-tree.api))
                    (api.config.mappings.default_on_attach bufnr)
                    (local bufopts {:noremap true :silent true :nowait true :buffer bufnr})
                    (vim.keymap.set "n" "<esc>" api.tree.close bufopts)
                    (vim.keymap.set "n" "u" api.tree.change_root_to_parent bufopts)
                    (vim.keymap.set "n" "." api.tree.change_root_to_node bufopts)
                )
                :filters { :dotfiles false :git_ignored false }
                :hijack_cursor true
                :disable_netrw true
                ;; :git {
                ;;     :enable true
                ;;     :show_on_dirs false
                ;; }
                :actions {
                    :change_dir { 
                        :global true
                        :enable true
                    }
                }
                :view {
                    ;; :side "right"
                    :width 38 
                    :float { 
                        :enable true 
                        ;; :open_win_config {
                        ;;     ;; :anchor "NE"
                        ;;     :row 50 
                        ;;     :col 50
                        ;;     :width 50
                        ;; }
                        :open_win_config (fn []
                            (local screen_w (vim.opt.columns:get))
                            (local screen_h (- (vim.opt.lines:get) (vim.opt.cmdheight:get)))
                            (local window_w (* screen_w 0.5))
                            (local window_h (* screen_h 0.62))
                            (local window_w_int (math.floor window_w))
                            (local window_h_int (math.floor window_h))
                            (local center_x (/ (- screen_w window_w) 2))
                            (local center_y (- (/ (- (vim.opt.lines:get) window_h) 2) (vim.opt.cmdheight:get)))
                            {
                                :border "rounded"
                                :relative "editor"
                                :row center_y
                                :col center_x
                                :width window_w_int
                                :height window_h_int
                            }
                        )
                    }
                }
                :renderer {
                    :icons {
                        :webdev_colors false
                        :git_placement "signcolumn"
                        :show {
                            :file true
                            ;; :folder false
                            :folder_arrow true
                            :git true
                            :modified true
                        }
                        :glyphs {
                            :git {
                                :unstaged "M"
                                :staged "S"
                                :unmerged ""
                                :renamed "➜"
                                :untracked "U"
                                :deleted ""
                                :ignored "◌"
                            }
                        }
                    }
                }
            })
           :dependencies [{1 :nvim-tree/nvim-web-devicons
                                  ;; :color_icons false
                                  }]}
            ; {1 "nvim-neo-tree/neo-tree.nvim" :dependencies [ "nvim-lua/plenary.nvim" "MunifTanjim/nui.nvim" ]}
           ])


; (local neotree (require :neo-tree))
; (neotree.setup {
;     :popup_border_style "rounded"
;     :enable_git_status false
;     :enable_diagnostics false
;     :default_component_configs {
;         :indent {
;             :with_expanders true
;             :expander_collapsed ""
;             :expander_expanded ""
;         }
;     }
;     :window {
;         :mappings {
;             "l" "open"
;             "h" "close_node"
;         }
;     }
; })


M
