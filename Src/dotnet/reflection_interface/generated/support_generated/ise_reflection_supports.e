indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.Supports"
	assembly: "ISE.Reflection.Support", "0.0.0.0", "neutral", "a3b366af8d5e38c"

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

	get_code_generation_support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.CodeGenerationSupport use ISE.Reflection.Supports"
		alias
			"get_CodeGenerationSupport"
		end

	get_reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.ReflectionSupport use ISE.Reflection.Supports"
		alias
			"get_ReflectionSupport"
		end

	frozen a_internal_conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.ConversionSupport use ISE.Reflection.Supports"
		alias
			"_internal_ConversionSupport"
		end

	get_conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.ConversionSupport use ISE.Reflection.Supports"
		alias
			"get_ConversionSupport"
		end

	frozen a_internal_code_generation_support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.CodeGenerationSupport use ISE.Reflection.Supports"
		alias
			"_internal_CodeGenerationSupport"
		end

	frozen a_internal_reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.ReflectionSupport use ISE.Reflection.Supports"
		alias
			"_internal_ReflectionSupport"
		end

feature -- Basic Operations

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.Supports"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_SUPPORTS
