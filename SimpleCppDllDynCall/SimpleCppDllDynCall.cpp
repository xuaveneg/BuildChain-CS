#include <Environment.h>

extern "C" APIEXPORT int DynamicCallDoSth() {
	void *handle = GetDllHandle("SimpleCppDll");
	if (handle == NULL) return LastSysError;
	int(*DoSth)() = (int(*)())GetSymbolInDllHandle(handle, "DoSth");
	if (DoSth == NULL) return LastSysError;
	return 100*DoSth();
}
