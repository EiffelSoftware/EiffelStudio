using System;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.IO;
using System.Collections.Generic;
using System.Reflection;

using md_foo;

namespace md_foo
{
    public class MdFoo
    {
        public MdFoo()
        {
        }

        public string bar()
        {
        	return "FooBar";
        }
        public MdFooBar foobar() {
        	return new MdFooBar();
        }

        public int count()
        {
        	return 123;
        }
    }
}
