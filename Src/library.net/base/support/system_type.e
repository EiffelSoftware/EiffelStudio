indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Type"

deferred external class
	SYSTEM_TYPE

inherit
	SYSTEM_REFLECTION_MEMBERINFO
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER
	SYSTEM_REFLECTION_IREFLECT
		rename
			invoke_member as invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier,
			get_members as get_members_binding_flags,
			get_member as get_member_string_binding_flags,
			get_properties as get_properties_binding_flags,
			get_property as get_property_string_binding_flags,
			get_fields as get_fields_binding_flags,
			get_field as get_field_string_binding_flags,
			get_methods as get_methods_binding_flags,
			get_method as get_method_string_binding_flags
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

	get_guid: SYSTEM_GUID is
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

	get_namespace: STRING is
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

	frozen filter_attribute: SYSTEM_REFLECTION_MEMBERFILTER is
		external
			"IL static_field signature :System.Reflection.MemberFilter use System.Type"
		alias
			"FilterAttribute"
		end

	get_module: SYSTEM_REFLECTION_MODULE is
		external
			"IL deferred signature (): System.Reflection.Module use System.Type"
		alias
			"get_Module"
		end

	get_type_handle: SYSTEM_RUNTIMETYPEHANDLE is
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

	get_reflected_type: SYSTEM_TYPE is
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

	get_base_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"get_BaseType"
		end

	frozen filter_name_ignore_case: SYSTEM_REFLECTION_MEMBERFILTER is
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

	frozen filter_name: SYSTEM_REFLECTION_MEMBERFILTER is
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

	get_declaring_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Type"
		alias
			"get_DeclaringType"
		end

	get_underlying_system_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"get_UnderlyingSystemType"
		end

	get_member_type: SYSTEM_REFLECTION_MEMBERTYPES is
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

	frozen get_attributes: SYSTEM_REFLECTION_TYPEATTRIBUTES is
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

	frozen get_type_initializer: SYSTEM_REFLECTION_CONSTRUCTORINFO is
		external
			"IL signature (): System.Reflection.ConstructorInfo use System.Type"
		alias
			"get_TypeInitializer"
		end

	frozen get_default_binder: SYSTEM_REFLECTION_BINDER is
		external
			"IL static signature (): System.Reflection.Binder use System.Type"
		alias
			"get_DefaultBinder"
		end

	frozen empty_types: ARRAY [SYSTEM_TYPE] is
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

	get_assembly_qualified_name: STRING is
		external
			"IL deferred signature (): System.String use System.Type"
		alias
			"get_AssemblyQualifiedName"
		end

	frozen missing: ANY is
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

	get_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL deferred signature (): System.Reflection.Assembly use System.Type"
		alias
			"get_Assembly"
		end

	get_full_name: STRING is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Type"
		alias
			"ToString"
		end

	frozen get_type_from_handle (handle: SYSTEM_RUNTIMETYPEHANDLE): SYSTEM_TYPE is
		external
			"IL static signature (System.RuntimeTypeHandle): System.Type use System.Type"
		alias
			"GetTypeFromHandle"
		end

	frozen get_property_string_type (name: STRING; return_type: SYSTEM_TYPE): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Type): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	find_interfaces (filter: SYSTEM_REFLECTION_TYPEFILTER; filter_criteria: ANY): ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (System.Reflection.TypeFilter, System.Object): System.Type[] use System.Type"
		alias
			"FindInterfaces"
		end

	get_default_members: ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetDefaultMembers"
		end

	frozen get_type_from_prog_id_string_boolean (prog_id: STRING; throw_on_error: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen invoke_member_string_binding_flags_binder_object_array_object_culture_info (name: STRING; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Globalization.CultureInfo): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	frozen get_nested_type (name: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Type"
		alias
			"GetNestedType"
		end

	is_subclass_of (c: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"IsSubclassOf"
		end

	get_constructors_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_CONSTRUCTORINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Type"
		alias
			"GetConstructors"
		end

	get_methods_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Type"
		alias
			"GetMethods"
		end

	get_fields_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Type"
		alias
			"GetFields"
		end

	frozen equals_type (o: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"Equals"
		end

	frozen get_type_from_prog_id_string_string_boolean (prog_id: STRING; server: STRING; throw_on_error: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen get_field (name: STRING): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL signature (System.String): System.Reflection.FieldInfo use System.Type"
		alias
			"GetField"
		end

	frozen get_type_from_prog_id_string_string (prog_id: STRING; server: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Type"
		alias
			"Equals"
		end

	get_nested_types_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_TYPE] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Type[] use System.Type"
		alias
			"GetNestedTypes"
		end

	get_events: ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
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

	frozen get_type_string_boolean_boolean (type_name: STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.Boolean, System.Boolean): System.Type use System.Type"
		alias
			"GetType"
		end

	find_members (member_type: SYSTEM_REFLECTION_MEMBERTYPES; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; filter: SYSTEM_REFLECTION_MEMBERFILTER; filter_criteria: ANY): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.Reflection.MemberTypes, System.Reflection.BindingFlags, System.Reflection.MemberFilter, System.Object): System.Reflection.MemberInfo[] use System.Type"
		alias
			"FindMembers"
		end

	frozen get_property_string_array_type (name: STRING; types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_constructors: ARRAY [SYSTEM_REFLECTION_CONSTRUCTORINFO] is
		external
			"IL signature (): System.Reflection.ConstructorInfo[] use System.Type"
		alias
			"GetConstructors"
		end

	is_assignable_from (c: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"IsAssignableFrom"
		end

	frozen get_type_string (type_name: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String): System.Type use System.Type"
		alias
			"GetType"
		end

	get_field_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Type"
		alias
			"GetField"
		end

	frozen get_type_string_boolean (type_name: STRING; throw_on_error: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetType"
		end

	get_events_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Type"
		alias
			"GetEvents"
		end

	frozen get_method_string_array_type_array_parameter_modifier (name: STRING; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier (name: STRING; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; named_parameters: ARRAY [STRING]): ANY is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	get_interface_string_boolean (name: STRING; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetInterface"
		end

	frozen get_property_string_binding_flags_binder (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; return_type: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_method (name: STRING): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_properties: ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL signature (): System.Reflection.PropertyInfo[] use System.Type"
		alias
			"GetProperties"
		end

	frozen get_type_from_prog_id (prog_id: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen get_methods: ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Type"
		alias
			"GetMethods"
		end

	frozen get_type_array (args: ARRAY [ANY]): ARRAY [SYSTEM_TYPE] is
		external
			"IL static signature (System.Object[]): System.Type[] use System.Type"
		alias
			"GetTypeArray"
		end

	frozen get_members: ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMembers"
		end

	frozen get_constructor (types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
		external
			"IL signature (System.Type[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	frozen get_member (name: STRING): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	frozen get_property_string_type_array_type_array_parameter_modifier (name: STRING; return_type: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_interface (name: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Type"
		alias
			"GetInterface"
		end

	frozen get_type_from_clsid_guid_string (clsid: SYSTEM_GUID; server: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.Guid, System.String): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	frozen get_method_string_binding_flags_binder (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_event (name: STRING): SYSTEM_REFLECTION_EVENTINFO is
		external
			"IL signature (System.String): System.Reflection.EventInfo use System.Type"
		alias
			"GetEvent"
		end

	frozen get_type_from_clsid_guid_string_boolean (clsid: SYSTEM_GUID; server: STRING; throw_on_error: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.Guid, System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	frozen invoke_member (name: STRING; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]): ANY is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[]): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	frozen get_type_code (type: SYSTEM_TYPE): SYSTEM_TYPECODE is
		external
			"IL static signature (System.Type): System.TypeCode use System.Type"
		alias
			"GetTypeCode"
		end

	frozen get_method_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	get_member_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	get_event_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_EVENTINFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Type"
		alias
			"GetEvent"
		end

	frozen get_type_from_clsid (clsid: SYSTEM_GUID): SYSTEM_TYPE is
		external
			"IL static signature (System.Guid): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	get_interfaces: ARRAY [SYSTEM_TYPE] is
		external
			"IL deferred signature (): System.Type[] use System.Type"
		alias
			"GetInterfaces"
		end

	get_members_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMembers"
		end

	frozen get_property_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_type_from_clsid_guid_boolean (clsid: SYSTEM_GUID; throw_on_error: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.Guid, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	get_interface_map (interface_type: SYSTEM_TYPE): SYSTEM_REFLECTION_INTERFACEMAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Type"
		alias
			"GetInterfaceMap"
		end

	frozen get_property_string_type_array_type (name: STRING; return_type: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Type, System.Type[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_type_handle_object (o: ANY): SYSTEM_RUNTIMETYPEHANDLE is
		external
			"IL static signature (System.Object): System.RuntimeTypeHandle use System.Type"
		alias
			"GetTypeHandle"
		end

	frozen get_constructor_binding_flags_binder_array_type (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
		external
			"IL signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	frozen get_nested_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Type"
		alias
			"GetNestedTypes"
		end

	get_properties_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Type"
		alias
			"GetProperties"
		end

	get_element_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"GetElementType"
		end

	frozen get_method_string_array_type (name: STRING; types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	get_member_string_member_types (name: STRING; type: SYSTEM_REFLECTION_MEMBERTYPES; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String, System.Reflection.MemberTypes, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	frozen get_property (name: STRING): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_fields: ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL signature (): System.Reflection.FieldInfo[] use System.Type"
		alias
			"GetFields"
		end

	frozen get_constructor_binding_flags_binder_calling_conventions (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
		external
			"IL signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	frozen get_method_string_binding_flags_binder2 (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	get_nested_type_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Type use System.Type"
		alias
			"GetNestedType"
		end

	is_instance_of_type (o: ANY): BOOLEAN is
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

	get_attribute_flags_impl: SYSTEM_REFLECTION_TYPEATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.TypeAttributes use System.Type"
		alias
			"GetAttributeFlagsImpl"
		end

	get_property_impl (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; return_type: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
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

	get_method_impl (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
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

	get_constructor_impl (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
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

end -- class SYSTEM_TYPE
