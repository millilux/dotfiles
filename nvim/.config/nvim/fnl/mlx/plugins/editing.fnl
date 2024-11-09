(local M [{1 :kylechui/nvim-surround :config true}
          ; {1 :windwp/nvim-autopairs
          ;  :lazy true
          ;  :event :InsertEnter
          ;  :config true}
          ; {1 :windwp/nvim-autopairs
          ;  :lazy true
          ;  :event :InsertEnter
          ;  :opts {:check_ts true
          ;         ; :enable_check_bracket_line false
          ;         :disable_filetype [:TelescopePrompt
          ;                            :vim
          ;                            :fennel
          ;                            :clojure
          ;                            :lisp
          ;                            :scheme]}
          ;  :config (fn [plugin opts]
          ;            (local cmp_autopairs
          ;                   (require :nvim-autopairs.completion.cmp))
          ;            (local cmp (require :cmp))
          ;            (cmp.event:on :confirm_done
          ;                          (cmp_autopairs.on_confirm_done))
          ;            (local autopairs (require :nvim-autopairs))
          ;            (autopairs.setup opts))}
          {1 :mg979/vim-visual-multi}
          {1 :stevearc/conform.nvim
           :keys [{1 :<leader>cf
                   2 (fn []
                       ((. (require :conform) :format) {:lsp_fallback true}))
                   :desc :Format}]
           :opts {:formatters_by_ft {:fennel [:fnlfmt]
                                     :yaml [:prettier]
                                     :json [:jq]
                                     :sh [:shfmt]}}}
          ; {1 :Pocco81/auto-save.nvim}
          ; {1 :smoka7/multicursors.nvim
          ;  :event :VeryLazy
          ;  :dependencies [:nvim-treesitter/nvim-treesitter :smoka7/hydra.nvim]
          ;  :opts {}
          ;  :cmd [:MCstart
          ;        :MCvisual
          ;        :MCclear
          ;        :MCpattern
          ;        :MCvisualPattern
          ;        :MCunderCursor]
          ;  :keys [{1 :<Leader>m
          ;          2 :<cmd>MCstart<cr>
          ;          :desc "Create a selection for selected text or word under the cursor"
          ;          :mode [:v :n]}]}
          ; {1 :gpanders/nvim-parinfer} ; auto formats and does some weird indenting with tables
          {1 :julienvincent/nvim-paredit
           :ft [:fennel :clojure :lisp :racket :scheme :janet :guile]
           :config (fn []
                     ((. (require :nvim-paredit) :setup)))}
          ; {1 :guns/vim-sexp
          ;  :ft [:fennel :clojure :lisp :racket :scheme :janet :guile]
          ;  :config (tset vim.g :sexp_filetypes
          ;                "clojure,scheme,lisp,timl,fennel,janet,hy")}
          {1 :mbbill/undotree
           :lazy true
           :keys [[:<leader>u ":UndotreeToggle<CR>"]]}])

M
