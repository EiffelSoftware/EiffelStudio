indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.SHA1Managed"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SHA1_MANAGED

inherit
	SHA1
	ICRYPTO_TRANSFORM
		rename
			dispose as system_idisposable_dispose
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_sha1_managed

feature {NONE} -- Initialization

	frozen make_sha1_managed is
		external
			"IL creator use System.Security.Cryptography.SHA1Managed"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.SHA1Managed"
		alias
			"Initialize"
		end

feature {NONE} -- Implementation

	hash_core (rgb: NATIVE_ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.SHA1Managed"
		alias
			"HashCore"
		end

	hash_final: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.SHA1Managed"
		alias
			"HashFinal"
		end

end -- class SHA1_MANAGED
