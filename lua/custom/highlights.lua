--Removes background from themes
local _hi_overrides = {
  defaults = {
    Normal = { 'guibg=#000000' },
    NormalNC = { 'guibg=#000000' },
  },
  oxocarbon = {
    Comment = {"guifg=#de95ff"}
    -- Comment = { 'guifg=#fcb5c6' },
  },
}

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    if not vim.g.transparent then
      return nil
    end

    for highlight, value in pairs(_hi_overrides['defaults']) do
      vim.cmd.highlight(highlight, table.unpack(value))
    end

    local c = vim.g.colors_name

    if _hi_overrides[c] ~= nil then
      for highlight, value in pairs(_hi_overrides[c]) do
        vim.cmd.highlight(highlight, table.unpack(value))
      end
    end
  end,
})
