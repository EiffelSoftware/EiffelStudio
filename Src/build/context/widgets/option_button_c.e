indexing
	description: "Context that represents an option button (EV_OPTION_BUTTON)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPTION_BUTTON_C

inherit
	BUTTON_C
		redefine
			gui_object,
			symbol, type,
			namer,
			eiffel_type,
			full_type_name
		end

	MENU_HOLDER_C
		undefine
			create_context,
			set_modified_flags,
			reset_modified_flags,
			is_able_to_be_grouped
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
			Result := context_catalog.menu_page.option_b_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Option_button")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_OPTION_BUTTON"
		end

	full_type_name: STRING is
		do
			Result := "Option button"
		end

feature -- Implementation

	gui_object: EV_OPTION_BUTTON

end -- class OPTION_BUTTON_C

