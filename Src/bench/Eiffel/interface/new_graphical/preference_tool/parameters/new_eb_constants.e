indexing
	description: "Constants for `bench'."
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_EB_CONSTANTS

feature {NONE} -- Resources

	Pixmaps: EB_SHARED_PIXMAPS is
	
		once
			create Result
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
