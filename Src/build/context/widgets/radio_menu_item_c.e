indexing
	description: "Context that represents a radio menu item (EV_RADIO_MENU_ITEM)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_MENU_ITEM_C

inherit
	CHECK_MENU_ITEM_C
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
			Result := context_catalog.menu_page.radio_menu_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Radio_menu_item")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_RADIO_MENU_ITEM"

	full_type_name: STRING is "Radio menu item"

feature -- Implementation

	gui_object: EV_RADIO_MENU_ITEM

end -- class RADIO_MENU_ITEM_C

