indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen cachehandler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyCacheHandler use ISE.Reflection.XmlCodeGenerator"
		alias
			"CacheHandler"
		end

	frozen typestorer: ISE_REFLECTION_TYPESTORER is
		external
			"IL field signature :ISE.Reflection.TypeStorer use ISE.Reflection.XmlCodeGenerator"
		alias
			"TypeStorer"
		end

feature -- Basic Operations

	endassemblygeneration is
		external
			"IL signature (): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"EndAssemblyGeneration"
		end

	startassemblygeneration (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is
		external
			"IL signature (ISE.Reflection.EiffelAssembly): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"StartAssemblyGeneration"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"Make"
		end

	generatetype (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.XmlCodeGenerator"
		alias
			"GenerateType"
		end

end -- class ISE_REFLECTION_XMLCODEGENERATOR
