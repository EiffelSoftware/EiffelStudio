indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "REFLECTION_SUPPORT"

deferred external class
	REFLECTION_SUPPORT

inherit
	SUPPORT_SUPPORT
	SUPPORT

feature -- Basic Operations

	a_set_error_messages (error_messages2: REFLECTION_SUPPORT_ERROR_MESSAGES) is
		external
			"IL deferred signature (REFLECTION_SUPPORT_ERROR_MESSAGES): System.Void use REFLECTION_SUPPORT"
		alias
			"_set_error_messages"
		end

	key: STRING is
		external
			"IL deferred signature (): STRING use REFLECTION_SUPPORT"
		alias
			"key"
		end

	xml_elements: XML_ELEMENTS is
		external
			"IL deferred signature (): XML_ELEMENTS use REFLECTION_SUPPORT"
		alias
			"xml_elements"
		end

	clean_assemblies is
		external
			"IL deferred signature (): System.Void use REFLECTION_SUPPORT"
		alias
			"clean_assemblies"
		end

	eiffel_delivery_path: STRING is
		external
			"IL deferred signature (): STRING use REFLECTION_SUPPORT"
		alias
			"eiffel_delivery_path"
		end

	default_xml_type_filename: STRING is
		external
			"IL deferred signature (): STRING use REFLECTION_SUPPORT"
		alias
			"default_xml_type_filename"
		end

	assemblies_folder_path: STRING is
		external
			"IL deferred signature (): STRING use REFLECTION_SUPPORT"
		alias
			"assemblies_folder_path"
		end

	clean_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use REFLECTION_SUPPORT"
		alias
			"clean_assembly"
		end

	xml_type_filename (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR; type_full_external_name: STRING): STRING is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR, STRING): STRING use REFLECTION_SUPPORT"
		alias
			"xml_type_filename"
		end

	eiffel_key: STRING is
		external
			"IL deferred signature (): STRING use REFLECTION_SUPPORT"
		alias
			"eiffel_key"
		end

	support: CODE_GENERATION_SUPPORT is
		external
			"IL deferred signature (): CODE_GENERATION_SUPPORT use REFLECTION_SUPPORT"
		alias
			"support"
		end

	dictionary: DICTIONARY is
		external
			"IL deferred signature (): DICTIONARY use REFLECTION_SUPPORT"
		alias
			"dictionary"
		end

	make is
		external
			"IL deferred signature (): System.Void use REFLECTION_SUPPORT"
		alias
			"make"
		end

	assembly_folder_path_from_info (a_descriptor: ASSEMBLY_DESCRIPTOR): STRING is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): STRING use REFLECTION_SUPPORT"
		alias
			"assembly_folder_path_from_info"
		end

	ise_eiffel_key_path: STRING is
		external
			"IL deferred signature (): STRING use REFLECTION_SUPPORT"
		alias
			"ise_eiffel_key_path"
		end

	xml_assembly_filename (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR): STRING is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): STRING use REFLECTION_SUPPORT"
		alias
			"xml_assembly_filename"
		end

	a_set_dictionary (dictionary2: DICTIONARY) is
		external
			"IL deferred signature (DICTIONARY): System.Void use REFLECTION_SUPPORT"
		alias
			"_set_dictionary"
		end

	assembly_description_filename: STRING is
		external
			"IL deferred signature (): STRING use REFLECTION_SUPPORT"
		alias
			"assembly_description_filename"
		end

	error_messages: REFLECTION_SUPPORT_ERROR_MESSAGES is
		external
			"IL deferred signature (): REFLECTION_SUPPORT_ERROR_MESSAGES use REFLECTION_SUPPORT"
		alias
			"error_messages"
		end

end -- class REFLECTION_SUPPORT
