indexing
	description: "Context that represents a toggle button (EV_TOGGLE_BUTTON)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_BUTTON_C

inherit
	BUTTON_C
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
			Result := context_catalog.primitive_page.toggle_b_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Toggle button")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_TOGGLE_BUTTON"
		end

	full_type_name: STRING is
		do
			Result := "Toggle button"
		end

feature -- Implementation

	gui_object: EV_TOGGLE_BUTTON

end -- class TOGGLE_BUTTON_C

