indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyAlgorithmIdAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYALGORITHMIDATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assembly_algorithm_id_attribute

feature {NONE} -- Initialization

	frozen make_assembly_algorithm_id_attribute (algorithm_id2: INTEGER) is
			-- Valid values for `algorithm_id2' are:
			-- None = 0
			-- MD5 = 32771
			-- SHA1 = 32772
		require
			valid_assembly_hash_algorithm: algorithm_id2 = 0 or algorithm_id2 = 32771 or algorithm_id2 = 32772
		external
			"IL creator signature (enum System.Configuration.Assemblies.AssemblyHashAlgorithm) use System.Reflection.AssemblyAlgorithmIdAttribute"
		end

feature -- Access

	frozen get_algorithm_id: INTEGER is
		external
			"IL signature (): System.UInt32 use System.Reflection.AssemblyAlgorithmIdAttribute"
		alias
			"get_AlgorithmId"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYALGORITHMIDATTRIBUTE
