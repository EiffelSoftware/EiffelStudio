indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.ICustomAttributeProvider"

deferred external class
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

inherit
	ANY
		undefine
			Finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL deferred signature (System.Boolean): System.Object[] use System.Reflection.ICustomAttributeProvider"
		alias
			"GetCustomAttributes"
		end

	is_defined (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Boolean use System.Reflection.ICustomAttributeProvider"
		alias
			"IsDefined"
		end

	get_custom_attributes_for_type (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Object[] use System.Reflection.ICustomAttributeProvider"
		alias
			"GetCustomAttributes"
		end

end -- class SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER
