#include <Environment.h>

extern "C" APIIMPORT int DoSth();
extern "C" APIEXPORT int CallDoSth() {
	return 10*DoSth();
}