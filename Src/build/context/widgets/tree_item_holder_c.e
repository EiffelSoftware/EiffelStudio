indexing
	description: "Context that represents a tree item holder (EV_TREE_ITEM_CONTAINER)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TREE_ITEM_HOLDER_C

inherit
	CONTEXT
		undefine
			create_context,
			set_modified_flags,
			reset_modified_flags,
			is_able_to_be_grouped
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
			tree_element.add_pnd_command (Pnd_types.tree_item_type, rcmd, Void)
--			create rcmd.make (~process_context)
--			gui_object.add_pnd_command (Pnd_types.context_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			tree_element.remove_pnd_commands (Pnd_types.tree_item_type)
--			gui_object.remove_pnd_commands (Pnd_types.context_type)
		end

feature -- Implementation

	gui_object: EV_TREE_ITEM_HOLDER

end -- class TREE_ITEM_HOLDER_C

