P  = function(v)
  vim.inspect(v)
  return v
end

RELOAD = function(name)
  package.loaded[name] = nil
end

R  = function(name)
  RELOAD(name)
  return require(name)
end
