indexing
	Generator: "Eiffel Emitter 2.6b2"
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

	frozen assembly_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AssemblyName"
		end

	frozen eiffel_cluster_path: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"EiffelClusterPath"
		end

	frozen types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"Types"
		end

	frozen assembly_culture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AssemblyCulture"
		end

	frozen assembly_public_key: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AssemblyPublicKey"
		end

	frozen assembly_version: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AssemblyVersion"
		end

	frozen emitter_version_number: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"EmitterVersionNumber"
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
