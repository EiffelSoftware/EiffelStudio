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
		
	GB_COMMAND_HANDLER
		undefine
			default_create, copy
		end

feature -- Initialization

	initialize is
			-- Initalize `Current'.
		local
			button: EV_BUTTON
		do
			Precursor {EV_DIALOG}
			set_title (gb_display_window_title)
			
				-- We must now temporarily create a new button, and add it to `Current'
				-- as the default cancel button. We then remove it. This is necessary so
				-- that we have access to the minimize, maximize and close buttons.
				-- Note that we have custom implmentations of EV_DIALOG_IMP, in order to
				-- fire these actions when the button is not visible.
			create button
			extend (button)
			button.select_actions.extend (agent show_hide_display_window_command.disable_selected)--execute)
			set_default_cancel_button (button)
			prune (button)
			
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_display_window @ 1)
		end

end -- class GB_DISPLAY_WINDOW
