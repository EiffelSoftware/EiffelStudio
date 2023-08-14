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

    class SHARED_NAME_FORMATTER
    {
        static public NAME_FORMATTER? _name_formatter;

        static public NAME_FORMATTER name_formatter
        {
            get {
                NAME_FORMATTER? nf = _name_formatter;
                if (nf == null) {
                    nf = new NAME_FORMATTER();
                    _name_formatter = nf;
                }
                return nf;
            }
        }
        static public string formatted_type_name (string name, Dictionary<string,string>? used_names)
        {
            return name_formatter.formatted_type_name(name, used_names);
        }    
        static public string formatted_feature_name (string name)
        {
            return name_formatter.formatted_feature_name(name);
        } 
        static public string formatted_argument_name (string name, int pos)
        {
            return name_formatter.formatted_argument_name(name, pos);
        } 
        static public string formatted_variable_type_name (string name)
        {
            return name_formatter.formatted_variable_type_name (name);
        }
    }
    class NAME_FORMATTER
    {
        Dictionary<string, string> full_name_type_mapping_table; // Special types indexed by .NET full name (including namespace)

        Dictionary<string, string> variable_mapping_table; // Protected Eiffel identifiers
        public Dictionary<string, string> unary_operators; // Unary known operators table
        public Dictionary<string, string> binary_operators; // binary known operators table
        Dictionary<string, string> operators; // known operators table
        Dictionary<string, string> argument_mapping_table; // Mapping for type when used in feature name to distinguish between different overloading.

        public NAME_FORMATTER()
        {
            full_name_type_mapping_table = new Dictionary<string,string>();
            init_full_name_type_mapping_table();
            variable_mapping_table = new Dictionary<string,string>();
            init_variable_mapping_table();
            unary_operators = new Dictionary<string,string>();
            init_unary_operators();
            binary_operators = new Dictionary<string,string>();
            init_binary_operators();
            operators = new Dictionary<string,string>();
            operators = operators.Concat(unary_operators).ToDictionary(x=>x.Key,x=>x.Value);
            operators = operators.Concat(binary_operators).ToDictionary(x=>x.Key,x=>x.Value);
            
            argument_mapping_table = new Dictionary<string,string>();
            init_argument_mapping_table();
        }

        public bool has_special_type_name (string fn)
			// -- Does .NET type with full name `a_full_name' has a special
			// -- name in Eiffel?        
        {
            if (full_name_type_mapping_table.ContainsKey(fn)) {
                string? tn;
                if (full_name_type_mapping_table.ContainsKey(fn)) {
                    tn = full_name_type_mapping_table[fn];
                } else {
                    tn = null;
                }
                if (tn != null) {
                    special_type_name = tn;
                    return true;
                } else {
                    special_type_name = null;
                }
            }
            return false;
        }
        public bool was_special()
		// 	-- Did last .NET type whose full name was given to
		// 	-- `has_special_type_name' have a special Eiffel name?
		// 	-- False if `has_special_type_name' was not called.        
        {
            return special_type_name != null;
        }
        public string? special_type_name = null;
        	// -- Eiffel name of .NET type whose full name was given to `has_special_type_name' last

        public string formatted_type_name (string name, Dictionary<string,string>? used_names)
                // -- Format `name' to Eiffel conventions.
            // require
            // 	non_void_name: name /= Void
            // 	valid_name: not name.is_empty and then name.item (1) /= '.'
		{
			string res = full_formatted_type_name (name, used_names);
            if (used_names != null) {
                if (used_names.ContainsKey (res)) {
                    int count = 2;
                    while (used_names.ContainsKey (res)) {
                        res = trim_end_digits(res);
                        res = res + count.ToString();
                        count = count + 1;
                    }
                }
                used_names.Add (res, res);
            }
            return res;
		}

        public string full_formatted_type_name (string name, Dictionary<string,string>? used_names)
                // -- Format .NET type name `name' to Eiffel class name.
        {
            string? res = null;
            string? simple_name;

            if (full_name_type_mapping_table.ContainsKey(name)) {
                res = full_name_type_mapping_table[name];
            }
            if (res != null) {
                return res;
            } else {
                int index = name.Count(c => c == '.');
                if (index > 0) {
                    int count = name.Length;
                    int pos = name.LastIndexOf('.');
                    simple_name =  name.Substring(pos + 1);
                    for (int i = 2; i <= index; i++) {
                        if (used_names != null && !used_names.ContainsKey(simple_name)) {
                            break;
                        }
                        pos = name.LastIndexOf('.', pos - 1);
                        simple_name =  name.Substring(pos + 1);

                    }
                } else {
                    simple_name = name;
                }
                string sn_low = simple_name.ToLower();
                if (variable_mapping_table.ContainsKey(sn_low)) {
                    res = variable_mapping_table[sn_low];
                } else {
                    res = null;
                }
                if (res != null) {
                    return res;
                } else {
                    if (simple_name.EndsWith("[]")) {
                        return "NATIVE_ARRAY [" + full_formatted_type_name(simple_name.Substring(0, simple_name.Length - 2), used_names) + "]";
                    } else {
                        int i = simple_name.IndexOf('+');
                        if (i > 0) {
                            string container = simple_name.Substring(0, i);
                            string nested = simple_name.Substring(i+1);
                                //  -- Estimated allocation size.
                            return full_formatted_type_name (nested, used_names) + "_IN_" + full_formatted_type_name(container, used_names);
                        } else {
                            if (simple_name.EndsWith("&")) {
                                return simple_name.Substring(0,simple_name.Length-1);
                            } else {
                                res = simple_name;
                                res = res.Replace(".", "_");
                                res = res.Replace("___", "_");
                                res = res.Replace("__", "_");
                                if (res.StartsWith("_")) {
                                    res = "C" + res;
                                } else if (Char.IsDigit(res[0])) {
                                    res = "C_" + res;
                                }
                                res = eiffel_format (res, true);
                                return res.ToUpper();
                            }
                        }
                    }
                }
            }   
        }

        private string 	eiffel_format (string s, bool a_class_format)
			// -- Format from CamelCase to eiffel_case
        {
            string res;
            res = "" + Char.ToLower(s[0]);
            int nb = s.Length;
            if (nb >= 2) {
                char p = s[0];
                char c = s[1];
                
                bool put_us;
                for (int i = 1; i + 1 < nb; i++) { //Stop before the end of `s`
                    char n = s[i+1];
                    put_us = false;
                    if (c != '_') {
                        if (Char.IsDigit(c) && !Char.IsDigit(p) && p != '_' && ! Char.IsUpper(p)) {
                            // add '_' before a digit only if nor preceded by uppercase characters
		                    // UTF8Decoder = UTF8_DECODER, Border3D = BORDER_3D
                            put_us = true;
                        } else if (Char.IsDigit(p) && !Char.IsDigit(c)) {
                            if (n != '_' && ! Char.IsDigit(n)) {
                                // 3dd = 3_dd, 3Dd = 3_Dd, 3DD = 3DD, 3dD = 3d_D, 3D_ = 3D_, 3d_ = 3d_
                                put_us = (Char.IsLower(c) && Char.IsLower(n)) 
                                            || (Char.IsUpper(c) && Char.IsLower(n));  
                            }
                        } else if (Char.IsUpper(p) && Char.IsUpper(c) && Char.IsLower(n)) {
                            if (a_class_format) {
                        		// allows IInterfaceName = IINTERFACE_NAME, CClassName = CCLASS_NAME, SServiceName = SSERVICE_NAME but FBar = F_BAR as per other rules, but allows UICues = UI_CUES
                                if (i == 1) {
                                    put_us = p != 'I' && p != 'C' && p != 'S';                          
                                } else {
                                    put_us = i > 1;
                                }
                            } else {
									// allows IUnknown = iunknown, SetIUnknown = set_iunknown and SetFBar = set_f_bar
                                if (i >= 2) {
                                    if (!Char.IsUpper(s[i-2])) {
                                        put_us = p != 'I';
                                    } else {
                                        put_us = true;
                                    }
                                } else {
                                    if (i == 1) {
                                        put_us = p != 'I';
                                    } else {
                                        put_us = i > 1;
                                    }
                                }
                            }
                        } else if (Char.IsLower(p) && Char.IsUpper(c)) {
                            put_us = true;                            
                        }
                    } else {
                        put_us = false;                        
                    }
                    if (put_us) {
                        res = res + "_";
                    }
                    res = res + Char.ToLower(c);

                    p = c;
                    c = n;
                }
                if ((Char.IsLetter(p) && Char.IsLower(p) && Char.IsDigit(c)) || (Char.IsLower(p) && Char.IsUpper(c))) {
                    res =  res + "_";
                }
                res = res + Char.ToLower(c);
            }
            return res;
        }

        public string formatted_feature_name (string name)
                // -- Format `name` to Eiffel conventions.
        {
        // require
        //     non_void_name: name /= Void
        //     not_name_is_empty: not name.is_empty
        // local
        //     l_name: STRING
        // do
            string? res = null;
            if (operators.ContainsKey(name)) {
                res = operators[name];
            }
            if (res != null) {
                return res;
            } else {
                res = name;
                if (res.Length == 0) {
                    // do nothing;
                } else if (res[0] == '_') {
                    res = 'm' + res;
                } else if (Char.IsDigit(res[0])) {
                    res = "m_" + res;
                }
                return formatted_variable_name(res);
            }
        // ensure
        //     non_void_result: Result /= Void
        }

        public string formatted_argument_name (string name, int pos)
                // -- Format argument at position `pos'.
        {
            // require
            // 	name_not_void: name /= Void
            // local
            // 	l_name: STRING
            // do
            if (name.Length == 0) {
                return "arg_" + pos.ToString();
            } else {
                string n;
                if (name[0] == '_') {
                    n = 'a' + name;
                } else if (Char.IsDigit(name[0])) {
                    n = "a_" + name;
                } else {
                    n = name;
                }
                return formatted_variable_name (n);
            }
            // ensure
            // 	formatted_argument_name_not_void: Result /= Void
            // end
        }

        public string formatted_variable_name (string name)
			// -- Format `name' to Eiffel conventions
        {
		// require
		// 	non_void_name: name /= Void
		// 	name_not_empty: not name.is_empty
		// local
		// 	l_name: STRING
		// 	l_var: like variable_mapping_table
		// do
		// 		-- resolve conflict names
            string? res = null;
            string l_name = name.ToLower();
            Dictionary<string, string> l_var = variable_mapping_table;
            if (l_var.ContainsKey(l_name)) {
                res = l_var[l_name];
            }
            if (res != null) {
                return res;
            } else {
                res = name;
                if (res.EndsWith('&')) {
                    res = res.Substring(0, res.Length - 1);
                }
                res.Replace(".", "_");
                res.Replace("___", "_");
                res.Replace("__", "_");
                if (!Char.IsLetter(res[0])) {
                    res = 'l' + res;
                }
                return eiffel_format(res, false);
            }
		// ensure
		// 	non_void_result: Result /= Void
		// end
        }

        public string formatted_variable_type_name (string name)
        // Format variable name that represents a type into Eiffel naming convention.
        {
		// require
		// 	non_void_name: name /= Void
		// local
		// 	i, index: INTEGER
		// 	container, nested: STRING
		// 	l_arg: like argument_mapping_table
		// do
            int index = name.LastIndexOf('.');
            string res;
            if (index >= 0) {
                res = name.Substring(index + 1);
            } else {
                res = name;
            }
            if (name.EndsWith("&")) {
                res = res.Substring(0, res.Length - 1);
            }
            var l_arg = argument_mapping_table;
            string? l_found_item = null;
            if (l_arg.ContainsKey(res)) {
                l_found_item = l_arg[res];
            }
            if (l_found_item != null) {
                res = l_found_item;
            } else {
                int i = name.IndexOf('+');
                if (i >= 0) {
                    string container = name.Substring(0, i - 1);
                    string nested = name.Substring(i + 1);
                    res = formatted_variable_type_name (nested) + in_string + formatted_variable_type_name (container);
                } else {
                    if (res.EndsWith("]")) {
                        string container = res.Substring(0, res.Length - 2);
                        res = formatted_variable_type_name(container) + array_string;
                    }
                    res.Replace(".", "_");
                    res.Replace("___", "_");
                    res.Replace("__", "_");
                    if (res.StartsWith("_")) {
                        res = "C" + res;
                    } else if (Char.IsDigit(res[0])) {
                        res = "C_" + res;
                    }
                    res = eiffel_format(res, true);
                }
            }
            return res;
		// ensure
		// 	non_void_result: Result /= Void
		// end
        }

        public string in_string = "_IN_";
        public string array_string = "_array";


        static public string trim_end_digits(string str)
			// -- Remove end digits from `s' and append `_' if needed.
        {
            string res = str;
            int pos = str.Length;
            for (int i = pos; i > 0; i--) 
            {
                char ch = str[i - 1];
                if (Char.IsDigit(ch)) {
                    pos = pos - 1;
                }
            }
            if (pos < str.Length) {
                res = str.Remove(pos - 1);
            } else {
                res = str;
            }
            if (res[res.Length-1] != '_') {
                res = res + '_';

            }
            return res;
        }

        private void init_full_name_type_mapping_table()
        {
            Dictionary<string,string> tb = full_name_type_mapping_table;
			tb.Add ("System.UInt32", "NATURAL_32");
			tb.Add ("System.UInt64", "NATURAL_64");
			tb.Add ("System.UInt16", "NATURAL_16");
			tb.Add ("System.Byte", "NATURAL_8");
			tb.Add ("System.Int32", "INTEGER");
			tb.Add ("System.Int64", "INTEGER_64");
			tb.Add ("System.Int16", "INTEGER_16");
			tb.Add ("System.SByte", "INTEGER_8");
			tb.Add ("System.Char", "CHARACTER");
			tb.Add ("System.Double", "DOUBLE");
			tb.Add ("System.Single", "REAL");
			tb.Add ("System.Boolean", "BOOLEAN");
			tb.Add ("System.UIntPtr", "POINTER");
			tb.Add ("System.IntPtr", "POINTER");
			tb.Add ("System.ValueType", "VALUE_TYPE");
			tb.Add ("System.Enum", "ENUM");
			tb.Add ("System.Object", "SYSTEM_OBJECT");
			tb.Add ("System.String", "SYSTEM_STRING");
			tb.Add ("System.Array", "SYSTEM_ARRAY");
			tb.Add ("System.Collections.Queue", "SYSTEM_QUEUE");
			tb.Add ("System.Console", "SYSTEM_CONSOLE");
			tb.Add ("System.IO.Stream", "SYSTEM_STREAM");
			tb.Add ("System.IO.MemoryStream", "SYSTEM_MEMORY_STREAM");
			tb.Add ("System.Collections.Stack", "SYSTEM_STACK");
			tb.Add ("System.IO.Directory", "SYSTEM_DIRECTORY");
			tb.Add ("System.IO.File", "SYSTEM_FILE");
			tb.Add ("System.IO.FileInfo", "SYSTEM_FILE_INFO");
			tb.Add ("System.IO.Path", "SYSTEM_PATH");
			tb.Add ("System.DateTime", "SYSTEM_DATE_TIME");
			tb.Add ("System.Collections.SortedList", "SYSTEM_SORTED_LIST");
			tb.Add ("System.Random", "SYSTEM_RANDOM");
			tb.Add ("System.ComponentModel.Container", "SYSTEM_CONTAINER");
			tb.Add ("System.Convert", "SYSTEM_CONVERT");
			tb.Add ("System.Type", "SYSTEM_TYPE");
			tb.Add ("System.Void", "SYSTEM_VOID");
			tb.Add ("System.Reflection.Pointer", "SYSTEM_POINTER");
			tb.Add ("System.Tuple", "SYSTEM_TUPLE");

				// -- Specialize implementations
			tb.Add ("System.Attribute", "NATIVE_ATTRIBUTE");
			tb.Add ("System.Exception", "NATIVE_EXCEPTION");

				// -- Threading conflicts
			tb.Add ("System.Threading.Thread", "SYSTEM_THREAD");
			tb.Add ("System.Threading.Mutex", "SYSTEM_MUTEX");

				// -- Zone
			tb.Add ("System.Security.Policy.Zone", "SYSTEM_ZONE");
        }

        private void init_variable_mapping_table()
        {
            Dictionary<string,string> tb = variable_mapping_table;
			// -- Special case for `make'
			tb.Add ("make", "make_");

			// -- Eiffel keywords
			tb.Add ("agent", "agent_");
			tb.Add ("alias", "alias_");
			tb.Add ("all", "all_");
			tb.Add ("and", "and_");
			tb.Add ("as", "as_");
			tb.Add ("assign", "assign_");
			tb.Add ("attribute", "attribute_");
			tb.Add ("bit", "bit_");
			tb.Add ("check", "check_");
			tb.Add ("class", "class_");
			tb.Add ("convert", "convert_");
			tb.Add ("create", "create_");
			tb.Add ("creation", "creation_");
			tb.Add ("current", "current_");
			tb.Add ("debug", "debug_");
			tb.Add ("deferred", "deferred_");
			tb.Add ("do", "do_");
			tb.Add ("else", "else_");
			tb.Add ("elseif", "elseif_");
			tb.Add ("end", "end_");
			tb.Add ("ensure", "ensure_");
			tb.Add ("expanded", "expanded_");
			tb.Add ("export", "export_");
			tb.Add ("external", "external_");
			tb.Add ("false", "false_");
			tb.Add ("feature", "feature_");
			tb.Add ("from", "from_");
			tb.Add ("frozen", "frozen_");
			tb.Add ("if", "if_");
			tb.Add ("implies", "implies_");
			tb.Add ("indexing", "indexing_");
			tb.Add ("infix", "infix_");
			tb.Add ("inherit", "inherit_");
			tb.Add ("inspect", "inspect_");
			tb.Add ("invariant", "invariant_");
			tb.Add ("is", "is_");
			tb.Add ("like", "like_");
			tb.Add ("local", "local_");
			tb.Add ("loop", "loop_");
			tb.Add ("not", "not_");
			tb.Add ("obsolete", "obsolete_");
			tb.Add ("old", "old_");
			tb.Add ("once", "once_");
			tb.Add ("or", "or_");
			tb.Add ("prefix", "prefix_");
			tb.Add ("precursor", "precursor_");
			tb.Add ("pure", "pure_");
			tb.Add ("redefine", "redefine_");
			tb.Add ("reference", "reference_");
			tb.Add ("rename", "rename_");
			tb.Add ("require", "require_");
			tb.Add ("rescue", "rescue_");
			tb.Add ("result", "result_");
			tb.Add ("retry", "retry_");
			tb.Add ("select", "select_");
			tb.Add ("separate", "separate_");
			tb.Add ("strip", "strip_");
			tb.Add ("then", "then_");
			tb.Add ("true", "true_");
			tb.Add ("tuple", "tuple_"); // FIXME was tupple !
			tb.Add ("undefine", "undefine_");
			tb.Add ("unique", "unique_");
			tb.Add ("until", "until_");
			tb.Add ("variant", "variant_");
			tb.Add ("void", "void_");
			tb.Add ("when", "when_");
			tb.Add ("xor", "xor_");
			tb.Add (".ctor", "make");
        }      
        private void init_argument_mapping_table()
            // -- Mapping for type when used in feature name to distinguish between
            // -- different overloading.
        {
            Dictionary<string,string> tb = argument_mapping_table;
            tb.Add ("Boolean", "boolean");
            tb.Add ("Char", "character");
            tb.Add ("Byte", "natural_8");
            tb.Add ("SByte", "integer_8");
            tb.Add ("UInt16", "natural_16");
            tb.Add ("Int16", "integer_16");
            tb.Add ("UInt32", "natural_32");
            tb.Add ("Int32", "integer_32");
            tb.Add ("IntPtr", "pointer");
            tb.Add ("UInt64", "natural_64");
            tb.Add ("Int64", "integer_64");
            tb.Add ("Double", "double");
            tb.Add ("Single", "real");
        }  
		private void init_unary_operators() 
			// -- Unary known operators table.
		{
            Dictionary<string,string> tb = unary_operators;

			tb.Add ("op_Decrement", "#--");
			tb.Add ("op_Increment", "#++");
			tb.Add ("op_UnaryNegation", "-");
			tb.Add ("op_UnaryPlus", "+");
			tb.Add ("op_LogicalNot", "not");
			tb.Add ("op_True", "#true");
			tb.Add ("op_False", "#false");
			tb.Add ("op_AddressOf", "&");
			tb.Add ("op_OnesComplement", "#~");
			tb.Add ("op_PointerDereference", "*");
        }

        private void init_binary_operators() 
			// -- binary known operators table.
		{
            Dictionary<string,string> tb = binary_operators;

			tb.Add ("op_Addition" , "+");
			tb.Add ("op_Subtraction", "-");
			tb.Add ("op_Multiply",  "*");
			tb.Add ("op_Division",  "/");
			tb.Add ("op_Modulus",  "\\");
			tb.Add ("op_ExclusiveOr",  "xor");
			tb.Add ("op_BitwiseAnd", "&");
			tb.Add ("op_BitwiseOr", "|");
			tb.Add ("op_LogicalAnd", "and");
			tb.Add ("op_LogicalOr", "or");
			tb.Add ("op_Assign", "#=");
			tb.Add ("op_LeftShift", "#<<");
			tb.Add ("op_RightShift", "#>>");
			tb.Add ("op_SignedRightShift", "#|>>");
			tb.Add ("op_UnsignedRightShift", "|>>");
			tb.Add ("op_Equality", "#==");
			tb.Add ("op_GreaterThan", ">");
			tb.Add ("op_LessThan", "<");
			tb.Add ("op_Inequality", "|=");
			tb.Add ("op_GreaterThanOrEqual", ">=");
			tb.Add ("op_LessThanOrEqual", "<=");
			tb.Add ("op_UnsignedRightShiftAssignment", "#|>>=");
			tb.Add ("op_MemberSelection", "#->");
			tb.Add ("op_RightShiftAssignment", "#>>=");
			tb.Add ("op_MultiplicationAssignment", "#*=");
			tb.Add ("op_PointerToMemberSelection", "#->*");
			tb.Add ("op_SubtractionAssignment", "#-=");
			tb.Add ("op_ExclusiveOrAssignment", "#^=");
			tb.Add ("op_LeftShiftAssignment", "#<<=");
			tb.Add ("op_ModulusAssignment", "#\\=");
			tb.Add ("op_AdditionAssignment", "#+=");
			tb.Add ("op_BitwiseAndAssignment", "#&=");
			tb.Add ("op_BitwiseOrAssignment", "#|=");
			tb.Add ("op_Comma", "#,");
			tb.Add ("op_DivisionAssignment", "#/=");
		}
    }
}
