indexing
	description: "Context that represents menu item (EV_MENU_ITEM)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_ITEM_C

inherit
	ITEM_C
		redefine
			gui_object,
			create_context
		end

	MENU_ITEM_HOLDER_C
		undefine
			create_context,
			set_modified_flags,
			reset_modified_flags
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
			Result := context_catalog.menu_page.menu_item_type
		end

feature -- Context creation

	create_context (a_parent: MENU_ITEM_HOLDER_C): like Current is
			-- Create a context of the same type.
		do
			Result ?= {ITEM_C} Precursor (a_parent)
			a_parent.append (Result)
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_MENU_ITEM_HOLDER) is
		do
			create gui_object.make (a_parent)
		end

feature -- Status report

	shown: BOOLEAN is
		do
--			Result := gui_object.parent /= Void
		end

feature -- Status setting

	show is
		local
			a_tree_item: MENU_ITEM_HOLDER_C
		do
--			a_tree_item ?= parent
--			gui_object.set_parent (a_tree_item.gui_object)
		end

	hide is
		do
--			gui_object.set_parent (Void)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Menu_item")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_MENU_ITEM"
		end

	full_type_name: STRING is
		do
			Result := "Menu item"
		end

feature -- Implementation

	gui_object: EV_MENU_ITEM

end -- class MENU_ITEM_C

