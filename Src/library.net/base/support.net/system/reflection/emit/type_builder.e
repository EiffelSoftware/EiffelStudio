indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.TypeBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TYPE_BUILDER

inherit
	TYPE
		redefine
			get_interface_map,
			is_assignable_from,
			is_subclass_of,
			get_member_string_member_types,
			get_events,
			get_reflected_type,
			get_declaring_type,
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

create {NONE}

feature -- Access

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Size"
		end

	get_assembly: ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Assembly"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Name"
		end

	get_reflected_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_ReflectedType"
		end

	get_type_handle: RUNTIME_TYPE_HANDLE is
		external
			"IL signature (): System.RuntimeTypeHandle use System.Reflection.Emit.TypeBuilder"
		alias
			"get_TypeHandle"
		end

	get_base_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_BaseType"
		end

	get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Namespace"
		end

	get_module: MODULE is
		external
			"IL signature (): System.Reflection.Module use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Module"
		end

	get_guid: GUID is
		external
			"IL signature (): System.Guid use System.Reflection.Emit.TypeBuilder"
		alias
			"get_GUID"
		end

	get_declaring_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_DeclaringType"
		end

	get_assembly_qualified_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_AssemblyQualifiedName"
		end

	get_full_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_FullName"
		end

	frozen get_type_token: TYPE_TOKEN is
		external
			"IL signature (): System.Reflection.Emit.TypeToken use System.Reflection.Emit.TypeBuilder"
		alias
			"get_TypeToken"
		end

	frozen unspecified_type_size: INTEGER is 0x0

	frozen get_packing_size: PACKING_SIZE is
		external
			"IL signature (): System.Reflection.Emit.PackingSize use System.Reflection.Emit.TypeBuilder"
		alias
			"get_PackingSize"
		end

	get_underlying_system_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_UnderlyingSystemType"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"ToString"
		end

	frozen define_nested_type_string_type_attributes (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen add_declarative_security (action: SECURITY_ACTION; pset: PERMISSION_SET) is
		external
			"IL signature (System.Security.Permissions.SecurityAction, System.Security.PermissionSet): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"AddDeclarativeSecurity"
		end

	frozen define_method_override (method_info_body: METHOD_INFO; method_info_declaration: METHOD_INFO) is
		external
			"IL signature (System.Reflection.MethodInfo, System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethodOverride"
		end

	frozen define_event (name: SYSTEM_STRING; attributes: EVENT_ATTRIBUTES; eventtype: TYPE): EVENT_BUILDER is
		external
			"IL signature (System.String, System.Reflection.EventAttributes, System.Type): System.Reflection.Emit.EventBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineEvent"
		end

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_nested_type_string_type_attributes_type_packing_size (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE; pack_size: PACKING_SIZE): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Reflection.Emit.PackingSize): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	is_subclass_of (c: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsSubclassOf"
		end

	get_constructors_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [CONSTRUCTOR_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetConstructors"
		end

	get_methods_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMethods"
		end

	frozen add_interface_implementation (interface_type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"AddInterfaceImplementation"
		end

	frozen define_nested_type_string_type_attributes_type_array_type (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE; interfaces: NATIVE_ARRAY [TYPE]): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Type[]): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	get_nested_types_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [TYPE] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Type[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetNestedTypes"
		end

	get_events: NATIVE_ARRAY [EVENT_INFO] is
		external
			"IL signature (): System.Reflection.EventInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvents"
		end

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetCustomAttribute"
		end

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetCustomAttributes"
		end

	is_assignable_from (c: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsAssignableFrom"
		end

	frozen create_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"CreateType"
		end

	get_field_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): FIELD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetField"
		end

	get_events_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [EVENT_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvents"
		end

	frozen define_type_initializer: CONSTRUCTOR_BUILDER is
		external
			"IL signature (): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineTypeInitializer"
		end

	invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier (name: SYSTEM_STRING; invoke_attr: BINDING_FLAGS; binder: BINDER; target: SYSTEM_OBJECT; args: NATIVE_ARRAY [SYSTEM_OBJECT]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]; culture: CULTURE_INFO; named_parameters: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Reflection.Emit.TypeBuilder"
		alias
			"InvokeMember"
		end

	get_interface_string_boolean (name: SYSTEM_STRING; ignore_case: BOOLEAN): TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterface"
		end

	get_fields_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [FIELD_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetFields"
		end

	frozen set_parent (parent: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetParent"
		end

	frozen define_uninitialized_data (name: SYSTEM_STRING; size: INTEGER; attributes: FIELD_ATTRIBUTES): FIELD_BUILDER is
		external
			"IL signature (System.String, System.Int32, System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineUninitializedData"
		end

	frozen define_nested_type (name: SYSTEM_STRING): TYPE_BUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen define_constructor (attributes: METHOD_ATTRIBUTES; calling_convention: CALLING_CONVENTIONS; parameter_types: NATIVE_ARRAY [TYPE]): CONSTRUCTOR_BUILDER is
		external
			"IL signature (System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type[]): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineConstructor"
		end

	frozen define_nested_type_string_type_attributes_type_int32 (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE; type_size: INTEGER): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	get_element_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetElementType"
		end

	frozen define_initialized_data (name: SYSTEM_STRING; data: NATIVE_ARRAY [INTEGER_8]; attributes: FIELD_ATTRIBUTES): FIELD_BUILDER is
		external
			"IL signature (System.String, System.Byte[], System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineInitializedData"
		end

	frozen define_field (field_name: SYSTEM_STRING; type: TYPE; attributes: FIELD_ATTRIBUTES): FIELD_BUILDER is
		external
			"IL signature (System.String, System.Type, System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineField"
		end

	get_event_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): EVENT_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvent"
		end

	frozen define_pinvoke_method_string_string_string (name: SYSTEM_STRING; dll_name: SYSTEM_STRING; entry_name: SYSTEM_STRING; attributes: METHOD_ATTRIBUTES; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]; native_call_conv: CALLING_CONVENTION; native_char_set: CHAR_SET): METHOD_BUILDER is
		external
			"IL signature (System.String, System.String, System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[], System.Runtime.InteropServices.CallingConvention, System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefinePInvokeMethod"
		end

	frozen define_default_constructor (attributes: METHOD_ATTRIBUTES): CONSTRUCTOR_BUILDER is
		external
			"IL signature (System.Reflection.MethodAttributes): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineDefaultConstructor"
		end

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetCustomAttributes"
		end

	get_interfaces: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterfaces"
		end

	get_members_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMembers"
		end

	frozen define_property (name: SYSTEM_STRING; attributes: PROPERTY_ATTRIBUTES; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): PROPERTY_BUILDER is
		external
			"IL signature (System.String, System.Reflection.PropertyAttributes, System.Type, System.Type[]): System.Reflection.Emit.PropertyBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineProperty"
		end

	get_interface_map (interface_type: TYPE): INTERFACE_MAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterfaceMap"
		end

	frozen define_nested_type_string_type_attributes_type (name: SYSTEM_STRING; attr: TYPE_ATTRIBUTES; parent: TYPE): TYPE_BUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	get_properties_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [PROPERTY_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetProperties"
		end

	frozen define_pinvoke_method (name: SYSTEM_STRING; dll_name: SYSTEM_STRING; attributes: METHOD_ATTRIBUTES; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]; native_call_conv: CALLING_CONVENTION; native_char_set: CHAR_SET): METHOD_BUILDER is
		external
			"IL signature (System.String, System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[], System.Runtime.InteropServices.CallingConvention, System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefinePInvokeMethod"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsDefined"
		end

	get_member_string_member_types (name: SYSTEM_STRING; type: MEMBER_TYPES; binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.String, System.Reflection.MemberTypes, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMember"
		end

	frozen define_method_string_method_attributes_calling_conventions (name: SYSTEM_STRING; attributes: METHOD_ATTRIBUTES; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): METHOD_BUILDER is
		external
			"IL signature (System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethod"
		end

	frozen define_method (name: SYSTEM_STRING; attributes: METHOD_ATTRIBUTES; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): METHOD_BUILDER is
		external
			"IL signature (System.String, System.Reflection.MethodAttributes, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethod"
		end

	get_nested_type_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): TYPE is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetNestedType"
		end

feature {NONE} -- Implementation

	get_property_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; return_type: TYPE; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetPropertyImpl"
		end

	get_attribute_flags_impl: TYPE_ATTRIBUTES is
		external
			"IL signature (): System.Reflection.TypeAttributes use System.Reflection.Emit.TypeBuilder"
		alias
			"GetAttributeFlagsImpl"
		end

	is_array_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsArrayImpl"
		end

	get_method_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMethodImpl"
		end

	is_comobject_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsCOMObjectImpl"
		end

	is_primitive_impl: BOOLEAN is
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

	get_constructor_impl (binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): CONSTRUCTOR_INFO is
		external
			"IL signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetConstructorImpl"
		end

	is_by_ref_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsByRefImpl"
		end

	has_element_type_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"HasElementTypeImpl"
		end

end -- class TYPE_BUILDER
