indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.EiffelAssemblyFactory"

external class
	ISE_REFLECTION_EIFFELASSEMBLYFACTORY

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.EiffelAssemblyFactory"
		end

feature -- Access

	frozen a_internal_emitter_version_number: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_internal_EmitterVersionNumber"
		end

	frozen a_internal_assembly_culture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_internal_AssemblyCulture"
		end

	frozen a_internal_assembly_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_internal_AssemblyName"
		end

	get_assembly_public_key: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"get_AssemblyPublicKey"
		end

	get_eiffel_cluster_path: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"get_EiffelClusterPath"
		end

	frozen a_internal_assembly_public_key: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_internal_AssemblyPublicKey"
		end

	get_assembly_version: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"get_AssemblyVersion"
		end

	get_emitter_version_number: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"get_EmitterVersionNumber"
		end

	frozen a_internal_assembly_version: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_internal_AssemblyVersion"
		end

	frozen a_internal_types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_internal_Types"
		end

	get_types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"get_Types"
		end

	frozen a_internal_eiffel_cluster_path: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_internal_EiffelClusterPath"
		end

	get_assembly_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"get_AssemblyName"
		end

	get_assembly_culture: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"get_AssemblyCulture"
		end

feature -- Basic Operations

	set_assembly_public_key (a_public_key: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetAssemblyPublicKey"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"Make"
		end

	set_eiffel_cluster_path (a_path: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetEiffelClusterPath"
		end

	set_emitter_version_number (a_value: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetEmitterVersionNumber"
		end

	add_type (a_type: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AddType"
		end

	set_assembly_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetAssemblyName"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_EIFFELASSEMBLYFACTORY) is
		external
			"IL static signature (ISE.Reflection.EiffelAssemblyFactory): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_invariant"
		end

	set_assembly_version (a_version: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetAssemblyVersion"
		end

	set_assembly_culture (a_culture: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetAssemblyCulture"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLYFACTORY
