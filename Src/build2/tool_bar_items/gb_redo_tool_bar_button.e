indexing
	description: "Objects that represent a redo button on the toolbar."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_REDO_TOOL_BAR_BUTTON

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
			default_create, copy
		end

feature -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Set pixmap and connect agents.
		local
			a_pixmap: EV_PIXMAP
			global_history: GLOBAL_HISTORY
		do
			Precursor {EV_TOOL_BAR_BUTTON}
			create a_pixmap
			a_pixmap.set_with_named_file ("D:\EIffel50\bench\bitmaps\ico\icon_redo_color.ico")
			set_pixmap (a_pixmap)
			select_actions.extend (agent history.redo)
			history.set_redo_button (Current)
		end

feature {NONE} -- Implementation

end -- class GB_REDO_TOOL_BAR_BUTTON
