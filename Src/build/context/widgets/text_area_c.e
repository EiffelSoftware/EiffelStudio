indexing
	description: "Context that represents a text area (EV_TEXT_AREA)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_AREA_C

inherit
	TEXT_COMPONENT_C
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
			Result := context_catalog.text_page.text_area_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Text_area")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_TEXT_AREA"
		end

	full_type_name: STRING is
		do
			Result := "Text area"
		end

feature -- Implementation

	gui_object: EV_TEXT_AREA

end -- class TEXT_AREA_C

