indexing
	description: "Objects that ..."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_INSERT_COMMAND

inherit
	UNDO_COMMAND

create
	make_from_string

feature -- Initialization

	make_from_string (c: TEXT_CURSOR; s: STRING; w: CHILD_WINDOW) is
		do
			y_start := c.y_in_lines
			x_start := c.x_in_characters
			message := s
			chwin := w
		end

feature -- Access

	message: STRING

	y_start: INTEGER

	x_start: INTEGER

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	extend (c: CHARACTER) is
		do
			message.extend (c)
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	undo is
		local
			cur: TEXT_CURSOR
		do
			cur := chwin.cursor
			cur.make_from_character_pos (x_start, y_start, chwin)
			cur.delete_n_chars (message.count)
		end

	redo is
		local
			cur: TEXT_CURSOR
		do
			cur := chwin.cursor
			cur.make_from_character_pos (x_start, y_start, chwin)
			cur.insert_string (message)
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	chwin : CHILD_WINDOW

invariant
	invariant_clause: -- Your invariant here

end -- class UNDO_INSERT_COMMAND
