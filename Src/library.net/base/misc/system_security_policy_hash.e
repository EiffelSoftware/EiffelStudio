indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.Hash"

frozen external class
	SYSTEM_SECURITY_POLICY_HASH

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make

feature {NONE} -- Initialization

	frozen make (assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL creator signature (System.Reflection.Assembly) use System.Security.Policy.Hash"
		end

feature -- Access

	frozen get_md5: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Policy.Hash"
		alias
			"get_MD5"
		end

	frozen get_sha1: ARRAY [INTEGER_8] is
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

	frozen get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Security.Policy.Hash"
		alias
			"GetObjectData"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Hash"
		alias
			"ToString"
		end

	frozen generate_hash (hash_alg: SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Security.Cryptography.HashAlgorithm): System.Byte[] use System.Security.Policy.Hash"
		alias
			"GenerateHash"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_SECURITY_POLICY_HASH
