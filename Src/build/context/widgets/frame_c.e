indexing
	description: "Context that represents a frame (EV_FRAME)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FRAME_C

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
			Result := context_catalog.container_page.frame_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Frame")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_FRAME"

	full_type_name: STRING is "Frame"

feature -- Implementation

	gui_object: EV_FRAME

end -- class FRAME_C

