indexing
	description: "Context that represents a tree (EV_TREE)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_C

inherit
	PRIMITIVE_C
		redefine
			gui_object,
			add_pnd_callbacks,
			remove_pnd_callbacks
		end

	TREE_ITEM_HOLDER_C
		redefine
			gui_object,
			add_pnd_callbacks,
			remove_pnd_callbacks
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.text_page.tree_type
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
			{PRIMITIVE_C} Precursor
			{TREE_ITEM_HOLDER_C} Precursor
			create rcmd.make (~process_type)
			gui_object.add_pnd_command (Pnd_types.tree_item_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			gui_object.remove_pnd_commands (Pnd_types.tree_item_type)
			{PRIMITIVE_C} Precursor
			{TREE_ITEM_HOLDER_C} Precursor
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Tree")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_TREE"
		end

	full_type_name: STRING is
		do
			Result := "Tree"
		end

feature -- Implementation

	gui_object: EV_TREE

end -- class TREE_C

