# Usage : build.bat <Input-Path> <Output-Path> <Build-Type> <Arch> [Api-version] [stdcxx]
# Generate lib<target-name>.so in the folder <Output-Path>/<Build-Type>/Android/<Api-version>/<Arch>
# with Arch in (armeabi;armeabi-v7a;x86)
# cmake and make need to be installed
# Input and Output Path need to be relative
curPath="`pwd`"
scriptPath="`pushd $(dirname $0) > /dev/null;pwd;popd > /dev/null`"
inputPath="${curPath}/$1"
outputPath="${curPath}/$2"
buildType=$3
arch=$4
androidApiVersion=$5
androidStdCxx=$6
rm -rf __tmp_build
mkdir __tmp_build
cd __tmp_build
cmake \
 -G"Unix Makefiles"\
 -DCMAKE_TOOLCHAIN_FILE="${scriptPath}/../init.cmake"\
 -DTARGET_PLATFORM="Android"\
 -DTARGET_ARCHITECTURE="${arch}"\
 -DCMAKE_BUILD_TYPE="${buildType}"\
 -DOUTPUT_ROOT_DIRECTORY="${outputPath}"\
 -DANDROID_API_VERSION="${androidApiVersion}"\
 -DANDROID_STDCXX="${androidStdCxx}"\
 "${inputPath}"
if [ -f cmake.return ]
then
	echo "CMake can't generate files for ${arch}-android"
	return=`cat cmake.return`
	cd ..
	rm -rf __tmp_build
	exit ${return}
fi
make
if [ "$?" -ge "2" ]
then
	echo "Compilation Error for ${arch}-android"
	exit 100
fi
cd ..
rm -rf __tmp_build