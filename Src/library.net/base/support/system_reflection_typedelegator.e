indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.TypeDelegator"

external class
	SYSTEM_REFLECTION_TYPEDELEGATOR

inherit
	SYSTEM_TYPE
		rename
			get_type_handle as get_type_handle_runtime_type_handle
		redefine
			get_interface_map,
			is_value_type_impl,
			get_member_string_member_types,
			get_events
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

create
	make_typedelegator

feature {NONE} -- Initialization

	frozen make_typedelegator (delegating_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Reflection.TypeDelegator"
		end

feature -- Access

	get_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.TypeDelegator"
		alias
			"get_Assembly"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.TypeDelegator"
		alias
			"get_Name"
		end

	get_type_handle_runtime_type_handle: SYSTEM_RUNTIMETYPEHANDLE is
		external
			"IL signature (): System.RuntimeTypeHandle use System.Reflection.TypeDelegator"
		alias
			"get_TypeHandle"
		end

	get_guid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Reflection.TypeDelegator"
		alias
			"get_GUID"
		end

	get_base_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.TypeDelegator"
		alias
			"get_BaseType"
		end

	get_namespace: STRING is
		external
			"IL signature (): System.String use System.Reflection.TypeDelegator"
		alias
			"get_Namespace"
		end

	get_module: SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (): System.Reflection.Module use System.Reflection.TypeDelegator"
		alias
			"get_Module"
		end

	get_assembly_qualified_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.TypeDelegator"
		alias
			"get_AssemblyQualifiedName"
		end

	get_full_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.TypeDelegator"
		alias
			"get_FullName"
		end

	get_underlying_system_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.TypeDelegator"
		alias
			"get_UnderlyingSystemType"
		end

feature -- Basic Operations

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.TypeDelegator"
		alias
			"GetCustomAttributes"
		end

	get_interface_map (interface_type: SYSTEM_TYPE): SYSTEM_REFLECTION_INTERFACEMAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Reflection.TypeDelegator"
		alias
			"GetInterfaceMap"
		end

	get_element_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.TypeDelegator"
		alias
			"GetElementType"
		end

	get_event_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_EVENTINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Reflection.TypeDelegator"
		alias
			"GetEvent"
		end

	is_defined (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.TypeDelegator"
		alias
			"IsDefined"
		end

	get_properties_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetProperties"
		end

	get_constructors_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_CONSTRUCTORINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetConstructors"
		end

	get_fields_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetFields"
		end

	get_interface_string_boolean (name: STRING; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.TypeDelegator"
		alias
			"GetInterface"
		end

	get_field_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.TypeDelegator"
		alias
			"GetField"
		end

	get_nested_types_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Type[] use System.Reflection.TypeDelegator"
		alias
			"GetNestedTypes"
		end

	invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier (name: STRING; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; named_parameters: ARRAY [STRING]): ANY is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Reflection.TypeDelegator"
		alias
			"InvokeMember"
		end

	get_custom_attributes_type (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.TypeDelegator"
		alias
			"GetCustomAttributes"
		end

	get_events: ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
		external
			"IL signature (): System.Reflection.EventInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetEvents"
		end

	get_events_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetEvents"
		end

	get_members_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetMembers"
		end

	get_interfaces: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.TypeDelegator"
		alias
			"GetInterfaces"
		end

	get_member_string_member_types (name: STRING; type: SYSTEM_REFLECTION_MEMBERTYPES; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String, System.Reflection.MemberTypes, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetMember"
		end

	get_methods_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Reflection.TypeDelegator"
		alias
			"GetMethods"
		end

	get_nested_type_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Type use System.Reflection.TypeDelegator"
		alias
			"GetNestedType"
		end

feature {NONE} -- Implementation

	get_property_impl (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; return_type: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.TypeDelegator"
		alias
			"GetPropertyImpl"
		end

	get_attribute_flags_impl: SYSTEM_REFLECTION_TYPEATTRIBUTES is
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

	get_method_impl (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
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

	get_constructor_impl (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
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

end -- class SYSTEM_REFLECTION_TYPEDELEGATOR
