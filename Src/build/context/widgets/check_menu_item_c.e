indexing
	description: "Context that represents a check menu item (EV_CHECK_MENU_ITEM)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_MENU_ITEM_C

inherit
	MENU_ITEM_C
		redefine
			gui_object,
			symbol, type,
			namer, eiffel_type, full_type_name
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_page.check_menu_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Check_menu_item")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_CHECK_MENU_ITEM"
		end

	full_type_name: STRING is
		do
			Result := "Check menu item"
		end

feature -- Implementation

	gui_object: EV_CHECK_MENU_ITEM

end -- class CHECK_MENU_ITEM_C

