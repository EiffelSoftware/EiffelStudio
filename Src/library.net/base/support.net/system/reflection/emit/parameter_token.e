indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.ParameterToken"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	PARAMETER_TOKEN

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Access

	frozen empty: PARAMETER_TOKEN is
		external
			"IL static_field signature :System.Reflection.Emit.ParameterToken use System.Reflection.Emit.ParameterToken"
		alias
			"Empty"
		end

	frozen get_token: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.ParameterToken"
		alias
			"get_Token"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.ParameterToken"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.ParameterToken"
		alias
			"Equals"
		end

end -- class PARAMETER_TOKEN
