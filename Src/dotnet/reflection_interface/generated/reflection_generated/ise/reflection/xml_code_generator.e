indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "XML_CODE_GENERATOR"

deferred external class
	XML_CODE_GENERATOR

inherit
	XML_ELEMENTS
	CODE_GENERATOR_SUPPORT
	DICTIONARY

feature -- Basic Operations

	generate_type (an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL deferred signature (EIFFEL_CLASS): System.Void use XML_CODE_GENERATOR"
		alias
			"generate_type"
		end

	start_assembly_generation (an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use XML_CODE_GENERATOR"
		alias
			"start_assembly_generation"
		end

	type_storer: TYPE_STORER is
		external
			"IL deferred signature (): TYPE_STORER use XML_CODE_GENERATOR"
		alias
			"type_storer"
		end

	cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY_CACHE_HANDLER use XML_CODE_GENERATOR"
		alias
			"cache_handler"
		end

	end_assembly_generation is
		external
			"IL deferred signature (): System.Void use XML_CODE_GENERATOR"
		alias
			"end_assembly_generation"
		end

	a_set_type_storer (type_storer2: TYPE_STORER) is
		external
			"IL deferred signature (TYPE_STORER): System.Void use XML_CODE_GENERATOR"
		alias
			"_set_type_storer"
		end

	a_set_cache_handler (cache_handler2: EIFFEL_ASSEMBLY_CACHE_HANDLER) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Void use XML_CODE_GENERATOR"
		alias
			"_set_cache_handler"
		end

	replace_type (an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL deferred signature (EIFFEL_CLASS): System.Void use XML_CODE_GENERATOR"
		alias
			"replace_type"
		end

	make_xml_code_generator is
		external
			"IL deferred signature (): System.Void use XML_CODE_GENERATOR"
		alias
			"make_xml_code_generator"
		end

end -- class XML_CODE_GENERATOR
