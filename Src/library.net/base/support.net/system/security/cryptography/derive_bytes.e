indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.DeriveBytes"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DERIVE_BYTES

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	reset is
		external
			"IL deferred signature (): System.Void use System.Security.Cryptography.DeriveBytes"
		alias
			"Reset"
		end

	get_bytes (cb: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Int32): System.Byte[] use System.Security.Cryptography.DeriveBytes"
		alias
			"GetBytes"
		end

end -- class DERIVE_BYTES
