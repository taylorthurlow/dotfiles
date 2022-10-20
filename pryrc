Pry.editor = "nvim"

if defined?(Break)
  Pry.commands.alias_command "c", "continue"
  Pry.commands.alias_command "s", "step"
  Pry.commands.alias_command "n", "next"
  Pry.commands.alias_command "f", "finish"
end

# Fix weird escape sequences being visible
ENV["PAGER"] = " less --raw-control-chars -F -X"
