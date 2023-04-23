# .bashrc

# add home bin dir
export PATH=$PATH:~/bin

#set env variables
export EDITOR=vim

#colorize prompt
PS1='\[\033[00;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

#aliases
alias ll="ls -lha --color"
alias ls="ls --color -h"
alias df="df -Tha --total"
alias ..="cd .."
alias cd..="cd .."
alias fhere="find . -name "
alias free="free -mt"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -pv"
alias wget="wget -c"
alias top="htop"
alias pine="alpine"
alias du="du -h"
alias who="who -a"
alias apt_hist="aptitude search \"?and(?installed, ?not(?automatic))\""
alias scdr="sudo systemctl daemon-reload"
alias scs="sudo systemctl start"
alias scr="sudo systemctl restart"
alias scx="sudo systemctl stop"
alias sci="sudo systemctl status"
alias svim="sudo vim"
alias ports='netstat -tulanp'
alias su="sudo -i"
alias bigfiles="ls --human-readable --size -1 -S --classify"
alias newfiles="ls -t -1"
alias gh="history | grep"
alias sduo="sudo "
alias upd="sudo apt update -y && sudo apt upgrade -y && sudo apt autoclean -y && sudo apt clean -y && sudo apt autoremove -y"
alias reboot="sudo reboot"

#functions

# extract common file types recursively

grab.images ()
{

                find  . -iregex "\*.*\.(jp*g|png|gif|tir*f|psd|raw|eps|svg|bmp|webp|ai)" -exec cp{} $2 \;
}



grab.docs()
{
        if [[$# -ne 3 ]]; then
                echo "Usage: $0 STARTING_DIR OUTPUT_DIR"
                exit 1
        fi

        if [ -d $2 ]; then
                find -E $1 -iregex "\*.*\.(txt|doc*|xls*|ppt*|dot*|htm*|pdf|rtf|odt|wps|xml|xps|csv|dbf|xla* )" -exec cp{} $2
                return 0
        else
                echo "ERROR: $2 is not a directory. Please specify a valid directory."
                exit 2
        fi
}

# make a new dir and enter it
mkcd ()
{
        mkdir -p -- "$1"
        cd -P -- "$1"
  }

# create a backup and edit the original
bak ()
{

        cp "$1" "$1".bak
        vim $1
}

# manually block an IP address
blockip()
{
        sudo ufw deny from "$1" to any
        sudo ufw reload
}

# build from git source

gbuild()
{
        mkdir build
        cd build
        cmake ..
        make
        sudo make install
}

function extract {
        if [ -z "$1" ]; then
                # display usage if no parameters given
                echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
                echo "    extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        else
        for n in "$@"
        do
                if [ -f "$n" ] ; then
                        case "${n%,}" in *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                        tar xvf "$n"       ;;
                        *.lzma)      unlzma ./"$n"      ;;
                        *.bz2)       bunzip2 ./"$n"     ;;
                        *.cbr|*.rar) unrar x -ad ./"$n" ;;
                        *.gz)        gunzip ./"$n"      ;;
                        *.cbz|*.epub|*.zip) unzip ./"$n"       ;;
                        *.z)         uncompress ./"$n"  ;;
                        *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar) 7z x ./"$n"     ;;
                        *.xz)        unxz ./"$n"        ;;
                        *.exe)       cabextract ./"$n"  ;;
                        *.cpio)      cpio -id < ./"$n"  ;;
                        *.cba|*.ace) unace x ./"$n"      ;;
                        *.zpaq)      zpaq x ./"$n"      ;;
                        *.arc)       arc e ./"$n"       ;;
                        *.cso)       ciso 0 ./"$n" ./"$n.iso" && extract $n.iso && \rm -f $n ;;
                        *)echo "extract: '$n' - unknown archive method"
                        return 1
                        ;;
                        esac
                else
                        echo "'$n' - file does not exist"
                        return 1
                fi
                done
        fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
