indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EDK_APPLICATION

feature -- Access

	display: EDK_DISPLAY
			-- Return the display used for displaying Windows.
		once
			create {EDK_DISPLAY_DESKTOP} Result
		end

end
