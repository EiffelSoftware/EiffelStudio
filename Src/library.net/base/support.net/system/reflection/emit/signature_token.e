indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.SignatureToken"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	SIGNATURE_TOKEN

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Access

	frozen empty: SIGNATURE_TOKEN is
		external
			"IL static_field signature :System.Reflection.Emit.SignatureToken use System.Reflection.Emit.SignatureToken"
		alias
			"Empty"
		end

	frozen get_token: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.SignatureToken"
		alias
			"get_Token"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.SignatureToken"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.SignatureToken"
		alias
			"Equals"
		end

end -- class SIGNATURE_TOKEN
