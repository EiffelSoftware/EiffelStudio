indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.SHA1CryptoServiceProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SHA1_CRYPTO_SERVICE_PROVIDER

inherit
	SHA1
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
	make_sha1_crypto_service_provider

feature {NONE} -- Initialization

	frozen make_sha1_crypto_service_provider is
		external
			"IL creator use System.Security.Cryptography.SHA1CryptoServiceProvider"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.SHA1CryptoServiceProvider"
		alias
			"Initialize"
		end

feature {NONE} -- Implementation

	hash_core (rgb: NATIVE_ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.SHA1CryptoServiceProvider"
		alias
			"HashCore"
		end

	hash_final: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.SHA1CryptoServiceProvider"
		alias
			"HashFinal"
		end

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.SHA1CryptoServiceProvider"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.SHA1CryptoServiceProvider"
		alias
			"Finalize"
		end

end -- class SHA1_CRYPTO_SERVICE_PROVIDER
