indexing
	description: "Constants for `bench'."
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_EB_CONSTANTS

feature {NONE} -- Resources

	General_resources: EB_GENERAL_PARAMETERS is
			-- General resources
		once
			Create Result.make
			
		end

	Graphical_resources: EB_GRAPHICAL_PARAMETERS is
			-- Graphical resources
		once
			Create Result.make
			
		end

	Pixmaps: EB_SHARED_PIXMAPS is
	
		once
			Create Result
		end

	Interface_names: INTERFACE_NAMES is
			-- All names used in the interface
		once
			create Result
		end

	Warning_messages: WARNING_MESSAGES is
			-- All warnings used in the interface
		once
			create Result
		end

end -- class NEW_EB_CONSTANTS
