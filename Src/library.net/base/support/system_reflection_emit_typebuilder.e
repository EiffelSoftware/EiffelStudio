indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.TypeBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_TYPEBUILDER

inherit
	SYSTEM_TYPE
		rename
			get_type_handle as get_type_handle_runtime_type_handle
		redefine
			get_interface_map,
			is_subclass_of,
			get_member_string_member_types,
			get_events,
			get_reflected_type,
			get_declaring_type,
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

create {NONE}

feature -- Access

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Size"
		end

	get_assembly: SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Assembly"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Name"
		end

	get_type_handle_runtime_type_handle: SYSTEM_RUNTIMETYPEHANDLE is
		external
			"IL signature (): System.RuntimeTypeHandle use System.Reflection.Emit.TypeBuilder"
		alias
			"get_TypeHandle"
		end

	get_guid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Reflection.Emit.TypeBuilder"
		alias
			"get_GUID"
		end

	get_base_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_BaseType"
		end

	get_namespace: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Namespace"
		end

	get_module: SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (): System.Reflection.Module use System.Reflection.Emit.TypeBuilder"
		alias
			"get_Module"
		end

	frozen get_packing_size: SYSTEM_REFLECTION_EMIT_PACKINGSIZE is
		external
			"IL signature (): System.Reflection.Emit.PackingSize use System.Reflection.Emit.TypeBuilder"
		alias
			"get_PackingSize"
		end

	get_declaring_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_DeclaringType"
		end

	get_assembly_qualified_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_AssemblyQualifiedName"
		end

	get_full_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"get_FullName"
		end

	frozen get_type_token: SYSTEM_REFLECTION_EMIT_TYPETOKEN is
		external
			"IL signature (): System.Reflection.Emit.TypeToken use System.Reflection.Emit.TypeBuilder"
		alias
			"get_TypeToken"
		end

	frozen unspecified_type_size: INTEGER is 0x0

	get_underlying_system_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_UnderlyingSystemType"
		end

	get_reflected_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"get_ReflectedType"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.TypeBuilder"
		alias
			"ToString"
		end

	frozen define_nested_type_string_type_attributes (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen add_declarative_security (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION; pset: SYSTEM_SECURITY_PERMISSIONSET) is
		external
			"IL signature (System.Security.Permissions.SecurityAction, System.Security.PermissionSet): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"AddDeclarativeSecurity"
		end

	frozen define_method_override (method_info_body: SYSTEM_REFLECTION_METHODINFO; method_info_declaration: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL signature (System.Reflection.MethodInfo, System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethodOverride"
		end

	frozen define_event (name: STRING; attributes: SYSTEM_REFLECTION_EVENTATTRIBUTES; eventtype: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_EVENTBUILDER is
		external
			"IL signature (System.String, System.Reflection.EventAttributes, System.Type): System.Reflection.Emit.EventBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineEvent"
		end

	frozen set_custom_attribute_constructor_info (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binary_attribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen define_nested_type_string_type_attributes_type_packing_size (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE; pack_size: SYSTEM_REFLECTION_EMIT_PACKINGSIZE): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Reflection.Emit.PackingSize): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	is_subclass_of (c: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsSubclassOf"
		end

	get_constructors_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_CONSTRUCTORINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.ConstructorInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetConstructors"
		end

	get_methods_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMethods"
		end

	frozen add_interface_implementation (interface_type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"AddInterfaceImplementation"
		end

	frozen define_nested_type_string_type_attributes_type_array_type (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE; interfaces: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Type[]): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	get_nested_types_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Type[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetNestedTypes"
		end

	get_events: ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
		external
			"IL signature (): System.Reflection.EventInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvents"
		end

	frozen set_custom_attribute (custom_builder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetCustomAttribute"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen create_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"CreateType"
		end

	get_field_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetField"
		end

	get_events_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_EVENTINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.EventInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvents"
		end

	frozen define_type_initializer: SYSTEM_REFLECTION_EMIT_CONSTRUCTORBUILDER is
		external
			"IL signature (): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineTypeInitializer"
		end

	invoke_member_string_binding_flags_binder_object_array_object_array_parameter_modifier (name: STRING; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; named_parameters: ARRAY [STRING]): ANY is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Reflection.Emit.TypeBuilder"
		alias
			"InvokeMember"
		end

	get_interface_string_boolean (name: STRING; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Boolean): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterface"
		end

	get_fields_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetFields"
		end

	frozen set_parent (parent: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.TypeBuilder"
		alias
			"SetParent"
		end

	frozen define_uninitialized_data (name: STRING; size: INTEGER; attributes: SYSTEM_REFLECTION_FIELDATTRIBUTES): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
		external
			"IL signature (System.String, System.Int32, System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineUninitializedData"
		end

	frozen define_nested_type (name: STRING): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	frozen define_constructor (attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_CONSTRUCTORBUILDER is
		external
			"IL signature (System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type[]): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineConstructor"
		end

	frozen define_nested_type_string_type_attributes_type_int32 (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE; type_size: INTEGER): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type, System.Int32): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	get_element_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetElementType"
		end

	frozen define_initialized_data (name: STRING; data: ARRAY [INTEGER_8]; attributes: SYSTEM_REFLECTION_FIELDATTRIBUTES): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
		external
			"IL signature (System.String, System.Byte[], System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineInitializedData"
		end

	frozen define_field (field_name: STRING; type: SYSTEM_TYPE; attributes: SYSTEM_REFLECTION_FIELDATTRIBUTES): SYSTEM_REFLECTION_EMIT_FIELDBUILDER is
		external
			"IL signature (System.String, System.Type, System.Reflection.FieldAttributes): System.Reflection.Emit.FieldBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineField"
		end

	get_event_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_EVENTINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Reflection.EventInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetEvent"
		end

	frozen define_pinvoke_method_string_string_string (name: STRING; dll_name: STRING; entry_name: STRING; attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]; native_call_conv: SYSTEM_RUNTIME_INTEROPSERVICES_CALLINGCONVENTION; native_char_set: SYSTEM_RUNTIME_INTEROPSERVICES_CHARSET): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
		external
			"IL signature (System.String, System.String, System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[], System.Runtime.InteropServices.CallingConvention, System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefinePInvokeMethod"
		end

	frozen define_default_constructor (attributes: SYSTEM_REFLECTION_METHODATTRIBUTES): SYSTEM_REFLECTION_EMIT_CONSTRUCTORBUILDER is
		external
			"IL signature (System.Reflection.MethodAttributes): System.Reflection.Emit.ConstructorBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineDefaultConstructor"
		end

	get_custom_attributes_type (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetCustomAttributes"
		end

	get_interfaces: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterfaces"
		end

	get_members_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMembers"
		end

	frozen define_property (name: STRING; attributes: SYSTEM_REFLECTION_PROPERTYATTRIBUTES; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_PROPERTYBUILDER is
		external
			"IL signature (System.String, System.Reflection.PropertyAttributes, System.Type, System.Type[]): System.Reflection.Emit.PropertyBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineProperty"
		end

	get_interface_map (interface_type: SYSTEM_TYPE): SYSTEM_REFLECTION_INTERFACEMAPPING is
		external
			"IL signature (System.Type): System.Reflection.InterfaceMapping use System.Reflection.Emit.TypeBuilder"
		alias
			"GetInterfaceMap"
		end

	frozen define_nested_type_string_type_attributes_type (name: STRING; attr: SYSTEM_REFLECTION_TYPEATTRIBUTES; parent: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_TYPEBUILDER is
		external
			"IL signature (System.String, System.Reflection.TypeAttributes, System.Type): System.Reflection.Emit.TypeBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineNestedType"
		end

	get_properties_binding_flags (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetProperties"
		end

	frozen define_pinvoke_method (name: STRING; dll_name: STRING; attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]; native_call_conv: SYSTEM_RUNTIME_INTEROPSERVICES_CALLINGCONVENTION; native_char_set: SYSTEM_RUNTIME_INTEROPSERVICES_CHARSET): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
		external
			"IL signature (System.String, System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[], System.Runtime.InteropServices.CallingConvention, System.Runtime.InteropServices.CharSet): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefinePInvokeMethod"
		end

	is_defined (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.TypeBuilder"
		alias
			"IsDefined"
		end

	get_member_string_member_types (name: STRING; type: SYSTEM_REFLECTION_MEMBERTYPES; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL signature (System.String, System.Reflection.MemberTypes, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.Emit.TypeBuilder"
		alias
			"GetMember"
		end

	frozen define_method_string_method_attributes_calling_conventions (name: STRING; attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
		external
			"IL signature (System.String, System.Reflection.MethodAttributes, System.Reflection.CallingConventions, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethod"
		end

	frozen define_method (name: STRING; attributes: SYSTEM_REFLECTION_METHODATTRIBUTES; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_METHODBUILDER is
		external
			"IL signature (System.String, System.Reflection.MethodAttributes, System.Type, System.Type[]): System.Reflection.Emit.MethodBuilder use System.Reflection.Emit.TypeBuilder"
		alias
			"DefineMethod"
		end

	get_nested_type_string_binding_flags (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Reflection.BindingFlags): System.Type use System.Reflection.Emit.TypeBuilder"
		alias
			"GetNestedType"
		end

feature {NONE} -- Implementation

	get_property_impl (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; return_type: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.Emit.TypeBuilder"
		alias
			"GetPropertyImpl"
		end

	get_attribute_flags_impl: SYSTEM_REFLECTION_TYPEATTRIBUTES is
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

	get_method_impl (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
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

	get_constructor_impl (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; call_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_CONSTRUCTORINFO is
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

end -- class SYSTEM_REFLECTION_EMIT_TYPEBUILDER
