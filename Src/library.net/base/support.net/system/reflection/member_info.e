indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.MemberInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	MEMBER_INFO

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICUSTOM_ATTRIBUTE_PROVIDER

feature -- Access

	get_reflected_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.MemberInfo"
		alias
			"get_ReflectedType"
		end

	get_member_type: MEMBER_TYPES is
		external
			"IL deferred signature (): System.Reflection.MemberTypes use System.Reflection.MemberInfo"
		alias
			"get_MemberType"
		end

	get_declaring_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.MemberInfo"
		alias
			"get_DeclaringType"
		end

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Reflection.MemberInfo"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Object[] use System.Reflection.MemberInfo"
		alias
			"GetCustomAttributes"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.MemberInfo"
		alias
			"GetHashCode"
		end

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (System.Boolean): System.Object[] use System.Reflection.MemberInfo"
		alias
			"GetCustomAttributes"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Boolean use System.Reflection.MemberInfo"
		alias
			"IsDefined"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.MemberInfo"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.MemberInfo"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.MemberInfo"
		alias
			"Finalize"
		end

end -- class MEMBER_INFO
