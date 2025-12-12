-- Keymaps configuration for various features
-- This replaces the keymaps that were previously in which-key

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>ol", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open linting notifications" })
vim.keymap.set("n", "<leader>gf", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format code" })

-- Explorer keymaps (using snacks now)

-- Manim + Manim Slides helpers using uv
local MANIM = "uv run manim"
local SLIDES = "uv run manim-slides"

local function open_float(content)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content or "", "\n"))
	local width = math.floor(vim.o.columns * 0.7)
	local height = math.floor(vim.o.lines * 0.7)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
	vim.keymap.set("n", "<Esc>", function()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end, { buffer = buf, nowait = true })
end

local function run_popen(cmd)
	local handle = io.popen(cmd)
	if not handle then
		vim.notify("Failed to run: " .. cmd, vim.log.levels.ERROR)
		return
	end
	local result = handle:read("*a") or ""
	handle:close()
	open_float(result)
end

local function term_run(cmd)
	vim.cmd("vsplit | terminal " .. cmd)
	vim.cmd("startinsert")
end

local function buf_scenes()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local scenes = {}
	for _, l in ipairs(lines) do
		local name, bases = l:match("^class%s+([%w_]+)%s*%(([%w_,%s]+)%)%s*:")
		if name and bases and (bases:match("Scene") or bases:match("Slide")) then
			table.insert(scenes, name)
		end
	end
	return scenes
end

local function choose_scene(cb)
	local scenes = buf_scenes()
	if #scenes == 0 then
		vim.notify("No Scene/Slide class found in this buffer", vim.log.levels.WARN)
		return
	elseif #scenes == 1 then
		cb(scenes[1])
	else
		vim.ui.select(scenes, { prompt = "Select Scene/Slide to run" }, function(choice)
			if choice then cb(choice) end
		end)
	end
end

local function preview_lq()
	choose_scene(function(scene)
		local file = vim.fn.expand("%:p")
		local cmd = ("%s -p -ql %s %s"):format(MANIM, vim.fn.shellescape(file), vim.fn.shellescape(scene))
		run_popen(cmd)
	end)
end

local function render_hq()
	choose_scene(function(scene)
		local file = vim.fn.expand("%:p")
		local cmd = ("%s -qh %s %s"):format(MANIM, vim.fn.shellescape(file), vim.fn.shellescape(scene))
		run_popen(cmd)
	end)
end

local function slides_hq_then_start()
	choose_scene(function(scene)
		local file = vim.fn.expand("%:p")
		local render_cmd = ("%s render -qh %s %s"):format(SLIDES, vim.fn.shellescape(file), vim.fn.shellescape(scene))
		run_popen(render_cmd)
		local start_cmd = ("%s %s"):format(SLIDES, vim.fn.shellescape(scene))
		term_run(start_cmd)
	end)
end

local function insert_below(text)
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, row, row, true, { text })
end

local function insert_next_slide()
	insert_below("self.next_slide()")
end

local function insert_next_slide_loop()
	insert_below("self.next_slide(loop=True)")
end
-- Refactoring Keymaps: LSP Rename and ThePrimeagen/refactoring.nvim

-- Set up LSP Rename (Normal Mode)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true, desc = '[R]ename Symbol (LSP)' })

-- Set up ThePrimeagen/refactoring.nvim keymaps
-- Note: This requires the plugin to be installed and loaded successfully.
-- The commands use require('refactoring').<function>()

-- Visual Mode Mappings (Used for extracting code blocks)
vim.api.nvim_set_keymap('x', '<leader>xf', "<cmd>lua require('refactoring').extract_function()<CR>", { noremap = true, silent = true, desc = 'e[X]tract [F]unction' })
vim.api.nvim_set_keymap('x', '<leader>xv', "<cmd>lua require('refactoring').extract_variable()<CR>", { noremap = true, silent = true, desc = 'e[X]tract [V]ariable' })
vim.api.nvim_set_keymap('x', '<leader>xc', "<cmd>lua require('refactoring').extract_constant()<CR>", { noremap = true, silent = true, desc = 'e[X]tract [C]onstant' })

-- Normal Mode Mappings (Used for inlining, cursor over the symbol)
vim.api.nvim_set_keymap('n', '<leader>fi', "<cmd>lua require('refactoring').inline_function()<CR>", { noremap = true, silent = true, desc = '[F]unction [I]nline' })
vim.api.nvim_set_keymap('n', '<leader>vi', "<cmd>lua require('refactoring').inline_variable()<CR>", { noremap = true, silent = true, desc = '[V]ariable [I]nline' })


vim.keymap.set("n", "<leader>rm", function()
  require("reader_mode").toggle()
end, { desc = "Toggle Reader Mode" })


vim.keymap.set("n", "<leader>ci", "<CMD>Telescope hierarchy incoming_calls<CR>", { desc = "Incoming Calls Hierarchy" })
vim.keymap.set("n", "<leader>co", "<CMD>Telescope hierarchy outgoing_calls<CR>", { desc = "Outgoing Calls Hierarchy" })
