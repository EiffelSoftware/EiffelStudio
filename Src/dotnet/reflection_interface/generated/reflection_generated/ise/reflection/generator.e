indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "GENERATOR"

deferred external class
	GENERATOR

feature -- Basic Operations

	a_set_eiffel_generator_from_xml (eiffel_generator_from_xml2: EIFFEL_CODE_GENERATOR_FROM_XML) is
		external
			"IL deferred signature (EIFFEL_CODE_GENERATOR_FROM_XML): System.Void use GENERATOR"
		alias
			"_set_eiffel_generator_from_xml"
		end

	xml_generator: XML_CODE_GENERATOR is
		external
			"IL deferred signature (): XML_CODE_GENERATOR use GENERATOR"
		alias
			"xml_generator"
		end

	make is
		external
			"IL deferred signature (): System.Void use GENERATOR"
		alias
			"make"
		end

	eiffel_generator_from_xml: EIFFEL_CODE_GENERATOR_FROM_XML is
		external
			"IL deferred signature (): EIFFEL_CODE_GENERATOR_FROM_XML use GENERATOR"
		alias
			"eiffel_generator_from_xml"
		end

	a_set_eiffel_generator (eiffel_generator2: EIFFEL_CODE_GENERATOR) is
		external
			"IL deferred signature (EIFFEL_CODE_GENERATOR): System.Void use GENERATOR"
		alias
			"_set_eiffel_generator"
		end

	a_set_xml_generator (xml_generator2: XML_CODE_GENERATOR) is
		external
			"IL deferred signature (XML_CODE_GENERATOR): System.Void use GENERATOR"
		alias
			"_set_xml_generator"
		end

	eiffel_generator: EIFFEL_CODE_GENERATOR is
		external
			"IL deferred signature (): EIFFEL_CODE_GENERATOR use GENERATOR"
		alias
			"eiffel_generator"
		end

end -- class GENERATOR
