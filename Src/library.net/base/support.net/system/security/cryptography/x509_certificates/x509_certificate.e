indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.X509Certificates.X509Certificate"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	X509_CERTIFICATE

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			to_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (cert: X509_CERTIFICATE) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509Certificate) use System.Security.Cryptography.X509Certificates.X509Certificate"
		end

	frozen make (data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Security.Cryptography.X509Certificates.X509Certificate"
		end

	frozen make_1 (handle: POINTER) is
		external
			"IL creator signature (System.IntPtr) use System.Security.Cryptography.X509Certificates.X509Certificate"
		end

feature -- Basic Operations

	get_key_algorithm_parameters: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetKeyAlgorithmParameters"
		end

	frozen create_from_cert_file (filename: SYSTEM_STRING): X509_CERTIFICATE is
		external
			"IL static signature (System.String): System.Security.Cryptography.X509Certificates.X509Certificate use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"CreateFromCertFile"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetName"
		end

	get_expiration_date_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetExpirationDateString"
		end

	get_key_algorithm: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetKeyAlgorithm"
		end

	get_issuer_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetIssuerName"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetHashCode"
		end

	get_key_algorithm_parameters_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetKeyAlgorithmParametersString"
		end

	get_effective_date_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetEffectiveDateString"
		end

	get_public_key_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetPublicKeyString"
		end

	get_serial_number_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetSerialNumberString"
		end

	get_cert_hash_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetCertHashString"
		end

	to_string_boolean (f_verbose: BOOLEAN): SYSTEM_STRING is
		external
			"IL signature (System.Boolean): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"ToString"
		end

	equals_x509_certificate (other: X509_CERTIFICATE): BOOLEAN is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Boolean use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"Equals"
		end

	get_raw_cert_data_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetRawCertDataString"
		end

	frozen create_from_signed_file (filename: SYSTEM_STRING): X509_CERTIFICATE is
		external
			"IL static signature (System.String): System.Security.Cryptography.X509Certificates.X509Certificate use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"CreateFromSignedFile"
		end

	get_format: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetFormat"
		end

	get_serial_number: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetSerialNumber"
		end

	get_raw_cert_data: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetRawCertData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"ToString"
		end

	get_cert_hash: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetCertHash"
		end

	get_public_key: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.X509Certificates.X509Certificate"
		alias
			"GetPublicKey"
		end

end -- class X509_CERTIFICATE
