indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.StrongNamePublicKeyBlob"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STRONG_NAME_PUBLIC_KEY_BLOB

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (public_key: NATIVE_ARRAY [INTEGER_8]) is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNamePublicKeyBlob"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Permissions.StrongNamePublicKeyBlob"
		alias
			"Equals"
		end

end -- class STRONG_NAME_PUBLIC_KEY_BLOB
