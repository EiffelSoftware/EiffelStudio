indexing
	description: "Context that represents a list item (EV_LIST_ITEM)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_ITEM_C

inherit
	ITEM_C
		redefine
			gui_object,
			create_context
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_page.list_item_type
		end

feature -- Context creation

	create_context (a_parent: LIST_C): like Current is
			-- Create a context of the same type.
		do
			Result ?= {ITEM_C} Precursor (a_parent)
			a_parent.append (Result)
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_LIST) is
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
			a_list: LIST_C
		do
			a_list ?= parent
			gui_object.set_parent (a_list.gui_object)
		end

	hide is
		do
			gui_object.set_parent (Void)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("List_item")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_LIST_ITEM"

	full_type_name: STRING is "List item"

feature -- Implementation

	gui_object: EV_LIST_ITEM

end -- class LIST_ITEM_C

