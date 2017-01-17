#!/bin/zsh

function freemem(){
	 free -h && sync
	 sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches' && sync
     sudo sh -c 'echo 2 >/proc/sys/vm/drop_caches' && sync
	 sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && sync
	 sync && free -h && sync
 }

 function cdandroid() {
	 cd ~/AndroidStudioProjects
 }
 
 function cdworkspace(){
	 cd ~/Workspace
 }

 function cddoc(){
	 cd ~/Documents
 }

function androidDumpCurrentActivity(){
	adb shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp' --color=always
}

function androidDebugInfo(){
#Explanations:
## System.err to grep stacktrace information of catched exceptions
##AndroidRuntime to grep stacktrace information of uncaughted runtime exceptions
##MessageQueue to grep exceptions happended during MessageQueue
##CONSOLE to grep console message releated with javascript console.info
##dalvikvm informations about dalvik vm 
##StrictMode information about StrictMode warnings
  adb logcat |grep --color=always -E "System.err|AndroidRuntime|MessageQueue|CONSOLE|W/Bundle|dalvikvm|StrictMode"
}

function myip(){
    /sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:地址ブロードキャスト"
}

function androidClearAppData(){
	adb shell am start  -a "android.settings.APPLICATION_DETAILS_SETTINGS" -d "package:$1"
}

function androidLogcatPkg(){
	python2 $ZSH/logcatPkg.py $1
}

# function emacsopen(){
# 	XLIB_SKIP_ARGB_VISUALS=1 emacs 2>/dev/null&disown
# }

function fullpath(){
	HERE=$(pwd)
	cd $1
	pwd
	cd $HERE
}


export IODIR=/home/juson/Workspace/io/blog
function ioblog(){
	TMP=$(pwd)
	if [ -z "$1" ] ; then
		echo "$0 <filename>"
	else
		cd $IODIR
		filename=$(hexo new post $1 | awk '{print $3}')
		vim $filename
		cd $TMP
	fi
}

function iocommit(){

}

function ioimgupload(){

}
export XLIB_SKIP_ARGB_VISUALS=1

function ycmhere(){
	cp -v ~/.vim/data/.ycm_extra_conf.py $(pwd)/
}

function ycmhereC(){
	cp -v ~/.vim/data/ycm_extra_conf_for_clang.py $(pwd)/.ycm_extra_conf.py
}

function android_arm7_gcc(){
	CC=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc  
	$CC --sysroot=$ANDROID_NDK/platforms/android-17/arch-arm/ $*
}

function open(){
	xdg-open $* &>/dev/null&disown 
}
function docs(){
	ranger ~/Documents
}

function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi

        export http_proxy="http://$1/"
        export https_proxy=$http_proxy
        export ftp_proxy=$http_proxy
        export rsync_proxy=$http_proxy
        echo "Proxy environment variable set."
        return 0
    fi

#    echo -n "username: "; read username
#    if [[ $username != "" ]]; then
#        echo -n "password: "
#        read -es password
#        local pre="$username:$password@"
#    fi

    echo -n "server: "; read server
    echo -n "port: "; read port
    export http_proxy="http://$pre$server:$port/"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export FTP_PROXY=$http_proxy
    export RSYNC_PROXY=$http_proxy
}

function proxy_off(){
    unset  rsync_proxy
    unset  HTTP_PROXY
    unset  HTTPS_PROXY
    unset  FTP_PROXY
    unset  RSYNC_PROXY
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset rsync_proxy
    echo -e "Proxy environment variable removed."
}

