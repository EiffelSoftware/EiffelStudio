indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REPLACE_COMMAND

inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end

create
	make_from_strings

feature -- Initialization

	make_from_string (c: CURSOR, s1,s2: STRING; w: CHILD_WINDOW) is
		do
			y_start := c.y_in_lines
			x_start := c.x_in_characters
			message := s
			chwin := w
		end

feature -- Access

	old_message: STRING

	new_message: STRING

	y_start: INTEGER

	x_start: INTEGER

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	extend_old (c: CHARACTER) is
		do
			old_message.extend (c)
		end

	extend_new (c: CHARACTER) is
		do
			new_message.extend (c)
		end

	prepend_old  (c: CHARACTER) is
		do
			old_message.prepend_char (c)
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	undo is
		do
			create cur.make_from_character_pos (x_start, y_start, chwin)
			cur.delete_n_chars (new_message.count)
			cur.insert (old_message)
		end

	redo is
		do
			create cur.make_from_character_pos (x_start, y_start, chwin)
			cur.delete_n_chars (old_message.count)
			cur.insert (new_message)
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	chwin : CHILD_WINDOW

invariant
	invariant_clause: -- Your invariant here

end -- class UNDO_REPLACE_COMMAND
