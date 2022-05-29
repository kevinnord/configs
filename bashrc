# .bashrc

#colorize prompt
PS1='\[\033[00;93m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

#aliases
alias ll="ls -lha --color"
alias ls="ls --color -h"
alias df="df -Tha --total"
alias ..="cd .."
alias cd..="cd .."
alias fhere="find . -name "
alias free="free -mt"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -p"
alias wget="wget -c"
alias top="htop"
alias pine="alpine"
alias du="du -h"
alias who="who -a"

#functions

mkcd () 
{
	  mkdir -p -- "$1" && cd -P -- "$1"
  }

bak ()
{
	mv "$1" "$1.bak"
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
				case "${n%,}" in			                  *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
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

