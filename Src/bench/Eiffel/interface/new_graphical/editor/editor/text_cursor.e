indexing
	description	: "Objects that represent the cursor of an editor window "
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
			y_valid: y >= 1
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
				current_token = Void or else current_token.previous = Void
			loop
				current_width := current_width + current_token.width
				current_token := current_token.previous
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
			-- Move to next character.
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
			-- Move to previous character.
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
			-- Move up one line (to preceding line).
		do
			set_line_to_previous
			update_current_char
		end

	go_down_line is
			-- Move down one line (to next line).
		do
			set_line_to_next
			update_current_char
		end

	go_start_line is
			-- Move to beginning of line.
		do
			set_current_char (line.first_token, 1)
		end

	go_end_line is
			-- Move to end of line.
		do
			set_current_char (line.end_token, line.end_token.length)
		end

feature -- Transformation

	insert_char (c: CHARACTER) is
		local
			t_before, t_after: EDITOR_TOKEN
			s: STRING
		do
			if c = '%N' then
				insert_eol (False)
			else
				s := clone (token.image)
				s.insert (c.out, pos_in_token)
				t_before := token.previous
				if (t_before /= Void) then
					s.prepend (t_before.image)
					t_before := t_before.previous
				end
				t_after := token.next
				if (t_after /= line.end_token) then
					s.append (t_after.image)
					t_after := t_after.next
				end
				whole_text.lexer.execute (s)
				if t_before = Void then
					line.replace_beginning_from_lexer (whole_text.lexer, t_after)
				else
					line.replace_from_lexer (whole_text.lexer, t_before, t_after)
				end
			end
			update_current_char
			go_right_char
		end

	delete_char is
		local
			t_before, t_after: EDITOR_TOKEN
			s: STRING
		do
			if token = line.end_token then
					line.merge_with_next_line (whole_text.lexer)
			else
				s := clone (token.image)
				s.remove (pos_in_token)
				t_before := token.previous
				if (t_before /= Void) then
					s.prepend (t_before.image)
					t_before := t_before.previous
				end
				t_after := token.next
				if (t_after /= line.end_token) then
					s.append (t_after.image)
					t_after := t_after.next
				end
				whole_text.lexer.execute (s)
				if t_before = Void then
					line.replace_beginning_from_lexer (whole_text.lexer, t_after)
				else
					line.replace_from_lexer (whole_text.lexer, t_before, t_after)
				end
			end
			update_current_char				
		end

	replace_char (c: CHARACTER) is
		local
			s: STRING
			t_before, t_after: EDITOR_TOKEN
		do
			if c = '%N' then
				insert_eol (True)
			else
				s := clone (token.image)
				s.put (c, pos_in_token)
				t_before := token.previous
				if (t_before /= Void) then
					s.prepend (t_before.image)
					t_before := t_before.previous
				end
				t_after := token.next
				if (t_after /= line.end_token) then
					s.append (t_after.image)
					t_after := t_after.next
				end
				whole_text.lexer.execute (s)
				if t_before = Void then
					line.replace_beginning_from_lexer (whole_text.lexer, t_after)
				else
					line.replace_from_lexer (whole_text.lexer, t_before, t_after)
				end
			end
			update_current_char
			go_right_char
		end

	delete_previous is
		do
			go_left_char
			delete_char
		end


	insert_eol (overwrite_current_char : BOOLEAN) is
		local
			t_image, s: STRING
			i_t: EDITOR_TOKEN
			new_line : EDITOR_LINE
		do
			if token = line.end_token then
				create new_line.make_empty_line
			else
				t_image := token.image
				if overwrite_current_char then
					s := t_image.substring (pos_in_token + 1, t_image.count)
				else
					s := t_image.substring (pos_in_token, t_image.count)
				end
				from
					i_t := token.next
				until
					i_t = line.end_token
				loop
					s.append (i_t.image)
					i_t := i_t.next
				end
				check
					s_non_empty: not (s.empty)
				end
				delete_after_cursor
				whole_text.lexer.execute (s)
				create new_line.make_from_lexer (whole_text.lexer)
			end
			line.add_right (new_line)
		end

	delete_after_cursor is
			-- Erase from cursor (included) to end of line.
		local
			t_eol: EDITOR_TOKEN_EOL
			prev_token: EDITOR_TOKEN
			s: STRING
			
		do
			if token /= line.end_token then
				prev_token := token.previous
--				if pos_in_token = 1 then
--					create t_eol.make
--					if prev_token = Void then
--						line.set_first_token (t_eol)
--					else
--						prev_token.set_next (t_eol)
--						t_eol.set_previous (prev_token)
--					end
--					line.set_end_token (t_eol)
--				else
				s := token.image.substring (1, pos_in_token - 1)
				whole_text.lexer.execute (s)
				if prev_token = Void then
					line.replace_beginning_from_lexer (whole_text.lexer, line.end_token)
				else
					line.replace_from_lexer (whole_text.lexer, prev_token, line.end_token)
				end
			end
			update_current_char
		end


feature {NONE} -- Implementation

	set_line_to_next is
			-- Make `line.next' the new value of `line'.
			-- Change `y_in_lines' accordingly.
		do
			if line.next /= Void then
				line := line.next
				y_in_lines := y_in_lines + 1
			end
		end

	set_line_to_previous is
			-- Make `line.previous' the new value of `line'.
			-- Change `y_in_lines' accordingly.
		do
			if line.previous /= Void then
				line := line.previous
				y_in_lines := y_in_lines - 1
			end
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
				current_token = Void or else current_x >= x_in_pixels
			loop
					-- Compute where we are in pixels.
				current_x := current_x + current_token.width

					-- Prepare next iteration.
				current_token := current_token.next
			end

			if current_token /= Void then
				-- The cursor is situated before the end of the line.
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
			else
				-- The cursor is further than the end of the line, so
				-- we set the current token to the last of the line.
				token := line.end_token
				pos_in_token := 1
			end
		end

	whole_text: STRUCTURED_TEXT
		-- Whole text displayed.

invariant
	x_in_pixels_positive_or_null	: x_in_pixels >= 0
	y_in_lines_positive_or_null		: y_in_lines >= 0
	whole_text_not_void				: whole_text /= Void

end -- class TEXT_CURSOR
