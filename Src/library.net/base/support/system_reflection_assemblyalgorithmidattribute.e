indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyAlgorithmIdAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYALGORITHMIDATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblyalgorithmidattribute

feature {NONE} -- Initialization

	frozen make_assemblyalgorithmidattribute (algorithm_id: SYSTEM_CONFIGURATION_ASSEMBLIES_ASSEMBLYHASHALGORITHM) is
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

end -- class SYSTEM_REFLECTION_ASSEMBLYALGORITHMIDATTRIBUTE
