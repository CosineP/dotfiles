export ANDROID_HOME=~/.android/Sdk

# Need the 8.0 CUDA idek
export PATH=/usr/local/cuda/bin:$PATH
export PATH=$PATH:$HOME/bin:/usr/local/bin:/opt
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.cabal/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/opt/spring/bin:/opt/flutter/bin
export PATH=$PATH:$HOME/src/fabric/fabric-samples/bin
export PATH=$PATH:$HOME/.mozbuild/arcanist/bin:$HOME/.mozbuild/moz-phab
export PATH=$PATH:/opt/godot
export PATH=$PATH:/opt/android-studio/bin
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/opt/anki/bin
export PATH=$PATH:/opt/firestorm-install
export PATH=$PATH:/home/luna/miniconda2/bin
export PATH=$PATH:/opt/tor-browser/Browser
export PATH=$PATH:~/src/fedi/fd
export PATH=$PATH:/opt/intellij/bin

export ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}/usr/local/cuda/extras/CUPTI/lib64

