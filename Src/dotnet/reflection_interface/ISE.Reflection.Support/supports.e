indexing
	description: "Root class"
	external_name: "ISE.Reflection.Supports"

class
	SUPPORTS

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
			external_name: "Make"
		do
		end
		
feature -- Access

	reflection_support: REFLECTION_SUPPORT
		indexing
			description: "Reflection support"
			external_name: "ReflectionSupport"
		end
	
	code_generation_support: CODE_GENERATION_SUPPORT
		indexing
			description: "Code generation support"
			external_name: "CodeGenerationSupport"
		end

	conversion_support: CONVERSION_SUPPORT
		indexing
			description: "Conversion support"
			external_name: "ConversionSupport"
		end
		
end -- class SUPPORTS
