indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.RNGCryptoServiceProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RNGCRYPTO_SERVICE_PROVIDER

inherit
	RANDOM_NUMBER_GENERATOR
		redefine
			finalize
		end

create
	make_rngcrypto_service_provider,
	make_rngcrypto_service_provider_1,
	make_rngcrypto_service_provider_2,
	make_rngcrypto_service_provider_3

feature {NONE} -- Initialization

	frozen make_rngcrypto_service_provider is
		external
			"IL creator use System.Security.Cryptography.RNGCryptoServiceProvider"
		end

	frozen make_rngcrypto_service_provider_1 (str: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Cryptography.RNGCryptoServiceProvider"
		end

	frozen make_rngcrypto_service_provider_2 (rgb: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Security.Cryptography.RNGCryptoServiceProvider"
		end

	frozen make_rngcrypto_service_provider_3 (csp_params: CSP_PARAMETERS) is
		external
			"IL creator signature (System.Security.Cryptography.CspParameters) use System.Security.Cryptography.RNGCryptoServiceProvider"
		end

feature -- Basic Operations

	get_non_zero_bytes (data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.RNGCryptoServiceProvider"
		alias
			"GetNonZeroBytes"
		end

	get_bytes (data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.RNGCryptoServiceProvider"
		alias
			"GetBytes"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.RNGCryptoServiceProvider"
		alias
			"Finalize"
		end

end -- class RNGCRYPTO_SERVICE_PROVIDER
