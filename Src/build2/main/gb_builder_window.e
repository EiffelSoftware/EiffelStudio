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
		
	GB_COMMAND_HANDLER
		undefine
			default_create, copy
		end

feature -- Initialization

	initialize is
			-- Initalize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			set_title (gb_builder_window_title)
			close_request_actions.extend (agent (show_hide_builder_window_command).execute)
		end

end -- class GB_BUILDER_WINDOW
