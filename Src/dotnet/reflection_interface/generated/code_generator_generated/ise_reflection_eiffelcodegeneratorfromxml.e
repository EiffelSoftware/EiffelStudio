indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.EiffelCodeGeneratorFromXml"

external class
	ISE_REFLECTION_EIFFELCODEGENERATORFROMXML

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.EiffelCodeGeneratorFromXml"
		end

feature -- Access

	get_eiffel_code_generator: ISE_REFLECTION_EIFFELCODEGENERATOR is
		external
			"IL signature (): ISE.Reflection.EiffelCodeGenerator use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"get_EiffelCodeGenerator"
		end

	get_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (): ISE.Reflection.EiffelAssembly use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"get_EiffelAssembly"
		end

	frozen a_internal_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"_internal_EiffelAssembly"
		end

	frozen a_internal_assembly_description_filename: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"_internal_AssemblyDescriptionFilename"
		end

	frozen a_internal_eiffel_code_generator: ISE_REFLECTION_EIFFELCODEGENERATOR is
		external
			"IL field signature :ISE.Reflection.EiffelCodeGenerator use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"_internal_EiffelCodeGenerator"
		end

	get_assembly_description_filename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"get_AssemblyDescriptionFilename"
		end

feature -- Basic Operations

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"Make"
		end

	update_assembly_description (new_path: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"UpdateAssemblyDescription"
		end

	make_from_info (an_assembly_description_filename: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"MakeFromInfo"
		end

	generate_eiffel_code_from_xml (type_description_filename: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"GenerateEiffelCodeFromXml"
		end

	generate_eiffel_code_from_xml_and_path (type_description_filename: STRING; a_path: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"GenerateEiffelCodeFromXmlAndPath"
		end

	dotnet_library_relative_path: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"DotnetLibraryRelativePath"
		end

	eiffel_class_from_xml (type_description_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.String): ISE.Reflection.EiffelClass use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"EiffelClassFromXml"
		end

	make_from_info_and_path (an_assembly_description_filename: STRING; new_path: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"MakeFromInfoAndPath"
		end

end -- class ISE_REFLECTION_EIFFELCODEGENERATORFROMXML
