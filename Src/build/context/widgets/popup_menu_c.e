indexing
	description: "Context that represents a popup menu (EV_POPUP_MENU)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POPUP_MENU_C

inherit
	MENU_ITEM_HOLDER_C
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
			Result := context_catalog.menu_page.popup_menu_type
		end

	data_type: EV_PND_TYPE is
		do
			Result := Pnd_types.widget_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

	add_gui_callbacks is
		do
			add_pnd_callbacks
		end

	remove_gui_callbacks is
		do
			remove_pnd_callbacks
		end

	copy_attributes (other: like Current) is
		do
		end

feature -- Status setting

	shown: BOOLEAN is
		do
			Result := False
		end

	hide is
		do
		end

	show is
		do
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Popup_menu")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_POPUP_MENU"
		end

	full_type_name: STRING is
		do
			Result := "Popup menu"
		end

feature -- Implementation

	gui_object: EV_POPUP_MENU

end -- class POPUP_MENU_C

