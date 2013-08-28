-----------------
Possible Target :
-----------------

- Windows (i686 & x86_64)
- Linux (i386 & i686 & x86_64)
- OSX (i386 & x86_64)
- iOS (armv6 & armv7 & i386)
- Android (arm & armv7-a & mips & x86)

----------------------------------
What you need to install/to have :
----------------------------------

*** For every build :
cmake

*** For Windows :
Visual Studio or a cross-compiler (supposedly named [targeted-architecture]-w64-mingw32-[compiler])

*** For Linux :
A compiler for the targeted platform

*** For Android :
Android's ndk (see http://developer.android.com/tools/sdk/ndk/index.html, available for Windows, Linux and Mac OSX)

*** For iOS/OSX :
An Apple device with Xcode

*** For remote build :
ssh

----------------------
What you need to set :
----------------------

*** For every build :
- CMAKE_TOOLCHAIN_FILE	:	path to cmake_toolchain/init.cmake
- TARGET_PLATFORM		:	android | ios | osx | linux | windows
- CMAKE_BUILD_TYPE		:	Debug | Release

*** For Windows :
***** With Visual Studio :
Nothing else.
***** With Another Generator :
- WINDOWS_ARCHITECTURE	:	i686 | x86_64
***** In cross-compilation
- WINDOWS_ENVIRONMENT_PATH	:	path to the windows environment, containing include/ and lib/ and possibly usr/include/ and  usr/lib/ subfolders.

*** For Linux :
- LINUX_ARCHITECTURE	:	i386 | i686 | x86_64
***** In cross-compilation
- LINUX_ENVIRONMENT_PATH	:	path to the linux environment, containing include/ and lib/ and possibly usr/include/ and usr/lib subfolders.

*** For OSX :
- OSX_ARCHITECTURE		:	i386 | x86_64

*** For iOS :
- IOS_ARCHITECTURE		:	armv6 | armv7 | i386

*** For Android :
- ANDROID_NDK_PATH		:	path to Android's ndk (see http://developer.android.com/tools/sdk/ndk/index.html)
- ANDROID_ARCH			:	armeabi | armeabi-v7a | mips | x86
- ANDROID_API_VERSION	:	1.6 | 2.1 | 2.2 | 2.3 | 3.1 | 4.0 | 4.0.3 | 4.1 | 4.2
- ANDROID_STDCXX		:	stlport | gabi++ | gnu-libstdc++ | system