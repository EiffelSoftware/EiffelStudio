indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.MACTripleDES"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MACTRIPLE_DES

inherit
	KEYED_HASH_ALGORITHM
		redefine
			dispose,
			finalize
		end
	ICRYPTO_TRANSFORM
		rename
			dispose as system_idisposable_dispose
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_mactriple_des,
	make_mactriple_des_2,
	make_mactriple_des_1

feature {NONE} -- Initialization

	frozen make_mactriple_des is
		external
			"IL creator use System.Security.Cryptography.MACTripleDES"
		end

	frozen make_mactriple_des_2 (str_triple_des: SYSTEM_STRING; rgb_key: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.String, System.Byte[]) use System.Security.Cryptography.MACTripleDES"
		end

	frozen make_mactriple_des_1 (rgb_key: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Security.Cryptography.MACTripleDES"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.MACTripleDES"
		alias
			"Initialize"
		end

feature {NONE} -- Implementation

	hash_core (rgb_data: NATIVE_ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.MACTripleDES"
		alias
			"HashCore"
		end

	hash_final: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.MACTripleDES"
		alias
			"HashFinal"
		end

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.MACTripleDES"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.MACTripleDES"
		alias
			"Finalize"
		end

end -- class MACTRIPLE_DES
