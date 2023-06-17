(local M [{1 :junegunn/fzf}
          {1 :ibhagwan/fzf-lua :opts {
            ; :fzf_opts {
                ; :--delimiter ":"
                ; :--nth 1
                ; :--with-nth 1
            ; }
            :previewer {
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
                :border "none"
            }
          }}
          ;; {1 :junegunn/fzf.vim}
          ;; {1 :fanto/fzf-lsp.nvim}
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

