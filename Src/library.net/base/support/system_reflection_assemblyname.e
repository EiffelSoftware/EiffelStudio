indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyName"

external class
	SYSTEM_REFLECTION_ASSEMBLYNAME

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Reflection.AssemblyName"
		end

feature -- Access

	get_hash_algorithm: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASHALGORITHM is
		external
			"IL signature (): System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Reflection.AssemblyName"
		alias
			"get_HashAlgorithm"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_Name"
		end

	get_culture_info: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Reflection.AssemblyName"
		alias
			"get_CultureInfo"
		end

	get_flags: SYSTEM_REFLECTION_ASSEMBLYNAMEFLAGS is
		external
			"IL signature (): System.Reflection.AssemblyNameFlags use System.Reflection.AssemblyName"
		alias
			"get_Flags"
		end

	get_version_compatibility: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYVERSIONCOMPATIBILITY is
		external
			"IL signature (): System.Configuration.Assemblies.AssemblyVersionCompatibility use System.Reflection.AssemblyName"
		alias
			"get_VersionCompatibility"
		end

	get_full_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_FullName"
		end

	get_code_base: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"get_CodeBase"
		end

	get_key_pair: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR is
		external
			"IL signature (): System.Reflection.StrongNameKeyPair use System.Reflection.AssemblyName"
		alias
			"get_KeyPair"
		end

	get_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.Reflection.AssemblyName"
		alias
			"get_Version"
		end

feature -- Element Change

	set_culture_info (value: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Reflection.AssemblyName"
		alias
			"set_CultureInfo"
		end

	set_key_pair (value: SYSTEM_REFLECTION_STRONGNAMEKEYPAIR) is
		external
			"IL signature (System.Reflection.StrongNameKeyPair): System.Void use System.Reflection.AssemblyName"
		alias
			"set_KeyPair"
		end

	set_hash_algorithm (value: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASHALGORITHM) is
		external
			"IL signature (System.Configuration.Assemblies.AssemblyHashAlgorithm): System.Void use System.Reflection.AssemblyName"
		alias
			"set_HashAlgorithm"
		end

	set_version (value: SYSTEM_VERSION) is
		external
			"IL signature (System.Version): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Version"
		end

	set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Name"
		end

	set_flags (value: SYSTEM_REFLECTION_ASSEMBLYNAMEFLAGS) is
		external
			"IL signature (System.Reflection.AssemblyNameFlags): System.Void use System.Reflection.AssemblyName"
		alias
			"set_Flags"
		end

	set_code_base (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.AssemblyName"
		alias
			"set_CodeBase"
		end

	set_version_compatibility (value: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYVERSIONCOMPATIBILITY) is
		external
			"IL signature (System.Configuration.Assemblies.AssemblyVersionCompatibility): System.Void use System.Reflection.AssemblyName"
		alias
			"set_VersionCompatibility"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyName"
		alias
			"ToString"
		end

	frozen get_public_key_token: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.AssemblyName"
		alias
			"GetPublicKeyToken"
		end

	frozen get_assembly_name (assembly_file: STRING): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL static signature (System.String): System.Reflection.AssemblyName use System.Reflection.AssemblyName"
		alias
			"GetAssemblyName"
		end

	frozen get_public_key: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.AssemblyName"
		alias
			"GetPublicKey"
		end

	on_deserialization (sender: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.AssemblyName"
		alias
			"OnDeserialization"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Reflection.AssemblyName"
		alias
			"Clone"
		end

	frozen set_public_key_token (public_key_token: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.AssemblyName"
		alias
			"SetPublicKeyToken"
		end

	frozen set_public_key (public_key: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Reflection.AssemblyName"
		alias
			"SetPublicKey"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.AssemblyName"
		alias
			"Equals"
		end

	frozen get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
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

end -- class SYSTEM_REFLECTION_ASSEMBLYNAME
