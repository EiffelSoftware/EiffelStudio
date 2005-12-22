indexing
	description: "Cursor for EIFFEL_EDITOR_LINE"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_EDITOR_CURSOR

inherit
	EDITOR_CURSOR
		redefine
			line,
			text
		end

create
	make_from_relative_pos,
	make_from_character_pos, make_from_integer

feature -- Access

	line: EIFFEL_EDITOR_LINE
			-- Line where `Current' is.

	text: CLICKABLE_TEXT
			-- Text that contains `current'.

end
