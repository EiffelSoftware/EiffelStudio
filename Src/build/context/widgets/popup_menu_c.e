indexing
	description: "Context that represents a popup menu (EV_POPUP_MENU)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POPUP_MENU_C

inherit
	WIDGET_C
		redefine
			gui_object
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

	symbol_file: FILE_NAME is
		do
			!! Result.make
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
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

