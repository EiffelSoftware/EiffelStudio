indexing
	description: "Objects that represent a generation command."
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
		export
			{NONE} all
		end
	
	GB_SHARED_XML_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

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
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			objects ?= window_selector.objects
			from
				objects.start
			until
				objects.off or titled_window_object /= Void
			loop
				titled_window_object ?= objects.item
				objects.forth
			end
				-- Only executable if there is at least on window within the system.
			Result := system_status.project_open and titled_window_object /= Void
		end

feature -- Basic operations
	
	execute is
				-- Execute `Current'.
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			force_name_change_completion_on_all_editors
			objects := Window_selector.objects
			if not object_handler.objects_all_named (objects) then
				create confirmation_dialog.make_with_text (Not_all_windows_named_string)
				confirmation_dialog.set_icon_pixmap (Icon_build_window @ 1)
				confirmation_dialog.show_modal_to_window (main_window)
				if confirmation_dialog.selected_button.is_equal ("OK") then
					object_handler.add_default_names (objects)
				end
			end
			if object_handler.objects_all_named (objects) then
					-- We check to see if the generation should begin, by the
					-- status of the naming.
				create dialog.make_default
				dialog.show_modal_to_window (main_window)
			end
		end
		
feature {NONE} -- Implementation

	dialog: GB_CODE_GENERATION_DIALOG
		-- Displays generation output.

end -- class GB_GENERATION_COMMAND
