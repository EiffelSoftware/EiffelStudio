indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.PropertyToken"

frozen expanded external class
	SYSTEM_REFLECTION_EMIT_PROPERTYTOKEN

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal
		end

feature -- Access

	frozen empty: SYSTEM_REFLECTION_EMIT_PROPERTYTOKEN is
		external
			"IL static_field signature :System.Reflection.Emit.PropertyToken use System.Reflection.Emit.PropertyToken"
		alias
			"Empty"
		end

	frozen get_token: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.PropertyToken"
		alias
			"get_Token"
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.PropertyToken"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.PropertyToken"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_REFLECTION_EMIT_PROPERTYTOKEN
