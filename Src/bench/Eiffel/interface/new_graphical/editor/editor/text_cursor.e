indexing
	description	: " Objects that represent the cursor of an %
				  % editor window "
	author		: "Christophe Bonnard  / Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	TEXT_CURSOR

inherit
	CURSOR

create
	make_from_absolute_pos

feature -- Initialization

	make_from_absolute_pos (x, y : INTEGER; a_text: STRUCTURED_TEXT) is
		require
			a_text_valid: a_text /= Void
			x_valid: x >= 0
			y_valid: y >= 0
		do
			whole_text := a_text
			set_y_in_lines (y)
			set_x_in_pixels (x)
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

	set_current_char (a_token: EDITOR_TOKEN; a_position: INTEGER) is
			-- Make `a_token' be the new value for `token'.
			-- Set the value of `pos_in_token' to `a_position'.
			-- Update `x_in_pixels' accordingly.
		require
			token_not_void: a_token /= Void
			a_position_positive_not_null: a_position >= 0
		local
			current_width: INTEGER
			current_token: EDITOR_TOKEN
		do
				-- update the attributes.
			token := a_token
			pos_in_token := a_position
			
				-- Compute the size of the current token.
			current_width := a_token.get_substring_width(a_position)

				-- Rewind the tokens of the line to get
				-- the width of each one.
			from
				current_token := a_token.previous
			until
				current_token.previous = Void
			loop
				current_width := current_width + current_token.width
			end

				-- Update the value of `x_in_pixels'
			x_in_pixels := current_width
		end

	set_x_in_pixels (x: INTEGER) is
			-- Make `x' be the new value of `x_in_pixels'.
		require
			x_valid: x >= 0
		do
				-- Update the attribute.
			x_in_pixels := x

				-- Update the current token and the
				-- the position in it
			update_current_char
		end

	set_y_in_lines (y: INTEGER) is
			-- Make `y' be the new value of `y_in_lines'.
			-- Change `line' accordingly.
		require
			y_valid: y >= 0
		do
			y_in_lines := y

				-- update the line attribute
			whole_text.go_i_th(y)
			line := whole_text.current_line
			update_current_char
		end

feature -- Cursor movement

	go_right_char is
			-- Go to next character.
		do
			if pos_in_token = token.length then
					-- Go to next token, first character.
				if token.next = Void then
						-- No next token? Go to next line.
					set_line_to_next
					set_current_char (line.first_token, 1)
				else
					set_current_char (token.next, 1)
				end
			else
					set_current_char (token, pos_in_token + 1)
			end
		end

	go_left_char is
			-- Go to previous character.
		do
			if pos_in_token = 1 then
					-- Go to previous token, last character.
				if token.previous = Void then
						-- No previous token? Go to previous line.
					set_line_to_previous
					set_current_char (line.end_token, line.end_token.length)
				else
					set_current_char (token.previous, token.previous.length)
				end
			else
					set_current_char (token, pos_in_token - 1)
			end
		end

	go_up_line is
		do
			set_line_to_next
			update_current_char
		end

	go_down_line is
		do
			set_line_to_previous
			update_current_char
		end

	go_start_line is
		do
			set_current_char (line.first_token, 1)
		end

	go_end_line is
		do
			set_current_char (line.end_token, line.end_token.length)
		end

feature -- Transformation

	insert_char (c: CHARACTER) is
		do
		end

	delete_char is
		do
		end

	replace_char (c: CHARACTER) is
		do
		end

	delete_previous is
		do
			go_left_char
			delete_char
		end

	insert_eol is
		local
			s: STRING
		do
			
		end

feature {NONE} -- Implementation

	set_line_to_next is
			-- Make `line.next' the new value of `line'.
			-- Change `y_in_lines' accordingly.
		do
			line := line.next
			y_in_lines := y_in_lines + 1
			update_current_char
		end

	set_line_to_previous is
			-- Make `line.previous' the new value of `line'.
			-- Change `y_in_lines' accordingly.
		do
			line := line.previous
			y_in_lines := y_in_lines - 1
			update_current_char
		end

	update_current_char is
			-- Update the current token and the the position in it.
		local
			current_x: INTEGER
			current_token: EDITOR_TOKEN
			x_in_token: INTEGER
		do
				-- Update the current token.
			from
				current_token := line.first_token
				current_x := 0
			until
				current_x >= x_in_pixels
			loop
					-- Compute where we are in pixels.
				current_x := current_x + current_token.width

					-- Prepare next iteration.
				current_token := current_token.next
			end

			if current_x = x_in_pixels then
					-- We are lucky. The cursor is situated at the
					-- beggining of a token
				pos_in_token := 1
				token := current_token
			else
					-- we are too far, so the good token is the
					-- previous one, we have to look into it.
				token := current_token.previous
					-- rewind our pixel position
				current_x := current_x - token.width
				x_in_token := x_in_pixels - current_x

					-- Now retrieve the position inside the token.
				pos_in_token := token.retrieve_position_by_width(x_in_token)
			end
		end

	whole_text: STRUCTURED_TEXT
		-- Whole text displayed.

invariant
	x_in_pixels_positive_or_null	: x_in_pixels >= 0
	y_in_lines_positive_or_null		: y_in_lines >= 0
	whole_text_not_void				: whole_text /= Void

end -- class TEXT_CURSOR
