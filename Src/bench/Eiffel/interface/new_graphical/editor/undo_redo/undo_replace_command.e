indexing
	description: "Objects that ..."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REPLACE_COMMAND

inherit
	UNDO_COMMAND

create
	make_from_strings

feature -- Initialization

	make_from_strings (c: TEXT_CURSOR; s1,s2: STRING; w: CHILD_WINDOW) is
		do
			y_start := c.y_in_lines
			x_start := c.x_in_characters
			old_message := s1
			new_message := s2
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
			old_message.precede (c)
		end

	extend_both (c1, c2: CHARACTER) is
		do
			old_message.extend (c1)
			new_message.extend (c2)
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
				--| Commodite d'ecriture pour "chwin.cursor".
		do
			cur := chwin.cursor
			cur.make_from_character_pos (x_start, y_start, chwin)
			cur.delete_n_chars (new_message.count)
			chwin.set_selection_start (cur)
			cur.insert_string (old_message)
		end

	redo is
		local
			cur: TEXT_CURSOR
				--| Commodite d'ecriture pour "chwin.cursor".
		do
			cur := chwin.cursor
			cur.make_from_character_pos (x_start, y_start, chwin)
			cur.delete_n_chars (old_message.count)
			chwin.set_selection_start (cur)
			cur.insert_string (new_message)
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	chwin : CHILD_WINDOW

invariant
	invariant_clause: -- Your invariant here

end -- class UNDO_REPLACE_COMMAND
