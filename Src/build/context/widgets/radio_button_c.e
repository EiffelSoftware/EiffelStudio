indexing
	description: "Context that represents a radio button (EV_RADIO_BUTTON)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_C

inherit
	CHECK_BUTTON_C
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
			Result := context_catalog.primitive_page.radio_b_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Radio button")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_RADIO_BUTTON"

	full_type_name: STRING is "Radio button"

feature -- Implementation

	gui_object: EV_RADIO_BUTTON

end -- class RADIO_BUTTON_C

