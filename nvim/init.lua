-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
require("matwa-conf")
require("lazy").setup("plugins")

-- Utility: open a floating window with given content
local function open_float(content)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))

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

  -- Map <Esc> in the float to close it
  vim.keymap.set("n", "<Esc>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true })
end

-- Run a shell command and show results in floating window
local function run_quick(cmd)
  local handle = io.popen(cmd)
  if not handle then return end
  local result = handle:read("*a")
  handle:close()
  open_float(result)
end

-- Run quick on current file (full path)
vim.keymap.set("n", "<leader>Q", function()
  local file = vim.fn.expand("%")
  run_quick("quick run " .. file)
end, { desc = "Quick: Run tests for current file" })

-- Run quick in strict mode (filename only)
vim.keymap.set("n", "<leader>S", function()
  local fname = vim.fn.expand("%:t")  -- just filename.py
  run_quick("quick run --strict " .. fname)
end, { desc = "Quick: Run tests (strict) for current file" })

-- Prompt for testcase creation
vim.keymap.set("n", "<leader>C", function()
  local n = vim.fn.input("Number of testcases: ")
  if n ~= "" then
    local fname = vim.fn.input("Filename (leave empty for default): ")
    local cmd = "quick create " .. n
    if fname ~= "" then
      cmd = cmd .. " " .. fname
    end
    run_quick(cmd)
  end
end, { desc = "Quick: Create new testcases" })

