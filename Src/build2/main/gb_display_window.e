indexing
	description: "Objects that display the widget structure built by the user."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DISPLAY_WINDOW

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
			set_title (gb_display_window_title)
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_display_window @ 1)
			close_request_actions.extend (agent (show_hide_display_window_command).execute)
		end

end -- class GB_DISPLAY_WINDOW
