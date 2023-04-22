(require :mlx.options)

(let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system [:git
                    :clone
                    "--filter=blob:none"
                    :--single-branch
                    "https://github.com/folke/lazy.nvim.git"
                    lazypath]))
  (vim.opt.runtimepath:prepend lazypath))

(local lazy (require :lazy))
(lazy.setup [{:import :mlx.plugins}])

(require :mlx.keymaps)
(require :mlx.ui)

