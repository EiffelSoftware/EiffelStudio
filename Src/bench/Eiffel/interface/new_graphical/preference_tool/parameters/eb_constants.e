indexing
	description	: "Constants for EiffelStudio."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONSTANTS

feature {NONE} -- Resources

	Pixmaps: EB_SHARED_PIXMAPS is
		once
			create Result
		end

	Cursors: EB_SHARED_CURSORS is
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

	Layout_constants: EV_LAYOUT_CONSTANTS is
			-- Constants for vision2 layout
		once
			create Result
		end

end -- class EB_CONSTANTS

