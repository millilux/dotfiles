(require :mlx.options)
(require :mlx.statusline)

(let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system [:git
                    :clone
                    "--filter=blob:none"
                    :--single-branch
                    "https://github.com/folke/lazy.nvim.git"
                    lazypath]))
  (vim.opt.runtimepath:prepend lazypath))

(let [lazy (require :lazy)]
  (lazy.setup :mlx.plugins))

(require :mlx.keymaps)
(require :mlx.ui)

(global P (fn [value]
            (print (vim.inspect value))
            (value)))

