indexing
	description: "Context that represents a list (EV_LIST)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_C

inherit
	PRIMITIVE_C
		redefine
			gui_object,
			add_pnd_callbacks,
			remove_pnd_callbacks
		end

	HOLDER_C
		redefine
			gui_object
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.text_page.list_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Pick and drop

	add_pnd_callbacks is
		local
			rcmd: EV_ROUTINE_COMMAND
		do
			create rcmd.make (~process_type)
			gui_object.add_pnd_command (Pnd_types.list_item_type, rcmd, Void)
			tree_element.add_pnd_command (Pnd_types.list_item_type, rcmd, Void)
--			create rcmd.make (~process_context)
--			gui_object.add_pnd_command (Pnd_types.context_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			gui_object.remove_pnd_commands (Pnd_types.list_item_type)
			tree_element.remove_pnd_commands (Pnd_types.list_item_type)
--			gui_object.remove_pnd_commands (Pnd_types.context_type)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("List")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_LIST"
		end

	full_type_name: STRING is
		do
			Result := "List"
		end

feature -- Implementation

	gui_object: EV_LIST

end -- class LIST_C

