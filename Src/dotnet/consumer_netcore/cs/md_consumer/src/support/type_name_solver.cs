using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;
using System.Linq;

namespace md_consumer
{
    class TYPE_NAME_SOLVER : IComparable<TYPE_NAME_SOLVER>
    {
        public Type internal_type;
        public string simple_name;
        public string eiffel_name;
        public int weight=0;
        public int assembly_id=-1;

        public TYPE_NAME_SOLVER(Type a_type, int aid)
        {
            assembly_id = aid;
            internal_type = a_type;
            simple_name = a_type.Name;
            eiffel_name = "";
            string? str = a_type.FullName;
            if (str != null)
            {
                weight = str.Count(f => (f == '.'));
            } else {
                weight = 0;
            }
        }

        public int CompareTo (TYPE_NAME_SOLVER? other)
        {
            if (other == null) {
                return 1;
            } else {
                return weight.CompareTo(other.weight);
            }
        }

        protected char[] dot_array()
        {
            // char[] res = new Array(1);
            // res[0] = '.';
            return new char[1] {'.'};
        }

        public void set_eiffel_name(string en)
        {
            eiffel_name = en;
        }
   }

}