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
		
	GB_SHARED_COMMAND_HANDLER
	
	GB_SHARED_XML_HANDLER
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_SHARED_TOOLS
	
	GB_SHARED_OBJECT_EDITORS

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
			set_menu_name ("Generate code")
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
			sensitive_i: EV_SENSITIVE_I
			sensitive: EV_SENSITIVE
		do
				-- Disable all other floating windows.
				-- Note that we cannot perform the following:
				-- all_floating_tools.do_all (agent {EV_DIALOG}.disable_sensitive)
				-- because, doing this means, that when we generate the code, a query to
				-- the interface, will return that the window for the display window is
				-- not sensitive. So, here we have to go through the _I, so that the code
				-- generator handles this correctly, and we do not effect the status
				-- when queried from the display window.
	
			from
				all_floating_tools.start
			until
				all_floating_tools.off
			loop
				sensitive ?= all_floating_tools.item
				check
					floating_tool_is_sensitive: sensitive /= Void
				end
				sensitive_i ?= sensitive.implementation
				
				sensitive_i.disable_sensitive
				all_floating_tools.forth
			end
			create dialog.make_default
			dialog.show_modal_to_window (main_window)
			from
				all_floating_tools.start
			until
				all_floating_tools.off
			loop
				sensitive ?= all_floating_tools.item
				check
					floating_tool_is_sensitive: sensitive /= Void
				end
				sensitive_i ?= sensitive.implementation
				
				sensitive_i.enable_sensitive
				all_floating_tools.forth
			end
		end

	dialog: GB_CODE_GENERATION_DIALOG
		-- Displays generation output.

end -- class GB_GENERATION_COMMAND
