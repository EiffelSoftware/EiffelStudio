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
			initialize_transport
		end

	TREE_ITEM_HOLDER_C
		redefine
			gui_object
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_page.tree_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Pick and drop

	initialize_transport is
		local
			routine_cmd: EV_ROUTINE_COMMAND
		do
			{PRIMITIVE_C} Precursor
			create routine_cmd.make (~process_context)
			gui_object.add_pnd_command (Pnd_types.context_type, routine_cmd, Void)
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

