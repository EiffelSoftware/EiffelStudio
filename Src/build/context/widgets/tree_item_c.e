indexing
	description: "Context that represents a tree item (EV_TREE_ITEM)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_ITEM_C

inherit
	ITEM_C
		redefine
			gui_object,
			create_context
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
			Result := context_catalog.text_page.tree_item_type
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
			create gui_object.make (a_parent)
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

