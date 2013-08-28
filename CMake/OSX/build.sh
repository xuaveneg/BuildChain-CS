cmake | grep -q Xcode
if [ $? -ne 0 ]
then
	echo "Can't build for Apple platform without Xcode."
	exit 4
fi
# Usage : build.bat <Input-Path> <Output-Path> <Build-Type> <Arch>
# Generate lib<target-name>.dylib in the folder <Output-Path>\<Build-Type>\OSX\<Arch>
# with Arch in (i386;x86_64)
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
 -GXcode\
 -DCMAKE_TOOLCHAIN_FILE="${scriptPath}/../init.cmake"\
 -DTARGET_PLATFORM="OSX"\
 -DTARGET_ARCHITECTURE="${arch}"\
 -DCMAKE_BUILD_TYPE="${buildType}"\
 -DOUTPUT_ROOT_DIRECTORY="${outputPath}"\
 "${inputPath}"
if [ -f cmake.return ]
then
	echo "CMake can't generate files for ${arch}-osx"
	return=`cat cmake.return`
	cd ..
	rm -rf __tmp_build
	exit ${return}
fi
xcodebuild VALID_ARCHS="${arch}" -arch ${arch} -configuration ${buildType} clean build
if [ "$?" -ne "0" ]
then
	echo "Compilation Error for ${arch}-osx"
	exit 100
fi
cd ..
rm -rf __tmp_build