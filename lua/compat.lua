-- ~/.config/nvim/lua/compat.lua
-- Compatibility shims for deprecated Neovim APIs used by some plugins.

-- 1) vim.tbl_islist -> use vim.islist if available
if vim.tbl_islist == nil and type(vim.islist) == "function" then
  vim.tbl_islist = vim.islist
end

-- 2) vim.tbl_flatten -> prefer vim.iter(...):flatten():totable() on newer nvim
do
  local has_iter = type(vim.iter) == "function"
  local orig_flatten = vim.tbl_flatten

  if has_iter then
    -- replace tbl_flatten with new-API implementation (safe and compatible)
    vim.tbl_flatten = function(t)
      -- if a plugin still expects the old behavior for non-array values,
      -- this simple wrapper preserves common semantics for array-of-arrays.
      return vim.iter(t):flatten():totable()
    end
  else
    -- if no iter available and no builtin flatten, provide a simple implementation
    if orig_flatten == nil then
      vim.tbl_flatten = function(t)
        local out = {}
        local function _flat(x)
          for _, v in ipairs(x) do
            if type(v) == "table" then
              _flat(v)
            else
              table.insert(out, v)
            end
          end
        end
        _flat(t)
        return out
      end
    end
    -- otherwise keep orig_flatten
  end
end

-- 3) vim.validate wrapper that accepts both "old style" table form and "new style"
do
  local orig_validate = vim.validate
  if orig_validate then
    vim.validate = function(a, ...)
      -- Old-style: vim.validate{ name = { value, "type", optional } , ... }
      if type(a) == "table" then
        for name, spec in pairs(a) do
          local val = spec[1]
          local typ = spec[2]
          local optional = spec[3]
          if type(typ) == "string" then
            if val == nil and optional then
              -- ok
            elseif type(val) ~= typ then
              error(string.format("bad argument '%s' expected %s, got %s", name, typ, type(val)), 3)
            end
          end
          -- if `typ` is more complex (table/function), we don't handle all cases here,
          -- but this covers the common uses that telescope/plugins normally call.
        end
        return true
      end

      -- New-style or other forms: forward to original implementation
      return orig_validate(a, ...)
    end
  end
end
