indexing
	description: "Context that represents a button (EV_BUTTON)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON_C

inherit
	PRIMITIVE_C
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
			Result := context_catalog.primitive_page.button_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Button")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_BUTTON"
		end

	full_type_name: STRING is
		do
			Result := "Button"
		end

feature -- Implementation

	gui_object: EV_BUTTON

end -- class BUTTON_C

