indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.EnumBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ENUM_BUILDER

inherit
	TYPE
		redefine
			get_interface_map,
			is_value_type_impl,
			get_member_string_member_types,
			get_events,
			get_reflected_type,
			get_declaring_type
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

	get_assembly: ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.Emit.EnumBuilder"
		alias
			"get_Assembly"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.EnumBuilder"
		alias
			"get_Name"
		end

	get_reflected_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.EnumBuilder"
		alias
			"get_ReflectedType"
		end

	get_type_handle: RUNTIME_TYPE_HANDLE is
		external
			"IL signature (): System.RuntimeTypeHandle use System.Reflection.Emit.EnumBuilder"
		alias
			"get_TypeHandle"
		end

	get_base_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.EnumBuilder"
		alias
			"get_BaseType"
		end

	get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.EnumBuilder"
		alias
			"get_Namespace"
		end

	get_module: MODULE is
		external
			"IL signature (): System.Reflection.Module use System.Reflection.Emit.EnumBuilder"
		alias
			"get_Module"
		end

	get_guid: GUID is
		external
			"IL signature (): System.Guid use System.Reflection.Emit.EnumBuilder"
		alias
			"get_GUID"
		end

	get_declaring_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.EnumBuilder"
		alias
			"get_DeclaringType"
		end

	get_assembly_qualified_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.EnumBuilder"
		alias
			"get_AssemblyQualifiedName"
		end

	frozen get_underlying_field: FIELD_BUILDER is
		external
			"IL signature (): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.EnumBuilder"
		alias
			"get_UnderlyingField"
		end

	get_full_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.EnumBuilder"
		alias
			"get_FullName"
		end

	frozen get_type_token: TYPE_TOKEN is
		external
			"IL signature (): System.Reflection.Emit.TypeToken use System.Reflection.Emit.EnumBuilder"
		alias
			"get_TypeToken"
		end

	get_underlying_system_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.EnumBuilder"
		alias
			"get_UnderlyingSystemType"
		end

feature -- Basic Operations

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetCustomAttributes"
		end

	get_interface_map (interface_type: TYPE): INTERFACE_MAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Reflection.Emit.EnumBuilder"
		alias
			"GetInterfaceMap"
		end

	get_element_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.EnumBuilder"
		alias
			"GetElementType"
		end

	get_event_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): EVENT_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Reflection.Emit.EnumBuilder"
		alias
			"GetEvent"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.EnumBuilder"
		alias
			"IsDefined"
		end

	get_properties_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [PROPERTY_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetProperties"
		end

	get_constructors_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [CONSTRUCTOR_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetConstructors"
		end

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.EnumBuilder"
		alias
			"SetCustomAttribute"
		end

	get_fields_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [FIELD_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetFields"
		end

	get_interface_string_boolean (name: SYSTEM_STRING; ignore_case: BOOLEAN): TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Emit.EnumBuilder"
		alias
			"GetInterface"
		end

	get_field_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): FIELD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.Emit.EnumBuilder"
		alias
			"GetField"
		end

	get_nested_types_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [TYPE] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Type[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetNestedTypes"
		end

	invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier (name: SYSTEM_STRING; invoke_attr: BINDING_FLAGS; binder: BINDER; target: SYSTEM_OBJECT; args: NATIVE_ARRAY [SYSTEM_OBJECT]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]; culture: CULTURE_INFO; named_parameters: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Reflection.Emit.EnumBuilder"
		alias
			"InvokeMember"
		end

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetCustomAttributes"
		end

	get_events: NATIVE_ARRAY [EVENT_INFO] is
		external
			"IL signature (): System.Reflection.EventInfo[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetEvents"
		end

	frozen define_literal (literal_name: SYSTEM_STRING; literal_value: SYSTEM_OBJECT): FIELD_BUILDER is
		external
			"IL signature (System.String, System.Object): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.EnumBuilder"
		alias
			"DefineLiteral"
		end

	get_events_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [EVENT_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetEvents"
		end

	get_members_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetMembers"
		end

	get_interfaces: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetInterfaces"
		end

	get_member_string_member_types (name: SYSTEM_STRING; type: MEMBER_TYPES; binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.String, System.Reflection.MemberTypes, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetMember"
		end

	get_methods_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Reflection.Emit.EnumBuilder"
		alias
			"GetMethods"
		end

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.EnumBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen create_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.EnumBuilder"
		alias
			"CreateType"
		end

	get_nested_type_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): TYPE is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Type use System.Reflection.Emit.EnumBuilder"
		alias
			"GetNestedType"
		end

feature {NONE} -- Implementation

	get_property_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; return_type: TYPE; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.Emit.EnumBuilder"
		alias
			"GetPropertyImpl"
		end

	get_attribute_flags_impl: TYPE_ATTRIBUTES is
		external
			"IL signature (): System.Reflection.TypeAttributes use System.Reflection.Emit.EnumBuilder"
		alias
			"GetAttributeFlagsImpl"
		end

	is_array_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.EnumBuilder"
		alias
			"IsArrayImpl"
		end

	get_method_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.Emit.EnumBuilder"
		alias
			"GetMethodImpl"
		end

	is_comobject_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.EnumBuilder"
		alias
			"IsCOMObjectImpl"
		end

	is_primitive_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.EnumBuilder"
		alias
			"IsPrimitiveImpl"
		end

	is_pointer_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.EnumBuilder"
		alias
			"IsPointerImpl"
		end

	get_constructor_impl (binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): CONSTRUCTOR_INFO is
		external
			"IL signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Reflection.Emit.EnumBuilder"
		alias
			"GetConstructorImpl"
		end

	is_value_type_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.EnumBuilder"
		alias
			"IsValueTypeImpl"
		end

	is_by_ref_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.EnumBuilder"
		alias
			"IsByRefImpl"
		end

	has_element_type_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.EnumBuilder"
		alias
			"HasElementTypeImpl"
		end

end -- class ENUM_BUILDER
