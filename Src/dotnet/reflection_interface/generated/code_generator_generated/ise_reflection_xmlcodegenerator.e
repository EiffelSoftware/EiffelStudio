indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.XmlCodeGenerator"

external class
	ISE_REFLECTION_XMLCODEGENERATOR

inherit
	ISE_REFLECTION_XMLELEMENTS

create
	make_xmlcodegenerator

feature {NONE} -- Initialization

	frozen make_xmlcodegenerator is
		external
			"IL creator use ISE.Reflection.XmlCodeGenerator"
		end

feature -- Access

	get_type_storer: ISE_REFLECTION_TYPESTORER is
		external
			"IL signature (): ISE.Reflection.TypeStorer use ISE.Reflection.XmlCodeGenerator"
		alias
			"get_TypeStorer"
		end

	frozen a_internal_type_storer: ISE_REFLECTION_TYPESTORER is
		external
			"IL field signature :ISE.Reflection.TypeStorer use ISE.Reflection.XmlCodeGenerator"
		alias
			"_internal_TypeStorer"
		end

	get_cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER is
		external
			"IL signature (): ISE.Reflection.EiffelAssemblyCacheHandler use ISE.Reflection.XmlCodeGenerator"
		alias
			"get_CacheHandler"
		end

	frozen a_internal_cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyCacheHandler use ISE.Reflection.XmlCodeGenerator"
		alias
			"_internal_CacheHandler"
		end

feature -- Basic Operations

	make_xml_code_generator is
		external
			"IL signature (): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"MakeXmlCodeGenerator"
		end

	end_assembly_generation is
		external
			"IL signature (): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"EndAssemblyGeneration"
		end

	replace_type (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"ReplaceType"
		end

	start_assembly_generation (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is
		external
			"IL signature (ISE.Reflection.EiffelAssembly): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"StartAssemblyGeneration"
		end

	generate_type (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"GenerateType"
		end

end -- class ISE_REFLECTION_XMLCODEGENERATOR
