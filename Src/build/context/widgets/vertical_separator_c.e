indexing
	description: "Context that represents a vertical separator (EV_VERTICAL_SEPARATOR)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_SEPARATOR_C

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
			Result := context_catalog.primitive_page.vseparator_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Vertical_separator")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_VERTICAL_SEPARATOR"

	full_type_name: STRING is "Vertical separator"

feature -- Implementation

	gui_object: EV_VERTICAL_SEPARATOR

end -- class VERTICAL_SEPARATOR_C

