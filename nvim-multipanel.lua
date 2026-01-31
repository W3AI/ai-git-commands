-- Multipanel Layout Setup Script
-- This script automatically arranges the Neovim interface into the desired layout

local function setup_multipanel()
  -- Wait for plugins to load
  vim.defer_fn(function()
    -- Close all windows except current
    vim.cmd("only")
    
    -- Open nvim-tree on the left
    vim.cmd("NvimTreeOpen")
    
    -- Focus back to main window (single center editor)
    vim.cmd("wincmd l")
    
    -- Open two terminal panels at the bottom using proper terminal commands
    -- Create a horizontal split at the bottom
    vim.cmd("botright split")
    vim.cmd("resize 15")
    vim.cmd("terminal")
    local term1_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(term1_buf, "Terminal 1")
    
    -- Create second terminal next to the first
    vim.cmd("vsplit")
    vim.cmd("terminal")
    local term2_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(term2_buf, "Terminal 2")
    
    -- Focus back on the main editor
    vim.cmd("wincmd k")
    
    -- Make sure we're not in nvim-tree
    if vim.bo.filetype == "NvimTree" then
      vim.cmd("wincmd l")
    end
    
    print("Multipanel layout initialized!")
    print("Use Ctrl+hjkl to navigate windows, <Esc> to exit terminal insert mode")
    print("Press <Space>q or type :qa! to quit all panels")
    print("Click the [✕ Exit] button in the top bar to quit all panels")
  end, 100)
end

-- Set up autocommand to run the layout on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
  callback = setup_multipanel,
  once = true,
})
