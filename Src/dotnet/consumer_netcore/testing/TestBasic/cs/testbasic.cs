using System;
using System.IO;
using System.Collections.Generic;


namespace Eiffel.MD.Testing
{

	interface IBar
	{
        int item();
	}
    public class Bar: IBar
    {
        public Bar(int v)
        {
        	bar_value = v;
        }

    	public int bar_value;

        public int bar_item
        {
        	get { return bar_value; }
        	set { bar_value = value; }
        }

        public int item()
        {
        	return bar_item;
        }

        public void set_bar_value(int v)
        {
        	bar_value = v;
        }
    }
    public class Foo
    {
        public string foo_value="default";
        public Foo()
        {
        	foo_value = "Foo";
        }
        public Foo(string v)
        {
        	foo_value = v;
        }

        public Bar bar()
        {
        	Bar b = new Bar(123);
        	return b;
        }
        public string debug_output() 
        {
        	return foo_value + ": " + bar().item().ToString();
        }
    }

    public class FooBar: Foo, IBar
    {
        private Bar priv_bar;
        public FooBar(): base()
        {
        	priv_bar = new Bar(246);
        }

        public int item()
        {
        	return priv_bar.item();
        }


        new public string debug_output() 
        {
        	return "FOOBAR["+ debug_output() +"]";
        }
    }
    public class Abc
    {
    	string data;
    	public Abc()
    	{
    		data = "abc";
    	}
    	public void test() {
    		InnerAbc i = new(123);
    		data = "number=" + i.data();
		}
		private void test_with_inner (InnerAbc inner)
		{
    		data = "number=" + inner.data();
		}

		public string? code2string(int code) {
			return string.Format("code[{0}]", code);
		}

		protected internal delegate string? StringFromCode(int code);

		protected void test_StringFromCode_delegate (StringFromCode d)
		{
			var s = d(123);
			if (s != null) {
				data = s;
			}
		}

		public delegate string? PublicStringFromCode(int code);

		public void test_PublicStringFromCode_delegate (PublicStringFromCode d)
		{
			var s = d(123);
			if (s != null) {
				data = s;
			}
		}

    	class InnerAbc
    	{
    		int inner_data;
    		public InnerAbc(int i)
    		{
    			inner_data = i;
    		}
    		public int data()
    		{
    			return inner_data;
    		}
    	}
    }

}
