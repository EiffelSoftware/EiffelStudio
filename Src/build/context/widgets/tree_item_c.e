indexing
	description: "Context that represents a tree item (EV_TREE_ITEM)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_ITEM_C

inherit
	SIMPLE_ITEM_C
		undefine
			add_pnd_callbacks,
			remove_pnd_callbacks
		redefine
			gui_object,
			create_context
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
			Result := context_catalog.text_page.tree_item_type
		end

	data_type: EV_PND_TYPE is
		do
			Result := Pnd_types.tree_item_type
		end

feature -- Context creation

	create_context (a_parent: TREE_ITEM_HOLDER_C): like Current is
			-- Create a context of the same type.
		do
			Result ?= Precursor (a_parent)
			a_parent.append (Result)
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_TREE_ITEM_HOLDER) is
		do
			create gui_object.make_with_text (a_parent, visual_name)
		end

feature {NONE} -- Pick and drop

	add_pnd_callbacks is
		local
			rcmd: EV_ROUTINE_COMMAND
		do
			{TREE_ITEM_HOLDER_C} Precursor
			create rcmd.make (~process_type)
			gui_object.add_pnd_command (Pnd_types.tree_item_type, rcmd, Void)
--			create rcmd.make (~process_context)
--			gui_object.add_pnd_command (Pnd_types.context_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			{TREE_ITEM_HOLDER_C} Precursor
			gui_object.remove_pnd_commands (Pnd_types.tree_item_type)
--			gui_object.remove_pnd_commands (Pnd_types.context_type)
		end

feature -- Status report

	shown: BOOLEAN is
		do
			Result := gui_object.parent /= Void
		end

feature -- Status setting

	show is
		local
			a_tree_item: TREE_ITEM_HOLDER_C
		do
			a_tree_item ?= parent
			gui_object.set_parent (a_tree_item.gui_object)
		end

	hide is
		do
			gui_object.set_parent (Void)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Tree_item")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_TREE_ITEM"
		end

	full_type_name: STRING is
		do
			Result := "Tree item"
		end

feature -- Implementation

	gui_object: EV_TREE_ITEM

end -- class TREE_ITEM_C

