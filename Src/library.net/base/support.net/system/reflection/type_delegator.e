indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.TypeDelegator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TYPE_DELEGATOR

inherit
	TYPE
		redefine
			get_interface_map,
			is_value_type_impl,
			get_member_string_member_types,
			get_events
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

create
	make_type_delegator

feature {NONE} -- Initialization

	frozen make_type_delegator (delegating_type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Reflection.TypeDelegator"
		end

feature -- Access

	get_assembly: ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.TypeDelegator"
		alias
			"get_Assembly"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.TypeDelegator"
		alias
			"get_Name"
		end

	get_type_handle: RUNTIME_TYPE_HANDLE is
		external
			"IL signature (): System.RuntimeTypeHandle use System.Reflection.TypeDelegator"
		alias
			"get_TypeHandle"
		end

	get_base_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.TypeDelegator"
		alias
			"get_BaseType"
		end

	get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.TypeDelegator"
		alias
			"get_Namespace"
		end

	get_module: MODULE is
		external
			"IL signature (): System.Reflection.Module use System.Reflection.TypeDelegator"
		alias
			"get_Module"
		end

	get_guid: GUID is
		external
			"IL signature (): System.Guid use System.Reflection.TypeDelegator"
		alias
			"get_GUID"
		end

	get_assembly_qualified_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.TypeDelegator"
		alias
			"get_AssemblyQualifiedName"
		end

	get_full_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.TypeDelegator"
		alias
			"get_FullName"
		end

	get_underlying_system_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.TypeDelegator"
		alias
			"get_UnderlyingSystemType"
		end

feature -- Basic Operations

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.TypeDelegator"
		alias
			"GetCustomAttributes"
		end

	get_interface_map (interface_type: TYPE): INTERFACE_MAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Reflection.TypeDelegator"
		alias
			"GetInterfaceMap"
		end

	get_element_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.TypeDelegator"
		alias
			"GetElementType"
		end

	get_event_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): EVENT_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Reflection.TypeDelegator"
		alias
			"GetEvent"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"IsDefined"
		end

	get_properties_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [PROPERTY_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetProperties"
		end

	get_constructors_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [CONSTRUCTOR_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetConstructors"
		end

	get_fields_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [FIELD_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetFields"
		end

	get_interface_string_boolean (name: SYSTEM_STRING; ignore_case: BOOLEAN): TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.TypeDelegator"
		alias
			"GetInterface"
		end

	get_field_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): FIELD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.TypeDelegator"
		alias
			"GetField"
		end

	get_nested_types_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [TYPE] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Type[] use System.Reflection.TypeDelegator"
		alias
			"GetNestedTypes"
		end

	invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier (name: SYSTEM_STRING; invoke_attr: BINDING_FLAGS; binder: BINDER; target: SYSTEM_OBJECT; args: NATIVE_ARRAY [SYSTEM_OBJECT]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]; culture: CULTURE_INFO; named_parameters: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Reflection.TypeDelegator"
		alias
			"InvokeMember"
		end

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.TypeDelegator"
		alias
			"GetCustomAttributes"
		end

	get_events: NATIVE_ARRAY [EVENT_INFO] is
		external
			"IL signature (): System.Reflection.EventInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetEvents"
		end

	get_events_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [EVENT_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetEvents"
		end

	get_members_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetMembers"
		end

	get_interfaces: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.TypeDelegator"
		alias
			"GetInterfaces"
		end

	get_member_string_member_types (name: SYSTEM_STRING; type: MEMBER_TYPES; binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL signature (System.String, System.Reflection.MemberTypes, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetMember"
		end

	get_methods_binding_flags (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetMethods"
		end

	get_nested_type_string_binding_flags (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): TYPE is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Type use System.Reflection.TypeDelegator"
		alias
			"GetNestedType"
		end

feature {NONE} -- Implementation

	get_property_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; return_type: TYPE; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.TypeDelegator"
		alias
			"GetPropertyImpl"
		end

	get_attribute_flags_impl: TYPE_ATTRIBUTES is
		external
			"IL signature (): System.Reflection.TypeAttributes use System.Reflection.TypeDelegator"
		alias
			"GetAttributeFlagsImpl"
		end

	is_array_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"IsArrayImpl"
		end

	get_method_impl (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.TypeDelegator"
		alias
			"GetMethodImpl"
		end

	is_comobject_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"IsCOMObjectImpl"
		end

	is_primitive_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"IsPrimitiveImpl"
		end

	is_pointer_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"IsPointerImpl"
		end

	get_constructor_impl (binding_attr: BINDING_FLAGS; binder: BINDER; call_convention: CALLING_CONVENTIONS; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): CONSTRUCTOR_INFO is
		external
			"IL signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Reflection.CallingConventions, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.ConstructorInfo use System.Reflection.TypeDelegator"
		alias
			"GetConstructorImpl"
		end

	is_value_type_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"IsValueTypeImpl"
		end

	is_by_ref_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"IsByRefImpl"
		end

	has_element_type_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"HasElementTypeImpl"
		end

end -- class TYPE_DELEGATOR
