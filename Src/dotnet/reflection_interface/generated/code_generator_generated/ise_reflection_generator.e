indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen eiffelgeneratorfromxml: ISE_REFLECTION_EIFFELCODEGENERATORFROMXML is
		external
			"IL field signature :ISE.Reflection.EiffelCodeGeneratorFromXml use ISE.Reflection.Generator"
		alias
			"EiffelGeneratorFromXml"
		end

	frozen eiffelgenerator: ISE_REFLECTION_EIFFELCODEGENERATOR is
		external
			"IL field signature :ISE.Reflection.EiffelCodeGenerator use ISE.Reflection.Generator"
		alias
			"EiffelGenerator"
		end

	frozen xmlgenerator: ISE_REFLECTION_XMLCODEGENERATOR is
		external
			"IL field signature :ISE.Reflection.XmlCodeGenerator use ISE.Reflection.Generator"
		alias
			"XmlGenerator"
		end

feature -- Basic Operations

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.Generator"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_GENERATOR
