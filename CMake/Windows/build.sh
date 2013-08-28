# Usage : build.bat <Input-Path> <Output-Path> <Build-Type> <Arch>
# Generate <target-name>.dll in the folder <Output-Path>\<Build-Type>\Windows\<Arch>
# with Arch in (i686;x86_64)
# cmake and make need to be installed
# Input and Output Path need to be relative
curPath="`pwd`"
scriptPath="`pushd $(dirname $0) > /dev/null;pwd;popd > /dev/null`"
inputPath="${curPath}/$1"
outputPath="${curPath}/$2"
buildType=$3
arch=$4
rm -rf __tmp_build
mkdir __tmp_build
cd __tmp_build
cmake \
 -G"Unix Makefiles"\
 -DCMAKE_TOOLCHAIN_FILE="${scriptPath}/../init.cmake"\
 -DTARGET_PLATFORM="Windows"\
 -DTARGET_ARCHITECTURE="${arch}"\
 -DCMAKE_BUILD_TYPE="${buildType}"\
 -DOUTPUT_ROOT_DIRECTORY="${outputPath}"\
 "${inputPath}"
if [ -f cmake.return ]
then
	echo "CMake can't generate files for ${arch}-windows"
	return=`cat cmake.return`
	cd ..
	rm -rf __tmp_build
	exit ${return}
fi
make
if [ "$?" -ge "2" ]
then
	echo "Compilation Error for ${arch}-windows"
	exit 100
fi
cd ..
rm -rf __tmp_build