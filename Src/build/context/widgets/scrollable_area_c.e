indexing
	description: "Context that represents a scrollable area (EV_SCROLLABLE_AREA)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_AREA_C

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
			Result := context_catalog.container_page.scrollable_area_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Scrollable_area")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_SCROLLABLE_AREA"

	full_type_name: STRING is "Scrollable area"

feature -- Implementation

	gui_object: EV_SCROLLABLE_AREA

end -- class SCROLLABLE_AREA_C

