export ANDROID_HOME=~/.android/Sdk

# Need the 8.0 CUDA idek
export PATH=~/.local/bin:$PATH
export PATH=$PATH:$HOME/bin:/usr/local/bin:/opt
export PATH=$PATH:~/.cabal/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/opt/eclipse/eclipse
export PATH=$PATH:/opt/spring/bin:/opt/flutter/bin
export PATH=$PATH:/opt/android-studio/bin
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/opt/anki/bin
export PATH=$PATH:~/src/fedi/fd
export PATH=$PATH:~/src/FlameGraph
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools
export PATH=$PATH:/opt/hop/bin
export PATH=$PATH:~/src/depot_tools
export PATH=$PATH:~/.racket/7.9/bin
for opt_dir in `find /opt -maxdepth 1 -type d -print0`; do
	export PATH="$PATH:$opt_dir"
done

export ANDROID_HOME=~/.android/Sdk
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
export MOZ_USE_XINPUT2=1
export GOPATH=~/.go

export LV2_PATH="$HOME/.lv2:/usr/local/lib/lv2:/usr/lib/lv2"
export LXVST_PATH="$HOME/.vst:/usr/lib/vst"
export TEXMFHOME="~/.texmf"

source ~/.cargo/env

export vblank_mode=2

