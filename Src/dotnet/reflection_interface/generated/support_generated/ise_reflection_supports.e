indexing
	Generator: "Eiffel Emitter 2.4b2"
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

	frozen ConversionSupport: ISE_REFLECTION_CONVERSIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.ConversionSupport use ISE.Reflection.Supports"
		alias
			"ConversionSupport"
		end

	frozen ReflectionSupport: ISE_REFLECTION_REFLECTIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.ReflectionSupport use ISE.Reflection.Supports"
		alias
			"ReflectionSupport"
		end

	frozen CodeGenerationSupport: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL field signature :ISE.Reflection.CodeGenerationSupport use ISE.Reflection.Supports"
		alias
			"CodeGenerationSupport"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.Supports"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_SUPPORTS
