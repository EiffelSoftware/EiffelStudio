indexing
	description: "Provide support for code generation and reflection."
	external_name: "ISE.Reflection.Supports"

class
	SUPPORTS

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		indexing
			external_name: "Make"
		do
		end
		
feature -- Access

	reflection_support: REFLECTION_SUPPORT
			-- Reflection support
		indexing
			external_name: "ReflectionSupport"
		end
	
	code_generation_support: CODE_GENERATION_SUPPORT
			-- Code generation support
		indexing
			external_name: "CodeGenerationSupport"
		end

	conversion_support: CONVERSION_SUPPORT
			-- Conversion support
		indexing
			external_name: "ConversionSupport"
		end
		
end -- class SUPPORTS
