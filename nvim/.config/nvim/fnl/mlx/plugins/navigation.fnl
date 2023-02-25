(local M [{1 :unblevable/quick-scope}
          {1 :ggandor/leap.nvim
           :config (fn [opts]
                     (local leap (require :leap))
                     (leap.set_default_keymaps))}
          {1 :tpope/vim-unimpaired}
          {1 :tpope/vim-repeat}
          {1 :bronson/vim-visual-star-search}])

M
