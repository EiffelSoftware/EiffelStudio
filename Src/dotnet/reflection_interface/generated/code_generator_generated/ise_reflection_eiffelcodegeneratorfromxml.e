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

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"Make"
		end

	MakeFromInfo (an_assembly_description_filename: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"MakeFromInfo"
		end

	GenerateEiffelCodeFromXml (type_description_filename: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"GenerateEiffelCodeFromXml"
		end

end -- class ISE_REFLECTION_EIFFELCODEGENERATORFROMXML
