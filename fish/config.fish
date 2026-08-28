zoxide init fish | source
export GIT_SSH_COMMAND="ssh -i /home/helminth/.ssh/id_ed25519"
set -gx WLR_NO_HARDWARE_CURSORS 1 
export QT_QPA_PLATFORMTHEME=qt5ct QT_STYLE_OVERRIDE=kvantum
set -gx YDOTOOL_SOCKET /run/user/1000/.ydotool_socket
set -gx EDITOR nvim
set -gx PATH /usr/sbin /home/helminth/.local/bin $PATH

alias nr="dbus-run-session niri --session"

if test (tty) = "/dev/tty1"
  clear
  nr > /dev/null 2>&1
end

function dell
    set wha (ls /var/cache/pacman/pkg | grep -i "download-")
    if test -n "$wha"
      doas rm -rf /var/cache/pacman/pkg/download-*
    else 
      echo "no cache found"
    end
    yes | paru -Scc 
    echo ""; echo ""
    set orphans (paru -Qtdq)
    if test -n "$orphans"
        paru -Rns $orphans
    else
        echo "no orphans found"
    end
    sync
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

alias gd="git diff"
alias na="j pcmanfm ."
alias x="ping google.com"
alias xx="ip link"
alias qd="dua -i /run i /"
alias cd="z"
alias f="fastfetch; echo ''"
alias b="btop"
alias o="nvim ~/.config/niri/modules/keybinds.kdl"
alias p="cd ~/.config/niri/modules"
alias m="nvim"
alias ff="nvim ~/.config/fish/config.fish"
alias ss="exec fish"
alias fd="fd -H --absolute-path"
alias i="paru -S"
alias is="paru -Ss"
alias ls="lsd"
alias del="doas pacman -Rsnv"
alias fr="nvim ~/.config/fastfetch/config.jsonc"
alias 321='doas reboot'
alias 123='doas poweroff'
alias u="paru -Syu"
alias q="br"
alias s="git clone"
alias n="nvidia-smi"
alias nv="nvtop"
alias l="lsd -a"
alias e="lsblk -f"
alias c="clear"
alias w="wget"
alias gs="git add . && git commit -m 1"
alias gp="git push"

function gss
  cd ~/.config > /dev/null 2>&1
  set gs (gd)
  if test -n "$gs"
    gs; gp
  else
    echo "git tree clean"
  end
  cd > /dev/null 2>&1
end

function git-wipe
  cd .config > /dev/null 2>&1
  rm -rf .git 
  git init 
  gs 
  gl 
  git branch -m el 
  git push --set-upstream origin el -f
  cd > /dev/null 2>&1
end

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
alias yy="tint --theme everforest-dark --image"
alias yyy="tint --theme gruvbox-dark --image"
alias qe="ssh-keygen -t ed25519 -C"
alias wha="paru -Qs"
alias net="nmtui"

function nrun
    env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only > /dev/null 2>&1 &
    disown
end

alias dc="cd"
alias sl="ls"
alias qq="doas nvim /etc/pacman.conf"
alias imdumb="paru -S --mflags '--skipchecksums'"
alias rute="doas chown helminth:helminth ."
alias j="run"
alias nw="niri msg windows"
alias mc="cd /home/helminth/.local/share/PrismLauncher/instances"
alias ll="lsd -alF"
alias qs="nvim ~/.config/alacritty.toml"
alias qr="nvim ~/.config/nvim/lua/mappings.lua"
alias ms="rivalcfg --z1 52263E --z2 52263E --z3 52263E"
alias tre="tre -a"
alias gj="cd ~/.config; rm -rf .git; git init; gs; gl; git branch -m el; git push --set-upstream origin el -f; cd"

alias gimmeinit="doas mkinitcpio -p linux-zen"
alias aurwha="pacman -Qm"
alias upd-grub="doas grub-mkconfig -o /boot/grub/grub.cfg"
alias qf="uptime -p"
alias rp="commandline -f repaint"
alias mr="doas nvim /etc/pacman.d/mirrorlist"
alias dwvd="cd /mnt/vd && yt-dlp -t mp4"
alias qp="pacman -Qtt | fzf"
alias dw="yt-dlp -t mp3"
alias k="optionmusic ."
alias dwsp="spotdl"

function fish_user_key_bindings
  bind \cq "q; rp"
  bind \cf "tmux; rp"
end
