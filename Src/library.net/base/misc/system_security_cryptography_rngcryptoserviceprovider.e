indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.RNGCryptoServiceProvider"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_RNGCRYPTOSERVICEPROVIDER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_RANDOMNUMBERGENERATOR
		redefine
			finalize
		end

create
	make_rngcryptoserviceprovider,
	make_rngcryptoserviceprovider_1,
	make_rngcryptoserviceprovider_2,
	make_rngcryptoserviceprovider_3

feature {NONE} -- Initialization

	frozen make_rngcryptoserviceprovider is
		external
			"IL creator use System.Security.Cryptography.RNGCryptoServiceProvider"
		end

	frozen make_rngcryptoserviceprovider_1 (str: STRING) is
		external
			"IL creator signature (System.String) use System.Security.Cryptography.RNGCryptoServiceProvider"
		end

	frozen make_rngcryptoserviceprovider_2 (rgb: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Security.Cryptography.RNGCryptoServiceProvider"
		end

	frozen make_rngcryptoserviceprovider_3 (csp_params: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS) is
		external
			"IL creator signature (System.Security.Cryptography.CspParameters) use System.Security.Cryptography.RNGCryptoServiceProvider"
		end

feature -- Basic Operations

	get_non_zero_bytes (data: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.RNGCryptoServiceProvider"
		alias
			"GetNonZeroBytes"
		end

	get_bytes (data: ARRAY [INTEGER_8]) is
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

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_RNGCRYPTOSERVICEPROVIDER
