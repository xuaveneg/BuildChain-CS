using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CsEnvironment
{
    internal class DllHandle
    {
        private static string name;
        [System.Runtime.InteropServices.DllImport("")]
        private extern static void DummyEntry();
        public DllHandle(string dllName)
        {
            name = dllName;
            DummyEntry();
        }
    }
    public class CsEnvironment
    {
        private static System.Collections.Stack handles = new System.Collections.Stack();
        public static string LastError { get; set; }
        public static string StackTrace { get; set; }
        public static bool LoadDll(String name)
        {
            DllHandle handle = new DllHandle(name);
            Type handleType = handle.GetType();
            System.Reflection.MethodInfo dummyEntry = handleType.GetMethod("DummyEntry");
            dummyEntry.Attributes = new System.Runtime.InteropServices.DllImportAttribute(name);
            try
            {
                DllHandle handle = new DllHandle(name);
                handles.Push(handle);
                return true;
            }
            catch (System.DllNotFoundException dllNotFound)
            {
                LastError = dllNotFound.Message;
                StackTrace = dllNotFound.StackTrace;
                return false;
            }
        }
    }
}
