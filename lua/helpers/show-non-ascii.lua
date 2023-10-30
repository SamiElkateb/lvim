-- vim.api.nvim_create_user_command(
--   'ShowNonAscii',
--   function()
--     -- Define a new highlight group for the non-ASCII search
--     vim.api.nvim_command('highlight NonAsciiSearch ctermbg=yellow guibg=yellow')

--     -- Use the search command to look for non-ASCII characters and apply the highlight, suppressing any errors
--     vim.api.nvim_command('silent! /[^\\x00-\\x7F]/')

--     -- Set the highlight group for the search
--     vim.api.nvim_command('set hlsearch')
--     vim.api.nvim_command('set hls')
--     
--     -- Apply the `NonAsciiSearch` highlight group to the non-ASCII characters in the buffer
--     vim.api.nvim_command('match NonAsciiSearch /[^\\x00-\\x7F]/')
--   end,
--   {}
-- )

_G.match_id = nil

vim.api.nvim_create_user_command(
  'ShowNonAscii',
  function()
    -- Define a new highlight group for the non-ASCII search
    vim.api.nvim_command('highlight NonAsciiSearch ctermbg=yellow guibg=yellow')

    -- If a previous match exists, delete it
    if _G.match_id then
      vim.api.nvim_command('silent! call matchdelete(' .. _G.match_id .. ')')
    end

    -- Use the matchadd() function to persistently highlight non-ASCII characters and store the match ID
    _G.match_id = vim.fn.matchadd("NonAsciiSearch", "[^\\x00-\\x7F]")
  end,
  {}
)
