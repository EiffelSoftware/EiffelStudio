indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.MD5CryptoServiceProvider"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_MD5CRYPTOSERVICEPROVIDER

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_MD5
		redefine
			finalize
		end
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

create
	make_md5cryptoserviceprovider

feature {NONE} -- Initialization

	frozen make_md5cryptoserviceprovider is
		external
			"IL creator use System.Security.Cryptography.MD5CryptoServiceProvider"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.MD5CryptoServiceProvider"
		alias
			"Initialize"
		end

feature {NONE} -- Implementation

	hash_core (rgb: ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.MD5CryptoServiceProvider"
		alias
			"HashCore"
		end

	hash_final: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.MD5CryptoServiceProvider"
		alias
			"HashFinal"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.MD5CryptoServiceProvider"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_MD5CRYPTOSERVICEPROVIDER
