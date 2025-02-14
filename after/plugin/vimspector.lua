-- vim.g.vimspector_enable_mappings = 'VISUAL STUDIO'

vim.keymap.set("n", "<Leader>dd", ":call vimspector#Launch()<CR>")
vim.keymap.set("n", "<Leader>de", ":call vimspector#Reset()<CR>")
vim.keymap.set("n", "<Leader>dq", ":call vimspector#Reset()<CR>")
vim.keymap.set("n", "<Leader>qd", ":call vimspector#Reset()<CR>")
vim.keymap.set("n", "<Leader>dc", ":call vimspector#Continue()<CR>")

vim.keymap.set("n", "<Leader>dt", ":call vimspector#ToggleBreakpoint()<CR>")
vim.keymap.set("n", "<Leader>dT", ":call vimspector#ClearBreakpoints()<CR>")

vim.keymap.set("n", "<Leader>dk", "<Plug>VimspectorRestart");
vim.keymap.set("n", "<Leader>dh", "<Plug>VimspectorStepOut");
vim.keymap.set("n", "<Leader>dl", "<Plug>VimspectorStepInto");
vim.keymap.set("n", "<Leader>dj", "<Plug>VimspectorStepOver");

vim.keymap.set("n", "<Leader>ds", "<Plug>VimspectorShowOutput");

vim.keymap.set("n", "<F8>", "<Plug>VimspectorStop");

-- for normal mode - the word under the cursor
vim.keymap.set("n", "<Leader>K", "<Plug>VimspectorBalloonEval")
-- for visual mode, the visually selected text
vim.keymap.set("x", "<Leader>K", "<Plug>VimspectorBalloonEval")

