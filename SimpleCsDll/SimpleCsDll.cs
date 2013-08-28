using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SimpleCsDll
{
    public class SimpleCsDll
    {
        [System.Runtime.InteropServices.DllImport("SimpleCppDll")]
        public extern static int DoSth(); // 10
        [System.Runtime.InteropServices.DllImport("SimpleCppDllCall")]
        public extern static int CallDoSth(); // 100
        [System.Runtime.InteropServices.DllImport("SimpleCppDllDynCall")]
        public extern static int DynamicCallDoSth(); // 1000
    }
}
