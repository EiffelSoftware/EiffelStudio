indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.SHA384Managed"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_SHA384MANAGED

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_SHA384
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

create
	make_sha384managed

feature {NONE} -- Initialization

	frozen make_sha384managed is
		external
			"IL creator use System.Security.Cryptography.SHA384Managed"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.SHA384Managed"
		alias
			"Initialize"
		end

feature {NONE} -- Implementation

	hash_core (rgb: ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.SHA384Managed"
		alias
			"HashCore"
		end

	hash_final: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.SHA384Managed"
		alias
			"HashFinal"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_SHA384MANAGED
