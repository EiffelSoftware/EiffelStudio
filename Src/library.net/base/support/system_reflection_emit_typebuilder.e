indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.TypeBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_TYPEBUILDER

inherit
	SYSTEM_TYPE
		redefine
			get_interface_map,
			is_subclass_of,
			get_member_with_type_and_constraints,
			get_events,
			get_reflected_type,
			get_declaring_type,
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

create {NONE}

feature -- Access

	get_full_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_FullName"
		end

	get_reflected_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_ReflectedType"
		end

	get_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Assembly"
		end

	frozen unspecified_type_size: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Reflection.Emit.TypeBuilder"
		alias
			"UnspecifiedTypeSize"
		end

	frozen get_packing_size: INTEGER is
		external
			"IL signature (): enum System.Reflection.Emit.PackingSize use System.Reflection.Emit.TypeBuilder"
		alias
			"get_PackingSize"
		ensure
			valid_packing_size: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16
		end

	get_underlying_system_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_UnderlyingSystemType"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Size"
		end

	get_declaring_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_DeclaringType"
		end

	get_type_handle: SYSTEM_RUNTIMETYPEHANDLE is
		external
			"IL signature (): System.RuntimeTypeHandle use System.Reflection.Emit.TypeBuilder"
		alias
			"get_TypeHandle"
		end

	frozen get_type_token: SYSTEM_REFLECTION_EMIT_TYPETOKEN is
		external
			"IL signature (): System.Reflection.Emit.TypeToken use System.Reflection.Emit.TypeBuilder"
		alias
			"get_TypeToken"
		end

	get_base_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_BaseType"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Name"
		end

	get_GUID: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Reflection.Emit.TypeBuilder"
		alias
			"get_GUID"
		end

	get_namespace: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Namespace"
		end

	get_assembly_qualified_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_AssemblyQualifiedName"
		end

	get_module: SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (): System.Reflection.Module use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Module"
		end

feature -- Basic Operations

	get_member_with_type_and_constraints (name2: STRING; type: INTEGER; bindingAttr: INTEGER): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String, enum System.Reflection.MemberTypes, enum System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMember"
		end

	get_event_with_constraints (name2: STRING; bindingAttr: INTEGER): SYSTEM_REFLECTION_EVENTINFO is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvent"
		end

	frozen define_type_initializer: SYSTEM_REFLECTION_EMIT_CONSTRUCTORBUILDER is
		external
			"IL signature (): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineTypeInitializer"
		end

	frozen define_p_invoke_method_with_entry_point (name2: STRING; dllName: STRING; entryName: STRING; attributes2: INTEGER; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]; native_call_conv: INTEGER; native_char_set: INTEGER): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
			-- Valid values for `native_char_set' are:
			-- None = 1
			-- Ansi = 2
			-- Unicode = 3
			-- Auto = 4
		require
			valid_char_set: native_char_set = 1 or native_char_set = 2 or native_char_set = 3 or native_char_set = 4
		external
			"IL signature (System.String, System.String, System.String, enum System.Reflection.MethodAttributes, enum System.Reflection.CallingConventions, System.Type, System.Type[], enum System.Runtime.InteropServices.CallingConvention, enum System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefinePInvokeMethod"
		end

	frozen define_nested_type (name2: STRING): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen define_nested_with_attributes (name2: STRING; attr: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `attr' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & attr = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen define_nested_with_attributes_and_parent (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `attr' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & attr = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen define_nested_type_with_attributes_parent_and_size (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE; typeSize: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `attr' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & attr = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen define_nested_ype_with_attributes_parent_and_interfaces (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE; interfaces: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `attr' are a combination of the following values:
			-- VisibilityMask = 7
			-- NotPublic = 0
			-- Public = 1
			-- NestedPublic = 2
			-- NestedPrivate = 3
			-- NestedFamily = 4
			-- NestedAssembly = 5
			-- NestedFamANDAssem = 6
			-- NestedFamORAssem = 7
			-- LayoutMask = 24
			-- AutoLayout = 0
			-- SequentialLayout = 8
			-- ExplicitLayout = 16
			-- ClassSemanticsMask = 32
			-- Class = 0
			-- Interface = 32
			-- Abstract = 128
			-- Sealed = 256
			-- SpecialName = 1024
			-- Import = 4096
			-- Serializable = 8192
			-- StringFormatMask = 196608
			-- AnsiClass = 0
			-- UnicodeClass = 65536
			-- AutoClass = 131072
			-- BeforeFieldInit = 1048576
			-- ReservedMask = 264192
			-- RTSpecialName = 2048
			-- HasSecurity = 262144
		require
			valid_type_attributes: (7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144) & attr = 7 + 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 24 + 0 + 8 + 16 + 32 + 0 + 32 + 128 + 256 + 1024 + 4096 + 8192 + 196608 + 0 + 65536 + 131072 + 1048576 + 264192 + 2048 + 262144
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type, System.Type[]): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen define_nested_type_with_attributes_parent_and_packing_size (name2: STRING; attr: INTEGER; parent: SYSTEM_TYPE; pack_size: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
			-- Valid values for `pack_size' are:
			-- Unspecified = 0
			-- Size1 = 1
			-- Size2 = 2
			-- Size4 = 4
			-- Size8 = 8
			-- Size16 = 16
		require
			valid_packing_size: pack_size = 0 or pack_size = 1 or pack_size = 2 or pack_size = 4 or pack_size = 8 or pack_size = 16
		external
			"IL signature (System.String, enum System.Reflection.TypeAttributes, System.Type, enum System.Reflection.Emit.PackingSize): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen add_declarative_security (action: INTEGER; pset: SYSTEM_SECURITY_PERMISSIONSET) is
			-- Valid values for `action' are:
			-- Demand = 2
			-- Assert = 3
			-- Deny = 4
			-- PermitOnly = 5
			-- LinkDemand = 6
			-- InheritanceDemand = 7
			-- RequestMinimum = 8
			-- RequestOptional = 9
			-- RequestRefuse = 10
		require
			valid_security_action: action = 2 or action = 3 or action = 4 or action = 5 or action = 6 or action = 7 or action = 8 or action = 9 or action = 10
		external
			"IL signature (enum System.Security.Permissions.SecurityAction, System.Security.PermissionSet): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"AddDeclarativeSecurity"
		end

	get_all_methods (bindingAttr: INTEGER): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (enum System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMethods"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen define_field (fieldName: STRING; type: SYSTEM_TYPE; attributes2: INTEGER): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
			-- Valid values for `attributes2' are:
			-- FieldAccessMask = 7
			-- PrivateScope = 0
			-- Private = 1
			-- FamANDAssem = 2
			-- Assembly = 3
			-- Family = 4
			-- FamORAssem = 5
			-- Public = 6
			-- Static = 16
			-- InitOnly = 32
			-- Literal = 64
			-- NotSerialized = 128
			-- SpecialName = 512
			-- PinvokeImpl = 8192
			-- ReservedMask = 38144
			-- RTSpecialName = 1024
			-- HasFieldMarshal = 4096
			-- HasDefault = 32768
			-- HasFieldRVA = 256
		require
			valid_field_attributes: attributes2 = 7 or attributes2 = 0 or attributes2 = 1 or attributes2 = 2 or attributes2 = 3 or attributes2 = 4 or attributes2 = 5 or attributes2 = 6 or attributes2 = 16 or attributes2 = 32 or attributes2 = 64 or attributes2 = 128 or attributes2 = 512 or attributes2 = 8192 or attributes2 = 38144 or attributes2 = 1024 or attributes2 = 4096 or attributes2 = 32768 or attributes2 = 256
		external
			"IL signature (System.String, System.Type, enum System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineField"
		end

	frozen define_method (name2: STRING; attributes2: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
			-- Valid values for `attributes2' are:
			-- MemberAccessMask = 7
			-- PrivateScope = 0
			-- Private = 1
			-- FamANDAssem = 2
			-- Assembly = 3
			-- Family = 4
			-- FamORAssem = 5
			-- Public = 6
			-- Static = 16
			-- Final = 32
			-- Virtual = 64
			-- HideBySig = 128
			-- VtableLayoutMask = 256
			-- ReuseSlot = 0
			-- NewSlot = 256
			-- Abstract = 1024
			-- SpecialName = 2048
			-- PinvokeImpl = 8192
			-- UnmanagedExport = 8
			-- RTSpecialName = 4096
			-- ReservedMask = 53248
			-- HasSecurity = 16384
			-- RequireSecObject = 32768
		require
			valid_method_attributes: attributes2 = 7 or attributes2 = 0 or attributes2 = 1 or attributes2 = 2 or attributes2 = 3 or attributes2 = 4 or attributes2 = 5 or attributes2 = 6 or attributes2 = 16 or attributes2 = 32 or attributes2 = 64 or attributes2 = 128 or attributes2 = 256 or attributes2 = 0 or attributes2 = 256 or attributes2 = 1024 or attributes2 = 2048 or attributes2 = 8192 or attributes2 = 8 or attributes2 = 4096 or attributes2 = 53248 or attributes2 = 16384 or attributes2 = 32768
		external
			"IL signature (System.String, enum System.Reflection.MethodAttributes, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethod"
		end

	is_subclass_of (c: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsSubclassOf"
		end

	frozen define_p_invoke_method (name2: STRING; dllName: STRING; attributes2: INTEGER; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]; native_call_conv: INTEGER; native_char_set: INTEGER): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
			-- Valid values for `native_char_set' are:
			-- None = 1
			-- Ansi = 2
			-- Unicode = 3
			-- Auto = 4
		require
			valid_char_set: native_char_set = 1 or native_char_set = 2 or native_char_set = 3 or native_char_set = 4
		external
			"IL signature (System.String, System.String, enum System.Reflection.MethodAttributes, enum System.Reflection.CallingConventions, System.Type, System.Type[], enum System.Runtime.InteropServices.CallingConvention, enum System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefinePInvokeMethod"
		end

	frozen set_custom_attribute (customBuilder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetCustomAttribute"
		end

	get_interfaces: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterfaces"
		end

	frozen define_property (name2: STRING; attributes2: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_PROPERTYBUILDER is
			-- Valid values for `attributes2' are a combination of the following values:
			-- None = 0
			-- SpecialName = 512
			-- ReservedMask = 62464
			-- RTSpecialName = 1024
			-- HasDefault = 4096
			-- Reserved2 = 8192
			-- Reserved3 = 16384
			-- Reserved4 = 32768
		require
			valid_property_attributes: (0 + 512 + 62464 + 1024 + 4096 + 8192 + 16384 + 32768) & attributes2 = 0 + 512 + 62464 + 1024 + 4096 + 8192 + 16384 + 32768
		external
			"IL signature (System.String, enum System.Reflection.PropertyAttributes, System.Type, System.Type[]): System.Reflection.Emit.PropertyBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineProperty"
		end

	get_all_members (bindingAttr: INTEGER): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (enum System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMembers"
		end

	frozen set_parent (parent: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetParent"
		end

	get_interface_case_sensitive (name2: STRING; ignoreCase: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterface"
		end

	get_all_constructors (bindingAttr: INTEGER): ARRAY [SYSTEM_REFLECTION_CONSTRUCTORINFO] is
		external
			"IL signature (enum System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetConstructors"
		end

	frozen define_initialized_data (name2: STRING; data: ARRAY [INTEGER_8]; attributes2: INTEGER): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
			-- Valid values for `attributes2' are:
			-- FieldAccessMask = 7
			-- PrivateScope = 0
			-- Private = 1
			-- FamANDAssem = 2
			-- Assembly = 3
			-- Family = 4
			-- FamORAssem = 5
			-- Public = 6
			-- Static = 16
			-- InitOnly = 32
			-- Literal = 64
			-- NotSerialized = 128
			-- SpecialName = 512
			-- PinvokeImpl = 8192
			-- ReservedMask = 38144
			-- RTSpecialName = 1024
			-- HasFieldMarshal = 4096
			-- HasDefault = 32768
			-- HasFieldRVA = 256
		require
			valid_field_attributes: attributes2 = 7 or attributes2 = 0 or attributes2 = 1 or attributes2 = 2 or attributes2 = 3 or attributes2 = 4 or attributes2 = 5 or attributes2 = 6 or attributes2 = 16 or attributes2 = 32 or attributes2 = 64 or attributes2 = 128 or attributes2 = 512 or attributes2 = 8192 or attributes2 = 38144 or attributes2 = 1024 or attributes2 = 4096 or attributes2 = 32768 or attributes2 = 256
		external
			"IL signature (System.String, System.Byte[], enum System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineInitializedData"
		end

	is_defined (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsDefined"
		end

	frozen define_uninitialized_data (name2: STRING; size2: INTEGER; attributes2: INTEGER): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
			-- Valid values for `attributes2' are:
			-- FieldAccessMask = 7
			-- PrivateScope = 0
			-- Private = 1
			-- FamANDAssem = 2
			-- Assembly = 3
			-- Family = 4
			-- FamORAssem = 5
			-- Public = 6
			-- Static = 16
			-- InitOnly = 32
			-- Literal = 64
			-- NotSerialized = 128
			-- SpecialName = 512
			-- PinvokeImpl = 8192
			-- ReservedMask = 38144
			-- RTSpecialName = 1024
			-- HasFieldMarshal = 4096
			-- HasDefault = 32768
			-- HasFieldRVA = 256
		require
			valid_field_attributes: attributes2 = 7 or attributes2 = 0 or attributes2 = 1 or attributes2 = 2 or attributes2 = 3 or attributes2 = 4 or attributes2 = 5 or attributes2 = 6 or attributes2 = 16 or attributes2 = 32 or attributes2 = 64 or attributes2 = 128 or attributes2 = 512 or attributes2 = 8192 or attributes2 = 38144 or attributes2 = 1024 or attributes2 = 4096 or attributes2 = 32768 or attributes2 = 256
		external
			"IL signature (System.String, System.Int32, enum System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineUninitializedData"
		end

	get_interface_map (interfaceType: SYSTEM_TYPE): SYSTEM_REFLECTION_INTERFACEMAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterfaceMap"
		end

	get_all_nested_type (name2: STRING; bindingAttr: INTEGER): SYSTEM_TYPE is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetNestedType"
		end

	get_all_nested_types (bindingAttr: INTEGER): ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (enum System.Reflection.BindingFlags): System.Type[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetNestedTypes"
		end

	frozen create_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"CreateType"
		end

	frozen add_interface_implementation (interfaceType: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"AddInterfaceImplementation"
		end

	get_all_fields (bindingAttr: INTEGER): ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL signature (enum System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetFields"
		end

	get_all_events (bindingAttr: INTEGER): ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
		external
			"IL signature (enum System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvents"
		end

	get_all_properties (bindingAttr: INTEGER): ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL signature (enum System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetProperties"
		end

	frozen define_method_override (methodInfoBody: SYSTEM_REFLECTION_METHODINFO; methodInfoDeclaration: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL signature (System.Reflection.MethodInfo, System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethodOverride"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"ToString"
		end

	frozen define_method_with_conventions (name2: STRING; attributes2: INTEGER; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
			-- Valid values for `calling_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & calling_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (System.String, enum System.Reflection.MethodAttributes, enum System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethod"
		end

	get_field_with_constraints (name2: STRING; bindingAttr: INTEGER): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetField"
		end

	frozen set_custom_attribute_with_blob (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binaryAttribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetCustomAttribute"
		end

	get_element_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetElementType"
		end

	frozen define_event (name2: STRING; attributes2: INTEGER; eventtype: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_EVENTBUILDER is
			-- Valid values for `attributes2' are:
			-- None = 0
			-- SpecialName = 512
			-- ReservedMask = 1024
			-- RTSpecialName = 1024
		require
			valid_event_attributes: attributes2 = 0 or attributes2 = 512 or attributes2 = 1024 or attributes2 = 1024
		external
			"IL signature (System.String, enum System.Reflection.EventAttributes, System.Type): System.Reflection.Emit.EventBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineEvent"
		end

	frozen define_constructor (attributes2: INTEGER; calling_convention: INTEGER; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_CONSTRUCTORBUILDER is
			-- Valid values for `calling_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & calling_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (enum System.Reflection.MethodAttributes, enum System.Reflection.CallingConventions, System.Type[]): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineConstructor"
		end

	invoke_member_with_culture_and_modifiers (name2: STRING; invokeAttr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; namedParameters: ARRAY [STRING]): ANY is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Reflection.Emit.TypeBuilder"
		alias
			"InvokeMember"
		end

	get_events: ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
		external
			"IL signature (): System.Reflection.EventInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvents"
		end

	get_custom_attributes_for_type (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen define_default_constructor (attributes2: INTEGER): SYSTEM_REFLECTION_EMIT_CONSTRUCTORBUILDER is
			-- Valid values for `attributes2' are:
			-- MemberAccessMask = 7
			-- PrivateScope = 0
			-- Private = 1
			-- FamANDAssem = 2
			-- Assembly = 3
			-- Family = 4
			-- FamORAssem = 5
			-- Public = 6
			-- Static = 16
			-- Final = 32
			-- Virtual = 64
			-- HideBySig = 128
			-- VtableLayoutMask = 256
			-- ReuseSlot = 0
			-- NewSlot = 256
			-- Abstract = 1024
			-- SpecialName = 2048
			-- PinvokeImpl = 8192
			-- UnmanagedExport = 8
			-- RTSpecialName = 4096
			-- ReservedMask = 53248
			-- HasSecurity = 16384
			-- RequireSecObject = 32768
		require
			valid_method_attributes: attributes2 = 7 or attributes2 = 0 or attributes2 = 1 or attributes2 = 2 or attributes2 = 3 or attributes2 = 4 or attributes2 = 5 or attributes2 = 6 or attributes2 = 16 or attributes2 = 32 or attributes2 = 64 or attributes2 = 128 or attributes2 = 256 or attributes2 = 0 or attributes2 = 256 or attributes2 = 1024 or attributes2 = 2048 or attributes2 = 8192 or attributes2 = 8 or attributes2 = 4096 or attributes2 = 53248 or attributes2 = 16384 or attributes2 = 32768
		external
			"IL signature (enum System.Reflection.MethodAttributes): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineDefaultConstructor"
		end

feature {NONE} -- Implementation

	get_constructor_impl (bindingAttr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; callConvention: INTEGER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
		external
			"IL signature (enum System.Reflection.BindingFlags, System.Reflection.Binder, enum System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetConstructorImpl"
		end

	is_COM_object_Impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsCOMObjectImpl"
		end

	is_primitive_Impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsPrimitiveImpl"
		end

	is_pointer_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsPointerImpl"
		end

	get_method_Impl (name2: STRING; bindingAttr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; callConvention: INTEGER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, enum System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMethodImpl"
		end

	get_property_Impl (name2: STRING; bindingAttr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; returnType: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetPropertyImpl"
		end

	get_attribute_flags_impl: INTEGER is
		external
			"IL signature (): enum System.Reflection.TypeAttributes use System.Reflection.Emit.TypeBuilder"
		alias
			"GetAttributeFlagsImpl"
		end

	is_by_ref_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsByRefImpl"
		end

	is_array_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsArrayImpl"
		end

	has_element_type_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"HasElementTypeImpl"
		end

end -- class SYSTEM_REFLECTION_EMIT_TYPEBUILDER
