@echo OFF
REM Usage : build.bat <Input-Path> <Output-Path> <Build-Type> <Arch> [Api-version] [stdcxx]
REM Generate lib<target-name>.so in the folder <Output-Path>\<Build-Type>\Android\<Api-version>\<Arch>
REM with Arch in (armeabi;armeabi-v7a;x86)
REM cmake and make need to be installed
REM Input and Output Path need to be relative
set scriptPath=%~dp0
set inputPath=%~f1
set outputPath=%~f2
set buildType=%3
set arch=%4
set androidApiVersion=%5
set androidStdCxx=%6
rmdir /S /Q __tmp_build
mkdir __tmp_build
cd __tmp_build
cmake ^
 -G"Unix Makefiles"^
 -DCMAKE_TOOLCHAIN_FILE="%scriptPath%\..\init.cmake"^
 -DTARGET_PLATFORM="Android"^
 -DTARGET_ARCHITECTURE="%arch%"^
 -DCMAKE_BUILD_TYPE="%buildType%"^
 -DOUTPUT_ROOT_DIRECTORY="%outputPath%/"^
 -DANDROID_API_VERSION="%androidApiVersion%"^
 -DANDROID_STDCXX="%androidStdCxx%"^
 "%inputPath%/"
if exist cmake.return (
	for /F %%l in (cmake.return) do (
		echo CMake can't generate files for %arch%-android
		set return=%%l
	)
	cd ..
	rmdir /S /Q __tmp_build
	exit /B %return%
)
make
if %errorlevel% GEQ 2 (
	echo Compilation Error for %arch%-android
	exit /B 100
)
cd ..
rmdir /S /Q __tmp_build