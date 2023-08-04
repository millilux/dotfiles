(local M [{1 :kylechui/nvim-surround :config true}
          {1 :windwp/nvim-autopairs
           :opts {:check_ts true
                  ; :enable_check_bracket_line false
                  :disable_filetype [:TelescopePrompt
                                     :vim
                                     :fennel
                                     :clojure
                                     :lisp
                                     :scheme]}
           :config (fn [plugin opts]
                     (local cmp_autopairs
                            (require :nvim-autopairs.completion.cmp))
                     (local cmp (require :cmp))
                     (cmp.event:on :confirm_done
                                   (cmp_autopairs.on_confirm_done))
                     (local autopairs (require :nvim-autopairs))
                     (autopairs.setup opts))}
          {1 :junegunn/vim-peekaboo}
          {1 :guns/vim-sexp
           :ft [:fennel :clojure :lisp :racket :scheme :janet :guile]
           :config (tset vim.g :sexp_filetypes
                         "clojure,scheme,lisp,timl,fennel,janet,hy")}
          {1 :mbbill/undotree}])

M

