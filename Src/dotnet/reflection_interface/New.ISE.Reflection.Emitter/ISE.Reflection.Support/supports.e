indexing
	description: "Root class"

class
	SUPPORTS
	
inherit
	SUPPORT_SUPPORT

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
		end
		
feature -- Access

	reflection_support: REFLECTION_SUPPORT
		indexing
			description: "Reflection support"
		end
	
	code_generation_support: CODE_GENERATION_SUPPORT
		indexing
			description: "Code generation support"
		end

	conversion_support: CONVERSION_SUPPORT
		indexing
			description: "Conversion support"
		end
		
end -- class SUPPORTS
