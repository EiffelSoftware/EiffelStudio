indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EIFFEL_ASSEMBLY"

deferred external class
	EIFFEL_ASSEMBLY

inherit
	SUPPORT_SUPPORT
	SUPPORT

feature -- Basic Operations

	emitter_version_number: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_ASSEMBLY"
		alias
			"emitter_version_number"
		end

	a_set_assembly_descriptor (assembly_descriptor2: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use EIFFEL_ASSEMBLY"
		alias
			"_set_assembly_descriptor"
		end

	assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		external
			"IL deferred signature (): ASSEMBLY_DESCRIPTOR use EIFFEL_ASSEMBLY"
		alias
			"assembly_descriptor"
		end

	implementation: EIFFEL_ASSEMBLY_IMP is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY_IMP use EIFFEL_ASSEMBLY"
		alias
			"implementation"
		end

	a_set_eiffel_cluster_path (eiffel_cluster_path2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_ASSEMBLY"
		alias
			"_set_eiffel_cluster_path"
		end

	types_retrieval_failed: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_ASSEMBLY"
		alias
			"types_retrieval_failed"
		end

	a_set_emitter_version_number (emitter_version_number2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_ASSEMBLY"
		alias
			"_set_emitter_version_number"
		end

	set_implementation (a_implementation: EIFFEL_ASSEMBLY_IMP) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY_IMP): System.Void use EIFFEL_ASSEMBLY"
		alias
			"set_implementation"
		end

	types_retrieval_failed_message: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_ASSEMBLY"
		alias
			"types_retrieval_failed_message"
		end

	make (a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: STRING; a_number: STRING) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR, STRING, STRING): System.Void use EIFFEL_ASSEMBLY"
		alias
			"make"
		end

	types: LINKED_LIST_ANY is
		external
			"IL deferred signature (): LINKED_LIST_ANY use EIFFEL_ASSEMBLY"
		alias
			"types"
		end

	a_set_xml_elements (xml_elements2: XML_ELEMENTS) is
		external
			"IL deferred signature (XML_ELEMENTS): System.Void use EIFFEL_ASSEMBLY"
		alias
			"_set_xml_elements"
		end

	eiffel_cluster_path: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_ASSEMBLY"
		alias
			"eiffel_cluster_path"
		end

	xml_elements: XML_ELEMENTS is
		external
			"IL deferred signature (): XML_ELEMENTS use EIFFEL_ASSEMBLY"
		alias
			"xml_elements"
		end

	make_from_implementation (a_implementation: EIFFEL_ASSEMBLY_IMP; a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: STRING; a_number: STRING) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY_IMP, ASSEMBLY_DESCRIPTOR, STRING, STRING): System.Void use EIFFEL_ASSEMBLY"
		alias
			"make_from_implementation"
		end

	a_set_implementation (implementation2: EIFFEL_ASSEMBLY_IMP) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY_IMP): System.Void use EIFFEL_ASSEMBLY"
		alias
			"_set_implementation"
		end

end -- class EIFFEL_ASSEMBLY
