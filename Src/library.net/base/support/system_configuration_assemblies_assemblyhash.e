indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.Assemblies.AssemblyHash"

frozen expanded external class
	SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASH

inherit
	VALUE_TYPE
	SYSTEM_ICLONEABLE

feature -- Initialization

	frozen make_assemblyhash (value: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Configuration.Assemblies.AssemblyHash"
		end

	frozen make_assemblyhash_1 (algorithm: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASHALGORITHM; value: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Configuration.Assemblies.AssemblyHashAlgorithm, System.Byte[]) use System.Configuration.Assemblies.AssemblyHash"
		end

feature -- Access

	frozen empty: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASH is
		external
			"IL static_field signature :System.Configuration.Assemblies.AssemblyHash use System.Configuration.Assemblies.AssemblyHash"
		alias
			"Empty"
		end

	frozen get_algorithm: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASHALGORITHM is
		external
			"IL signature (): System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Configuration.Assemblies.AssemblyHash"
		alias
			"get_Algorithm"
		end

feature -- Element Change

	frozen set_algorithm (value: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASHALGORITHM) is
		external
			"IL signature (System.Configuration.Assemblies.AssemblyHashAlgorithm): System.Void use System.Configuration.Assemblies.AssemblyHash"
		alias
			"set_Algorithm"
		end

feature -- Basic Operations

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Configuration.Assemblies.AssemblyHash"
		alias
			"Clone"
		end

	frozen set_value (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Configuration.Assemblies.AssemblyHash"
		alias
			"SetValue"
		end

	frozen get_value: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Configuration.Assemblies.AssemblyHash"
		alias
			"GetValue"
		end

end -- class SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASH
