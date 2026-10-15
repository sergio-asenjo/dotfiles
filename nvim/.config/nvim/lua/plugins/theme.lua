local function apply_colorscheme()
  local time = tonumber(os.date("%H%M"))
  local colorscheme = (time >= 1800 or time < 800) and "tokyonight-moon" or "tokyonight-day"

  if vim.g.colors_name ~= colorscheme then
    vim.cmd.colorscheme(colorscheme)
  end
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        apply_colorscheme()

        local timer = assert(vim.uv.new_timer())
        timer:start(60000, 60000, vim.schedule_wrap(apply_colorscheme))

        vim.api.nvim_create_autocmd("VimLeavePre", {
          once = true,
          callback = function()
            timer:stop()
            timer:close()
          end,
        })
      end,
    },
  },
}
