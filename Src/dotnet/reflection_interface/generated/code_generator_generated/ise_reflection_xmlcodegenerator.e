indexing
	Generator: "Eiffel Emitter 2.6b2"
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

	frozen cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyCacheHandler use ISE.Reflection.XmlCodeGenerator"
		alias
			"CacheHandler"
		end

	frozen type_storer: ISE_REFLECTION_TYPESTORER is
		external
			"IL field signature :ISE.Reflection.TypeStorer use ISE.Reflection.XmlCodeGenerator"
		alias
			"TypeStorer"
		end

feature -- Basic Operations

	start_assembly_generation (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY) is
		external
			"IL signature (ISE.Reflection.EiffelAssemblyFactory): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"StartAssemblyGeneration"
		end

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

	generate_type (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"GenerateType"
		end

end -- class ISE_REFLECTION_XMLCODEGENERATOR
