(local M [
          {1 :ibhagwan/fzf-lua :opts {
            :fzf_colors true
            :defaults {
              :formatter "path.filename_first"            
            }
            :grep {
                :prompt "   "
                ; rg honours global gitignore?
                :rg_opts "--column --no-heading --color=always --smart-case --hidden --max-columns=4096 --line-number --glob='!{.git,node_modules,.mypy_cache}' -e"
                :hidden true
                :fzf_opts {
                    :--history (.. (vim.fn.stdpath "data") "/fzf-lua-history")
                    :--delimiter ":"
                    ; :--nth "..2"
                    ; :--with-nth "1"
                }
            }
            :files {
                ; :path_shorten true
                :cwd_prompt false
                :fd_opts "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude .mypy_cache"
                ; :cmd "rg --files --color=never --follow --hidden --glob='!{.git,node_modules,.mypy_cache}'"
            }
            :previewers {
                :builtin {
                    :extensions {
                        "gif" :chafa
                        "png" :chafa
                        "jpg" :chafa
                        "jpeg" :chafa
                    }
                }
            }
            :winopts {
              :preview {
                  :layout :vertical
              }
              ; :border "none"
            }
          }}
          ; {1 :nvim-telescope/telescope.nvim
          ;  :config (fn [opts]
          ;   (local telescope (require :telescope))
          ;   (local actions (require :telescope.actions))
          ;   (telescope.setup {
          ;    :defaults {
          ;       :prompt_prefix "   "
          ;       :selection_caret "  "
          ;       :sorting_strategy :ascending
          ;       :prompt_title false 
          ;       :results_title false
          ;       :dynamic_preview_title true
          ;       :path_display [:smart]
          ;       :file_ignore_patterns [
          ;           ".git"
          ;           "__pycache__"
          ;           "node_modules"
          ;           "dist"
          ;       ]
          ;       :layout_config {
          ;           :horizontal {:prompt_position :top :preview_width 0.55} 
          ;           ;; :vertical {:mirror false}
          ;       }
          ;       :mappings {
          ;           :i {
          ;               "<ESC>" actions.close
          ;               "<C-u>" false
          ;               "<C-f>" actions.to_fuzzy_refine
          ;           }
          ;       }
          ;    }
          ;    :pickers {
          ;       :find_files {
          ;          :prompt_title false 
          ;       }
          ;       :live_grep {
          ;          :prompt_title false 
          ;       }
          ;    }
          ;    :extensions {
          ;       :fzf {
          ;           :fuzzy true ;; false will only do exact matching
          ;           :override_generic_sorter true ;; override the generic sorter
          ;           :override_file_sorter true ;; override the file sorter
          ;           :case_mode "smart_case" ;; or "ignore_case" or "respect_case"
          ;           ;; the default case_mode is "smart_case"
          ;       }
          ;    }
          ;  }
          ;  ))
          ;  :dependencies [:nvim-lua/plenary.nvim
          ;                 {1 :nvim-telescope/telescope-fzf-native.nvim
          ;                  :build :make :init (fn [plugin]
          ;                       (local telescope (require :telescope))
          ;                       (telescope.load_extension "fzf")
          ;                  )}]}

           ])

M

