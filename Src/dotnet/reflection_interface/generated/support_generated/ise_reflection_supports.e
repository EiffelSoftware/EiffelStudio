indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.Supports"
external class
	ISE_REFLECTION_SUPPORTS

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.Supports"
		end

feature -- Access

	frozen conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.ConversionSupport use ISE.Reflection.Supports"
		alias
			"ConversionSupport"
		end

	frozen code_generation_support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.CodeGenerationSupport use ISE.Reflection.Supports"
		alias
			"CodeGenerationSupport"
		end

	frozen reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.ReflectionSupport use ISE.Reflection.Supports"
		alias
			"ReflectionSupport"
		end

feature -- Basic Operations

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.Supports"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_SUPPORTS
