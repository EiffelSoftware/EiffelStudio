indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Type"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	TYPE

inherit
	MEMBER_INFO
		rename
			equals as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end
	ICUSTOM_ATTRIBUTE_PROVIDER
		rename
			equals as equals_object
		end
	IREFLECT
		rename
			invoke_member as invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier,
			get_members as get_members_binding_flags,
			get_member as get_member_string_binding_flags,
			get_properties as get_properties_binding_flags,
			get_property as get_property_string_binding_flags,
			get_fields as get_fields_binding_flags,
			get_field as get_field_string_binding_flags,
			get_methods as get_methods_binding_flags,
			get_method as get_method_string_binding_flags,
			equals as equals_object
		end

feature -- Access

	frozen get_is_sealed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsSealed"
		end

	frozen get_is_abstract: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsAbstract"
		end

	frozen get_is_nested_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedPublic"
		end

	frozen get_is_not_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNotPublic"
		end

	frozen get_is_serializable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsSerializable"
		end

	frozen get_is_explicit_layout: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsExplicitLayout"
		end

	get_guid: GUID is
		external
			"IL deferred signature (): System.Guid use System.Type"
		alias
			"get_GUID"
		end

	frozen delimiter: CHARACTER is
		external
			"IL static_field signature :System.Char use System.Type"
		alias
			"Delimiter"
		end

	frozen get_is_auto_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsAutoClass"
		end

	frozen get_has_element_type: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_HasElementType"
		end

	frozen get_is_nested_private: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedPrivate"
		end

	frozen get_is_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsClass"
		end

	frozen get_is_layout_sequential: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsLayoutSequential"
		end

	frozen get_is_value_type: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsValueType"
		end

	frozen get_is_contextful: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsContextful"
		end

	get_namespace: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Type"
		alias
			"get_Namespace"
		end

	frozen get_is_enum: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsEnum"
		end

	frozen filter_attribute: MEMBER_FILTER is
		external
			"IL static_field signature :System.Reflection.MemberFilter use System.Type"
		alias
			"FilterAttribute"
		end

	get_module: MODULE is
		external
			"IL deferred signature (): System.Reflection.Module use System.Type"
		alias
			"get_Module"
		end

	get_type_handle: RUNTIME_TYPE_HANDLE is
		external
			"IL deferred signature (): System.RuntimeTypeHandle use System.Type"
		alias
			"get_TypeHandle"
		end

	frozen get_is_primitive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsPrimitive"
		end

	get_reflected_type: TYPE is
		external
			"IL signature (): System.Type use System.Type"
		alias
			"get_ReflectedType"
		end

	frozen get_is_unicode_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsUnicodeClass"
		end

	get_base_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"get_BaseType"
		end

	frozen filter_name_ignore_case: MEMBER_FILTER is
		external
			"IL static_field signature :System.Reflection.MemberFilter use System.Type"
		alias
			"FilterNameIgnoreCase"
		end

	frozen get_is_interface: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsInterface"
		end

	frozen get_is_nested_family: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedFamily"
		end

	frozen filter_name: MEMBER_FILTER is
		external
			"IL static_field signature :System.Reflection.MemberFilter use System.Type"
		alias
			"FilterName"
		end

	frozen get_is_comobject: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsCOMObject"
		end

	frozen get_is_import: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsImport"
		end

	frozen get_is_by_ref: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsByRef"
		end

	frozen get_is_array: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsArray"
		end

	get_declaring_type: TYPE is
		external
			"IL signature (): System.Type use System.Type"
		alias
			"get_DeclaringType"
		end

	get_underlying_system_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"get_UnderlyingSystemType"
		end

	get_member_type: MEMBER_TYPES is
		external
			"IL signature (): System.Reflection.MemberTypes use System.Type"
		alias
			"get_MemberType"
		end

	frozen get_is_marshal_by_ref: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsMarshalByRef"
		end

	frozen get_attributes: TYPE_ATTRIBUTES is
		external
			"IL signature (): System.Reflection.TypeAttributes use System.Type"
		alias
			"get_Attributes"
		end

	frozen get_is_ansi_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsAnsiClass"
		end

	frozen get_is_nested_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedAssembly"
		end

	frozen get_type_initializer: CONSTRUCTOR_INFO is
		external
			"IL signature (): System.Reflection.ConstructorInfo use System.Type"
		alias
			"get_TypeInitializer"
		end

	frozen get_default_binder: BINDER is
		external
			"IL static signature (): System.Reflection.Binder use System.Type"
		alias
			"get_DefaultBinder"
		end

	frozen empty_types: NATIVE_ARRAY [TYPE] is
		external
			"IL static_field signature :System.Type[] use System.Type"
		alias
			"EmptyTypes"
		end

	frozen get_is_pointer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsPointer"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsSpecialName"
		end

	get_assembly_qualified_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Type"
		alias
			"get_AssemblyQualifiedName"
		end

	frozen missing: SYSTEM_OBJECT is
		external
			"IL static_field signature :System.Object use System.Type"
		alias
			"Missing"
		end

	frozen get_is_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsPublic"
		end

	get_assembly: ASSEMBLY is
		external
			"IL deferred signature (): System.Reflection.Assembly use System.Type"
		alias
			"get_Assembly"
		end

	get_full_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Type"
		alias
			"get_FullName"
		end

	frozen get_is_nested_fam_andassem: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedFamANDAssem"
		end

	frozen get_is_auto_layout: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsAutoLayout"
		end

	frozen get_is_nested_fam_orassem: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedFamORAssem"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Type"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Type"
		alias
			"ToString"
		end

	frozen get_type_from_handle (handle: RUNTIME_TYPE_HANDLE): TYPE is
		external
			"IL static signature (System.RuntimeTypeHandle): System.Type use System.Type"
		alias
			"GetTypeFromHandle"
		end

	frozen get_property_string_type (name: SYSTEM_STRING; return_type: TYPE): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Type): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	find_interfaces (filter: TYPE_FILTER; filter_criteria: SYSTEM_OBJECT): NATIVE_ARRAY [TYPE] is
		external
			"IL signature (System.Reflection.TypeFilter, System.Object): System.Type[] use System.Type"
		alias
			"FindInterfaces"
		end

	get_default_members: NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetDefaultMembers"
		end

	frozen get_type_from_prog_id_string_boolean (prog_id: SYSTEM_STRING; throw_on_error: BOOLEAN): TYPE is
		external
			"IL static signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen invoke_member_string_binding_flags_binder_object_array_object_culture_info (name: SYSTEM_STRING; invoke_attr: BINDING_FLAGS; binder: BINDER; target: SYSTEM_OBJECT; args: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Globalization.CultureInfo): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	frozen get_nested_type (name: SYSTEM_STRING): TYPE is
		external
			"IL signature (System.String): System.Type use System.Type"
		alias
			"GetNestedType"
		end

	is_subclass_of (c: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"IsSubclassOf"
		end

	get_constructors_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [CONSTRUCTOR_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Type"
		alias
			"GetConstructors"
		end

	get_methods_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Type"
		alias
			"GetMethods"
		end

	get_fields_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [FIELD_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Type"
		alias
			"GetFields"
		end

	frozen get_type_from_prog_id_string_string_boolean (prog_id: SYSTEM_STRING; server: SYSTEM_STRING; throw_on_error: BOOLEAN): TYPE is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen get_field (name: SYSTEM_STRING): FIELD_INFO is
		external
			"IL signature (System.String): System.Reflection.FieldInfo use System.Type"
		alias
			"GetField"
		end

	frozen get_type_from_prog_id_string_string (prog_id: SYSTEM_STRING; server: SYSTEM_STRING): TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	equals_object (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Type"
		alias
			"Equals"
		end

	frozen equals (o: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"Equals"
		end

	get_nested_types_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [TYPE] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Type[] use System.Type"
		alias
			"GetNestedTypes"
		end

	get_events: NATIVE_ARRAY [EVENT_INFO] is
		external
			"IL signature (): System.Reflection.EventInfo[] use System.Type"
		alias
			"GetEvents"
		end

	get_array_rank: INTEGER is
		external
			"IL signature (): System.Int32 use System.Type"
		alias
			"GetArrayRank"
		end

	frozen get_type_string_boolean_boolean (type_name: SYSTEM_STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): TYPE is
		external
			"IL static signature (System.String, System.Boolean, System.Boolean): System.Type use System.Type"
		alias
			"GetType"
		end

	find_members (member_type: MEMBER_TYPES; binding_attr: BINDING_FLAGS; filter: MEMBER_FILTER; filter_criteria: SYSTEM_OBJECT): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.Reflection.MemberTypes, System.Reflection.BindingFlags, System.Reflection.MemberFilter, System.Object): System.Reflection.MemberInfo[] use System.Type"
		alias
			"FindMembers"
		end

	frozen get_property_string_array_type (name: SYSTEM_STRING; types: NATIVE_ARRAY [TYPE]): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_constructors: NATIVE_ARRAY [CONSTRUCTOR_INFO] is
		external
			"IL signature (): System.Reflection.ConstructorInfo[] use System.Type"
		alias
			"GetConstructors"
		end

	is_assignable_from (c: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"IsAssignableFrom"
		end

	frozen get_type_string (type_name: SYSTEM_STRING): TYPE is
		external
			"IL static signature (System.String): System.Type use System.Type"
		alias
			"GetType"
		end

	get_field_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): FIELD_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Type"
		alias
			"GetField"
		end

	frozen get_type_string_boolean (type_name: SYSTEM_STRING; throw_on_error: BOOLEAN): TYPE is
		external
			"IL static signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetType"
		end

	get_events_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [EVENT_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Type"
		alias
			"GetEvents"
		end

	frozen get_method_string_array_type_array_parameter_modifier (name: SYSTEM_STRING; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL signature (System.String, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier (name: SYSTEM_STRING; invoke_attr: BINDING_FLAGS; binder: BINDER; target: SYSTEM_OBJECT; args: NATIVE_ARRAY [SYSTEM_OBJECT]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]; culture: CULTURE_INFO; named_parameters: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	get_interface_string_boolean (name: SYSTEM_STRING; ignore_case: BOOLEAN): TYPE is
		external
			"IL deferred signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetInterface"
		end

	frozen get_property_string_binding_flags_binder (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; return_type: TYPE; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_method (name: SYSTEM_STRING): METHOD_INFO is
		external
			"IL signature (System.String): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_properties: NATIVE_ARRAY [PROPERTY_INFO] is
		external
			"IL signature (): System.Reflection.PropertyInfo[] use System.Type"
		alias
			"GetProperties"
		end

	frozen get_type_from_prog_id (prog_id: SYSTEM_STRING): TYPE is
		external
			"IL static signature (System.String): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen get_methods: NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Type"
		alias
			"GetMethods"
		end

	frozen get_type_array (args: NATIVE_ARRAY [SYSTEM_OBJECT]): NATIVE_ARRAY [TYPE] is
		external
			"IL static signature (System.Object[]): System.Type[] use System.Type"
		alias
			"GetTypeArray"
		end

	frozen get_members: NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMembers"
		end

	frozen get_constructor (types: NATIVE_ARRAY [TYPE]): CONSTRUCTOR_INFO is
		external
			"IL signature (System.Type[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	frozen get_member (name: SYSTEM_STRING): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.String): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	frozen get_property_string_type_array_type_array_parameter_modifier (name: SYSTEM_STRING; return_type: TYPE; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_interface (name: SYSTEM_STRING): TYPE is
		external
			"IL signature (System.String): System.Type use System.Type"
		alias
			"GetInterface"
		end

	frozen get_type_from_clsid_guid_string (clsid: GUID; server: SYSTEM_STRING): TYPE is
		external
			"IL static signature (System.Guid, System.String): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	frozen get_method_string_binding_flags_binder (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_event (name: SYSTEM_STRING): EVENT_INFO is
		external
			"IL signature (System.String): System.Reflection.EventInfo use System.Type"
		alias
			"GetEvent"
		end

	frozen get_type_from_clsid_guid_string_boolean (clsid: GUID; server: SYSTEM_STRING; throw_on_error: BOOLEAN): TYPE is
		external
			"IL static signature (System.Guid, System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	frozen invoke_member (name: SYSTEM_STRING; invoke_attr: BINDING_FLAGS; binder: BINDER; target: SYSTEM_OBJECT; args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[]): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	frozen get_type_code (type: TYPE): TYPE_CODE is
		external
			"IL static signature (System.Type): System.TypeCode use System.Type"
		alias
			"GetTypeCode"
		end

	frozen get_method_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	get_member_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	get_event_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): EVENT_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Type"
		alias
			"GetEvent"
		end

	frozen get_type_from_clsid (clsid: GUID): TYPE is
		external
			"IL static signature (System.Guid): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	get_interfaces: NATIVE_ARRAY [TYPE] is
		external
			"IL deferred signature (): System.Type[] use System.Type"
		alias
			"GetInterfaces"
		end

	get_members_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMembers"
		end

	frozen get_property_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_type_from_clsid_guid_boolean (clsid: GUID; throw_on_error: BOOLEAN): TYPE is
		external
			"IL static signature (System.Guid, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	get_interface_map (interface_type: TYPE): INTERFACE_MAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Type"
		alias
			"GetInterfaceMap"
		end

	frozen get_property_string_type_array_type (name: SYSTEM_STRING; return_type: TYPE; types: NATIVE_ARRAY [TYPE]): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Type, System.Type[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_type_handle_object (o: SYSTEM_OBJECT): RUNTIME_TYPE_HANDLE is
		external
			"IL static signature (System.Object): System.RuntimeTypeHandle use System.Type"
		alias
			"GetTypeHandle"
		end

	frozen get_constructor_binding_flags_binder_array_type (binding_attr: BINDING_FLAGS; binder: BINDER; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): CONSTRUCTOR_INFO is
		external
			"IL signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	frozen get_nested_types: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Type"
		alias
			"GetNestedTypes"
		end

	get_properties_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [PROPERTY_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Type"
		alias
			"GetProperties"
		end

	get_element_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"GetElementType"
		end

	frozen get_method_string_array_type (name: SYSTEM_STRING; types: NATIVE_ARRAY [TYPE]): METHOD_INFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	get_member_string_member_types (name: SYSTEM_STRING; type: MEMBER_TYPES; binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.String, System.Reflection.MemberTypes, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	frozen get_property (name: SYSTEM_STRING): PROPERTY_INFO is
		external
			"IL signature (System.String): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_fields: NATIVE_ARRAY [FIELD_INFO] is
		external
			"IL signature (): System.Reflection.FieldInfo[] use System.Type"
		alias
			"GetFields"
		end

	frozen get_constructor_binding_flags_binder_calling_conventions (binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): CONSTRUCTOR_INFO is
		external
			"IL signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	frozen get_method_string_binding_flags_binder2 (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	get_nested_type_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): TYPE is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Type use System.Type"
		alias
			"GetNestedType"
		end

	is_instance_of_type (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Type"
		alias
			"IsInstanceOfType"
		end

feature {NONE} -- Implementation

	is_contextful_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"IsContextfulImpl"
		end

	get_attribute_flags_impl: TYPE_ATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.TypeAttributes use System.Type"
		alias
			"GetAttributeFlagsImpl"
		end

	get_property_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; return_type: TYPE; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetPropertyImpl"
		end

	is_array_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"IsArrayImpl"
		end

	get_method_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethodImpl"
		end

	is_marshal_by_ref_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"IsMarshalByRefImpl"
		end

	is_comobject_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"IsCOMObjectImpl"
		end

	is_primitive_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"IsPrimitiveImpl"
		end

	is_pointer_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"IsPointerImpl"
		end

	get_constructor_impl (binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): CONSTRUCTOR_INFO is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructorImpl"
		end

	is_value_type_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"IsValueTypeImpl"
		end

	is_by_ref_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"IsByRefImpl"
		end

	has_element_type_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"HasElementTypeImpl"
		end

end -- class TYPE
