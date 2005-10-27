indexing
	description: "Objects that represent a redo command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_REDO_COMMAND

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
		do
			components := a_components
			make
			set_tooltip ("Redo")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_redo)
			set_name ("Redo")
			set_menu_name ("Redo")
			add_agent (agent execute)
				-- Now add an accelerator for `Current'.
			set_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_y),
				True, False, False))
		end

feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result :=  components.history.current_position < components.history.command_list.count
		end

feature -- Basic operations

		execute is
				-- Execute `Current'.
			do
				components.object_editors.force_name_change_completion_on_all_editors
				if executable then
					components.history.redo
					components.commands.update
				end
			end

end -- class GB_REDO_COMMAND
