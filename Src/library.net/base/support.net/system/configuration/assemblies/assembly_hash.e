indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.Assemblies.AssemblyHash"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	ASSEMBLY_HASH

inherit
	VALUE_TYPE
	ICLONEABLE

feature -- Initialization

	frozen make_assembly_hash_1 (algorithm: ASSEMBLY_HASH_ALGORITHM; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Configuration.Assemblies.AssemblyHashAlgorithm, System.Byte[]) use System.Configuration.Assemblies.AssemblyHash"
		end

	frozen make_assembly_hash (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Configuration.Assemblies.AssemblyHash"
		end

feature -- Access

	frozen empty: ASSEMBLY_HASH is
		external
			"IL static_field signature :System.Configuration.Assemblies.AssemblyHash use System.Configuration.Assemblies.AssemblyHash"
		alias
			"Empty"
		end

	frozen get_algorithm: ASSEMBLY_HASH_ALGORITHM is
		external
			"IL signature (): System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Configuration.Assemblies.AssemblyHash"
		alias
			"get_Algorithm"
		end

feature -- Element Change

	frozen set_algorithm (value: ASSEMBLY_HASH_ALGORITHM) is
		external
			"IL signature (System.Configuration.Assemblies.AssemblyHashAlgorithm): System.Void use System.Configuration.Assemblies.AssemblyHash"
		alias
			"set_Algorithm"
		end

feature -- Basic Operations

	frozen set_value (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Configuration.Assemblies.AssemblyHash"
		alias
			"SetValue"
		end

	frozen get_value: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Configuration.Assemblies.AssemblyHash"
		alias
			"GetValue"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Configuration.Assemblies.AssemblyHash"
		alias
			"Clone"
		end

end -- class ASSEMBLY_HASH
