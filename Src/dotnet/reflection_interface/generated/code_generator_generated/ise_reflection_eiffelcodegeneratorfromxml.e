indexing
	Generator: "Eiffel Emitter 2.3b"
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

	frozen AssemblyDescriptionFilename: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"AssemblyDescriptionFilename"
		end

	frozen EiffelAssembly: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"EiffelAssembly"
		end

	frozen EiffelCodeGenerator: ISE_REFLECTION_EIFFELCODEGENERATOR is
		external
			"IL field signature :ISE.Reflection.EiffelCodeGenerator use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"EiffelCodeGenerator"
		end

feature -- Basic Operations

	MakeFromInfo (an_assembly_description_filename: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"MakeFromInfo"
		end

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"Make"
		end

	MakeFromInfoAndPath (an_assembly_description_filename: STRING; new_path: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"MakeFromInfoAndPath"
		end

	GenerateEiffelCodeFromXmlAndPath (type_description_filename: STRING; a_path: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"GenerateEiffelCodeFromXmlAndPath"
		end

	GenerateEiffelCodeFromXml (type_description_filename: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"GenerateEiffelCodeFromXml"
		end

	DotnetLibraryRelativePath: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"DotnetLibraryRelativePath"
		end

	UpdateAssemblyDescription (new_path: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"UpdateAssemblyDescription"
		end

	EiffelClassFromXml (type_description_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.String): ISE.Reflection.EiffelClass use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"EiffelClassFromXml"
		end

end -- class ISE_REFLECTION_EIFFELCODEGENERATORFROMXML
