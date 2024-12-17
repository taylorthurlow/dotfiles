# Nushell Environment Config File
#
# version = "0.97.1"


$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

$env.HOMEBREW_PREFIX = "/opt/homebrew"
let openssl_version = "3"

$env.PATH = (
    try {$env.PATH} catch { "" }
    | split row (char esep)
    | compact -e
    | prepend $"/Applications/Docker.app/Contents/Resources/bin"
    | prepend $"($env.HOME)/.cargo/bin"
    | prepend $"($env.HOMEBREW_PREFIX)/opt/openssl@($openssl_version)/bin"
    | prepend $"($env.HOMEBREW_PREFIX)/opt/imagemagick@6/bin"
    | prepend $"($env.HOMEBREW_PREFIX)/sbin"
    | prepend $"($env.HOMEBREW_PREFIX)/bin"
    | uniq
)

$env.LIBRARY_PATH = (
    try {$env.LIBRARY_PATH} catch { "" }
    | split row (char esep)
    | compact -e
    | append $"($env.HOMEBREW_PREFIX)/opt/openssl@($openssl_version)/lib"
    | uniq
)

$env.PKG_CONFIG_PATH = (
    try {$env.PKG_CONFIG_PATH} catch { "" }
    | split row (char esep)
    | compact -e
    | append $"($env.HOMEBREW_PREFIX)/opt/openssl@($openssl_version)/lib/pkgconfig"
    | uniq
)

$env.RUBY_CONFIGURE_OPTS = [
    $"--with-openssl-dir=($env.HOMEBREW_PREFIX)/opt/openssl@($openssl_version)"
]

$env.HOMEBREW_AUTOREMOVE = true
$env.HOMEBREW_BAT = true
$env.HOMEBREW_BOOTSNAP = true
$env.HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK = true
$env.HOMEBREW_NO_INSTALL_CLEANUP = true

$env.KUBECONFIG = $"($env.HOME)/.kube/config:($env.HOME)/.kube/svkube"

$env.LC_COLLATE = "C"
$env.LESS = "-R"
$env.EDITOR = "nvim"
$env.DISABLE_SPRING = 1
$env.RUBY_DEBUG_IRB_CONSOLE = 1

def git-nuke [repo: string] {
	print $"☢️ ARE YOU SURE you want to nuke '($repo)'? \(y/N\)"

	if (input --numchar 1 --suppress-output) == "y" {
        print "☢️ LAUNCHING"
	    git branch -D $repo
		git push origin $":($repo)"
		print "☢️ DIRECT HIT"
	} else {
	    print "☢️ ABORTED"
	}
}

def nlp-timestamp-copy [dir_or_files: glob] {
    exiftool "-TimeCreated<DigitalCreationTime" "-DateCreated<DateTimeOriginal" $dir_or_files
}

alias ll = ls -l

alias cat = bat
alias lg = lazygit
# alias git = hub

alias gst = git status
alias gp = git push
alias gpr = git pull --rebase
alias gfap = git fetch --all --prune

alias zed = /opt/homebrew/bin/zed-preview
alias zed-stable = /opt/homebrew/bin/zed

alias be = bundle exec
alias bi = bundle install
alias bu = bundle update
alias bout = bundle outdated --only-explicit
alias dc = docker-compose
alias notes = nvim ~/.notes/main.md
alias worknotes = nvim ~/.notes/work.md
alias xit = exit
alias imgcat = wezterm imgcat
alias nu-env = nvim ~/.config/nushell/env.nu
alias nu-config = nvim ~/.config/nushell/config.nu

def beet-import [] = {
    TERM=xterm ssh root@192.168.1.2 -t "docker exec -itu abc beets beet import -tm /music/import"
}

def ruby-lsp-update [] = {
    BUNDLE_GEMFILE=.ruby-lsp/Gemfile bundle update ruby-lsp
}

def glog [] = {
    (
    GIT_PAGER="less -SR"
    git log --color=always
            --graph
            --date=short
            --pretty='format:%C(yellow)%h%Creset%C(auto)%(decorate:tag=)%Creset %s %C(cyan)[%aN]%Creset %Cgreen(%ad, %ar)%Creset'
    )
}

def gloga [] = {
    (
    GIT_PAGER="less -SR"
    git log --color=always
            --graph
            --date=short
            --perl-regexp
            --exclude="refs/remotes/*/dependabot*"
            --all
            --pretty="format:%C(yellow)%h%Creset%C(auto)%(decorate:tag=)%Creset %s %C(cyan)[%aN]%Creset %Cgreen(%ad, %ar)%Creset"
    )
}

def wglog [] = {
    loop {
        let result = (
            git
                --no-pager
            log
                --color=always
                --graph
                --date=short
                --pretty='format:%C(yellow)%h%Creset%C(auto)%(decorate:tag=)%Creset %s %C(cyan)[%aN]%Creset %Cgreen(%ad, %ar)%Creset'
        )

        clear
        echo $result | bat --wrap=never --paging=never --chop-long-lines --decorations=never --line-range=0:((tput lines | into int) - 2)
        sleep 1sec
    }
}

def wgloga [] = {
    loop {
        let result = (
            git
                --no-pager
            log
                --color=always
                --graph
                --date=short
                --perl-regexp
                --exclude="refs/remotes/*/dependabot*"
                --all
                --pretty="format:%C(yellow)%h%Creset%C(auto)%(decorate:tag=)%Creset %s %C(cyan)[%aN]%Creset %Cgreen(%ad, %ar)%Creset"
        )

        clear
        echo $result | bat --wrap=never --paging=never --chop-long-lines --decorations=never --line-range=0:((tput lines | into int) - 2)
        sleep 1sec
    }
}

def girb [] = {
    let ref = (glog | fzf --ansi | cut -d ' ' -f2 | into string)
    git rebase -i $"($ref)^"
}

def create_left_prompt [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

use "~/.config/nushell/scripts/rbenv.nu" *
use "~/.config/nushell/scripts/nodenv.nu" *

use "~/.config/nushell/nu_scripts/custom-completions/bat/bat-completions.nu" *
use "~/.config/nushell/nu_scripts/custom-completions/docker/docker-completions.nu" *
use "~/.config/nushell/nu_scripts/custom-completions/curl/curl-completions.nu" *
use "~/.config/nushell/nu_scripts/custom-completions/gh/gh-completions.nu" *
use "~/.config/nushell/nu_scripts/custom-completions/git/git-completions.nu" *
use "~/.config/nushell/nu_scripts/custom-completions/rg/rg-completions.nu" *
use "~/.config/nushell/nu_scripts/custom-completions/ssh/ssh-completions.nu" *
use "~/.config/nushell/nu_scripts/custom-completions/yarn/yarn-v4-completions.nu" *
