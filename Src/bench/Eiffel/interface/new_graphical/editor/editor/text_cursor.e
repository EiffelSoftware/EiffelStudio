indexing
	description	: " Objects that represents the cursor of an %
				  % editor window "
	author		: "Christophe Bonnard  / Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	TEXT_CURSOR

inherit
	CURSOR

create
	make, make_from_string

feature -- Initialization

	make is
		do
		end

feature -- Access

		--| Relative position

	token: EDITOR_TOKEN
			-- Token where Current is

	pos_in_token: INTEGER
			-- Character (in `token') Current points on

	line: EDITOR_LINE
			-- Line where Current is

		--| Absolute position

	x_in_pixels: INTEGER
			-- Theoric horizontal position of Current, in pixels

	y_in_lines: INTEGER
			-- Line number of Current in the whole text

feature -- Element change

	set_token (t: EDITOR_TOKEN) is
			-- Make `t' be the new value of `token'.
		do
			token := t
		end

	set_pos_in_token (p: INTEGER) is
			-- Set the value of `pos_in_token' to p.
		do
			pos_in_token := t
		end

	set_line (l: EDITOR_LINE) is
			-- Make `l' be the new value of `line'.
		do
			line := l
		end

	set_x_in_pixels (x: INTEGER) is
			-- Make `x' be the new value of `x_in_pixels'.
		do
			x_in_pixels := x
		end

	set_y_in_lines (y: INTEGER) is
			-- Make `y' be the new value of `y_in_lines'.
		do
			y_in_lines := y
		end

feature -- Cursor movement

	go_right_char is
		do
			if pos_in_token = token.length then
					-- Go to next token, first character.
			else
					pos_in_token = pos_in_token - 1
			end
			x_in_pixels := get_x_pixel_from_char (token, pos_in_token)
			y_in_lines := line.index
		end

	go_left_char is
		do
			if pos_in_token = 1 then
					-- Go to previous token, last character.
			else
					pos_in_token = pos_in_token - 1
			end
			x_in_pixels := get_x_pixel_from_char (token, pos_in_token)
			y_in_lines := line.index
		end

	go_up_line is
		do
		end

	go_down_line is
		do
		end

	go_start_line is
		do
		end

	go_end_line is
		do
		end

end -- class TEXT_CURSOR
