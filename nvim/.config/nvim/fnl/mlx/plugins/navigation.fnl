(local M [{1 :unblevable/quick-scope}
          ; {1 :ggandor/leap.nvim
          ;  :config (fn [opts]
          ;            (local leap (require :leap))
          ;            (leap.add_default_mappings))}
          {1 :tpope/vim-repeat}
          {1 :folke/flash.nvim
           :lazy true
           ; Char mode enables flash for f F t T ; and , motions
           :opts {:highlight {:matches false}
                  :label {:after false
                          :before true
                          ; :style :inline
                          :rainbow {:enabled false}}
                  :modes {:char {:enabled false}}}}
          {1 :bronson/vim-visual-star-search}])

M

