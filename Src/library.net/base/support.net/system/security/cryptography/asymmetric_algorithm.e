indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.AsymmetricAlgorithm"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ASYMMETRIC_ALGORITHM

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	get_signature_algorithm: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"get_SignatureAlgorithm"
		end

	get_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"get_KeySize"
		end

	get_legal_key_sizes: NATIVE_ARRAY [KEY_SIZES] is
		external
			"IL signature (): System.Security.Cryptography.KeySizes[] use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"get_LegalKeySizes"
		end

	get_key_exchange_algorithm: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"get_KeyExchangeAlgorithm"
		end

feature -- Element Change

	set_key_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"set_KeySize"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"ToString"
		end

	from_xml_string (xml_string: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"FromXmlString"
		end

	frozen create__string (alg_name: SYSTEM_STRING): ASYMMETRIC_ALGORITHM is
		external
			"IL static signature (System.String): System.Security.Cryptography.AsymmetricAlgorithm use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"Create"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"Clear"
		end

	frozen create_: ASYMMETRIC_ALGORITHM is
		external
			"IL static signature (): System.Security.Cryptography.AsymmetricAlgorithm use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"Create"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"Equals"
		end

	to_xml_string (include_private_parameters: BOOLEAN): SYSTEM_STRING is
		external
			"IL deferred signature (System.Boolean): System.String use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"ToXmlString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Security.Cryptography.AsymmetricAlgorithm"
		alias
			"System.IDisposable.Dispose"
		end

end -- class ASYMMETRIC_ALGORITHM
