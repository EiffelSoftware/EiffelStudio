using System;
using System.IO;
using System.Collections.Generic;


namespace Eiffel.MD.Testing
{
    public class GenericFoo<T>
    {
        public T foo_value;
        public GenericFoo(T v)
        {
        	foo_value = v;
        }

        public string debug_output() 
        {
        	return "Type = "  + typeof(T).ToString();
        }
    }

    public class FooOfString: GenericFoo<string>
    {
        public FooOfString(string v): base(v)
        {
        	foo_value = v;
        }
    	public int count() 
    	{
    		return foo_value.Length;
		}

        new public string debug_output() 
        {
        	return "String (count:" + count() + ": " + foo_value;
        }
    }

    public class Bar
    {
        public int bar_value;
        public Bar(int v)
        {
        	bar_value = v;
        }

        public string bargen<T>(T gen_v)
        {
        	return "bargen<"+typeof(T).ToString() +">";
        }
        public string barnogen(Object v)
        {
        	return "barnogen<"+v.GetType().ToString() +">";
        }

        public string debug_output() 
        {
        	return "Bar : " + bar_value;
        }
    }
}
