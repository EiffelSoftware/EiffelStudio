indexing
	description: "Context that represents a horizontal separator (EV_HORIZONTAL_SEPARATOR)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SEPARATOR_C

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
			Result := context_catalog.primitive_page.hseparator_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Horizontal_separator")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_HORIZONTAL_SEPARATOR"

	full_type_name: STRING is "Horizontal separator"

feature -- Implementation

	gui_object: EV_HORIZONTAL_SEPARATOR

end -- class HORIZONTAL_SEPARATOR_C

