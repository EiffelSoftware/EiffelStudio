indexing
	description: "Context that represents a vertical split area (EV_VERTICAL_SPLIT_AREA)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_SPLIT_AREA_C

inherit
	CONTAINER_C
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
			Result := context_catalog.container_page.vsplit_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Vertical_split_area")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_VERTICAL_SPLIT_AREA"

	full_type_name: STRING is "Vertical split area"

feature -- Implementation

	gui_object: EV_VERTICAL_SPLIT_AREA

end -- class VERTICAL_SPLIT_AREA_C

