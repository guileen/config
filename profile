export GOROOT=~/projects/go
export FLEX_HOME=~/sdk/flex
export ANDROID_NDK_ROOT=~/android/android-ndk-r9
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export QUICK_COCOS2DX_ROOT=~/projects/quick-cocos2d-x
export COCOS2DX_ROOT=${QUICK_COCOS2DX_ROOT}/lib/cocos2d-x
export ANDROID_HOME=${ANDROID_SDK_ROOT}
export GOPATH=~/gowork
export PATH=~/bin:~/config/bin:~/projects/go/bin:~/sdk/flex/bin:/usr/local/bin:/usr/local/sbin:$ANDROID_SDK_ROOT/platform-tools:$PATH:$GOPATH/bin:/sbin:~/projects/mongodb/bin
export PYTHONDONTWRITEBYTECODE=x
export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"

# Added by Canopy installer on 2015-01-23
# VIRTUAL_ENV_DISABLE_PROMPT can be set to '' to make bashprompt show that Canopy is active, otherwise 1
# VIRTUAL_ENV_DISABLE_PROMPT=1 source /Users/gl/opt/enthought/canopy/User/bin/activate


#### nvm
[ -s ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

#### nvm
[ -s "/home/gl/.nvm/nvm.sh" ] && . "/home/gl/.nvm/nvm.sh" # This loads nvm
[[ -s "/Users/gl/.gvm/scripts/gvm" ]] && source "/Users/gl/.gvm/scripts/gvm" && gvm use 1
export GOPATH=~/gowork:$GOPATH
# export http_proxy="http://localhost:10088"
