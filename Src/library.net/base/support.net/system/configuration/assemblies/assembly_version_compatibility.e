indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.Assemblies.AssemblyVersionCompatibility"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	ASSEMBLY_VERSION_COMPATIBILITY

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen same_process: ASSEMBLY_VERSION_COMPATIBILITY is
		external
			"IL enum signature :System.Configuration.Assemblies.AssemblyVersionCompatibility use System.Configuration.Assemblies.AssemblyVersionCompatibility"
		alias
			"2"
		end

	frozen same_domain: ASSEMBLY_VERSION_COMPATIBILITY is
		external
			"IL enum signature :System.Configuration.Assemblies.AssemblyVersionCompatibility use System.Configuration.Assemblies.AssemblyVersionCompatibility"
		alias
			"3"
		end

	frozen same_machine: ASSEMBLY_VERSION_COMPATIBILITY is
		external
			"IL enum signature :System.Configuration.Assemblies.AssemblyVersionCompatibility use System.Configuration.Assemblies.AssemblyVersionCompatibility"
		alias
			"1"
		end

end -- class ASSEMBLY_VERSION_COMPATIBILITY
