(local M [{1 :nvim-neotest/neotest
           :opts (fn [_ _]
                   (local neotest-python (require :neotest-python))
                   (local adapters
                          [(neotest-python {:dap {:justMyCode false}})])
                   {: adapters})
           :dependencies [:nvim-lua/plenary.nvim
                          :nvim-neotest/nvim-nio
                          :nvim-treesitter/nvim-treesitter
                          :nvim-neotest/neotest-python
                          :antoinemadec/FixCursorHold.nvim]}])

M

