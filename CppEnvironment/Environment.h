#pragma once

#include <cstring>
#ifdef _WIN32
#include <windows.h>
#define OpenDll(name) ((void*)LoadLibrary(name))
#define LoadSymbol(handle, symbol) ((void*)GetProcAddress((HMODULE)handle, symbol))
#define CloseDll(handle) FreeLibrary((HMODULE)handle)
#define APIEXPORT __declspec(dllexport)
#define APIIMPORT __declspec(dllimport)
#define LastSysError GetLastError()
//#define strcat(dst, src) strcat_s(dst, strlen(dst)+strlen(src)+1, src)
#else
#include <dlfcn.h>
#include <errno.h>
#include <cstdlib>
#define OpenDll(name) dlopen(name, RTLD_LAZY)
#define LoadSymbol(handle, symbol) dlsym(handle, symbol)
#define CloseDll(handle) (dlclose(handle) == 0)
#define APIEXPORT
#define APIIMPORT
#define LastSysError errno
#endif
#ifdef _WIN32
#ifndef LIBRARY_PREFIX
#define LIBRARY_PREFIX ""
#endif
#ifndef LIBRARY_SUFFIX
#define LIBRARY_SUFFIX ".dll"
#endif
#endif
#ifdef LINUX
#ifndef LIBRARY_PREFIX
#define LIBRARY_PREFIX "lib"
#endif
#ifndef LIBRARY_SUFFIX
#define LIBRARY_SUFFIX ".so"
#endif
#endif
#ifdef ANDROID
#ifndef LIBRARY_PREFIX
#define LIBRARY_PREFIX "lib"
#endif
#ifndef LIBRARY_SUFFIX
#define LIBRARY_SUFFIX ".so"
#endif
#endif
#ifdef OSX
#ifndef LIBRARY_PREFIX
#define LIBRARY_PREFIX "lib"
#endif
#ifndef LIBRARY_SUFFIX
#define LIBRARY_SUFFIX ".dylib"
#endif
#endif
#ifdef IOS
#ifndef LIBRARY_PREFIX
#define LIBRARY_PREFIX "lib"
#endif
#ifndef LIBRARY_SUFFIX
#define LIBRARY_SUFFIX ".a"
#endif
#endif

inline void *GetDllHandle(char *name) {
	char fullname[256];
	fullname[0] = '\0';
	strcat(fullname, LIBRARY_PREFIX);
	strcat(fullname, name);
	strcat(fullname, LIBRARY_SUFFIX);
	return OpenDll(fullname);
}

inline void *GetSymbolInDllHandle(void *handle, char *symbol) {
	return LoadSymbol(handle, symbol);
}

inline void *GetSymbolInDll(char *dllName, char *symbol) {
	return GetSymbolInDllHandle(GetDllHandle(dllName), symbol);
}

inline int FreeLibraryHandle(void *handle) {
	return CloseDll(handle);
}

extern "C" void DummyEntry() {
}