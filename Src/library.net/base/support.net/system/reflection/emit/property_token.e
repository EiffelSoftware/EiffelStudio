indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.PropertyToken"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	PROPERTY_TOKEN

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Access

	frozen empty: PROPERTY_TOKEN is
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

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.PropertyToken"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.PropertyToken"
		alias
			"Equals"
		end

end -- class PROPERTY_TOKEN
