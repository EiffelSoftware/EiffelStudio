indexing
	description: "Context that represents a menu holder (EV_MENU_CONTAINER)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MENU_HOLDER_C

inherit
	CONTEXT
		redefine
			gui_object
		end

	HOLDER_C
		redefine
			gui_object
		end

feature {NONE} -- Pick and drop

	add_pnd_callbacks is
		local
			rcmd: EV_ROUTINE_COMMAND
		do
			create rcmd.make (~process_type)
			tree_element.add_pnd_command (Pnd_types.menu_child_type, rcmd, Void)
--			create rcmd.make (~process_context)
--			gui_object.add_pnd_command (Pnd_types.context_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			tree_element.remove_pnd_commands (Pnd_types.menu_child_type)
		end

feature -- Implementation

	gui_object: EV_MENU_HOLDER

end -- class MENU_HOLDER_C

