indexing
	description: "Objects that display the widget structure built by the user."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DISPLAY_WINDOW

inherit
	
	EV_DIALOG
		redefine
			initialize
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_COMMAND_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_ICONABLE_TOOL
		undefine
			default_create, copy
		end

feature -- Initialization

	initialize is
			-- Initalize `Current'.
		do
			Precursor {EV_DIALOG}
			set_title (gb_display_window_title)
				-- Set up cancel actions on `Current'.
			fake_cancel_button (Current, agent show_hide_display_window_command.execute)			
			set_icon_pixmap (icon)
		end
		
feature -- Access

	icon: EV_PIXMAP is
			-- Icon displayed in title of `Current'.
		once
			Result := (create {GB_SHARED_PIXMAPS}).Icon_display_window @ 1
		end

end -- class GB_DISPLAY_WINDOW
