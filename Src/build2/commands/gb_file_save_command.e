indexing
	description: "Objects that represent a save command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_SAVE_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			components := a_components
			make
			set_tooltip ("Save")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_save)
			set_name ("Save")
			set_menu_name ("Save")
			disable_sensitive
			add_agent (agent execute)

				-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_s)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end

feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := components.system_status.project_open and components.system_status.project_modified
		end

feature -- Basic operations

		execute is
				-- Execute `Current'.
			do
				components.object_editors.force_name_change_completion_on_all_editors
				components.system_status.current_project_settings.save
				components.xml_handler.save
					-- Notify the system that the saved version is now up to date.
				components.system_status.mark_as_dirty
			end

end -- class GB_FILE_SAVE_COMMAND
