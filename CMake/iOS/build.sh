cmake | grep -q Xcode
if [ $? -ne 0 ]
then
	echo "Can't build for Apple platform without Xcode."
	exit 4
fi
# Usage : build.bat <Input-Path> <Output-Path> <Build-Type>
# Generate lib<target-name>.a in the folder <Output-Path>/<Build-Type>/iOS
# cmake and make need to be installed
# Input and Output Path need to be relative
curPath="`pwd`"
scriptPath="`pushd $(dirname $0) > /dev/null;pwd;popd > /dev/null`"
inputPath="${curPath}/$1"
outputPath="${curPath}/$2"
buildType=$3
archs="armv6 armv7 i386"
for arch in ${archs}
do
	rm -rf __tmp_build
	mkdir __tmp_build
	cd __tmp_build
	cmake \
	 -GXcode\
	 -DCMAKE_TOOLCHAIN_FILE="${scriptPath}/../init.cmake"\
	 -DTARGET_PLATFORM="iOS"\
	 -DTARGET_ARCHITECTURE="${arch}"\
	 -DCMAKE_BUILD_TYPE="${buildType}"\
	 -DOUTPUT_ROOT_DIRECTORY="${outputPath}"\
	 "${inputPath}"
	sdk="iphoneos"
	if [ "${arch}" == "i386" ]
	then
		sdk="iphonesimulator"
	fi
	if [ -f cmake.return ]
	then
		echo "CMake can't generate files for ${arch}-ios"
		return=`cat cmake.return`
		cd ..
		rm -rf __tmp_build
		exit ${return}
	fi
	xcodebuild VALID_ARCHS="${arch}" -sdk ${sdk} -arch ${arch} -configuration ${buildType} clean build
	if [ "$?" -ne "0" ]
	then
		echo "Compilation Error for ${arch}-ios"
		exit 100
	fi
	cd ..
done
rm -rf __tmp_build
mkdir -p "${outputPath}/${buildType}/iOS"
for lib in ${outputPath}/${buildType}/iOS/*/*.a
do
	if [ ! -f ${lib} ]
	then
		break
	fi
	libname=`basename ${lib}`
	if [ -f ${outputPath}/${buildType}/iOS/i386/${libname} ]
	then
		i386=${outputPath}/${buildType}/iOS/i386/${libname}
	fi
	if [ -f ${outputPath}/${buildType}/iOS/armv6/${libname} ]
	then
		armv6=${outputPath}/${buildType}/iOS/armv6/${libname}
	fi
	if [ -f ${outputPath}/${buildType}/iOS/armv7/${libname} ]
	then
		armv7=${outputPath}/${buildType}/iOS/armv7/${libname}
	fi
	lipo -create -output ${outputPath}/${buildType}/iOS/${libname} ${i386} ${armv6} ${armv7}
	rm ${i386} ${armv6} ${armv7}
done
rm -rf ${outputPath}/${buildType}/iOS/{i386,armv6,armv7}