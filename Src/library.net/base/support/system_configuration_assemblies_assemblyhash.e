indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Configuration.Assemblies.AssemblyHash"

frozen expanded external class
	SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASH

inherit
	SYSTEM_VALUETYPE
	SYSTEM_ICLONEABLE


feature {NONE} -- Initialization

	frozen make_assembly_hash (value: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Configuration.Assemblies.AssemblyHash"
		end

	frozen make_assembly_hash_1 (algorithm2: INTEGER; value: ARRAY [INTEGER_8]) is
			-- Valid values for `algorithm2' are:
			-- None = 0
			-- MD5 = 32771
			-- SHA1 = 32772
		require
			valid_assembly_hash_algorithm: algorithm2 = 0 or algorithm2 = 32771 or algorithm2 = 32772
		external
			"IL creator signature (enum System.Configuration.Assemblies.AssemblyHashAlgorithm, System.Byte[]) use System.Configuration.Assemblies.AssemblyHash"
		end

feature -- Access

	frozen get_algorithm: INTEGER is
		external
			"IL signature (): enum System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Configuration.Assemblies.AssemblyHash"
		alias
			"get_Algorithm"
		ensure
			valid_assembly_hash_algorithm: Result = 0 or Result = 32771 or Result = 32772
		end

	frozen empty: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASH is
		external
			"IL static_field signature :System.Configuration.Assemblies.AssemblyHash use System.Configuration.Assemblies.AssemblyHash"
		alias
			"Empty"
		end

feature -- Element Change

	frozen set_algorithm (value: INTEGER) is
			-- Valid values for `value' are:
			-- None = 0
			-- MD5 = 32771
			-- SHA1 = 32772
		require
			valid_assembly_hash_algorithm: value = 0 or value = 32771 or value = 32772
		external
			"IL signature (enum System.Configuration.Assemblies.AssemblyHashAlgorithm): System.Void use System.Configuration.Assemblies.AssemblyHash"
		alias
			"set_Algorithm"
		end

feature -- Basic Operations

	frozen get_value: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Configuration.Assemblies.AssemblyHash"
		alias
			"GetValue"
		end

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

end -- class SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASH
