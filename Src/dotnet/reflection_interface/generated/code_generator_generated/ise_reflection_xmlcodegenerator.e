indexing
	Generator: "Eiffel Emitter 2.4b2"
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

	frozen CacheHandler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyCacheHandler use ISE.Reflection.XmlCodeGenerator"
		alias
			"CacheHandler"
		end

	frozen TypeStorer: ISE_REFLECTION_TYPESTORER is
		external
			"IL field signature :ISE.Reflection.TypeStorer use ISE.Reflection.XmlCodeGenerator"
		alias
			"TypeStorer"
		end

feature -- Basic Operations

	StartAssemblyGeneration (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY) is
		external
			"IL signature (ISE.Reflection.EiffelAssemblyFactory): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"StartAssemblyGeneration"
		end

	EndAssemblyGeneration is
		external
			"IL signature (): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"EndAssemblyGeneration"
		end

	ReplaceType (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"ReplaceType"
		end

	MakeXmlCodeGenerator is
		external
			"IL signature (): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"MakeXmlCodeGenerator"
		end

	GenerateType (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"GenerateType"
		end

end -- class ISE_REFLECTION_XMLCODEGENERATOR
