indexing
	description: "Access to shared constant classes."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONSTANTS

feature -- Access

	Application_constants: APPLICATION_CONSTANTS is
			-- Application wide constants
		once
			create Result			
		end
		
	Graphical_constants: GRAPHICAL_CONSTANTS is
			-- Graphical constants
		once
			create Result			
		end
		
	Message_constants: MESSAGE_CONSTANTS is
			-- Message string constants
		once
			create Result
		end		
		
	Help_constants: HELP_SETTING_CONSTANTS is
			-- Help wide constants
		once
			create Result			
		end
		
	Transformation_constants: XSL_TRANSFORM_CONSTANTS is
			-- XSL transformation constants
		once
			create Result	
		end

end -- class SHARED_CONSTANTS
