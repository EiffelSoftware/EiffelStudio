indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.CryptoConfig"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOCONFIG

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Security.Cryptography.CryptoConfig"
		end

feature -- Basic Operations

	frozen create_from_name_string_array_object (name: STRING; args: ARRAY [ANY]): ANY is
		external
			"IL static signature (System.String, System.Object[]): System.Object use System.Security.Cryptography.CryptoConfig"
		alias
			"CreateFromName"
		end

	frozen encode_oid (str: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Security.Cryptography.CryptoConfig"
		alias
			"EncodeOID"
		end

	frozen create_from_name (name: STRING): ANY is
		external
			"IL static signature (System.String): System.Object use System.Security.Cryptography.CryptoConfig"
		alias
			"CreateFromName"
		end

	frozen map_name_to_oid (name: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Security.Cryptography.CryptoConfig"
		alias
			"MapNameToOID"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOCONFIG
