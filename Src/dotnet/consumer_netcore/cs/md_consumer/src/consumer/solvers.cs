using System;
using System.Text;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;
using System.Linq;
using System.Diagnostics;


namespace md_consumer
{

    class NAME_SOLVER : SHARED_NAME_FORMATTER
    {
        public Dictionary<string, string> reserved_names;
        static public Dictionary<string, string> ub_operator_names = new_ub_operator_names();

        public NAME_SOLVER() 
        {
            reserved_names = new Dictionary<string, string>();
        }        
        static Dictionary<string, string> new_ub_operator_names()
        {
            Dictionary<string, string> res = new Dictionary<string, string>();
            Dictionary<string, string> l_unary = name_formatter.unary_operators;
            Dictionary<string, string> l_binary = name_formatter.binary_operators;
            foreach (KeyValuePair<string,string> unary_e in l_unary) {
                foreach (KeyValuePair<string,string> binary_e in l_binary) {
                    if ((unary_e.Value).Equals ((binary_e.Value))) {
                        res.Add(unary_e.Key, binary_e.Key);
                        res.Add(binary_e.Key, binary_e.Key);
                    }
                }
            }
            return res;
        }
        public void reset_reserved_names(int nb) 
        {
            // `nb` is ignored.
            reserved_names.Clear();
        }
        public void set_reserved_names(Dictionary<string, string> tb)
        {
            reserved_names = tb;
        }
        public string unique_feature_name (string name)
        {
            int count = 2;
            string res = formatted_feature_name(name);
            if (!ub_operator_names.ContainsKey(name)) {
                while (reserved_names.ContainsKey(res)) {
                    res = NAME_FORMATTER.trim_end_digits (res);
                    res = res + count.ToString();
                    count = count + 1;
                }
            }
            if (reserved_names.ContainsKey(res)) {
                // Debug.Assert(false, "not expected");
            } else {
                reserved_names.Add(res,res);
            }
            return res;
        }
    }

    class OVERLOAD_SOLVER : NAME_SOLVER 
    {
        public Dictionary<string,Dictionary<string,string>> eiffel_names;
        public Dictionary<string,List<METHOD_SOLVER>> method_table;
        private REFLECTION reflection = new REFLECTION();
        public bool solved=false;

        public OVERLOAD_SOLVER() : base()
        {
            eiffel_names = new Dictionary<string,Dictionary<string,string>>(); // 50
            method_table = new Dictionary<string,List<METHOD_SOLVER>>(); // 20
        }
        public void solve()
			// -- Initialize `procedures' and `functions'.
			// -- Can only be called once.
        {
		// require
		// 	not_solved: not solved
            string name;
            foreach (KeyValuePair<string,List<METHOD_SOLVER>> kvp in method_table) {
                List<METHOD_SOLVER> method_list = kvp.Value;
                int n = method_list.Count;
                METHOD_SOLVER first_method = method_list[0];
                int param_count = first_method.arguments.Length;
                int number_of_methods_with_parameters = 0;
                if (n > 1 && !first_method.is_conversion_operator) {
                    number_of_methods_with_parameters = 1;
                }
                for (int i = 0 + 1; i < n; i++) 
                {
                    METHOD_SOLVER method = method_list[i];
                    if (method.is_conversion_operator) {
                        name = formatted_feature_name(method.starting_resolution_name());
                    } else {
                        // Check starting resolution name (com import assemblies have version number suffixed names)
                        name = formatted_feature_name(method.starting_resolution_name());
                        bool is_unique = is_unique_signature (method, method_list, 0);
                        if (!is_unique) {
                            number_of_methods_with_parameters = number_of_methods_with_parameters + 1;
                            int j = 0;
                            while (j < method.arguments.Length && !is_unique) {
                                name = name + "_" + formatted_variable_type_name(method.arguments[j].type.name);
                                is_unique = is_unique_signature (method, method_list, j);
                                j = j + 1;
                            }
                        }
                    }
                    method.set_eiffel_name(unique_feature_name (name));
                }
                if (number_of_methods_with_parameters > 1) {
                    name = formatted_feature_name(first_method.starting_resolution_name());
                    foreach (var a in first_method.arguments)
                    {
                        name = name + "_" + formatted_variable_type_name(a.type.name);
                    }
                    first_method.set_eiffel_name(unique_feature_name(name));
                } else {
                    first_method.set_eiffel_name(unique_feature_name(first_method.starting_resolution_name()));
                }
            }
            foreach (KeyValuePair<string,List<METHOD_SOLVER>> kvp in method_table) {
                List<METHOD_SOLVER> method_list = kvp.Value;
                foreach(METHOD_SOLVER method in method_list) {
                    Dictionary<string,string>? eiffel_args=null;
                    if (eiffel_names.ContainsKey(method.dotnet_name())) {
                        eiffel_args = eiffel_names[method.dotnet_name()];
                    } else {
                        eiffel_args = new Dictionary<string,string>();
                        eiffel_names[method.dotnet_name()] = eiffel_args;
                    }
                    try {
                        var k = key_args (method.internal_method.GetParameters(), method.internal_method.ReturnType, method.internal_method.DeclaringType);
                        if (!eiffel_args.ContainsKey(k)) {
                            eiffel_args.Add(k, method.eiffel_name);
                        } else {
                            // How come?
                        }
                    } catch {
                        // FIXME: find out why we have an exception here?
                        // Exception thrown: 'System.NotSupportedException' in System.Reflection.MetadataLoadContext.dll: 'Parsing function pointer types in signatures is not supported.'

                    }
                }
            }
		 	solved = true;
		// ensure
		// 	solved: solved
        }

		public string key_args(ParameterInfo[]? args, Type? return_type, Type? declared_type)
		{
			string res = "";
			if (args != null) {
				foreach(ParameterInfo a in args)
				{
					res = res + a.ParameterType.FullName;
				}
			}
            if (return_type != null) {
                res = res + return_type.FullName;
            }
            if (declared_type != null) {
                res = res + declared_type.FullName;
            }
			return res;
		}

        public string? unique_eiffel_name (string a_dotnet_name, ParameterInfo[]? args, Type? return_type, Type? declaring_type)
        {
            if (eiffel_names.ContainsKey(a_dotnet_name)) {
                Dictionary<string,string>? tb = eiffel_names[a_dotnet_name];
                if (tb != null) {
                    string s = key_args(args, return_type, declaring_type);
                    if (tb.ContainsKey(s)) {
                        return tb[s];
                    } else {
                        // FIXME: why?
                    }
                }
            }
            return null;
        }
        
        public bool is_unique_signature(METHOD_SOLVER method, List<METHOD_SOLVER> method_list, int index)
        {
		// require
		// 	non_void_method: method /= Void
		// 	non_void_list: method_list /= Void
		// 	valid_list: method_list.has (method)
		// 	valid_index: index >= 0
		// local
		// 	l_name: detachable STRING
		// 	l_item_name: STRING
		// 	meth: METHOD_SOLVER
		// 	count, i: INTEGER
		// 	cursor: CURSOR
			bool res = true;
            if (method.arguments.Length > 0) {
                string? l_name = null;
                foreach (METHOD_SOLVER meth in method_list) {
                    if (meth != method) {
                        int count = meth.arguments.Length;
                        int n = method.arguments.Length;
                        if (n < count) { count = n; }
                        if (count >= index) {
                            if (l_name == null) {
                                l_name =  method.starting_resolution_name();
                            }
                            string l_item_name = meth.starting_resolution_name();
                            if (l_name.Equals(l_item_name)) {
                                if (count == 0) {
                                    res = (meth == method);
                                } else {
                                    for (int i = index; i < count && res; i++) {
                                        res = (i > 0) && ! meth.arguments[i].type.same_as(method.arguments[i].type);
                                    }
                                }
                            }
                        }
                    }
                    if (res == true) {
                        break;
                    }
                }
            }
            return res;
		// ensure
		// 	method_list_position_identical: method_list.cursor.is_equal (old method_list.cursor)
        }

        private bool is_consumed_method(MethodInfo m)
        {
            return reflection.is_consumed_method(m);
        }
        public void add_property (PropertyInfo prop)
        {
            MethodInfo? l_meth;
            l_meth = METHOD_RETRIEVER.property_getter (prop);
            if (l_meth != null) {
                if (is_consumed_method (l_meth)) {
                    internal_add_method (l_meth, true);
                }
            }
            l_meth = METHOD_RETRIEVER.property_setter (prop);
            if (l_meth != null) {
                if (is_consumed_method (l_meth)) {
                    internal_add_method (l_meth, false);
                }
            }
        }

		// Already has this method added internally? 
		public bool has_method (MethodInfo meth)
        {
            string name = meth.Name;
            List<METHOD_SOLVER>? lst = null;
            if (method_table.ContainsKey(name)) {
                lst = method_table[name];
            }
            if (lst != null) {
                METHOD_SOLVER m = new METHOD_SOLVER(meth, false);
                foreach (METHOD_SOLVER ms in lst)
                {
                    if (ms.Equals (m)) {
                        return true;
                    } else {
                        if (ms.same_as (m)) {
                            return true;
                        }
                    }
                }
            }
            return false;
        }

        public void add_method (MethodInfo meth)
        {
            if (is_consumed_method (meth)) {
                if (has_method (meth)) {
                    // DEBUG Console.WriteLine("ALREADY HAS " + meth.ToString());
                } else {
                    internal_add_method (meth, false);
                }
            }                
        }

        public void add_event (EventInfo ev)
        {
            MethodInfo? l_meth;
            l_meth = METHOD_RETRIEVER.event_raiser (ev);
            if (l_meth != null) {
                if (is_consumed_method (l_meth)) {
                    internal_add_method (l_meth, false);
                }
            }
            l_meth = METHOD_RETRIEVER.event_adder (ev);
            if (l_meth != null) {
                if (is_consumed_method (l_meth)) {
                    internal_add_method (l_meth, false);
                }
            }
            l_meth = METHOD_RETRIEVER.event_remover (ev);
            if (l_meth != null) {
                if (is_consumed_method (l_meth)) {
                    internal_add_method (l_meth, false);
                }
            }
        }        

        protected void internal_add_method (MethodInfo meth, bool get_property) 
        {
            string dn = meth.Name;
            if (get_property) {
                int len = get_prefix.Length;
                if (dn.Length > len && String.Compare(get_prefix, dn.Substring(0, len), true) == 0) {
                    dn = dn.Substring(len);
                }
            }
            string name = dn;
            List<METHOD_SOLVER>? lst = null;
            if (method_table.ContainsKey(name)) {
                lst = method_table[name];
            }
            if (lst == null) {
                lst = new List<METHOD_SOLVER>();
                method_table.Add(name, lst);
            }
            lst.Add (new METHOD_SOLVER(meth, get_property));
        }
        public string get_prefix = "get_";
    }

    class ARGUMENT_SOLVER : SHARED_NAME_FORMATTER
    {
        protected SHARED_ASSEMBLY_MAPPING shared_assembly_mapping;
        public bool has_error = false;
        public ARGUMENT_SOLVER()
        {
            shared_assembly_mapping = new SHARED_ASSEMBLY_MAPPING();
        }
         
        public CONSUMED_ARGUMENT[] method_arguments(MethodBase info)
        {
        // require
		// 	non_void_method: info /= Void
		// local
		// 	i, count: INTEGER
		// 	en, dn: STRING
		// do
            List<CONSUMED_ARGUMENT> res = new List<CONSUMED_ARGUMENT>(0);

                // FIXME: check why sometime there is an exception:
                // Exception thrown: 'System.NotSupportedException' in System.Reflection.MetadataLoadContext.dll: 'Parsing function pointer types in signatures is not supported.'
            ParameterInfo[]? l_params;
            try {
                l_params = info.GetParameters();
            } catch {
                l_params = null;
                has_error = true;
            }
            if (l_params != null) {
                int i = 0;
                foreach (ParameterInfo p in l_params)
                {
                    string dn;
                    string en;
                    string? l_arg_name = p.Name;
                    if (l_arg_name != null) {
                        dn = l_arg_name;
                        en = SHARED_NAME_FORMATTER.formatted_argument_name (dn, i + 1);
                        if (dn.Length == 0) {
                            dn = en;
                        }
                    } else {
                        en = SHARED_NAME_FORMATTER.formatted_argument_name ("", i + 1);
                        dn = en;
                    }
                    Type? t = p.ParameterType;
                    if (t != null) {
                        CONSUMED_ARGUMENT arg = new CONSUMED_ARGUMENT(dn, en, shared_assembly_mapping.referenced_type_from_type (t));
                        res.Add(arg);
                    }
                    i = i + 1;
                }
            }
            return res.ToArray();
		// ensure
		// 	non_void_arguments: Result /= Void
		// end
        }
        
    }
    class METHOD_SOLVER :  ARGUMENT_SOLVER
    {
        public string eiffel_name;
        public MethodInfo internal_method;
        public CONSUMED_ARGUMENT[] arguments;        
        public bool is_get_property;
        public bool is_conversion_operator = false;
        public METHOD_SOLVER(MethodInfo meth, bool get_property) :  base()
        {
            eiffel_name = "";
            internal_method = meth;
            is_get_property = get_property;
            if (meth.IsSpecialName && (meth.Name.Equals(op_explicit) || meth.Name.Equals(op_implicit))) {
                ParameterInfo[] l_params = meth.GetParameters();
                if (l_params.Length == 1) {
                    Type? vt = Void_type();
                    if (vt == null) {
                        is_conversion_operator = true;
                    } else if (!meth.ReturnType.Equals(vt)) {
                        is_conversion_operator = true;
                    }
                }
            }
            arguments = base.method_arguments (meth);
        }    

        public string dotnet_name()
        {
            return internal_method.Name;
        }
        public void set_eiffel_name (string en)
        {
            eiffel_name = en;
        }
        protected string? internal_start_name = null; 
        static protected Hashtable suffix_table = new Hashtable();       
        public string starting_resolution_name() {
            string? res = internal_start_name;
            if (res != null) {
                return res;
            } else {
                res = dotnet_name();
                if (is_get_property && res.StartsWith("get_")) {
                    res = res.Substring(4);
                } else if (is_conversion_operator) {
                    ParameterInfo[] l_params = internal_method.GetParameters();
                    ParameterInfo? l_param = null;
                    if (l_params.Length > 0) {
                        l_param = l_params[0];
                    }
                    if (l_param != null) {
                        Type l_type = l_param.ParameterType;
                        if (l_type.Equals(internal_method.ReflectedType)) {
                            res = to_conversion_name + formatted_variable_type_name (shared_assembly_mapping.referenced_type_from_type (internal_method.ReturnType).name);
                        } else {
                            res = from_conversion_name + formatted_variable_type_name (shared_assembly_mapping.referenced_type_from_type (l_type).name);
                        }
                    } else {
                        Debug.Assert(false, "parameter_type_attached");
                    }
                }
                if (is_com_interface_member()) {
                    res = res + com_member_suffix();
                }
                internal_start_name = res;
                return res;
            }
        }
        public bool is_com_interface_member()
        {
            Type? t = internal_method.DeclaringType;
            if (t != null) {
                return t.IsInterface && t.IsImport;
            } else {
                return false;
            }
        }
        public string com_member_suffix()
        {
            Type? l_type = internal_method.DeclaringType;
            if (l_type != null) {
                string l_name = l_type.Name;
                string? res = null;
                res = (string?) suffix_table[l_name];
                if (res != null) {
                    return res;
                } else {
                    Type[] l_interfaces = l_type.GetInterfaces();
                    if (l_interfaces.Length > 0) {
                        // Only version if a COM interface inherits another interface.
                        // there is no need to check if the inherited interfaces are COM interfaces, because they should be.
                        // It not then the COM binary will not load.
                        int n = l_name.Length - 1;
                        int i = n;
                        while (i >= 0) {
                            if (Char.IsDigit(l_name[i])) {
                                i = i - 1;
                            } else {
                                i = i + 1;
                                break;
                            }
                        }
                        if (i <= n) {
                            res = "_" + l_name.Substring(i);
                        } else {
                            res = "";
                        }
                    } else {
                        res = "";
                    }
                    if (!suffix_table.Contains(res)) {
                        suffix_table.Add(res, l_name);
                    } else {
                        // FIXME: check why item was already added.
                    }
                    return res;
                }
            }
            return ""; //FIXME: should not happen
        }
        private Type? Void_type() {
            Type? res = Type.GetType("System.Void");
            if (res != null) {
                return res;
            } else {
                Debug.Assert(false, "from documentation");
                return null;
            }
        }

        public bool same_as (METHOD_SOLVER other)
        {
            MethodInfo m1 = internal_method;
            MethodInfo m2 = other.internal_method;
            int n1 = arguments.Length;
            int n2 = other.arguments.Length;
            if (
                n1 == n2 &&
                m1.Name.Equals (m2.Name)
            ) 
			{
				// Check attributes (Public, Static, ...)
                MethodAttributes matt1 = m1.Attributes;
                MethodAttributes matt2 = m2.Attributes;
                if (matt1.Equals(matt2)) {
					// Check ReturnType
	                Type? t1 = m1.ReturnType;
	                Type? t2 = m2.ReturnType;
	                if (t1 != null && t2 != null && ! t1.Equals(t2)) {
						// Check DeclaringType
	                	t1 = m1.DeclaringType;
	                	t2 = m2.DeclaringType;
	                	if (t1 != null && t2 != null && ! t1.Equals(t2)) {
							// Check Arguments
		                	for (var i = 0; i < n1; i++) {
			                    if (! arguments[i].same_as (other.arguments[i])) {
	    	                    	return false;
	        	            	}
	            	    	}
		                } else {
							return false;
	                	}
					} else {
	                    return false;
	                }
				} else {
                    return false;
                }
                return true;
            }
            return false;
        }

        public int CompareTo(METHOD_SOLVER other)
        {
            int n1 = arguments.Length;
            int n2 = other.arguments.Length;
            if (n1 == n2) {
                if (internal_method.IsPublic == other.internal_method.IsPublic) {
                    return 0;
                } else if (internal_method.IsPublic && ! other.internal_method.IsPublic) {
                    return -1;
                } else {
                    return 1;
                }
            } else {
                return n1.CompareTo(n2);
            }
        }
        private string from_conversion_name = "from_";
        private string to_conversion_name = "to_";
        private string op_explicit = "op_Explicit";
        private string op_implicit = "op_Implicit";
    }
    class CONSTRUCTOR_SOLVER : ARGUMENT_SOLVER, IComparable<CONSTRUCTOR_SOLVER>
    {
        public ConstructorInfo internal_constructor;
        public CONSUMED_ARGUMENT[] arguments;
        public bool is_public;
        public string? name;
        public CONSTRUCTOR_SOLVER(ConstructorInfo cons) :  base()
        {
            // base.ARGUMENT_SOLVER(cons);
            internal_constructor = cons;
            arguments = base.method_arguments (cons);
            is_public = cons.IsPublic;
        }
        public CONSUMED_CONSTRUCTOR? consumed_constructor()
        {
            Debug.Assert(name != null, "has attached name");
            Type? declaring_type = internal_constructor.DeclaringType;
            Debug.Assert(declaring_type != null, "has type");
            if (declaring_type != null) {
                var en = name;
                if (en == null) {
                    en = internal_constructor.Name;
                }
                return new CONSUMED_CONSTRUCTOR(en, arguments, is_public, shared_assembly_mapping.referenced_type_from_type(declaring_type));
            } else {
                return null;
            }
        }

        public bool is_less (CONSTRUCTOR_SOLVER other)
        {
            return arguments.Length < other.arguments.Length;
        }
        public int CompareTo(CONSTRUCTOR_SOLVER? other)
        {
            if (other == null) {
                return 1;
            } else {
                return arguments.Length.CompareTo(other.arguments.Length);
            }
        }
        public void set_name (string n)
        {
            name = n;
        }
    }
}
