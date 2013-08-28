using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SimpleCsDllCall
{
    public class SimpleCsDllCall
    {
        static public int DoSth() { return 2 * SimpleCsDll.SimpleCsDll.DoSth(); } // 20
        static public int CallDoSth() { return 2 * SimpleCsDll.SimpleCsDll.CallDoSth(); } // 200
        static public int DynamicCallDoSth() { return 2 * SimpleCsDll.SimpleCsDll.DynamicCallDoSth(); } // 2000
    }
}
