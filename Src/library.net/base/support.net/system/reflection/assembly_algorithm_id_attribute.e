indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyAlgorithmIdAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_ALGORITHM_ID_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_algorithm_id_attribute

feature {NONE} -- Initialization

	frozen make_assembly_algorithm_id_attribute (algorithm_id: ASSEMBLY_HASH_ALGORITHM) is
		external
			"IL creator signature (System.Configuration.Assemblies.AssemblyHashAlgorithm) use System.Reflection.AssemblyAlgorithmIdAttribute"
		end

feature -- Access

	frozen get_algorithm_id: INTEGER is
		external
			"IL signature (): System.UInt32 use System.Reflection.AssemblyAlgorithmIdAttribute"
		alias
			"get_AlgorithmId"
		end

end -- class ASSEMBLY_ALGORITHM_ID_ATTRIBUTE
