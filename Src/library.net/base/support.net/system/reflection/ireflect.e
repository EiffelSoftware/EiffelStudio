indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.IReflect"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IREFLECT

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_underlying_system_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.IReflect"
		alias
			"get_UnderlyingSystemType"
		end

feature -- Basic Operations

	get_methods (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Reflection.IReflect"
		alias
			"GetMethods"
		end

	get_field (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): FIELD_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.IReflect"
		alias
			"GetField"
		end

	get_property (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): PROPERTY_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.PropertyInfo use System.Reflection.IReflect"
		alias
			"GetProperty"
		end

	get_method_string_binding_flags_binder (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): METHOD_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.IReflect"
		alias
			"GetMethod"
		end

	invoke_member (name: SYSTEM_STRING; invoke_attr: BINDING_FLAGS; binder: BINDER; target: SYSTEM_OBJECT; args: NATIVE_ARRAY [SYSTEM_OBJECT]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]; culture: CULTURE_INFO; named_parameters: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Reflection.IReflect"
		alias
			"InvokeMember"
		end

	get_method (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): METHOD_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.MethodInfo use System.Reflection.IReflect"
		alias
			"GetMethod"
		end

	get_fields (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [FIELD_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Reflection.IReflect"
		alias
			"GetFields"
		end

	get_properties (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [PROPERTY_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Reflection.IReflect"
		alias
			"GetProperties"
		end

	get_property_string_binding_flags_binder (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS; binder: BINDER; return_type: TYPE; types: NATIVE_ARRAY [TYPE]; modifiers: NATIVE_ARRAY [PARAMETER_MODIFIER]): PROPERTY_INFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.IReflect"
		alias
			"GetProperty"
		end

	get_members (binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.IReflect"
		alias
			"GetMembers"
		end

	get_member (name: SYSTEM_STRING; binding_attr: BINDING_FLAGS): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.IReflect"
		alias
			"GetMember"
		end

end -- class IREFLECT
