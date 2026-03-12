local P = {}

function P.zig_run_floating()
	-- 1. GET FILE INFO FIRST (Before opening the float)
	local original_buf = vim.api.nvim_get_current_buf()
	local full_path = vim.api.nvim_buf_get_name(original_buf)

	-- Check if we have a valid file path
	if full_path == "" then
		vim.notify("No file path available. Please ensure the file is saved.", vim.log.levels.ERROR)
		return
	end

	-- Check if it's a Zig file
	if not full_path:match("%.zig$") then
		vim.notify("Current file is not a Zig file", vim.log.levels.ERROR)
		return
	end

	-- Check if buffer is modified and needs saving
	if vim.api.nvim_buf_get_option(original_buf, "modified") then
		local choice = vim.fn.confirm("Save before running?", "&Yes\n&No\n&Cancel", 1)
		if choice == 1 then
			vim.api.nvim_buf_call(original_buf, function()
				vim.cmd("write")
			end)
		elseif choice == 3 then
			return
		end
	end

	-- 2. CALCULATE DIMENSIONS
	local width = math.ceil(vim.o.columns * 0.8)
	local height = math.ceil(vim.o.lines * 0.8)
	local row = math.ceil((vim.o.lines - height) / 2)
	local col = math.ceil((vim.o.columns - width) / 2)

	-- 3. CREATE WINDOW
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	-- 4. PREPARE AND RUN COMMAND
	local filename = vim.fn.fnamemodify(full_path, ":t")
	local file_dir = vim.fn.fnamemodify(full_path, ":h")
	local run_command = string.format("cd %s && zig run %s", vim.fn.shellescape(file_dir), vim.fn.shellescape(filename))

	vim.fn.termopen(run_command)

	-- Keybinds for the floating terminal buffer
	vim.keymap.set("n", "q", ":close<CR>", { buffer = buf, silent = true })
	vim.keymap.set("n", "<Esc>", ":close<CR>", { buffer = buf, silent = true })

	-- Start in insert mode so you can see output immediately or interact
	vim.cmd("startinsert")
end

return P
