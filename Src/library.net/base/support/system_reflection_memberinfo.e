indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.MemberInfo"

deferred external class
	SYSTEM_REFLECTION_MEMBERINFO

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	get_reflected_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.MemberInfo"
		alias
			"get_ReflectedType"
		end

	get_member_type: SYSTEM_REFLECTION_MEMBERTYPES is
		external
			"IL deferred signature (): System.Reflection.MemberTypes use System.Reflection.MemberInfo"
		alias
			"get_MemberType"
		end

	get_declaring_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.MemberInfo"
		alias
			"get_DeclaringType"
		end

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.Reflection.MemberInfo"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_custom_attributes_type (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
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

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL deferred signature (System.Boolean): System.Object[] use System.Reflection.MemberInfo"
		alias
			"GetCustomAttributes"
		end

	is_defined (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Boolean use System.Reflection.MemberInfo"
		alias
			"IsDefined"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.MemberInfo"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_REFLECTION_MEMBERINFO
