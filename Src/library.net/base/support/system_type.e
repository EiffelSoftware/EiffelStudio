indexing
	Generator: "Eiffel Emitter 2.5b2"
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
			invoke_member as invoke_member_with_culture_and_modifiers,
			get_members as get_all_members,
			get_member as get_member_with_constraints,
			get_properties as get_all_properties,
			get_property as get_property_with_constraints,
			get_fields as get_all_fields,
			get_field as get_field_with_constraints,
			get_methods as get_all_methods,
			get_method as get_method_with_constraints
		end

feature -- Access

	frozen get_is_COM_object: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsCOMObject"
		end

	get_namespace: STRING is
		external
			"IL deferred signature (): System.String use System.Type"
		alias
			"get_Namespace"
		end

	frozen get_is_ansi_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsAnsiClass"
		end

	frozen get_type_initializer: SYSTEM_REFLECTION_CONSTRUCTORINFO is
		external
			"IL signature (): System.Reflection.ConstructorInfo use System.Type"
		alias
			"get_TypeInitializer"
		end

	frozen filter_name_ignore_case: SYSTEM_REFLECTION_MEMBERFILTER is
		external
			"IL static_field signature :System.Reflection.MemberFilter use System.Type"
		alias
			"FilterNameIgnoreCase"
		end

	frozen get_is_explicit_layout: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsExplicitLayout"
		end

	frozen get_is_value_type: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsValueType"
		end

	frozen get_is_auto_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsAutoClass"
		end

	frozen get_is_nested_private: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedPrivate"
		end

	frozen get_is_nested_fam_OR_assem: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedFamORAssem"
		end

	get_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL deferred signature (): System.Reflection.Assembly use System.Type"
		alias
			"get_Assembly"
		end

	frozen get_is_nested_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedAssembly"
		end

	frozen get_is_not_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNotPublic"
		end

	frozen get_is_nested_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedPublic"
		end

	frozen missing: ANY is
		external
			"IL static_field signature :System.Object use System.Type"
		alias
			"Missing"
		end

	get_GUID: SYSTEM_GUID is
		external
			"IL deferred signature (): System.Guid use System.Type"
		alias
			"get_GUID"
		end

	frozen get_is_layout_sequential: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsLayoutSequential"
		end

	frozen get_is_nested_family: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedFamily"
		end

	frozen filter_attribute: SYSTEM_REFLECTION_MEMBERFILTER is
		external
			"IL static_field signature :System.Reflection.MemberFilter use System.Type"
		alias
			"FilterAttribute"
		end

	get_member_type: INTEGER is
		external
			"IL signature (): enum System.Reflection.MemberTypes use System.Type"
		alias
			"get_MemberType"
		end

	get_base_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"get_BaseType"
		end

	get_type_handle: SYSTEM_RUNTIMETYPEHANDLE is
		external
			"IL deferred signature (): System.RuntimeTypeHandle use System.Type"
		alias
			"get_TypeHandle"
		end

	frozen get_is_interface: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsInterface"
		end

	frozen filter_name: SYSTEM_REFLECTION_MEMBERFILTER is
		external
			"IL static_field signature :System.Reflection.MemberFilter use System.Type"
		alias
			"FilterName"
		end

	frozen get_is_auto_layout: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsAutoLayout"
		end

	frozen get_is_pointer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsPointer"
		end

	frozen get_is_enum: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsEnum"
		end

	frozen get_is_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsClass"
		end

	get_reflected_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Type"
		alias
			"get_ReflectedType"
		end

	frozen get_attributes: INTEGER is
		external
			"IL signature (): enum System.Reflection.TypeAttributes use System.Type"
		alias
			"get_Attributes"
		ensure
			valid_type_attributes: Result = 7 or Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 24 or Result = 0 or Result = 8 or Result = 16 or Result = 32 or Result = 0 or Result = 32 or Result = 128 or Result = 256 or Result = 1024 or Result = 4096 or Result = 8192 or Result = 196608 or Result = 0 or Result = 65536 or Result = 131072 or Result = 1048576 or Result = 264192 or Result = 2048 or Result = 262144
		end

	get_full_name: STRING is
		external
			"IL deferred signature (): System.String use System.Type"
		alias
			"get_FullName"
		end

	get_declaring_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Type"
		alias
			"get_DeclaringType"
		end

	frozen get_is_nested_fam_AND_assem: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsNestedFamANDAssem"
		end

	get_assembly_qualified_name: STRING is
		external
			"IL deferred signature (): System.String use System.Type"
		alias
			"get_AssemblyQualifiedName"
		end

	frozen empty_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL static_field signature :System.Type[] use System.Type"
		alias
			"EmptyTypes"
		end

	frozen get_is_serviced_component: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsServicedComponent"
		end

	frozen get_is_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsPublic"
		end

	frozen get_is_abstract: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsAbstract"
		end

	get_underlying_system_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"get_UnderlyingSystemType"
		end

	frozen get_is_primitive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsPrimitive"
		end

	frozen get_is_serializable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsSerializable"
		end

	get_module: SYSTEM_REFLECTION_MODULE is
		external
			"IL deferred signature (): System.Reflection.Module use System.Type"
		alias
			"get_Module"
		end

	frozen get_is_contextful: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsContextful"
		end

	frozen get_is_import: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsImport"
		end

	frozen get_is_array: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsArray"
		end

	frozen get_is_by_ref: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsByRef"
		end

	frozen get_is_marshal_by_ref: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsMarshalByRef"
		end

	frozen delimiter: CHARACTER is
		external
			"IL static_field signature :System.Char use System.Type"
		alias
			"Delimiter"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsSpecialName"
		end

	frozen get_is_unicode_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsUnicodeClass"
		end

	frozen get_default_binder: SYSTEM_REFLECTION_BINDER is
		external
			"IL static signature (): System.Reflection.Binder use System.Type"
		alias
			"get_DefaultBinder"
		end

	frozen get_has_element_type: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_HasElementType"
		end

	frozen get_is_sealed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"get_IsSealed"
		end

feature -- Basic Operations

	frozen get_method (name2: STRING): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_method_with_constraints (name2: STRING; binding_attr: INTEGER): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_method_with_types (name2: STRING; types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_method_with_constraints_types_and_modifiers (name2: STRING; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_method_with_constraints_types_modifiers_and_convention (name2: STRING; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; call_convention: INTEGER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
			-- Valid values for `call_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & call_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, enum System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_method_with_types_and_modifiers (name2: STRING; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethod"
		end

	frozen get_methods: ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Type"
		alias
			"GetMethods"
		end

	get_all_methods (binding_attr: INTEGER): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL deferred signature (enum System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Type"
		alias
			"GetMethods"
		end

	find_members (memberType2: INTEGER; binding_attr: INTEGER; filter: SYSTEM_REFLECTION_MEMBERFILTER; filterCriteria: ANY): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (enum System.Reflection.MemberTypes, enum System.Reflection.BindingFlags, System.Reflection.MemberFilter, System.Object): System.Reflection.MemberInfo[] use System.Type"
		alias
			"FindMembers"
		end

	frozen get_event (name2: STRING): SYSTEM_REFLECTION_EVENTINFO is
		external
			"IL signature (System.String): System.Reflection.EventInfo use System.Type"
		alias
			"GetEvent"
		end

	get_event_with_constraints (name2: STRING; binding_attr: INTEGER): SYSTEM_REFLECTION_EVENTINFO is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (System.String, enum System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Type"
		alias
			"GetEvent"
		end

	get_all_events (binding_attr: INTEGER): ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (enum System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Type"
		alias
			"GetEvents"
		end

	get_events: ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
		external
			"IL signature (): System.Reflection.EventInfo[] use System.Type"
		alias
			"GetEvents"
		end

	frozen get_member (name2: STRING): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	get_member_with_constraints (name2: STRING; binding_attr: INTEGER): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	get_member_with_type_and_constraints (name2: STRING; type: INTEGER; binding_attr: INTEGER): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (System.String, enum System.Reflection.MemberTypes, enum System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMember"
		end

	frozen get_members: ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMembers"
		end

	get_all_members (binding_attr: INTEGER): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL deferred signature (enum System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetMembers"
		end

	find_interfaces (filter: SYSTEM_REFLECTION_TYPEFILTER; filterCriteria: ANY): ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (System.Reflection.TypeFilter, System.Object): System.Type[] use System.Type"
		alias
			"FindInterfaces"
		end

	get_array_rank: INTEGER is
		external
			"IL signature (): System.Int32 use System.Type"
		alias
			"GetArrayRank"
		end

	is_assignable_from (c: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"IsAssignableFrom"
		end

	frozen get_type_array (args: ARRAY [ANY]): ARRAY [SYSTEM_TYPE] is
		external
			"IL static signature (System.Object[]): System.Type[] use System.Type"
		alias
			"GetTypeArray"
		end

	frozen get_type_from_CLSID_from_server_with_exception (clsid: SYSTEM_GUID; server: STRING; throwOnError: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.Guid, System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	frozen get_type_from_CLSID (clsid: SYSTEM_GUID): SYSTEM_TYPE is
		external
			"IL static signature (System.Guid): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	frozen get_type_from_CLSID_from_server (clsid: SYSTEM_GUID; server: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.Guid, System.String): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	frozen get_type_from_CLSID_with_exception (clsid: SYSTEM_GUID; throwOnError: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.Guid, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromCLSID"
		end

	frozen get_type_from_prog_ID_with_exception (progID: STRING; throwOnError: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen get_type_from_prog_ID_from_server (progID: STRING; server: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen get_type_from_prog_ID_from_server_with_exception (progID: STRING; server: STRING; throwOnError: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	frozen get_type_from_prog_ID (progID: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String): System.Type use System.Type"
		alias
			"GetTypeFromProgID"
		end

	is_subclass_of (c: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"IsSubclassOf"
		end

	frozen get_type_code (type: SYSTEM_TYPE): INTEGER is
		external
			"IL static signature (System.Type): enum System.TypeCode use System.Type"
		alias
			"GetTypeCode"
		ensure
			valid_type_code: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 13 or Result = 14 or Result = 15 or Result = 16 or Result = 18
		end

	frozen get_constructor (types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
		external
			"IL signature (System.Type[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	frozen get_constructor_with_argument_modifiers_and_constraints (binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	frozen get_constructor_with_argument_modifiers_constraints_and_calling_conventions (binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; call_convention: INTEGER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
			-- Valid values for `call_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & call_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (enum System.Reflection.BindingFlags, System.Reflection.Binder, enum System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructor"
		end

	get_all_constructors (binding_attr: INTEGER): ARRAY [SYSTEM_REFLECTION_CONSTRUCTORINFO] is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (enum System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Type"
		alias
			"GetConstructors"
		end

	frozen get_constructors: ARRAY [SYSTEM_REFLECTION_CONSTRUCTORINFO] is
		external
			"IL signature (): System.Reflection.ConstructorInfo[] use System.Type"
		alias
			"GetConstructors"
		end

	get_constructor_impl (binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; call_convention: INTEGER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
			-- Valid values for `call_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & call_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL deferred signature (enum System.Reflection.BindingFlags, System.Reflection.Binder, enum System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Type"
		alias
			"GetConstructorImpl"
		end

	frozen get_interface (name2: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Type"
		alias
			"GetInterface"
		end

	get_interface_case_sensitive (name2: STRING; ignoreCase: BOOLEAN): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetInterface"
		end

	get_interface_map (interfaceType: SYSTEM_TYPE): SYSTEM_REFLECTION_INTERFACEMAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Type"
		alias
			"GetInterfaceMap"
		end

	get_interfaces: ARRAY [SYSTEM_TYPE] is
		external
			"IL deferred signature (): System.Type[] use System.Type"
		alias
			"GetInterfaces"
		end

	frozen get_type_handle_of (o: ANY): SYSTEM_RUNTIMETYPEHANDLE is
		external
			"IL static signature (System.Object): System.RuntimeTypeHandle use System.Type"
		alias
			"GetTypeHandle"
		end

	frozen get_type_with_options (typeName: STRING; throwOnError: BOOLEAN; ignoreCase: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.Boolean, System.Boolean): System.Type use System.Type"
		alias
			"GetType"
		end

	frozen get_type_case_sensitive (typeName: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String): System.Type use System.Type"
		alias
			"GetType"
		end

	frozen get_type_case_sensitive_with_error (typeName: STRING; throwOnError: BOOLEAN): SYSTEM_TYPE is
		external
			"IL static signature (System.String, System.Boolean): System.Type use System.Type"
		alias
			"GetType"
		end

	frozen equals_type (o: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Type"
		alias
			"Equals"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Type"
		alias
			"Equals"
		end

	get_default_members: ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (): System.Reflection.MemberInfo[] use System.Type"
		alias
			"GetDefaultMembers"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Type"
		alias
			"GetHashCode"
		end

	frozen get_field (name2: STRING): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL signature (System.String): System.Reflection.FieldInfo use System.Type"
		alias
			"GetField"
		end

	get_field_with_constraints (name2: STRING; binding_attr: INTEGER): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL deferred signature (System.String, enum System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Type"
		alias
			"GetField"
		end

	get_all_fields (binding_attr: INTEGER): ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL deferred signature (enum System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Type"
		alias
			"GetFields"
		end

	frozen get_fields: ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL signature (): System.Reflection.FieldInfo[] use System.Type"
		alias
			"GetFields"
		end

	get_all_nested_type (name2: STRING; binding_attr: INTEGER): SYSTEM_TYPE is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (System.String, enum System.Reflection.BindingFlags): System.Type use System.Type"
		alias
			"GetNestedType"
		end

	frozen get_nested_type (name2: STRING): SYSTEM_TYPE is
		external
			"IL signature (System.String): System.Type use System.Type"
		alias
			"GetNestedType"
		end

	get_all_nested_types (binding_attr: INTEGER): ARRAY [SYSTEM_TYPE] is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (enum System.Reflection.BindingFlags): System.Type[] use System.Type"
		alias
			"GetNestedTypes"
		end

	frozen get_nested_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Type"
		alias
			"GetNestedTypes"
		end

	frozen get_property (name2: STRING): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_property_with_returning_type_and_parameters (name2: STRING; returnType: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Type, System.Type[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_property_with_returning_type_parameters_and_modifiers (name2: STRING; returnType: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_property_with_constraints (name2: STRING; binding_attr: INTEGER): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_property_with_returnig_type (name2: STRING; returnType: SYSTEM_TYPE): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Type): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_property_with_parameters (name2: STRING; types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Type[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	frozen get_property_with_constraints_returning_type_parameters_and_modifiers (name2: STRING; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; returnType: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetProperty"
		end

	get_all_properties (binding_attr: INTEGER): ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL deferred signature (enum System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Type"
		alias
			"GetProperties"
		end

	frozen get_properties: ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL signature (): System.Reflection.PropertyInfo[] use System.Type"
		alias
			"GetProperties"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Type"
		alias
			"ToString"
		end

	frozen get_type_from_Handle (handle: SYSTEM_RUNTIMETYPEHANDLE): SYSTEM_TYPE is
		external
			"IL static signature (System.RuntimeTypeHandle): System.Type use System.Type"
		alias
			"GetTypeFromHandle"
		end

	get_element_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Type"
		alias
			"GetElementType"
		end

	frozen invoke_member (name2: STRING; invoke_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]): ANY is
			-- Valid values for `invoke_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & invoke_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[]): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	invoke_member_with_culture_and_modifiers (name2: STRING; invoke_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; namedParameters: ARRAY [STRING]): ANY is
		external
			"IL deferred signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	frozen invoke_member_with_culture (name2: STRING; invoke_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
			-- Valid values for `invoke_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & invoke_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Globalization.CultureInfo): System.Object use System.Type"
		alias
			"InvokeMember"
		end

	is_instance_of_type (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Type"
		alias
			"IsInstanceOfType"
		end

feature {NONE} -- Implementation

	is_array_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"IsArrayImpl"
		end

	is_COM_object_impl: BOOLEAN is
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

	get_method_impl (name2: STRING; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; call_convention: INTEGER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
			-- Valid values for `call_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & call_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL deferred signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, enum System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Type"
		alias
			"GetMethodImpl"
		end

	is_contextful_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"IsContextfulImpl"
		end

	get_attribute_flags_impl: INTEGER is
		external
			"IL deferred signature (): enum System.Reflection.TypeAttributes use System.Type"
		alias
			"GetAttributeFlagsImpl"
		ensure
			valid_type_attributes: Result = 7 or Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 24 or Result = 0 or Result = 8 or Result = 16 or Result = 32 or Result = 0 or Result = 32 or Result = 128 or Result = 256 or Result = 1024 or Result = 4096 or Result = 8192 or Result = 196608 or Result = 0 or Result = 65536 or Result = 131072 or Result = 1048576 or Result = 264192 or Result = 2048 or Result = 262144
		end

	get_property_impl (name2: STRING; binding_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; returnType: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
			-- Valid values for `binding_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & binding_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Type"
		alias
			"GetPropertyImpl"
		end

	is_by_ref_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"IsByRefImpl"
		end

	is_value_type_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"IsValueTypeImpl"
		end

	is_marshal_by_ref_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Type"
		alias
			"IsMarshalByRefImpl"
		end

	has_element_type_impl: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Type"
		alias
			"HasElementTypeImpl"
		end

end -- class SYSTEM_TYPE
