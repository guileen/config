export GOROOT=~/projects/go
export GOPATH=~/gowork

export ANDROID_NDK_ROOT=~/android/android-ndk-r9
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT

# PATH not support in fish
if [[ $SHELL != *"fish" ]]; then
	export PATH=$GOPATH/bin:~/anaconda2/bin:~/bin:~/config/bin:~/projects/go/bin:/usr/local/bin:/usr/local/sbin:$ANDROID_SDK_ROOT/platform-tools:$PATH:/sbin:~/projects/mongodb/bin
fi

export PYTHONDONTWRITEBYTECODE=x
export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"

export EDITOR="nvim"

alias vi='vim'
alias vim='nvim'
