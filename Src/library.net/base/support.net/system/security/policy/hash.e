indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.Hash"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	HASH

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE

create
	make

feature {NONE} -- Initialization

	frozen make (assembly: ASSEMBLY) is
		external
			"IL creator signature (System.Reflection.Assembly) use System.Security.Policy.Hash"
		end

feature -- Access

	frozen get_md5: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Policy.Hash"
		alias
			"get_MD5"
		end

	frozen get_sha1: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Policy.Hash"
		alias
			"get_SHA1"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.Hash"
		alias
			"GetHashCode"
		end

	frozen get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Security.Policy.Hash"
		alias
			"GetObjectData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Hash"
		alias
			"ToString"
		end

	frozen generate_hash (hash_alg: HASH_ALGORITHM): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Security.Cryptography.HashAlgorithm): System.Byte[] use System.Security.Policy.Hash"
		alias
			"GenerateHash"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.Hash"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.Hash"
		alias
			"Finalize"
		end

end -- class HASH
