indexing
	description: "Context that represents a horizontal box."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_BOX_C

inherit
	INVISIBLE_CONTAINER_C
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
			Result := context_catalog.container_page.hbox_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
			gui_object.set_border_width (5)
			gui_object.set_spacing (5)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Horizontal_box")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_HORIZONTAL_BOX"

	full_type_name: STRING is "Horizontal box"

feature -- Implementation

	gui_object: EV_HORIZONTAL_BOX

end -- class HORIZONTAL_BOX_C

