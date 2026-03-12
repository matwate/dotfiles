vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Center screen after half-page down
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Center screen after half-page up
vim.keymap.set("n", "<C-n>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Keybind: <leader>zr (Zig Run)
local zig_run_floating = require("config.ziglings").zig_run_floating
vim.keymap.set("n", "<leader>zr", zig_run_floating, { desc = "Run current Zigling exercise" })

vim.keymap.set("n", "<leader>ci", function()
	Snacks.input({
		prompt = "Compile command: ",
		-- Default to the last run command if available
		value = vim.g.compile_command or "make -k ",
	}, function(value)
		if value and value ~= "" then
			vim.cmd("Compile " .. value)
		end
	end)
end, { desc = "Compile with Input" })

local function compile_picker()
	local commands = {
		{ text = "(Zig) Run ", cmd = " zig build run " },
		{ text = "(Zig) Run Optimized", cmd = "zig build run -Doptimize=ReleaseFast" },
	}

	Snacks.picker({
		title = "Compile Commands",
		items = commands,
		layout = "select",
		-- Add this format function to tell the picker what to display
		format = function(item)
			return { { item.text, "SnacksPickerText" } }
		end,
		confirm = function(picker, item)
			picker:close()
			if item then
				vim.cmd("Compile " .. item.cmd)
			end
		end,
	})
end

vim.keymap.set("n", "<leader>cp", compile_picker, { desc = "Pick Compile Command" })
vim.keymap.set("n", "<leader>cr", "<cmd>Recompile<cr>", { desc = "Recompile" })
vim.keymap.set("n", "]e", "<cmd>NextError<cr>", { desc = "Next Compile Error" })
vim.keymap.set("n", "[e", "<cmd>PrevError<cr>", { desc = "Prev Compile Error" })
