indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.SymmetricAlgorithm"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYMMETRIC_ALGORITHM

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

	get_key: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_Key"
		end

	get_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_KeySize"
		end

	get_block_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_BlockSize"
		end

	get_mode: CIPHER_MODE is
		external
			"IL signature (): System.Security.Cryptography.CipherMode use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_Mode"
		end

	get_feedback_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_FeedbackSize"
		end

	get_padding: PADDING_MODE is
		external
			"IL signature (): System.Security.Cryptography.PaddingMode use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_Padding"
		end

	get_legal_block_sizes: NATIVE_ARRAY [KEY_SIZES] is
		external
			"IL signature (): System.Security.Cryptography.KeySizes[] use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_LegalBlockSizes"
		end

	get_iv: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_IV"
		end

	get_legal_key_sizes: NATIVE_ARRAY [KEY_SIZES] is
		external
			"IL signature (): System.Security.Cryptography.KeySizes[] use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"get_LegalKeySizes"
		end

feature -- Element Change

	set_mode (value: CIPHER_MODE) is
		external
			"IL signature (System.Security.Cryptography.CipherMode): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"set_Mode"
		end

	set_iv (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"set_IV"
		end

	set_feedback_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"set_FeedbackSize"
		end

	set_block_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"set_BlockSize"
		end

	set_key_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"set_KeySize"
		end

	set_padding (value: PADDING_MODE) is
		external
			"IL signature (System.Security.Cryptography.PaddingMode): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"set_Padding"
		end

	set_key (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"set_Key"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"GetHashCode"
		end

	frozen create__string (alg_name: SYSTEM_STRING): SYMMETRIC_ALGORITHM is
		external
			"IL static signature (System.String): System.Security.Cryptography.SymmetricAlgorithm use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"Create"
		end

	create_decryptor_array_byte (rgb_key: NATIVE_ARRAY [INTEGER_8]; rgb_iv: NATIVE_ARRAY [INTEGER_8]): ICRYPTO_TRANSFORM is
		external
			"IL deferred signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"CreateDecryptor"
		end

	create_decryptor: ICRYPTO_TRANSFORM is
		external
			"IL signature (): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"CreateDecryptor"
		end

	create_encryptor_array_byte (rgb_key: NATIVE_ARRAY [INTEGER_8]; rgb_iv: NATIVE_ARRAY [INTEGER_8]): ICRYPTO_TRANSFORM is
		external
			"IL deferred signature (System.Byte[], System.Byte[]): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"CreateEncryptor"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"Clear"
		end

	generate_key is
		external
			"IL deferred signature (): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"GenerateKey"
		end

	frozen create_: SYMMETRIC_ALGORITHM is
		external
			"IL static signature (): System.Security.Cryptography.SymmetricAlgorithm use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"Create"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"Equals"
		end

	create_encryptor: ICRYPTO_TRANSFORM is
		external
			"IL signature (): System.Security.Cryptography.ICryptoTransform use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"CreateEncryptor"
		end

	frozen valid_key_size (bit_length: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"ValidKeySize"
		end

	generate_iv is
		external
			"IL deferred signature (): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"GenerateIV"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Security.Cryptography.SymmetricAlgorithm"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYMMETRIC_ALGORITHM
