indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.Generator"

external class
	ISE_REFLECTION_GENERATOR

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.Generator"
		end

feature -- Access

	frozen EiffelGenerator: ISE_REFLECTION_EIFFELCODEGENERATOR is
		external
			"IL field signature :ISE.Reflection.EiffelCodeGenerator use ISE.Reflection.Generator"
		alias
			"EiffelGenerator"
		end

	frozen XmlGenerator: ISE_REFLECTION_XMLCODEGENERATOR is
		external
			"IL field signature :ISE.Reflection.XmlCodeGenerator use ISE.Reflection.Generator"
		alias
			"XmlGenerator"
		end

	frozen EiffelGeneratorFromXml: ISE_REFLECTION_EIFFELCODEGENERATORFROMXML is
		external
			"IL field signature :ISE.Reflection.EiffelCodeGeneratorFromXml use ISE.Reflection.Generator"
		alias
			"EiffelGeneratorFromXml"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.Generator"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_GENERATOR
