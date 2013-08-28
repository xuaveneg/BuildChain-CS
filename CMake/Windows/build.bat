@echo OFF
REM Usage : build.bat <Input-Path> <Output-Path> <Build-Type> <Arch>
REM Generate <target-name>.dll in the folder <Output-Path>\<Build-Type>\Windows\<Arch>
REM with Arch in (i686;x86_64)
REM cmake and make need to be installed
REM Input and Output Path need to be relative
set scriptPath=%~dp0
set inputPath=%~f1
set outputPath=%~f2
set buildType=%3
set arch=%4
rmdir /S /Q __tmp_build
mkdir __tmp_build
cd __tmp_build
cmake ^
 -G"Unix Makefiles"^
 -DCMAKE_TOOLCHAIN_FILE="%scriptPath%\..\init.cmake"^
 -DTARGET_PLATFORM="Windows"^
 -DTARGET_ARCHITECTURE="%arch%"^
 -DCMAKE_BUILD_TYPE="%buildType%"^
 -DOUTPUT_ROOT_DIRECTORY="%outputPath%/"^
 "%inputPath%"
if exist cmake.return (
	for /F %%l in (cmake.return) do (
		echo CMake can't generate files for %arch%-windows
		set return=%%l
	)
	cd ..
	rmdir /S /Q __tmp_build
	exit /B %return%
)
make
if %errorlevel% GEQ 2 (
	echo Compilation Error for %arch%-windows
	exit /B 100
)
cd ..
rmdir /S /Q __tmp_build