indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.IReflect"

deferred external class
	SYSTEM_REFLECTION_IREFLECT

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_underlying_system_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.IReflect"
		alias
			"get_UnderlyingSystemType"
		end

feature -- Basic Operations

	get_methods (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.MethodInfo[] use System.Reflection.IReflect"
		alias
			"GetMethods"
		end

	get_field (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.FieldInfo use System.Reflection.IReflect"
		alias
			"GetField"
		end

	get_property (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.PropertyInfo use System.Reflection.IReflect"
		alias
			"GetProperty"
		end

	get_method_string_binding_flags_binder (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.MethodInfo use System.Reflection.IReflect"
		alias
			"GetMethod"
		end

	invoke_member (name: STRING; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; target: ANY; args: ARRAY [ANY]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; named_parameters: ARRAY [STRING]): ANY is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object, System.Object[], System.Reflection.ParameterModifier[], System.Globalization.CultureInfo, System.String[]): System.Object use System.Reflection.IReflect"
		alias
			"InvokeMember"
		end

	get_method (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.MethodInfo use System.Reflection.IReflect"
		alias
			"GetMethod"
		end

	get_fields (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_FIELDINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.FieldInfo[] use System.Reflection.IReflect"
		alias
			"GetFields"
		end

	get_properties (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_PROPERTYINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.PropertyInfo[] use System.Reflection.IReflect"
		alias
			"GetProperties"
		end

	get_property_string_binding_flags_binder (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; return_type: SYSTEM_TYPE; types: ARRAY [SYSTEM_TYPE]; modifiers: ARRAY [SYSTEM_REFLECTION_PARAMETERMODIFIER]): SYSTEM_REFLECTION_PROPERTYINFO is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags, System.Reflection.Binder, System.Type, System.Type[], System.Reflection.ParameterModifier[]): System.Reflection.PropertyInfo use System.Reflection.IReflect"
		alias
			"GetProperty"
		end

	get_members (binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL deferred signature (System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.IReflect"
		alias
			"GetMembers"
		end

	get_member (name: STRING; binding_attr: SYSTEM_REFLECTION_BINDINGFLAGS): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL deferred signature (System.String, System.Reflection.BindingFlags): System.Reflection.MemberInfo[] use System.Reflection.IReflect"
		alias
			"GetMember"
		end

end -- class SYSTEM_REFLECTION_IREFLECT
