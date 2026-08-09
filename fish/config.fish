zoxide init fish | source
set -gx EDITOR nvim

if test (tty) = "/dev/tty1"
  dbus-run-session niri --session 
end

function dell
    pacleaner -um
    doas rm -rf /var/cache/pacman/pkg/download-* 2>/dev/null
    paru -Gc
    yes | paru -Scc
    set orphans (pacman -Qtdq)
    if test -n "$orphans"
        paru -Rns $orphans
    else
        echo "no orphans found"
    end
end

function run --description 'Launch a program detached from the terminal'
    if test (count $argv) -eq 0
        echo "Usage: run <command> [arguments]"
        return 1
    end
    $argv > /dev/null 2>&1 &
    disown
end

function mm 
    if test (count $argv) -gt 0
        nvim $argv -c "lua vim.schedule(function() vim.lsp.buf.format({async = true}); vim.cmd('Telescope find_files hidden=true no_ignore=true') end)"
    else
        nvim -c "lua vim.defer_fn(function() vim.cmd('Telescope find_files hidden=true no_ignore=true') end, 10)"
    end
end

function z
    __zoxide_z $argv
    if test $status -eq 0
        lsd
    end
end

function fish_prompt
    set -l last_status $status
    set -l blue (set_color blue)
    set -l magenta (set_color green)
    set -l terracotta (set_color yellow)
    set -l normal (set_color normal)
    set -l prompt_status ""
    if test $last_status -ne 0
        set prompt_status (set_color red)"❯"$normal
    else
        set prompt_status "$terracotta❯$normal"
    end
    echo -n -s "$magenta"$USER" "$blue(prompt_pwd)" "$prompt_status" "
end

function fish_right_prompt
    set -l last_status $status
    set -l pink (set_color yellow)
    set -l normal (set_color normal)
    if fish_git_prompt > /dev/null
        echo -n -s "$pink"(fish_git_prompt)"$normal"
    end
end

set -g fish_greeting ""

if test "$USER" = "helminth"
  if set -q NVIM 
    clear
  else 
    clear
    fastfetch
    echo ""
  end
end

#

alias nr="dbus-run-session niri --session"
alias gd="git diff"
alias na="j pcmanfm ."
alias x="ping google.com"
alias qd="dua -i /run i /"
alias cd="z"
alias f="fastfetch; echo ''"
alias b="btop"
alias o="nvim ~/.config/niri/cfg/keybinds.kdl"
alias p="cd ~/.config/niri/cfg"
alias m="nvim"
alias ff="nvim ~/.config/fish/config.fish"
alias ss="exec fish"
alias fd="fd -H --absolute-path"
alias i="paru -S"
alias is="paru -Ss"
alias ls="lsd"
alias del="doas pacman -Rsnv"
alias fr="nvim ~/.config/fastfetch/config.jsonc"
alias 321="doas reboot"
alias 123="doas poweroff"
alias u="paru -Syu"
alias q="br"
alias s="git clone"
alias n="nvidia-smi"
alias nv="nvtop"
alias l="lsd -a"
alias e="lsblk"
alias c="clear"
alias w="wget"
alias gs="git add . && git commit -m 1"
alias gp="git push"
alias gss="cd ~/.config; gs; gp; cd"
alias rg="rg -."
alias v="duf"
alias gl="git remote add origin git@github.com:mc0vafla/lk.git"
alias gll="git config --global user.email sssskrol@gmail.com; git config --global user.name mc0vafla"
alias qw="alias | fzf"
alias d="dua ."
alias mk="mkdir -p"
alias t="noctalia msg --help | grep"
alias pw="pw-top"
alias y="tint --theme monokaipro-classic --image"
alias qe="ssh-keygen -t ed25519 -C"
alias wha="paru -Qs"
alias net="nmtui"

function nrun
    env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only $argv > /dev/null 2>&1 &
    disown
end

alias dc="cd"
alias sl="ls"
alias qq="doas nvim /etc/pacman.conf"
alias imdumb="paru -S $argv --mflags '--skipchecksums'"
alias mnt="cd /run/media/helminth/MNT"
alias rute="doas chown helminth:helminth ."
alias j="run"
alias nw="niri msg windows"
alias mc="cd /home/helminth/.local/share/PrismLauncher/instances"
alias ll="lsd -alF"
alias qs="nvim ~/.config/alacritty.toml"
alias qr="nvim ~/.config/nvim/lua/mappings.lua"
alias ms="rivalcfg --z1 52263E --z2 52263E --z3 52263E"
alias tre="tre -a"
