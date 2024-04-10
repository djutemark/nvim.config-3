local loadplugins = vim.fn.stdpath("config") .. "/plugins.vim"
vim.cmd.source(loadplugins)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require("djutemark")

require("mason").setup()
require("mason-lspconfig").setup()

-- Set up nvim-cmp.
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
local lspOverloads = require('lsp-overloads')

local on_attach = function(client, bufnr)
	local custom_format = function()
		if vim.bo.filetype == "templ" then
			local cf_bufnr = vim.api.nvim_get_current_buf()
			local filename = vim.api.nvim_buf_get_name(cf_bufnr)
			local cmd = "templ fmt " .. vim.fn.shellescape(filename)

			vim.fn.jobstart(cmd, {
				on_exit = function()
					-- Reload the buffer only if it's still the current buffer
					if vim.api.nvim_get_current_buf() == cf_bufnr then
						vim.cmd('e!')
					end
				end,
			})
		else
			vim.lsp.buf.format()
		end
	end

	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "<leader>ff", function ()
		vim.cmd "w" -- Jag tror egentligen att jag inte vill spara, jag vill bara inte att befintliga ändringar ska förstöras. Men detta duger för tillfället.
		custom_format()
	end, opts)

  if client.server_capabilities.signatureHelpProvider then
    vim.keymap.set("n", "<A-s>", ":LspOverloadsSignature<CR>", { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("i", "<A-s>", "<esc>:LspOverloadsSignature<CR>a", { noremap = true, silent = true, buffer = bufnr })
  end

	vim.keymap.set("n", "K", vim.lsp.buf.hover)
        vim.keymap.set("n", '<leader>rn', vim.lsp.buf.rename)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
end

local lspconfig = require('lspconfig')

local servers = { 'omnisharp', 'gopls', 'templ', 'svelte', 'tsserver', 'clangd', 'sqlls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
lspconfig['html'].setup {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "templ" },
}
lspconfig['tailwindcss'].setup {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "templ", "html" },
	init_options = { userLanguages = { templ = "html" } },
}
lspconfig['lua_ls'].setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				enable = true,
				globals = {
					'vim',
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
lspconfig['htmx'].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})

vim.filetype.add({ extension = { templ = "templ" } })

require('fidget').setup({})
require('Comment').setup()
