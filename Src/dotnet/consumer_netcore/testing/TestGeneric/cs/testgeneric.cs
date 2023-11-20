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

        public string bargen_t<T>(T a1)
        {
        	return "bargen_t<"+typeof(T).ToString() +">";
        }

        public string bargen_tu<T,U>(T a1, U a2)
        {
        	return "bargen_tu<"+typeof(T).ToString() +", "+typeof(U).ToString() +">";
        }

        public string bargen_t_str_u<T,U>(T a1, string a2, U a3)
        {
        	return "bargen_t_str_u<"+typeof(T).ToString() +", string, "+typeof(U).ToString() +">";
        }

        public T bargen_rt_t<T>(T v)
        {
        	return v;
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
