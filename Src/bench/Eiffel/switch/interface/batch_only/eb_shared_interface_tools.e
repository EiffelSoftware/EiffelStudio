indexing
	description: "All shared access windows."
	date: "$Date$"
	revision: "$Revision $"

class
	EB_SHARED_INTERFACE_TOOLS

inherit
	EB_SHARED_OUTPUT_TOOLS

feature -- Access

	has_modified_classes: BOOLEAN is False
			-- For compatibility with new_graphical.

end
