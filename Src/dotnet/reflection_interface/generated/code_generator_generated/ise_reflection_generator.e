indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	get_eiffel_generator_from_xml: ISE_REFLECTION_EIFFELCODEGENERATORFROMXML is
		external
			"IL signature (): ISE.Reflection.EiffelCodeGeneratorFromXml use ISE.Reflection.Generator"
		alias
			"get_EiffelGeneratorFromXml"
		end

	frozen a_internal_eiffel_generator_from_xml: ISE_REFLECTION_EIFFELCODEGENERATORFROMXML is
		external
			"IL field signature :ISE.Reflection.EiffelCodeGeneratorFromXml use ISE.Reflection.Generator"
		alias
			"_internal_EiffelGeneratorFromXml"
		end

	get_xml_generator: ISE_REFLECTION_XMLCODEGENERATOR is
		external
			"IL signature (): ISE.Reflection.XmlCodeGenerator use ISE.Reflection.Generator"
		alias
			"get_XmlGenerator"
		end

	get_eiffel_generator: ISE_REFLECTION_EIFFELCODEGENERATOR is
		external
			"IL signature (): ISE.Reflection.EiffelCodeGenerator use ISE.Reflection.Generator"
		alias
			"get_EiffelGenerator"
		end

	frozen a_internal_eiffel_generator: ISE_REFLECTION_EIFFELCODEGENERATOR is
		external
			"IL field signature :ISE.Reflection.EiffelCodeGenerator use ISE.Reflection.Generator"
		alias
			"_internal_EiffelGenerator"
		end

	frozen a_internal_xml_generator: ISE_REFLECTION_XMLCODEGENERATOR is
		external
			"IL field signature :ISE.Reflection.XmlCodeGenerator use ISE.Reflection.Generator"
		alias
			"_internal_XmlGenerator"
		end

feature -- Basic Operations

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.Generator"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_GENERATOR
