indexing
	description: "Context that represents a password field (EV_PASSWORD_FIELD)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PASSWORD_FIELD_C

inherit
	TEXT_FIELD_C
		redefine
			gui_object,
			symbol, type,
			namer, eiffel_type, full_type_name
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_page.passwd_field_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Password_field")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_PASSWORD_FIELD"

	full_type_name: STRING is "Password field"


feature -- Implementation

	gui_object: EV_PASSWORD_FIELD

end -- class PASSWORD_FIELD_C

