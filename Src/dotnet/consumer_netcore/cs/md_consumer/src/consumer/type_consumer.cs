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
// using System.Diagnostics.CodeAnalysis;


namespace md_consumer
{
	class TYPE_CONSUMER : REFLECTION
    {
        public Type system_type;
        public string eiffel_name;
		public CONSUMED_TYPE consumed_type;
		public MemberInfo[] internal_members;
		public PropertyInfo[] internal_properties;
		public EventInfo[] internal_events;
		public ConstructorInfo[] internal_constructors;
		public CONSUMED_REFERENCED_TYPE internal_referenced_type;
		public Hashtable properties_and_events;
		protected NAME_SOLVER name_solver = new NAME_SOLVER();
		protected ARGUMENT_SOLVER argument_solver = new ARGUMENT_SOLVER();
		protected OVERLOAD_SOLVER overload_solver;
		public int assembly_id=-1;


        public TYPE_CONSUMER(Type t, string en, int aid=-1)
        {
			shared_assembly_mapping = new SHARED_ASSEMBLY_MAPPING();
			assembly_id=aid;
            system_type = t;
            eiffel_name = en;

			properties_and_events = new Hashtable();
		 	overload_solver = new OVERLOAD_SOLVER();
			name_solver.reset_reserved_names (0);
			internal_members = new MemberInfo[0];
			internal_properties = new PropertyInfo[0];
			internal_events = new EventInfo[0];
			internal_constructors = new ConstructorInfo[0];

			internal_referenced_type = referenced_type_from_type (t);

		    string dotnet_name;
			if (t.FullName != null) {
	            dotnet_name = t.FullName;
			} else {
				dotnet_name = t.Name;
			}

			/* workaround for nullable system 
				`consumed_type` will be (re) computed in initialize_type_consumer
			*/
			consumed_type = new CONSUMED_TYPE(
				dotnet_name, eiffel_name, t.IsInterface, t.IsAbstract,
					false, t.IsValueType, t.IsEnum, null, new List<CONSUMED_REFERENCED_TYPE>(0)
			);
			if (assembly_id >= 0) {
				// Type info only for forwarded type
				initialize_type_base_consumer(t, en, dotnet_name, false, null, new List<CONSUMED_REFERENCED_TYPE>(0));
			} else {
				initialize_type_consumer(t, en, dotnet_name);
			}
			consumed_type.assembly_id = assembly_id;
		}

		protected void initialize_type_base_consumer(Type t, string en, string dotnet_name, bool force_sealed, CONSUMED_REFERENCED_TYPE? parent, List<CONSUMED_REFERENCED_TYPE> interfaces)
		{
			if (t.IsNestedPublic || t.IsNestedFamily || t.IsNestedFamORAssem) {
					// -- `t.declaring_type' contains enclosing type of current nested type.
				Type? l_decl_type = t.DeclaringType;
				if (l_decl_type != null) {
					Debug.Assert(is_consumed_type (l_decl_type), "is_declaring_type_consumed");
					CONSUMED_REFERENCED_TYPE enc_type = referenced_type_from_type(l_decl_type);
					consumed_type = new CONSUMED_NESTED_TYPE(
							dotnet_name, en, t.IsInterface, (! force_sealed && t.IsAbstract),
							force_sealed, t.IsValueType, t.IsEnum, parent, interfaces,
							enc_type
						);
				} else {
					Debug.Assert(false, "declaring_type_attached");
					consumed_type = new CONSUMED_TYPE(
							dotnet_name, en, t.IsInterface, (! force_sealed && t.IsAbstract),
							force_sealed, t.IsValueType, t.IsEnum, parent, interfaces
						);
				}
			} else {
				consumed_type = new CONSUMED_TYPE(
							dotnet_name, en, t.IsInterface, (! force_sealed && t.IsAbstract),
							force_sealed, t.IsValueType, t.IsEnum, parent, interfaces
						);
			}
			if (assembly_id >= 0) {
				consumed_type.assembly_id = assembly_id;
			}			
		}

		protected void initialize_type_consumer(Type t, string en, string dotnet_name)
		{
			List<CONSUMED_REFERENCED_TYPE> interfaces;
			CONSUMED_REFERENCED_TYPE? parent = null;
			int nb, count;
			Type? parent_type;
			bool l_force_sealed;

			if (!t.IsInterface) {
				parent_type = consumed_parent (t);
				if (parent_type != null) {
					parent = referenced_type_from_type (parent_type);
				}
			}

			Type[]? inter = null;
			try {
				inter = t.GetInterfaces();
			} catch {
				STATUS_PRINTER.debug("Failure with GetInterface() on type "+ t.ToString());
				inter = null;
			}
			if (inter != null) {
				nb = inter.Length;
				interfaces = new List<CONSUMED_REFERENCED_TYPE>();
				count = 0;
				foreach (Type l_type in inter)
				{
					if (is_consumed_type (l_type)) {
						count = count + 1;
						CONSUMED_REFERENCED_TYPE? crt = referenced_type_from_type(l_type);
						if (crt != null) {
							interfaces.Add(crt);
						}					
					}
				}
			} else {
				interfaces = new List<CONSUMED_REFERENCED_TYPE>();
			}

			l_force_sealed = t.IsSealed;
			if (!l_force_sealed && (t.IsInterface || t.IsAbstract)) {
					// -- Enum and ValueType should not be descended from in Eiffel
				l_force_sealed = t.Equals (typeof (System.Enum)) || t.Equals (typeof (System.ValueType));
				if (!l_force_sealed) {
						// -- For non-Eiffel compliant interfaces we need to force them to be frozen
						// -- so they cannot be descended, which would result in an incomplete interface
						// -- implementation, because of the non-compliant members
					EC_CHECKED_TYPE? ct = checked_type(t);
					EC_CHECKED_ABSTRACT_TYPE? l_ab_type = null;
					if (ct != null && ct is EC_CHECKED_ABSTRACT_TYPE) {
						l_ab_type = (EC_CHECKED_ABSTRACT_TYPE) ct;
					}
					if (l_ab_type != null) {
						l_force_sealed = ! l_ab_type.is_eiffel_compliant_interface();
					}
				}
			}

			initialize_type_base_consumer(t, en, dotnet_name, l_force_sealed, parent, interfaces);

			if (t.IsInterface) {
					// -- Lookup members of current interface `t' but also add members coming
					// -- from parent interfaces as `t.get_members_binding_flags' does not do it.
				update_interface_members (t);
 			}
			else {
		 		MemberInfo[] l_members = t.GetMembers(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
				MethodInfo[] l_obj_methods = (typeof (Object)).GetMethods(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
					// -- Add static features of System.Object for correct overload resolution (because of interfaces inheriting System.Object)
				int l_members_count = l_members.Length;
				internal_members = new MemberInfo[l_members_count + l_obj_methods.Length];
				l_members.CopyTo(internal_members, 0);
				if (!t.Equals(typeof(Object))) {
					l_obj_methods.CopyTo(internal_members, l_members_count);
				}

		 		PropertyInfo[] l_properties = t.GetProperties(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
				internal_properties = new PropertyInfo[l_properties.Length];
				l_properties.CopyTo(internal_properties, 0);

				EventInfo[] l_events = t.GetEvents(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
				internal_events = new EventInfo[l_events.Length];
				l_events.CopyTo(internal_events, 0);
		
			}

			ConstructorInfo[] l_constructors = t.GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			internal_constructors = new ConstructorInfo[l_constructors.Length];
			l_constructors.CopyTo(internal_constructors, 0);

			internal_referenced_type = referenced_type_from_type (t); /* FIXME: remove as it is already done at the beginning? */

			
		// ensure
		// 	non_void_consumed_type: consumed_type /= Void
		// 	non_void_internal_constructors: internal_constructors /= Void
		// 	non_void_internal_members: internal_members /= Void
		// 	non_void_internal_methods: internal_members /= Void
		// 	non_void_internal_properties: internal_properties /= Void
		// 	non_void_internal_events: internal_events /= Void
		// 	non_void_internal_referenced_type: internal_referenced_type /= Void
		// end            
        }

		protected SHARED_ASSEMBLY_MAPPING shared_assembly_mapping;
		protected CONSUMED_REFERENCED_TYPE referenced_type_from_type (Type t)
		{
			return shared_assembly_mapping.referenced_type_from_type(t);
		}	

		public CONSUMED_FIELD? consumed_field (FieldInfo info)
		// 	-- Eiffel attribute from `info'.
		{
		// require
		// 	non_void_field_info: info /= Void
		// 	is_consumed_field: is_consumed_field (info)
		// local
		// 	dotnet_name: STRING
		// 	l_value: SYSTEM_OBJECT
		// 	l_code: TYPE_CODE
		// do
			string dotnet_name = info.Name;
			Type? l_type = info.DeclaringType;
			if (l_type != null) {
				Type l_field_type = info.FieldType;
				if (info.IsLiteral) {
		 			Object l_value = field_value (info);
		 			if (l_field_type.IsEnum) {
							// -- Conversion to integer is required to get associated value of `info',
							// -- Otherwise we simply get an object where calling `ToString' on it
							// -- will print out field name.
		 				TypeCode l_code = System.Convert.GetTypeCode (l_value);
						switch (l_code) {
							case TypeCode.Int16: l_value = System.Convert.ToInt16 (l_value); break;
							case TypeCode.Int32: l_value = System.Convert.ToInt32 (l_value); break;
							case TypeCode.Int64: l_value = System.Convert.ToInt64 (l_value); break;
							case TypeCode.UInt16: l_value = System.Convert.ToUInt16 (l_value); break;
							case TypeCode.UInt32: l_value = System.Convert.ToUInt32 (l_value); break;
							case TypeCode.UInt64: l_value = System.Convert.ToUInt64 (l_value); break;
							case TypeCode.Double: l_value = System.Convert.ToDouble (l_value); break;
							case TypeCode.Single: l_value = System.Convert.ToSingle (l_value); break;
							case TypeCode.Char: l_value = System.Convert.ToChar (l_value); break;
							case TypeCode.Boolean: l_value = System.Convert.ToBoolean (l_value); break;
							default: l_value = System.Convert.ToInt32 (l_value); break;
						}
					}
					return new CONSUMED_LITERAL_FIELD (
							name_solver.unique_feature_name (dotnet_name),
							dotnet_name,
							referenced_type_from_type (l_field_type),
							info.IsStatic,
							info.IsPublic,
							literal_field_value (l_value),
							referenced_type_from_type (l_type)
						);
				} else {
					return new CONSUMED_FIELD (
							name_solver.unique_feature_name (dotnet_name),
							dotnet_name,
							referenced_type_from_type (l_field_type),
							info.IsStatic,
							info.IsPublic,
							info.IsInitOnly,
							referenced_type_from_type (l_type)
						);				
				}
			} else {
				Debug.Assert(false, "from doc");
			}
			return null;
		}

		public CONSUMED_PROCEDURE? consumed_procedure (MethodInfo info, bool property_or_event)
		// 	-- Consumed procedure.
		{
		// require
		// 	non_void_info: info /= Void
		// local
		// 	l_unique_eiffel_name: STRING
		// 	l_dotnet_name: STRING
		// do
			if (is_consumed_method (info)) {
				string l_info_name = info.Name;
				Type? l_decl_type = info.DeclaringType;
				if (l_decl_type != null) {
					string l_dotnet_name = l_info_name;
					try {
						string? l_unique_eiffel_name = overload_solver.unique_eiffel_name (l_info_name, info.GetParameters(), info.ReturnType, l_decl_type);
						if (l_unique_eiffel_name == null) {
							l_unique_eiffel_name = l_info_name;
						}
						var proc = new CONSUMED_PROCEDURE (
								l_unique_eiffel_name,
								l_dotnet_name,
								SHARED_NAME_FORMATTER.formatted_feature_name (l_dotnet_name),
								argument_solver.method_arguments(info),
								info.IsFinal,
								info.IsStatic,
								info.IsAbstract,
								info.IsPublic,
								(((int)info.Attributes) & (int)MethodAttributes.NewSlot) == (int)MethodAttributes.NewSlot,
								info.IsVirtual,
								property_or_event,
								referenced_type_from_type (l_decl_type)
							);
						update_generic_info (info, proc);
						return proc;				
					} catch {
						// FIXME: exception due to function pointer... info.GetParameters() and info.ReturnType.
						return null;
					}
				} else {
					Debug.Assert(false, "from doc");
				}
			}
			return null;
		}

		public CONSUMED_FUNCTION? consumed_function (MethodInfo info, bool property_or_event)
			// -- Consumed function.
		{
		// require
		// 	non_void_info: info /= Void
		// local
		// 	l_unique_eiffel_name: STRING
		// 	l_dotnet_name: STRING
		// do
			if (is_consumed_method (info)) {
				Type? l_decl_type = info.DeclaringType;
				if (l_decl_type != null) {
					string l_info_name = info.Name;
					Type l_ret_type = info.ReturnType;
					string l_dotnet_name = l_info_name;
		 			string? l_unique_eiffel_name = overload_solver.unique_eiffel_name (l_info_name, info.GetParameters(), l_ret_type, l_decl_type);
					if (l_unique_eiffel_name == null) {
						l_unique_eiffel_name = l_info_name;
					}
					var fct = new CONSUMED_FUNCTION (
							l_unique_eiffel_name,
							l_dotnet_name,
							SHARED_NAME_FORMATTER.formatted_feature_name (l_dotnet_name),
							argument_solver.method_arguments(info),
							referenced_type_from_type (l_ret_type),
							info.IsFinal,
							info.IsStatic,
							info.IsAbstract,
							is_infix(info),
							is_prefix(info),
							info.IsPublic,
							(((int)info.Attributes) & (int)MethodAttributes.NewSlot) == (int)MethodAttributes.NewSlot,
							info.IsVirtual,
							property_or_event,
							referenced_type_from_type (l_decl_type)
						);
					update_generic_info (info, fct);
					return fct;				
				} else {
					Debug.Assert(false, "from doc");
				}
			}
			return null;
		}

		protected void update_generic_info (MethodInfo info, CONSUMED_PROCEDURE proc)
			// Update `proc` with generic method info if any.
		{
			if (info.IsGenericMethod) {
				Type[] typeArguments = info.GetGenericArguments();
				string[] generic_parameters = new string[typeArguments.Length];
				foreach (Type tParam in typeArguments) {

					generic_parameters[tParam.GenericParameterPosition] = tParam.Name;
					//Console.WriteLine("{0} param pos {1} decl meth {2}", tParam, tParam.GenericParameterPosition, tParam.DeclaringMethod);
				}
				proc.set_is_generic_method(true, generic_parameters);
			}
		}

		public CONSUMED_PROPERTY? consumed_property (PropertyInfo info)
			// -- Process property `info'.
		{
		// require
		// 	non_void_property_info: info /= Void
		// local
		// 	l_getter: CONSUMED_FUNCTION
		// 	l_setter: CONSUMED_PROCEDURE
		// 	l_info: METHOD_INFO
		// do
			MethodInfo? l_info = null;
			CONSUMED_FUNCTION? l_getter = null;
			CONSUMED_PROCEDURE? l_setter = null;

			if (info.CanRead) {
		 		l_info = METHOD_RETRIEVER.property_getter (info);
		 		if (l_info != null) {
					l_getter = consumed_function (l_info, true);
					if (l_getter != null && l_getter.is_excluded()) {
						l_getter = null;
					}
		 		}
			}
			if (info.CanWrite) {
		 		l_info = METHOD_RETRIEVER.property_setter (info);
		 		if (l_info != null) {
					l_setter = consumed_procedure (l_info, true);
					if (l_setter != null && l_setter.is_excluded()) {
						l_setter = null;
					}
		 		}				
			}
			if (l_info != null) {
				if (l_getter != null || l_setter != null) {
					Type? l_type = info.DeclaringType;
		 			if (l_type != null) {
						return new CONSUMED_PROPERTY(
								info.Name,
								l_info.IsPublic,
								l_info.IsStatic,
								referenced_type_from_type (l_type),
								l_getter,
								l_setter
						);
					} else {
						Debug.Assert(false, "from_documentation_declaring_type_attached");
					}
				}
			}
			return null;
		}

		public CONSUMED_EVENT? consumed_event (EventInfo info)
			// -- Process event `info'.
		{
		// require
		// 	non_void_event_info: info /= Void

			MethodInfo? l_add_method = info.GetAddMethod(true);
			MethodInfo? l_remove_method = info.GetRemoveMethod(true);
			MethodInfo? l_raise_method = info.GetRaiseMethod(true);
			CONSUMED_PROCEDURE? l_adder = null;
			CONSUMED_PROCEDURE? l_remover = null;
			CONSUMED_PROCEDURE? l_raiser = null;

			if (l_raise_method != null) {
				l_raiser = consumed_procedure (l_raise_method, true);
				if (l_raiser != null && l_raiser.is_excluded()) {
					l_raiser = null;
				}
			}
			if (l_add_method != null) {
				l_adder = consumed_procedure (l_add_method, true);
				if (l_adder != null && l_adder.is_excluded()) {
					l_adder = null;
				}
			}
			if (l_remove_method != null) {
				l_remover = consumed_procedure (l_remove_method, true);
				if (l_remover != null && l_remover.is_excluded()) {
					l_remover = null;
				}				
			}
			string dotnet_name = info.Name;
			if (l_remover != null || l_raiser != null || l_adder != null) {
				Type? l_type = info.DeclaringType;
				if (l_type != null) {
					return new CONSUMED_EVENT(
							dotnet_name,
							true,
							referenced_type_from_type (l_type),
							l_raiser,
							l_adder,
							l_remover
						);
				} else {
					Debug.Assert(false, "from_documentation_declaring_type_attached");
				}
			}
			return null;
		}

		public Type? consumed_parent (Type a_type)
			// -- Retrieves a consume parent of `a_type'.
		// require
		// 	a_type_attached: a_type /= Void
		{
			Type? l_base = a_type.BaseType;
			if (l_base != null) {
				if (is_consumed_type (l_base)) {
					return l_base;
				} else {
					return consumed_parent (l_base);
				}
			}
			return null;
		}

		public Dictionary<string, MethodInfo> object_methods()
			// -- List of members of System.Object.
		{
			Dictionary<string, MethodInfo> res = new Dictionary<string, MethodInfo>();
			MethodInfo[] l_methods = (typeof (Object)).GetMethods(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
			foreach(MethodInfo l_meth in l_methods)
			{
				if (l_meth.IsPublic || l_meth.IsFamily || l_meth.IsFamilyOrAssembly)
				{
					res.Add(object_key_name(l_meth), l_meth);
				}
			}
			return res;
		// ensure
		// 	object_methods: Result /= Void
		}

		protected void update_interface_members (Type t)
			// -- Updates members of interface to present a flat list of members and to include members of System.Object.
		{
			
	// 	local
			Hashtable l_processed;
			int i;
			// , j, k, nb;
			bool l_matched=false;
			string l_meth_name;
			l_processed = new Hashtable();

			internal_members = new MemberInfo[0];
			internal_properties = new PropertyInfo[0];
			internal_events = new EventInfo[0];

			internal_update_interface_members (t, l_processed);
			Dictionary<string,MethodInfo> l_object_methods = object_methods() ;
  
  			MemberInfo[] l_members = internal_members;
			i = 0;
			foreach (MemberInfo l_member in l_members)
			{
				// if (l_member is MethodInfo) 
				if (typeof(MethodInfo).IsAssignableFrom(l_member.GetType()))				
				{
					MethodInfo l_method = (MethodInfo) l_member;
					l_meth_name = object_key_name (l_method);
					MethodInfo? l_obj_method;
					if (l_object_methods.ContainsKey(l_meth_name)) {
						l_obj_method = l_object_methods[l_meth_name];
					} else {
						l_obj_method = null;
					}
					if (l_obj_method != null) {
							// -- Let's check return type and arguments type.
						ParameterInfo[] l_obj_params = l_obj_method.GetParameters();
						ParameterInfo[] l_params = l_method.GetParameters();
						if (l_params != null && l_obj_params != null && l_obj_method.ReturnType == l_method.ReturnType && l_obj_params.Length == l_params.Length) 
						{
							int k = l_obj_params.Length;
							l_matched = true;
							for (int j = 0; j < k && l_matched; j++) {
								var l_obj_param = l_obj_params[j];
								var l_param = l_params[j];
								l_matched = l_obj_param.ParameterType.Equals(l_param.ParameterType);
							}
						}
						if (l_matched) {
							l_object_methods.Remove (l_meth_name);
						}
					}
				}
				i = i + 1;

			}

			l_members = new MemberInfo[internal_members.Length + l_object_methods.Count];
			internal_members.CopyTo(l_members, 0);
			i = internal_members.Length;
			foreach(KeyValuePair<string, MethodInfo> mi in l_object_methods)
			{
				l_members[i] = mi.Value;
				i = i + 1;
			}

			internal_members = l_members;
		}

		private void internal_update_interface_members (Type t, Hashtable processed)
			// -- Update `internal_members', `internal_properties' and `internal_events' and recursively explores parent interface
			// -- if not already in `processed'.
		{
	// 	require
	// 		t_attached: t /= Void
	// 		processed_attached: processed /= Void
	// 	local
			MemberInfo[] l_merged_members;
			PropertyInfo[] l_merged_properties;
			EventInfo[] l_merged_events;
			Type[]? l_interfaces;
	// 		i, nb: INTEGER
			MemberInfo?[] l_members;
			PropertyInfo?[] l_properties;
			EventInfo?[] l_events;

			l_members = t.GetMembers (BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
			l_properties = t.GetProperties (BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static);
			l_events = t.GetEvents (BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static);

			int offset = 0;
				// -- merge members.
			if (l_members != null) {
				l_merged_members = new MemberInfo[internal_members.Length + l_members.Length];
				l_members.CopyTo(l_merged_members, 0);
				offset = l_members.Length;
			} else {
				l_merged_members = new MemberInfo[internal_members.Length];
			}
			internal_members.CopyTo(l_merged_members, offset);
			internal_members = l_merged_members;


				// -- merge properties.
			offset = 0;
			if (l_properties != null) { 
				l_merged_properties = new PropertyInfo[internal_properties.Length + l_properties.Length];
				l_properties.CopyTo(l_merged_properties, 0);
				offset = l_properties.Length;
			} else {
				l_merged_properties = new PropertyInfo[internal_properties.Length];
			}
			internal_properties.CopyTo(l_merged_properties, offset);
			internal_properties = l_merged_properties;

				// -- merge events.
			offset = 0;
			if (l_events != null) { 
				l_merged_events = new EventInfo[internal_events.Length + l_events.Length];
				l_events.CopyTo(l_merged_events, 0);
				offset = l_events.Length;
			} else {
				l_merged_events = new EventInfo[internal_events.Length];
			}
			internal_events.CopyTo(l_merged_events, offset); 
			internal_events = l_merged_events;

			
			try {
				l_interfaces = t.GetInterfaces();
			} catch {
				STATUS_PRINTER.debug("Failure with GetInterfaces() on type " + t.ToString());
				l_interfaces = null; // FIXME
			}			
			if (l_interfaces != null) {
				processed.Add(t, t);
				// foreach(DictionaryEntry e in processed)
				foreach(Type l_interface in l_interfaces)
				{
					if (!processed.Contains(l_interface)) {
						internal_update_interface_members(l_interface, processed);
					}
				}
			}
		}    
		public string object_key_name (MethodInfo a_method)
		{
			// -- Retrieves a key for use with `object_methods' given method `a_method'
		// require
		// 	a_method_attached: a_method /= Void
			string res = a_method.Name + '(';
			int i = 0;
			try {
				foreach(ParameterInfo l_param in a_method.GetParameters())
				{
					Type l_type = l_param.ParameterType;
					if (i > 0) {
						res = res + ',';
					}
					res = res + l_type.Name;
					i = i + 1;
				}
			} catch {
				STATUS_PRINTER.debug("Failure with GetParameters() on method " + a_method.ToString());
			}
			res = res + ')';
			return res;
		// ensure
		// 	result_attached: Result /= Void
		// 	not_result_is_empty: not Result.is_empty
		}

		public bool initialized = false;
		public void initialize()
		{
			// require
			// 	not_initialized: not initialized
			
			// local
			// 	rescued: BOOLEAN
			// 	i, nb: INTEGER
			// 	, l_other_functions: ARRAYED_LIST [CONSUMED_FUNCTION]
			// 	cons: CONSTRUCTOR_INFO
			// 	l_setter: CONSUMED_PROCEDURE

			// 	cp_function: CONSUMED_FUNCTION
			// 	cp_procedure: CONSUMED_PROCEDURE
			// 	cp_field: CONSUMED_FIELD
			// do

			// DEBUG: Console.WriteLine("Initialize " + eiffel_name + " : " + system_type.ToString());
 			STATUS_PRINTER.debug(string.Format("Initialize '{0}' : '{1}'", eiffel_name, system_type.ToString()));

			try {
			// 		check
			// 			non_void_internal_constructors: internal_constructors /= Void
			// 			non_void_internal_member: internal_members /= Void
			// 			non_void_internal_properties: internal_properties /= Void
			// 			non_void_internal_events: internal_events /= Void
			// 		
				List<CONSTRUCTOR_SOLVER> tc = new List<CONSTRUCTOR_SOLVER>();
				//FIXME: in Progress

				List<CONSUMED_FIELD> l_fields = new List<CONSUMED_FIELD>();
				List<CONSUMED_FUNCTION> l_functions = new List<CONSUMED_FUNCTION>();
				List<CONSUMED_PROCEDURE> l_procedures = new List<CONSUMED_PROCEDURE>();
				List<CONSUMED_PROPERTY> l_properties = new List<CONSUMED_PROPERTY>();
				List<CONSUMED_EVENT> l_events = new List<CONSUMED_EVENT>();
		
				name_solver.reset_reserved_names (100);

				bool is_enum = consumed_type.is_enum();
					// -- Add constructors.
				foreach (ConstructorInfo cons in internal_constructors)
				{
					if (is_consumed_method (cons)) {
						tc.Add(new CONSTRUCTOR_SOLVER(cons));
					}
				}

					// -- Initialize overload solver.
				initialize_overload_solver();
					// -- Resolve oveload conflicts.
				overload_solver.set_reserved_names(name_solver.reserved_names);
				overload_solver.solve();

					// -- Add methods and fields.
				// CONSUMED_FUNCTION? cp_function = null;
				// CONSUMED_PROCEDURE? cp_procedure = null;
				// CONSUMED_FIELD? cp_field = null;	

				CONSUMED_REFERENCED_TYPE? underlying_enum_type = null;

				bool has_consumed_function (CONSUMED_FUNCTION fct) //, List<CONSUMED_FUNCTION> lst)
				{
					foreach (CONSUMED_FUNCTION f in l_functions) {
						if (f.Equals (fct) || f.same_function (fct)) {
							return true;
						}
					}
					return false;
				}
				bool has_consumed_procedure (CONSUMED_PROCEDURE proc)
				{
					foreach (CONSUMED_PROCEDURE p in l_procedures) {
						if (p.Equals (proc) || p.same_procedure (proc)) {
							return true;
						}
					}
					return false;
				}

				foreach(MemberInfo l_member in internal_members) 
				{
					try {
						if (l_member.MemberType == MemberTypes.Method) {
							MethodInfo l_meth = (MethodInfo) l_member;
							// DEBUG: Console.WriteLine(" - " + eiffel_name + "." + l_meth.Name + " : " + l_meth.ToString() + "static=" + l_meth.IsStatic);
							if (!is_property_or_event (l_meth)) {
								if (is_function (l_meth)) {
									CONSUMED_FUNCTION? cp_function = consumed_function (l_meth, false);
									if (cp_function != null) {
										if (cp_function.is_excluded()) {
											if (cp_function.has_generic_type_arguments()) {
												STATUS_PRINTER.debug(string.Format(" - GENERIC EXCLUDED Function {0}.{1} -> {2}", eiffel_name, l_meth.Name, l_meth.ToString()));
											} else {
												STATUS_PRINTER.debug(string.Format(" - EXCLUDED Function {0}.{1} -> {2}", eiffel_name, l_meth.Name, l_meth.ToString()), 2);
											}
										} else {
											if (has_consumed_function (cp_function)) {
											// DEBUG: Console.WriteLine(" !!! Already has such function: " + eiffel_name + "." + cp_function.dotnet_name);
												STATUS_PRINTER.debug(string.Format(" ! FOUND Function {0}.{1}", eiffel_name, cp_function.dotnet_name));
											} else {
												STATUS_PRINTER.debug(string.Format(" + Function  {1} -> {2}", eiffel_name, l_meth.Name, l_meth.ToString()));
												l_functions.Add (cp_function);
											}
										}
									}
								} else {
									CONSUMED_PROCEDURE? cp_procedure = consumed_procedure (l_meth, false);
									if (cp_procedure != null) {
										if (cp_procedure.is_excluded()) {
											if (cp_procedure.has_generic_type()) {
												STATUS_PRINTER.debug(string.Format(" - GENERIC EXCLUDED Procedure {1} -> {2}", eiffel_name, l_meth.Name, l_meth.ToString()));
											} else {
												STATUS_PRINTER.debug(string.Format(" - EXCLUDED Procedure {1} -> {2}", eiffel_name, l_meth.Name, l_meth.ToString()), 2);
											}
										} else {
											if (has_consumed_procedure (cp_procedure)) {
												STATUS_PRINTER.debug(string.Format(" ! FOUND Procedure {0}.{1}", eiffel_name, cp_procedure.dotnet_name), 2);
											// DEBUG: Console.WriteLine(" !!! Already has such procedure ");
											} else {
												STATUS_PRINTER.debug(string.Format(" + Procedure {1} -> {2}", eiffel_name, l_meth.Name, l_meth.ToString()));
												l_procedures.Add (cp_procedure);
											}
										}								
									}
								}
							} else {
								// -- The method will be added at the same time than the property or the event.
							}
						} else if (l_member.MemberType == MemberTypes.Field) {
							FieldInfo l_field = (FieldInfo) l_member;
							if (is_enum && !l_field.IsLiteral) {
								// -- Get base type of enumeration
								Type l_field_type = l_field.FieldType;
								underlying_enum_type = referenced_type_from_type (l_field_type);
							}
							if (is_consumed_field (l_field)) {
								CONSUMED_FIELD? cp_field = consumed_field (l_field);
								if (cp_field != null && !cp_field.is_excluded()) {
									STATUS_PRINTER.debug(string.Format(" + Field {1} -> {2}", eiffel_name, l_field.Name, l_field.ToString()));
									l_fields.Add (cp_field);
									if (is_public_field (l_field) && !is_init_only_field (l_field)) {
										CONSUMED_PROCEDURE? l_setter = attribute_setter_feature (l_field, l_fields.Last().eiffel_name);
										if (l_setter != null && !l_setter.is_excluded()) {
											cp_field.set_setter (l_setter);
											STATUS_PRINTER.debug(string.Format(" + Proc-Setter {1} -> {2}", eiffel_name, l_setter.eiffel_name, l_setter.dotnet_name));
											l_procedures.Add (l_setter);
											
										} else {
											Debug.Assert(false, "has setter");
										}
									}
								} else {
									Debug.Assert(cp_field != null && cp_field.is_excluded(), "has field");
									STATUS_PRINTER.debug(string.Format(" - EXCLUDED Field {1} -> {2}", eiffel_name, l_field.Name, l_field.ToString()));
								}
							} else {
								STATUS_PRINTER.debug(string.Format(" - IGNORED Field {1} -> {2}", eiffel_name, l_field.Name, l_field.ToString()));
							}
						} else if (l_member.MemberType == MemberTypes.Property) {
							PropertyInfo l_property = (PropertyInfo) l_member;
							CONSUMED_PROPERTY? cp_property = consumed_property(l_property);
							if (cp_property != null) {
								STATUS_PRINTER.debug(string.Format(" + Property {1} -> {2}", eiffel_name, l_property.Name, l_property.ToString()));
								l_properties.Add (cp_property);
							} else {
								STATUS_PRINTER.debug(string.Format(" - IGNORED Property {1} -> {2}", eiffel_name, l_property.Name, l_property.ToString()));
							}
						} else if (l_member.MemberType == MemberTypes.Event) {
							EventInfo l_event = (EventInfo) l_member;
							CONSUMED_EVENT? cp_event = consumed_event(l_event);
							if (cp_event != null) {
								STATUS_PRINTER.debug(string.Format(" + Event {1} -> {2}", eiffel_name, l_event.Name, l_event.ToString()));
								l_events.Add (cp_event);
							} else {
								STATUS_PRINTER.debug(string.Format(" - IGNORED Event {1} -> {2}", eiffel_name, l_event.Name, l_event.ToString()));								
							}
						}
					} catch {
						// DEBUG: Console.WriteLine("ERROR: issue with field " + l_member.Name);
					}
				}

				consumed_type.set_properties (l_properties);
				consumed_type.set_events (l_events);
				// tc.Sort((a,b) => { return a.CompareTo(b); });
				tc.Sort();
				consumed_type.set_constructors (solved_constructors (tc));
				consumed_type.set_fields (l_fields);
				consumed_type.set_procedures (l_procedures);
				if (is_enum) {
					if (underlying_enum_type == null) {
						underlying_enum_type = integer_type();
					}
					var l_other_functions = l_functions;
					l_functions = new List<CONSUMED_FUNCTION>(l_other_functions.Count + Additional_enum_features);
					foreach (CONSUMED_FUNCTION fct in l_other_functions)
					{
						if (!fct.is_excluded()) {
							l_functions.Add(fct);
						}
					}
					CONSUMED_FUNCTION? f = null;
					f = infix_and_feature (internal_referenced_type);
					if (!f.is_excluded()) {
						l_functions.Add (f);
					}
					f = infix_or_feature (internal_referenced_type);
					if (!f.is_excluded()) {
						l_functions.Add (f);
					}
					if (underlying_enum_type != null && !underlying_enum_type.is_excluded()) {
						f = from_integer_feature (internal_referenced_type, underlying_enum_type);
						if (!f.is_excluded()) {
							l_functions.Add (f);
						}
						f = to_integer_feature (internal_referenced_type, underlying_enum_type);
						if (!f.is_excluded()) {
							l_functions.Add (f);
						}
					}
				}
				consumed_type.set_functions (l_functions);
				initialized = true;
			
			} catch {
				STATUS_PRINTER.error(string.Format("Failure while initializing type '{0}' : '{1}'", eiffel_name, system_type.ToString()));

				initialized = false;

			// rescue
			// 	debug ("log_exceptions")
			// 		log_last_exception
			// 	end
			// 	rescued := True
			// 	retry
			}

			// ensure
			// 	non_void_constructors: consumed_type.constructors /= Void
			// 	non_void_fields: consumed_type.fields /= Void
			// 	non_void_procedures: consumed_type.procedures /= Void
			// 	non_void_functions: consumed_type.functions /= Void
			// 	non_void_properties: consumed_type.properties /= Void
			// 	non_void_events: consumed_type.events /= Void

		}

		public void initialize_overload_solver() 
		{
			OVERLOAD_SOLVER l_solver = overload_solver; 
			foreach (PropertyInfo l_property in internal_properties)
			{
				add_property (l_property);
				l_solver.add_property (l_property);
			}
			foreach (EventInfo l_event in internal_events)
			{
				add_event (l_event);
				l_solver.add_event (l_event);
			}
			foreach (MemberInfo l_member in internal_members)
			{
				if (l_member.MemberType == MemberTypes.Method 
					&& typeof(MethodInfo).IsAssignableFrom(l_member.GetType())
					)
				{
					MethodInfo l_meth = (MethodInfo) l_member;
					string n = l_meth.Name;
					if (!is_property_or_event (l_meth)) {
						l_solver.add_method (l_meth);
					}
				}
			}			
		}

		public List<CONSUMED_CONSTRUCTOR> solved_constructors (List<CONSTRUCTOR_SOLVER>	tc)
			// -- Initialize `constructors' from `tc'.
		{
		// require
		// 	non_void_constructors: tc /= Void

			List<CONSUMED_CONSTRUCTOR> res = new List<CONSUMED_CONSTRUCTOR>(tc.Count);
			if (tc.Count > 0) {
		 		if (tc.Count == 1) {
						// -- When there is only one constructor, let's call it make
						// -- to avoid confusion.
		 			tc[0].set_name (Creation_routine_name);
					var c = tc[0].consumed_constructor();
					if (c != null && !c.is_excluded()) {
						res.Add(c);
					}
				} else {
						// -- Compute all possible names for constructor.
					int p = 0;
					int p_max = tc.Count - 1;

					int i = 0;
					int nb = tc.Count;
					CONSTRUCTOR_SOLVER csolver = tc[p];
					Dictionary<string,string> l_reserved = name_solver.reserved_names;
					CONSUMED_ARGUMENT[] args = csolver.arguments;
					if (args.Length == 0) {
						csolver.set_name(Creation_routine_name);
						var c = csolver.consumed_constructor();
						if (c != null && !c.is_excluded()) {
							res.Add(c);
						}
						p = p + 1;
					}
					string name;
					while (p <= p_max && args.Length <= Constructor_overload_resolution) {
						csolver = tc[p];
						args = csolver.arguments;
						name = Complete_creation_routine_name_prefix;
						i = 0;
						foreach (CONSUMED_ARGUMENT arg in args)
						{
							i = i + 1;
							if (i > 1) {
								name = name + "_and_";
							}
							name = name + arg.eiffel_name;
						}
						name = name_solver.unique_feature_name (name);
						csolver.set_name (name);
						var c = csolver.consumed_constructor();
						if (c != null && !c.is_excluded()) {
							res.Add(c);
						}
						p = p + 1;
					}
					while (p <= p_max)
					{
						csolver = tc[p];
						args = csolver.arguments;
						name = Partial_creation_routine_name_prefix;
						if (args.Length > 0) {
							name = name + args[0].eiffel_name;
						} else {
							Debug.Assert(false, "has argument");
						}
						i = 0;
						foreach (CONSUMED_ARGUMENT arg in args)
						{
							i = i + 1;
							if (!l_reserved.ContainsKey(name)) {
								//break;  	// FIXME For now, append all argument names.
											// see how to improve Eiffel to select feature in inheritance clause
										   	// passing signature, instead of relying on argument names !
							}

							if (i > 1) {
								name = name + "_and_" + arg.eiffel_name;
							}
						}
						name = name_solver.unique_feature_name(name);
						csolver.set_name(name);
						var c = csolver.consumed_constructor();
						if (c != null && !c.is_excluded()) {
							res.Add(c);
						}
						p = p + 1;
					}
				}
			}
			return res;
		// ensure
		// 	non_void_constructors: Result /= Void
		}

		public int Additional_enum_features = 3; // -- Number of additional features for enum types.

		public CONSUMED_FUNCTION infix_and_feature (CONSUMED_REFERENCED_TYPE a_enum_type)
			// -- Create instance of CONSUMED_FUNCTION for `&' in enum type `t'.
		{
		// require
		// 	a_enum_type_not_void: a_enum_type /= Void

			CONSUMED_ARGUMENT l_arg = new CONSUMED_ARGUMENT("other", "other", a_enum_type);
			CONSUMED_ARGUMENT[] l_args = new CONSUMED_ARGUMENT[]{l_arg};
			CONSUMED_FUNCTION res = new CONSUMED_FUNCTION (
					"&", "&", "&", l_args, a_enum_type,
					true,	// -- is_frozen
					false,	// -- is_static
					false,	// -- is_deferred
					true,	// -- is_infix
					false,	// -- is_prefix
					true,	// -- is_public
					false,  // -- is_new_slot
					true,	// -- is_virtual
					false,	// -- is_property_or_event
					a_enum_type
				);

		 	res.set_is_artificially_added (true);
			return res;
		}		

		public CONSUMED_FUNCTION infix_or_feature (CONSUMED_REFERENCED_TYPE a_enum_type)
			// -- Create instance of CONSUMED_FUNCTION for `|' in enum type `t'.
		{
		// require
		// 	a_enum_type_not_void: a_enum_type /= Void

			CONSUMED_ARGUMENT l_arg = new CONSUMED_ARGUMENT("other", "other", a_enum_type);
			CONSUMED_ARGUMENT[] l_args = new CONSUMED_ARGUMENT[]{l_arg};
			CONSUMED_FUNCTION res = new CONSUMED_FUNCTION (
					"|", "|", "|", l_args, a_enum_type,
					true,	// -- is_frozen
					false,	// -- is_static
					false,	// -- is_deferred
					true,	// -- is_infix
					false,	// -- is_prefix
					true,	// -- is_public
					false,  // -- is_new_slot
					true,	// -- is_virtual
					false,	// -- is_property_or_event
					a_enum_type
				);
		 	res.set_is_artificially_added (true);
			return res;
		}

		public CONSUMED_FUNCTION from_integer_feature (CONSUMED_REFERENCED_TYPE a_enum_type, CONSUMED_REFERENCED_TYPE a_underlying_enum_type)
			// -- Create instance of CONSUMED_FUNCTION for`from_integer' in enum type `t'.
		{
		// require
		// 	a_enum_type_not_void: a_enum_type /= Void
		// 	a_underlying_enum_type_void: a_underlying_enum_type /= Void
			CONSUMED_ARGUMENT l_arg = new CONSUMED_ARGUMENT("a_value", "a_value", a_underlying_enum_type);
			CONSUMED_ARGUMENT[] l_args = new CONSUMED_ARGUMENT[]{l_arg};
			CONSUMED_FUNCTION res = new CONSUMED_FUNCTION (
					"from_integer", "from_integer", "from_integer", l_args, a_enum_type,
					true,	// -- is_frozen
					false,	// -- is_static
					false,	// -- is_deferred
					false,	// -- is_infix
					false,	// -- is_prefix
					true,	// -- is_public
					false,  // -- is_new_slot
					true,	// -- is_virtual
					false,	// -- is_property_or_event
					a_enum_type
				);
		 	res.set_is_artificially_added (true);
			return res;		
		}

		public CONSUMED_FUNCTION to_integer_feature (CONSUMED_REFERENCED_TYPE a_enum_type, CONSUMED_REFERENCED_TYPE a_underlying_enum_type)
			// -- Create instance of CONSUMED_FUNCTION for`to_integer' in enum type `t'.
		{
		// require
		// 	a_enum_type_not_void: a_enum_type /= Void
		// 	a_underlying_enum_type_void: a_underlying_enum_type /= Void
			CONSUMED_ARGUMENT[] l_args = new CONSUMED_ARGUMENT[0];
			CONSUMED_FUNCTION res = new CONSUMED_FUNCTION (
					"to_integer", "to_integer", "to_integer", l_args, a_underlying_enum_type,
					true,	// -- is_frozen
					false,	// -- is_static
					false,	// -- is_deferred
					false,	// -- is_infix
					false,	// -- is_prefix
					true,	// -- is_public
					false,  // -- is_new_slot
					true,	// -- is_virtual
					false,	// -- is_property_or_event
					a_enum_type
				);
		 	res.set_is_artificially_added (true);
			return res;		
		}		

		public CONSUMED_PROCEDURE? attribute_setter_feature (FieldInfo a_field, string a_field_name)
			// -- attribute setter feature.
		{
		// require
		// 	non_void_field: a_field /= Void and then a_field.name /= Void
		// 	public_field: is_public_field (a_field)
		// 	valid_field_name: a_field_name /= Void and then not a_field_name.is_empty

			Type l_type = a_field.FieldType;
			string l_dotnet_field_name = a_field.Name;
			return new CONSUMED_PROCEDURE(
					"set_" + a_field_name + "_field",
					l_dotnet_field_name,
					new CONSUMED_ARGUMENT ("a_value", "a_value", referenced_type_from_type (l_type)),
					internal_referenced_type,
					a_field.IsStatic
				);
		}

		public string key_args(ParameterInfo[]? args)
		{
			string res = "";
			if (args != null) {
				foreach(ParameterInfo a in args)
				{
					res = res + a.ParameterType.Name;
				}
			}
			return res;
		}
		// public Object field_value (FieldInfo fi)
        // // Value from field `fi`.
        // {
        //     Object? res = fi.GetRawConstantValue();
        //     if (res == null) {
        //         Debug.Assert(false, "unexpected");
        //         res = 0;
        //     }
        //     return res;
        // }

		public string literal_field_value (Object val)
        // Value from field `fi`.
        {
			Type l_type = val.GetType();
			if (l_type.Equals(typeof(System.Double))) {
				return System.Convert.ToHexString(BitConverter.GetBytes((Double) val));
			} else if (l_type.Equals(typeof(System.Single))) {
				return System.Convert.ToHexString(BitConverter.GetBytes((Single) val));
			} else {
				string? res = val.ToString();
				if (res == null) { res = ""; }
				return res;
			}
        }

		private bool is_Void_type(Type? t) 
		{
			if (t == null) {
				return true;
			} else {
				Type? vt = Type.GetType("System.Void");
				if (vt != null) {
					string? s1 = t.AssemblyQualifiedName;
					string? s2 = vt.AssemblyQualifiedName;
					if (s1 != null && s2 != null) {
						if (s1.Equals(s2)) {
							return true;
						} else {
							// FIXME: check how to remain in the same .Net version.
							// Compare the typename, the culture, but not the Version
							// to be able to consume Assembly of .Net version different from the one used
							// to compile the current tool (nemdc).
							s1 = vt.FullName;
							s2 = t.FullName;
							// Compare type name
							if (s1 != null && s1.Equals (s2)) {
								// Then compare assembly name
								AssemblyName? a1 = vt.Assembly.GetName();
								AssemblyName? a2 = t.Assembly.GetName();
								if (a1 != null && a2 != null) {
									if (a1.Name != null && a2.Name != null) {
										if (a1.Name.Equals (a2.Name)) {
											return a1.CultureName != null && a1.CultureName.Equals(a2.CultureName);
										} else if (
												a1.Name.StartsWith("System.Private.")
												&& a2.Name.Equals("System.Runtime") 
											) 
										{
											// WARNING: the nemdc already load the System.Void from System.Private.CoreLib
											// and using Reference Assemblies, `t` may be System.Void from System.Runtime 
											// and `vt` may be System.Void from System.Private.CoreLib
											return true;
										} else {
											return false;
										}
									} else {
										return false;
									}
								}
							} else {
								return false;
							}
						}
					}
				}
				if (t.FullName != null && t.FullName.Equals("System.Void")) {
					return true;
				} else {
					Debug.Assert(vt != null, "from documentation");
					return false;
				}
			}
		}
		private CONSUMED_REFERENCED_TYPE? integer_type()
			// -- Referenced type of `System.Int32'.
		{
			Type? t = Type.GetType("System.Int32");
			if (t == null) {
				t = typeof(System.Int32);
			}
			return referenced_type_from_type(t);
		}

		public bool is_property_or_event(MethodInfo info)
		{
			bool res=false;
			string dn = info.Name;
			int i = dn.LastIndexOf('.');
			if (i > 0) {
				dn = dn.Substring(i + 1);
			}
			string k = dn;
			// if (!info.IsHideBySig) { //FIXME: addition...
			try {
				k = k + key_args(info.GetParameters());
			} catch {
				// FIXME: Exception has occurred: CLR/System.NotSupportedException
				// Exception thrown: 'System.NotSupportedException' in System.Reflection.MetadataLoadContext.dll: 'Parsing function pointer types in signatures is not supported.'
				// Case: System.RuntimeTypeHandle  GetActivationInfo
			}
			// }
			res = properties_and_events.ContainsKey(k);	
			return res;
		}

		public bool is_infix(MethodInfo info)
			// -- Is function an infix function?
		{
		// require
		// 	is_function: is_function (info)
			string l_info_name = info.Name;
			ParameterInfo[] l_params = info.GetParameters();

			return l_info_name.Length > 3 
					&& info.IsSpecialName 
					&& l_info_name.StartsWith(Operator_name_prefix)
					&& l_params.Length == 2 
					&& l_params[0].ParameterType.Equals(info.ReflectedType)
					&& !l_info_name.Equals(Op_implicit)
					&& !l_info_name.Equals(Op_explicit)
					;
		}

		public bool is_prefix(MethodInfo info)
			// -- Is function an prefix function?
		{
		// require
		// 	is_function: is_function (info)
			string l_info_name = info.Name;
			ParameterInfo[] l_params = info.GetParameters();

			return l_info_name.Length > 3 
					&& info.IsSpecialName 
					&& l_info_name.StartsWith(Operator_name_prefix)
					&& l_params.Length == 1 
					&& l_params[0].ParameterType.Equals(info.ReflectedType)
					&& !l_info_name.Equals(Op_implicit)
					&& !l_info_name.Equals(Op_explicit)
					;
		}
		public bool is_function (MethodInfo info)
		{
			// FIXME: check if info.IsHideBySig should be taken into account.
			Type? rt = null;
			try {
				rt = info.ReturnType;
			} catch {
				// FIXME: check why exception could be raised here. It seems to depend on the signature, maybe with function pointer?
				rt = null;
			}
			return !is_Void_type(rt);
		}
		public void add_property (PropertyInfo info)
		{
			if (info.CanRead) {
				MethodInfo? g = METHOD_RETRIEVER.property_getter (info);
				if (g != null) {
					add_properties_or_events_method (g);
				}
			}
			if (info.CanWrite) {
				MethodInfo? s = METHOD_RETRIEVER.property_setter (info);
				if (s != null) {
					add_properties_or_events_method (s);
				}
			}			
		}
		public void add_event (EventInfo info)
		{
			MethodInfo? l_adder = METHOD_RETRIEVER.event_adder (info);
			MethodInfo? l_remover = METHOD_RETRIEVER.event_remover (info);
			MethodInfo? l_raiser = METHOD_RETRIEVER.event_raiser (info);
			if (l_adder != null) add_properties_or_events_method (l_adder);
			if (l_remover != null) add_properties_or_events_method (l_remover);
			if (l_raiser != null) add_properties_or_events_method (l_raiser);
		}
		public void add_properties_or_events_method (MethodInfo info)
		{
			if (is_consumed_method(info)) {
				string dn = info.Name;
				string key = new string(' ', 0);
				key = dn + key_args(info.GetParameters());
				if (!properties_and_events.ContainsKey(key)) {
					properties_and_events.Add(key, info);
				}
			}
		}	

		public int Constructor_overload_resolution = 3; // Number of arguments in a constructor for which we always expand their name definition.
		public string Creation_routine_name = "make";
		public string Complete_creation_routine_name_prefix = "make_from_";
		public string Partial_creation_routine_name_prefix = "make_with_";
			// -- Creation routine name prefix
		public string Operator_name_prefix = "op_";
		public string Op_implicit = "op_implicit";
		public string Op_explicit = "op_Explicit";
	}

	class TYPE_INFO_ONLY_CONSUMER : TYPE_CONSUMER
	{
		public TYPE_INFO_ONLY_CONSUMER(Type t, string en, int aid=-1) : base (t, en, aid)
		{
		}
		new protected void initialize_type_consumer(Type t, string en, string dotnet_name)
		{
			List<CONSUMED_REFERENCED_TYPE> interfaces = new List<CONSUMED_REFERENCED_TYPE>(0);
			CONSUMED_REFERENCED_TYPE? parent = null;
			bool l_force_sealed = false;

			initialize_type_base_consumer(t, en, dotnet_name, l_force_sealed, parent, interfaces);
		}
	}
}
