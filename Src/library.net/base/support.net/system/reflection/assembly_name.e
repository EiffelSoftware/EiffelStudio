indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyName"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ASSEMBLY_NAME

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	ISERIALIZABLE
	IDESERIALIZATION_CALLBACK

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Reflection.AssemblyName"
		end

feature -- Access

	get_hash_algorithm: ASSEMBLY_HASH_ALGORITHM is
		external
			"IL signature (): System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Reflection.AssemblyName"
		alias
			"get_HashAlgorithm"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_Name"
		end

	get_culture_info: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Reflection.AssemblyName"
		alias
			"get_CultureInfo"
		end

	get_flags: ASSEMBLY_NAME_FLAGS is
		external
			"IL signature (): System.Reflection.AssemblyNameFlags use System.Reflection.AssemblyName"
		alias
			"get_Flags"
		end

	get_version_compatibility: ASSEMBLY_VERSION_COMPATIBILITY is
		external
			"IL signature (): System.Configuration.Assemblies.AssemblyVersionCompatibility use System.Reflection.AssemblyName"
		alias
			"get_VersionCompatibility"
		end

	get_full_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_FullName"
		end

	get_code_base: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_CodeBase"
		end

	get_escaped_code_base: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_EscapedCodeBase"
		end

	get_key_pair: STRONG_NAME_KEY_PAIR is
		external
			"IL signature (): System.Reflection.StrongNameKeyPair use System.Reflection.AssemblyName"
		alias
			"get_KeyPair"
		end

	get_version: VERSION is
		external
			"IL signature (): System.Version use System.Reflection.AssemblyName"
		alias
			"get_Version"
		end

feature -- Element Change

	set_culture_info (value: CULTURE_INFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Reflection.AssemblyName"
		alias
			"set_CultureInfo"
		end

	set_key_pair (value: STRONG_NAME_KEY_PAIR) is
		external
			"IL signature (System.Reflection.StrongNameKeyPair): System.Void use System.Reflection.AssemblyName"
		alias
			"set_KeyPair"
		end

	set_hash_algorithm (value: ASSEMBLY_HASH_ALGORITHM) is
		external
			"IL signature (System.Configuration.Assemblies.AssemblyHashAlgorithm): System.Void use System.Reflection.AssemblyName"
		alias
			"set_HashAlgorithm"
		end

	set_version (value: VERSION) is
		external
			"IL signature (System.Version): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Version"
		end

	set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Name"
		end

	set_flags (value: ASSEMBLY_NAME_FLAGS) is
		external
			"IL signature (System.Reflection.AssemblyNameFlags): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Flags"
		end

	set_code_base (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.AssemblyName"
		alias
			"set_CodeBase"
		end

	set_version_compatibility (value: ASSEMBLY_VERSION_COMPATIBILITY) is
		external
			"IL signature (System.Configuration.Assemblies.AssemblyVersionCompatibility): System.Void use System.Reflection.AssemblyName"
		alias
			"set_VersionCompatibility"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"ToString"
		end

	frozen get_public_key_token: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.AssemblyName"
		alias
			"GetPublicKeyToken"
		end

	frozen get_assembly_name (assembly_file: SYSTEM_STRING): ASSEMBLY_NAME is
		external
			"IL static signature (System.String): System.Reflection.AssemblyName use System.Reflection.AssemblyName"
		alias
			"GetAssemblyName"
		end

	frozen get_public_key: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.AssemblyName"
		alias
			"GetPublicKey"
		end

	on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.AssemblyName"
		alias
			"OnDeserialization"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Reflection.AssemblyName"
		alias
			"Clone"
		end

	frozen set_public_key_token (public_key_token: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.AssemblyName"
		alias
			"SetPublicKeyToken"
		end

	frozen set_public_key (public_key: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.AssemblyName"
		alias
			"SetPublicKey"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.AssemblyName"
		alias
			"Equals"
		end

	frozen get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Reflection.AssemblyName"
		alias
			"GetObjectData"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.AssemblyName"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.AssemblyName"
		alias
			"Finalize"
		end

end -- class ASSEMBLY_NAME
