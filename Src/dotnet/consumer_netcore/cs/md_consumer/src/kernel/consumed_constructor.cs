using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace md_consumer
{
    public class CONSUMED_CONSTRUCTOR: CONSUMED_ENTITY
    {
        // public string dotnet_name;
        // public string eiffel_name;

        public CONSUMED_ARGUMENT[] arguments;
        public bool is_frozen = true;
        public bool is_constructor = true;
        new public string dotnet_eiffel_name()
        {
            return "make";
        }

        public CONSUMED_CONSTRUCTOR(string en, CONSUMED_ARGUMENT[] args, bool pub, CONSUMED_REFERENCED_TYPE a_type) : base (en, en, pub, a_type)
        {
            dotnet_name = ".ctor" ;
            arguments = args;
        }

        new public bool is_excluded() {
            if (base.is_excluded()) {
                return true;
            } else {
                if (arguments != null) {
                    foreach (var a in arguments) {
                        if (a.is_excluded()) {
                            return true;
                        }
                    }
                }
            }
            return false;
        }        
        public bool has_generic_type() 
        {
            if (arguments != null) {
                foreach (var a in arguments) {
                    if (a.has_generic_type()) {
                        return true;
                    }
                }
            }
            return false;
        }          

        public bool is_equal (CONSUMED_ARGUMENT other)
        {
            return other.dotnet_name.Equals(dotnet_name) && other.type.same_as (declared_type);
        }
    }

}