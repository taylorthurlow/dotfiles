Pry.editor = "nvim"

if defined?(Break)
  Pry.commands.alias_command "c", "exit"
  Pry.commands.alias_command "s", "step"
  Pry.commands.alias_command "n", "next"
end

# Fix weird escape sequences being visible
ENV["PAGER"] = " less --raw-control-chars -F -X"
