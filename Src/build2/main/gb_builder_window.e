indexing
	description: "Objects that contain the widget structure built by the user%
		%with containers visible."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_BUILDER_WINDOW


inherit
	
	EV_TITLED_WINDOW
		redefine
			initialize
		end
		
	GB_CONSTANTS
		undefine
			default_create, copy, is_equal
		end

feature -- Initialization

	initialize is
			-- Initalize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			set_title (gb_builder_window_title)
		end

end -- class GB_BUILDER_WINDOW
