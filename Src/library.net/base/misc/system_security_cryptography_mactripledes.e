indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.MACTripleDES"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_MACTRIPLEDES

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_KEYEDHASHALGORITHM
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

create
	make_mactripledes,
	make_mactripledes_2,
	make_mactripledes_1

feature {NONE} -- Initialization

	frozen make_mactripledes is
		external
			"IL creator use System.Security.Cryptography.MACTripleDES"
		end

	frozen make_mactripledes_2 (str_triple_des: STRING; rgb_key: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.String, System.Byte[]) use System.Security.Cryptography.MACTripleDES"
		end

	frozen make_mactripledes_1 (rgb_key: ARRAY [INTEGER_8]) is
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

	hash_core (rgb_data: ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.MACTripleDES"
		alias
			"HashCore"
		end

	hash_final: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.MACTripleDES"
		alias
			"HashFinal"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_MACTRIPLEDES
