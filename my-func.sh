#!/bin/zsh


function freemem(){
	 free -h && sync
	 sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'
     sudo sh -c 'echo 2 >/proc/sys/vm/drop_caches'
	 sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
	 sync && free -h && sync
 }

alias cdandroid="cd ~/AndroidStudioProjects"
alias cdworkspace="cd ~/Workspace"
alias cddoc="cd ~/Documents"

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
	python2 logcatPkg.py $1
}

