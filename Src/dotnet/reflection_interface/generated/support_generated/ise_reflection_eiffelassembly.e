indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.EiffelAssembly"
	assembly: "ISE.Reflection.Support", "0.0.0.0", "neutral", "2ef5239aeb372f26"

external class
	ISE_REFLECTION_EIFFELASSEMBLY

inherit
	ISE_REFLECTION_SUPPORT

create
	make_eiffelassembly

feature {NONE} -- Initialization

	frozen make_eiffelassembly is
		external
			"IL creator use ISE.Reflection.EiffelAssembly"
		end

feature -- Access

	frozen a_internal_emitter_version_number: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"_internal_EmitterVersionNumber"
		end

	get_eiffel_cluster_path: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssembly"
		alias
			"get_EiffelClusterPath"
		end

	get_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL signature (): ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelAssembly"
		alias
			"get_AssemblyDescriptor"
		end

	get_xml_elements: ISE_REFLECTION_XMLELEMENTS is
		external
			"IL signature (): ISE.Reflection.XmlElements use ISE.Reflection.EiffelAssembly"
		alias
			"get_XmlElements"
		end

	frozen a_internal_xml_elements: ISE_REFLECTION_XMLELEMENTS is
		external
			"IL field signature :ISE.Reflection.XmlElements use ISE.Reflection.EiffelAssembly"
		alias
			"_internal_XmlElements"
		end

	get_emitter_version_number: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssembly"
		alias
			"get_EmitterVersionNumber"
		end

	frozen a_internal_eiffel_cluster_path: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"_internal_EiffelClusterPath"
		end

	frozen a_internal_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL field signature :ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelAssembly"
		alias
			"_internal_AssemblyDescriptor"
		end

feature -- Basic Operations

	types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.EiffelAssembly"
		alias
			"Types"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_EIFFELASSEMBLY) is
		external
			"IL static signature (ISE.Reflection.EiffelAssembly): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"_invariant"
		end

	make (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; a_path: STRING; a_number: STRING) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, System.String, System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"Make"
		end

	types_retrieval_failed_message: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssembly"
		alias
			"TypesRetrievalFailedMessage"
		end

	types_retrieval_failed: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssembly"
		alias
			"TypesRetrievalFailed"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLY
