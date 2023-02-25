(local M [
    {1 "mfussenegger/nvim-dap" 
    :config (fn [opts]
        (local dap (require :dap))
        (local dapui (require :dapui))

        (fn focus_float [ element ]
            (dapui.float_element element { :enter true })
        )

        (vim.keymap.set "n" "<F9>" dap.continue)
        (vim.keymap.set "n" "<F10>" dap.step_over)
        (vim.keymap.set "n" "<F11>" dap.step_into)
        (vim.keymap.set "n" "<F12>" dap.step_out)
        (vim.keymap.set "n" "<Leader>x" dap.toggle_breakpoint)
        (vim.keymap.set "n" "<Leader>X" (fn [] (dap.set_breakpoint (vim.fn.input "Condition: "))))
        ;; nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
        ;; (vim.keymap.set "n" "<Leader>dr" dap.repl.toggle)
        (vim.keymap.set "n" "<Leader>du" dapui.toggle)
        (vim.keymap.set "n" "<Leader>dc" (fn [] (focus_float "console")))
        (vim.keymap.set "n" "<Leader>dr" (fn [] (focus_float "repl")))
        (vim.keymap.set "n" "<Leader>dv" (fn [] (focus_float "scopes")))
        (vim.keymap.set "n" "<Leader>ds" (fn [] (focus_float "stacks")))
        (vim.keymap.set "n" "<Leader>de" (fn [] (focus_float "expressions")))
        (vim.keymap.set "n" "<Leader>dw" (fn [] (focus_float "watches")))
        ;; nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

        (tset dap.listeners.after.event_initialized "dapui_config" (fn [] (dapui.open)))
        (tset dap.listeners.before.event_terminated "dapui_config" (fn [] (dapui.close)))
        (tset dap.listeners.before.event_exited "dapui_config" (fn [] (dapui.close)))
    )
    :dependencies [
        {1 "rcarriga/nvim-dap-ui" :opts {
            :layouts [
                ;; {
                ;;     :elements [
                ;;         "repl"
                ;;         "console"
                ;;     ]
                ;;     :size 0.1 ;; % of total lines
                ;;     :position "bottom"
                ;; }
                {
                    :elements [
                    ;; Elements can be strings or table with id and size keys.
                        { :id "scopes" :size 0.25 }
                        "breakpoints"
                        "stacks"
                        "watches"
                    ]
                    :size 40 ;; Columns
                    :position "right"
                }
            ]
            ;; :controls {
            ;;     :element "console"
            ;; }
            :render {
                :max_value_lines 3
            }
        }}

        {1 "mfussenegger/nvim-dap-python" :config (fn [opts]
            (local dap-python (require :dap-python))
            (local dap (require :dap))
            (dap-python.setup "~/.virtualenvs/debugpy/bin/python")
            (table.insert dap.configurations.python {
                    :type :python
                    :request :attach
                    :name "Docker"
                    :connect { :port 5678 :host "127.0.0.1" }
                    :mode :remote
                    ;; :cwd (vim.fn.getcwd)
                    :pathMappings [{:localRoot (vim.fn.getcwd)
                                    :remoteRoot "/athena/backend"}]})
                    ;; :program "${file}"})	

        )}

        {1 "theHamsta/nvim-dap-virtual-text" :config true}

    ]

    }
])

(fn attach_python_debugger [args]
       (let [dap (require :dap)
             host (. args 1)
             port 5678]
         (global python-attach-adapter
                 {:type :server : host :port port})
         (global python-attach-config
                 {:type :python
                  :request :attach
                  :connect {:port port : host}
                  :mode :remote
                  :name "Remote Attached Debugger"
                  :cwd (vim.fn.getcwd)
                  :pathMappings [{:localRoot (vim.fn.getcwd)
                                  :remoteRoot :/usr/src/app}]})
         (local session (dap.attach host (tonumber 5) python-attach-config))
         (when (= session nil)
           (io.write "Error launching adapter"))
         (dap.repl.open)))	
M
