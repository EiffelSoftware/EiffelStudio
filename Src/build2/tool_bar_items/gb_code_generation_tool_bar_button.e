indexing
	description: "Objects that represent the code generation button on the toolbar."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CODE_GENERATION_TOOL_BAR_BUTTON
	
	--| FIXME, make_into a command.

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
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_SYSTEM_STATUS
		undefine
			default_create, copy
		end
		
feature -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Set pixmap and connect agents.
		do
			Precursor {EV_TOOL_BAR_BUTTON}
			set_pixmap ((create {GB_SHARED_PIXMAPS}).icon_code_generation @ 1)
			set_tooltip ("Code generation")
			select_actions.extend (agent show_generation_dialog)
		end

feature {NONE} -- Implementation

	show_generation_dialog is
			-- Display a dialog to receive the code generation options
			-- from the user.
		local
			dialog: GB_CODE_GENERATION_DIALOG
		do
			create dialog.make_default
			dialog.show_relative_to_window (system_status.main_window)
			dialog.start_generation

			dialog.hide
			dialog.show_completion
			dialog.show_modal_to_window (system_status.main_window)
		end
		
		
	code_generation_dialog: GB_CODE_GENERATION_DIALOG is
			-- `Result' is dialog
		do
			create Result.make_default
		end
		

end -- class GB_CODE_GENERATION_TOOL_BAR_BUTTON