indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EIFFEL_CODE_GENERATOR_FROM_XML"

deferred external class
	EIFFEL_CODE_GENERATOR_FROM_XML

inherit
	CODE_GENERATOR_SUPPORT

feature -- Basic Operations

	assembly_description_filename: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"assembly_description_filename"
		end

	eiffel_code_generator: EIFFEL_CODE_GENERATOR is
		external
			"IL deferred signature (): EIFFEL_CODE_GENERATOR use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"eiffel_code_generator"
		end

	a_set_assembly_description_filename (assembly_description_filename2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"_set_assembly_description_filename"
		end

	make is
		external
			"IL deferred signature (): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"make"
		end

	update_assembly_description (new_path: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"update_assembly_description"
		end

	make_from_info (an_assembly_description_filename: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"make_from_info"
		end

	generate_eiffel_code_from_xml (type_description_filename: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"generate_eiffel_code_from_xml"
		end

	eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"eiffel_assembly"
		end

	a_set_eiffel_assembly (eiffel_assembly2: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"_set_eiffel_assembly"
		end

	a_set_eiffel_code_generator (eiffel_code_generator2: EIFFEL_CODE_GENERATOR) is
		external
			"IL deferred signature (EIFFEL_CODE_GENERATOR): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"_set_eiffel_code_generator"
		end

	generate_eiffel_code_from_xml_and_path (type_description_filename: STRING; a_path: STRING) is
		external
			"IL deferred signature (STRING, STRING): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"generate_eiffel_code_from_xml_and_path"
		end

	dotnet_library_relative_path: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"dotnet_library_relative_path"
		end

	eiffel_class_from_xml (type_description_filename: STRING): EIFFEL_CLASS is
		external
			"IL deferred signature (STRING): EIFFEL_CLASS use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"eiffel_class_from_xml"
		end

	make_from_info_and_path (an_assembly_description_filename: STRING; new_path: STRING) is
		external
			"IL deferred signature (STRING, STRING): System.Void use EIFFEL_CODE_GENERATOR_FROM_XML"
		alias
			"make_from_info_and_path"
		end

end -- class EIFFEL_CODE_GENERATOR_FROM_XML
