indexing
	description: "Context that represents a text area (EV_TEXT)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_C

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

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.text_page.text_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Text")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_TEXT"
		end

	full_type_name: STRING is
		do
			Result := "Text"
		end

feature -- Implementation

	gui_object: EV_TEXT

end -- class TEXT_C

