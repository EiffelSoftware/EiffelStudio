indexing
	Generator: "Eiffel Emitter beta 2"
	external_name: "ISE.Reflection.EiffelCodeGeneratorFromXml"

external class
	ISE_REFLECTION_EIFFELCODEGENERATORFROMXML

inherit
	ANY
		redefine
			equals,
			tostring,
			finalize,
			gethashcode
		end
	ISE_REFLECTION_CODEGENERATOR
		rename
			generatecode as a__generatecode
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.EiffelCodeGeneratorFromXml"
		end

feature -- Access

	frozen assemblydescriptionfilename: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"AssemblyDescriptionFilename"
		end

	frozen typedescriptionfilename: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"TypeDescriptionFilename"
		end

feature -- Basic Operations

	makefrominfo (an_assembly_description_filename: STRING; a_type_description_filename: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"MakeFromInfo"
		end

	generateeiffelcodefromxml is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"GenerateEiffelCodeFromXml"
		end

	gethashcode: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"GetHashCode"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"Make"
		end

	tostring: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen a__generatecode is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"__GenerateCode"
		end

	finalize is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGeneratorFromXml"
		alias
			"Finalize"
		end

end -- class ISE_REFLECTION_EIFFELCODEGENERATORFROMXML
