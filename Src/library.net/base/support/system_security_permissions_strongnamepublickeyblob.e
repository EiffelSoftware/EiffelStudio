indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.StrongNamePublicKeyBlob"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEPUBLICKEYBLOB

inherit
	ANY
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (public_key: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Security.Permissions.StrongNamePublicKeyBlob"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Permissions.StrongNamePublicKeyBlob"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Permissions.StrongNamePublicKeyBlob"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNamePublicKeyBlob"
		alias
			"ToString"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEPUBLICKEYBLOB
