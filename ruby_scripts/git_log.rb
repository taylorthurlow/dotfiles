# frozen_string_literal: true

# This script is designed to do some postprocessing on the result of a git log
# call.

require "time"

terminal_width = `tput cols`.to_i
glog_parse_regex = /[a-f0-9]{7}.+?m(.+?) .+?m\{([\w ]+)\}.+?m (?:\((.+?)\))?.+?m(.+$)/
format_str = "%C(yellow)%h %Cgreen%aI %Cblue{%an}%Cred%d %Creset%s"
raw_log = `git log --oneline --decorate --color --graph --pretty=format:'#{format_str}'`
today = Time.now

# Define the number of seconds at which we start measuring in a given
# measurement
thresholds = {
  year: 5 * 12 * 30 * 24 * 60 * 60,
  month: 6 * 30 * 24 * 60 * 60,
  week: 4 * 7 * 24 * 60 * 60,
  day: 2 * 24 * 60 * 60,
  hour: 1 * 60 * 60,
  minute: 60,
  second: 0,
}

# The duration of a given measurement in seconds
lengths = {
  year: 12 * 30 * 24 * 60 * 60,
  month: 30 * 24 * 60 * 60,
  week: 7 * 24 * 60 * 60,
  day: 24 * 60 * 60,
  hour: 60 * 60,
  minute: 60,
  second: 1,
}

abbreviations = {
  year: "Y",
  month: "M",
  week: "w",
  day: "d",
  hour: "h",
  minute: "m",
  second: "s",
}

def without_escapes(string)
  string.gsub(/\e\[([;\d]+)?m/, "").chomp
end

begin
  padding_char = " "

  raw_log.split("\n").each do |line|
    date_match = line.match(glog_parse_regex)
    if date_match
      new_line = line

      time = Time.iso8601(date_match[1])
      author = date_match[2]
      msg = date_match[4]

      # Handle time
      seconds_ago = today - time
      measurement = thresholds.find { |_, threshold| threshold < seconds_ago }[0]
      quantity = (seconds_ago / lengths[measurement]).floor
      to_sub = +"#{quantity}#{abbreviations[measurement]}".rjust(3)
      to_sub << "\e[31m" if date_match[3] # add color if we have refs in this line
      new_line.sub!(date_match[1], to_sub)

      # Handle commit message prefix
      msg.match(/^([\w\d-]+?:)/) do |prefix_match|
        new_line.sub!(prefix_match[1], "\e[38;5;237m#{prefix_match[1]}\e[m")
      end

      # Handle author
      new_line.sub!("\e[34m{#{author}}\e[31m ", "")
      total_length = without_escapes(new_line).length
      over = (total_length + author.length + 1) - terminal_width
      new_line = new_line[0...-over] if over > 0

      total_length = without_escapes(new_line).length
      spaces_needed = terminal_width - total_length - author.length - 2
      if spaces_needed < 0
        new_line = +"#{new_line[0...-spaces_needed - 5]}...  "
      else
        new_line << " \e[30m"
        new_line << padding_char * spaces_needed
        new_line << " \e[m"
      end

      new_line << "\e[34m#{author}\e[m"

      puts new_line
    else
      puts line
    end

    padding_char = padding_char == " " ? "-" : " "
  end
rescue Errno::EPIPE, SystemExit, Interrupt
  # do nothing, cleanly exit
end
