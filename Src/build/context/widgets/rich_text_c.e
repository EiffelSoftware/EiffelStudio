indexing
	description: "Context that represents a rich text (EV_RICH_TEXT)."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	RICH_TEXT_C

inherit
	TEXT_C
		redefine
			type,
			namer,
			eiffel_type,
			full_type_name,
			gui_object
		end

feature -- Type data

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_page.rich_text_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Rich_text")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_RICH_TEXT"
		end

	full_type_name: STRING is
		do
			Result := "Rich text"
		end

feature -- Implementation

	gui_object: EV_RICH_TEXT

end -- class RICH_TEXT_C

