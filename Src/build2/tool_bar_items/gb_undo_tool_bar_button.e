indexing
	description: "Objects that represent an undo button on the toolbar."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_UNDO_TOOL_BAR_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		undefine
			is_in_default_state
		redefine
			initialize
		end
		
	GB_DEFAULT_STATE
	
	GB_ACCESSIBLE_OBJECT_HANDLER
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_OBJECT_EDITOR
		undefine
			default_create, copy, is_equal
		end
		
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy
		end
		
	GB_ACCESSIBLE_HISTORY
		undefine
			default_create, copy, is_equal
		end

feature -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Set pixmap and connect agents.
		do
			Precursor {EV_TOOL_BAR_BUTTON}
			set_pixmap ((create {GB_SHARED_PIXMAPS}).icon_undo @ 1)
			set_tooltip ("Undo")
			select_actions.extend (agent history.undo)
			history.set_undo_button (Current)
		end

end -- class GB_HISTORY_TOOL_BAR_BUTTON