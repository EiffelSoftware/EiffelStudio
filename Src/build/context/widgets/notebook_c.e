indexing
	description: "Context that represents a notebook (EV_NOTEBOOK)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NOTEBOOK_C

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
			Result := context_catalog.container_page.notebook_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Notebook")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_NOTEBOOK"

	full_type_name: STRING is "Notebook"

feature -- Implementation

	gui_object: EV_NOTEBOOK

end -- class NOTEBOOK_C

