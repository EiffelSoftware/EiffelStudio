indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.Assemblies.AssemblyHashAlgorithm"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	ASSEMBLY_HASH_ALGORITHM

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen none: ASSEMBLY_HASH_ALGORITHM is
		external
			"IL enum signature :System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Configuration.Assemblies.AssemblyHashAlgorithm"
		alias
			"0"
		end

	frozen md5: ASSEMBLY_HASH_ALGORITHM is
		external
			"IL enum signature :System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Configuration.Assemblies.AssemblyHashAlgorithm"
		alias
			"32771"
		end

	frozen sha1: ASSEMBLY_HASH_ALGORITHM is
		external
			"IL enum signature :System.Configuration.Assemblies.AssemblyHashAlgorithm use System.Configuration.Assemblies.AssemblyHashAlgorithm"
		alias
			"32772"
		end

end -- class ASSEMBLY_HASH_ALGORITHM
