indexing
	description: "Objects that represent a save command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GENERATION_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_ACCESSIBLE_COMMAND_HANDLER
	
	GB_ACCESSIBLE_XML_HANDLER
	
	GB_ACCESSIBLE_SYSTEM_STATUS
	
	GB_ACCESSIBLE_OBJECT_EDITOR

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Generate code")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_code_generation)
			set_name ("generate code")
			set_menu_name ("generate code")
			disable_sensitive
			add_agent (agent execute)

				-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_g)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end
		
feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := system_status.project_open
		end

feature -- Basic operations
	
	execute is
				-- Execute `Current'.
		local
			dialog: GB_CODE_GENERATION_DIALOG
		do
			create dialog.make_default
			dialog.show_relative_to_window (system_status.main_window)
			dialog.start_generation
			
				-- The dialog is relative to the window until
				-- complete, whenit is replaced with a modal dialog.
				-- This was deemed the best solution, as if we did not convert
				-- to a modal dialog, the dialog may be dissapear before a
				-- user would ever see it. This is not good, and the behaviour
				-- here is an attempt to combat this problem.
			dialog.hide
			dialog.show_completion
			dialog.show_modal_to_window (system_status.main_window)
		end

end -- class GB_GENERATION_COMMAND
