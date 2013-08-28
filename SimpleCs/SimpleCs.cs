using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SimpleCs
{
    class SimpleCs
    {
        [System.Runtime.InteropServices.DllImport("SimpleCppDll")]
        extern static int DoSth();
        [System.Runtime.InteropServices.DllImport("SimpleCppDllCall")]
        extern static int CallDoSth();
        [System.Runtime.InteropServices.DllImport("SimpleCppDllDynCall")]
        extern static int DynamicCallDoSth();
        static void Main(string[] args)
        {
            // Cpp call
            System.Console.WriteLine(DoSth()); // 10
            // Cpp -> Cpp (static) call
            System.Console.WriteLine(CallDoSth()); // 100
            // Cpp -> Cpp (dynamic) call
            System.Console.WriteLine(DynamicCallDoSth()); // 1000
            // Cs -> Cpp call
            System.Console.WriteLine(SimpleCsDll.SimpleCsDll.DoSth()); // 10
            // Cs -> Cpp -> Cpp (static) call
            System.Console.WriteLine(SimpleCsDll.SimpleCsDll.CallDoSth()); // 100
            // Cs -> Cpp -> Cpp (dynamic) call
            System.Console.WriteLine(SimpleCsDll.SimpleCsDll.DynamicCallDoSth()); // 1000
            // Cs -> Cs -> Cpp call
            System.Console.WriteLine(SimpleCsDllCall.SimpleCsDllCall.DoSth()); // 20
            // Cs -> Cs -> Cpp -> Cpp (static) call
            System.Console.WriteLine(SimpleCsDllCall.SimpleCsDllCall.CallDoSth()); // 200
            // Cs -> Cs -> Cpp -> Cpp (dynamic) call
            System.Console.WriteLine(SimpleCsDllCall.SimpleCsDllCall.DynamicCallDoSth()); // 2000
            while (true) ;
        }
    }
}
