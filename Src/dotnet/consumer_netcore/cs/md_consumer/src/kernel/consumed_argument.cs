using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace md_consumer
{
    public class CONSUMED_ARGUMENT
    {
        public string dotnet_name;
        public string eiffel_name;
        public CONSUMED_REFERENCED_TYPE type;
        public CONSUMED_ARGUMENT(string dn, string en, CONSUMED_REFERENCED_TYPE t)
        {
            dotnet_name = dn;
            eiffel_name = en;
            type = t;
        }

        public bool same_as (CONSUMED_ARGUMENT other)
        {
            return other.dotnet_name.Equals(dotnet_name)
                && other.type.same_as (type);
        }
        public bool has_generic_type()
        {
            return type.has_generic_type;
        }
        public bool is_excluded()
        {
            return type.is_excluded();
        }
        public string real_argument_type_name()
        {
            return type.real_type_name();
        }        

    }

}