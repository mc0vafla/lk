zoxide init fish | source
set -gx WLR_NO_HARDWARE_CURSORS 1 
export QT_QPA_PLATFORMTHEME=qt5ct QT_STYLE_OVERRIDE=kvantum
set -gx YDOTOOL_SOCKET /run/user/1000/.ydotool_socket
set -gx EDITOR nvim
set -gx PATH /usr/sbin $PATH

if test "$TERM" = "linux"
    echo -en "\e]P0392b2b"
    echo -en "\e]P1e67e80" 
    echo -en "\e]P2e68d80" 
    echo -en "\e]P3e6a080" 
    echo -en "\e]P4e680a0" 
    echo -en "\e]P5e680c0" 
    echo -en "\e]P6e68080" 
    echo -en "\e]P7e6cccc" 
    echo -en "\e]P8725c5c" 
    echo -en "\e]P9f09496" 
    echo -en "\e]PAf0a294" 
    echo -en "\e]PBf0b594"
    echo -en "\e]PCf094b5" 
    echo -en "\e]PDf094d5"
    echo -en "\e]PEf09494" 
    echo -en "\e]PFf5e6e6" 
    clear
end

if test (tty) = "/dev/tty1"
    rivalcfg --z1 52263E --z2 52263E --z3 52263E &
    while true
        clear
        for i in (seq 1 15)
            echo ""
        end
        echo "                                                                                                        Choose:"
        echo ""
        echo "                                                                                                         WM"
        echo ""
        echo "                                                                                                          Main:"
        echo ""
        echo "                                                                                                           1) Niri"
        echo "                                                                                                           2) Driftwm"
        echo "                                                                                                           3) Mango"
        echo ""
        echo "                                                                                                          Exp:"
        echo ""
        echo "                                                                                                           4) I3"
        echo "                                                                                                           5) Hyprslop"
        echo "                                                                                                           6) Cwm"
        echo ""
        echo "                                                                                                         DE"
        echo ""
        echo "                                                                                                           x) Xfce"
        echo "                                                                                                           k) Kde"
        echo "                                                                                                           m) Mate"
        echo ""
        echo "                                                                                                         Im so fucking high:"
        echo ""
        echo "                                                                                                           -) Hevel"
        echo ""
        echo "                                                                                                        Session"
        echo ""
        echo "                                                                                                           0) Stay in the tty"
        echo "                                                                                                           r) Reboot"
        echo "                                                                                                           s) Shutdown"
        echo "                                                                                                           /) Reload config"
        echo ""
        
        read -l -p "echo '                                                                                                      > '" choice

        switch $choice
            case 1 
                dbus-run-session niri --session > /dev/null 2>&1
            case 2 
                dbus-run-session driftwm > /dev/null 2>&1
            case 3
                dbus-run-session mango > /dev/null 2>&1
            case 4 
                xinit ~/.xinitrc.i3 -- -nolisten tcp > /dev/null 2>&1 
            case 5 
                dbus-run-session start-hyprland > /dev/null 2>&1
            case 6 
                xinit ~/.xinitrc.cwm -- -nolisten tcp > /dev/null 2>&1 
            case x 
                xinit ~/.xinitrc.xfce -- -nolisten tcp > /dev/null 2>&1 
            case k
                dbus-run-session startplasma-wayland > /dev/null 2>&1
                sleep 0.1
            case m
                xinit ~/.xinitrc.mate -- -nolisten tcp > /dev/null 2>&1 
            case -
                swc-launch hevel > /dev/null 2>&1
            case r 
                doas reboot > dev/null 2>&1
            case s 
                doas poweroff > /dev/null 2>&1
            case /
                exec fish
            case 0
                break
            case '*'
                echo ""
                echo "                                                                                                          no such option"
                sleep 1
        end
    end
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

function j
  run $argv
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
clear
fastfetch
echo ""

#

alias ii="nvim ~/.config/i3/config"
alias gd="git diff"
alias na="j pcmanfm ."
alias x="ping google.com"
alias qd="dua i /"
alias cd="z"
alias f="fastfetch; echo ''"
alias b="btop"
alias o="nvim ~/.config/driftwm/config.toml"
alias oo="nvim ~/.config/mango/config.conf"
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
alias cute="tenki -f 75 --wind disable"
alias mk="mkdir -p"
alias t="noctalia msg --help | grep"
alias pw="pw-top"
alias y="tint --theme monokaipro-classic --image"
alias nw="driftwm msg state"
alias qe="ssh-keygen -t ed25519 -C"
alias qs="nvim /etc/driftwm/config.reference.toml"
alias wha="paru -Qs"
alias net="nmtui"
alias nrun="env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only"
alias h="nvim ~/.config/hypr/hyprland.lua"
alias hv="swc-launch dbus-run-session hevel"
alias qf="cd ~/.config/hevel; make clean && make && doas make install"
alias qc="nvim ~/.config/hevel/config.h"
alias dc="cd"
alias sl="ls"
alias qq="doas nvim /etc/pacman.conf"
alias mc="cd /home/helminth/.local/share/PrismLauncher/instances"
alias imdumb="paru -S $argv --mflags '--skipchecksums'"
alias kde="dbus-run-session startplasma-wayland > /dev/null 2>&1"
alias nc="cd /home/helminth/.local/state/noctalia"
alias mnt="cd /run/media/helminth/MNT"
alias rute="doas chown helminth:helminth ."
alias figlet="figlet -f slant"
alias g="spf"
alias ds="cd ~/.local/share/applications/"
