indexing
	description	: "Objects that represent the cursor of an editor window "
	author		: "Christophe Bonnard  / Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	TEXT_CURSOR

inherit
	CURSOR
		redefine
			is_equal
		end

	COMPARABLE
		redefine
			is_equal
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		redefine
			is_equal
		end

create
	make_from_absolute_pos, make_from_relative_pos

feature -- Initialization

	make_from_absolute_pos (x, y : INTEGER; a_window: CHILD_WINDOW) is
			-- Create a cursor in `a_window', at position given by
			-- `x' (in pixels) and `y' (in lines).
		require
			a_window_valid: a_window /= Void
			x_valid: x >= 0
			y_valid: y >= 1
		do
			associated_window := a_window
			whole_text := a_window.text_displayed
			set_y_in_lines (y)
			set_x_in_pixels (x)
		end

	make_from_relative_pos (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN;
				pos: INTEGER; a_window: CHILD_WINDOW) is
			-- Create a cursor in `a_window', at position given by
			-- `a_line', `a_token' and `pos'.
		do
			associated_window := a_window
			whole_text := a_window.text_displayed
			set_line (a_line)
			set_current_char (a_token, pos)
		end

	make_from_character_pos (ch_num, y: INTEGER; a_window: CHILD_WINDOW) is
			-- Create a cursor in `a_window', at the `ch_num'th
			-- character in line `y'.
		require
			a_window_valid: a_window /= Void
			ch_num_valid: ch_num >= 1
			y_valid: y >= 1
		do
			associated_window := a_window
			whole_text := a_window.text_displayed
			set_y_in_lines (y)
			set_x_in_characters (ch_num)
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
			--| (Caution! Unlike all others, this attribute is 0-based.)

	y_in_lines: INTEGER
			-- Line number of Current in the whole text

		--| Character-based position

	x_in_characters: INTEGER is
			-- Horizontal position of Current, in characters.
		local
			current_token : EDITOR_TOKEN
		do
			Result := pos_in_token
			from
				current_token := token.previous
			until
				current_token = Void
			loop
				Result := Result + current_token.length
				current_token := current_token.previous
			end
		end

feature -- Element change

	set_line (a_line: EDITOR_LINE) is
			-- Make `a_line' the new value of `line'.
		require
			a_line_exists: a_line /= Void
		do
			line := a_line
			y_in_lines := line.index
			update_current_char
		end

	set_current_char (a_token: EDITOR_TOKEN; a_position: INTEGER) is
			-- Make `a_token' be the new value for `token'.
			-- Set the value of `pos_in_token' to `a_position'.
			-- Update `x_in_pixels' accordingly.
		require
			a_token_exists: a_token /= Void
			a_position_positive_not_null: a_position >= 0
		local
			current_width: INTEGER
			current_token: EDITOR_TOKEN
		do
				-- Update the attributes.
			token := a_token
			pos_in_token := a_position
			
				-- Compute the size of the current token.
			current_width := a_token.get_substring_width (a_position - 1)

				-- Rewind the tokens of the line to get
				-- the width of each one.
			from
				current_token := a_token.previous
			until
				current_token = Void
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
				-- the position in it.
			update_current_char
		end

	set_y_in_lines (y: INTEGER) is
			-- Make `y' be the new value of `y_in_lines'.
			-- Change `line' accordingly.
		require
			y_valid: y >= 1
		do
			y_in_lines := y

				-- Update the line attribute.
			whole_text.go_i_th (y)
			line := whole_text.item
			update_current_char
		end

	set_x_in_characters (x_in_ch: INTEGER) is
			-- Set attributes so that `x_in_characters' return `x_in_ch'.
		require
			x_in_ch_valid: x_in_ch >= 1
		local
			current_x: INTEGER
			current_token: EDITOR_TOKEN
			remaining_ch: INTEGER
		do
				-- Update the current token.
			from
				current_token := line.first_token
				current_x := 0
				remaining_ch := x_in_ch
			until
				current_token = Void or else remaining_ch <= current_token.length
			loop
					-- Compute where we are in pixels.
				current_x := current_x + current_token.width

					-- Compute where we are in characters.
				remaining_ch := remaining_ch - current_token.length

					-- Prepare next iteration.
				current_token := current_token.next
			end
			check
				before_goal: remaining_ch > 0
			end
			if current_token /= Void then
					-- We stopped in a token. Now we look in the token. 
				token := current_token
				pos_in_token := remaining_ch

					-- Now retrieve position in pixels
				x_in_pixels := current_x + token.get_substring_width (remaining_ch - 1)
			else
					-- The cursor is further than the end of the line, so
					-- we set the current token to the last of the line.
				token := line.eol_token
				pos_in_token := 1
				x_in_pixels := current_x
			end
		end

feature -- Cursor movement

	go_right_char is
			-- Move to next character, if there is one.
		do
			if pos_in_token = token.length then
					-- Go to next token, first character.
				if token.next = Void then
						-- No next token? Go to next line.
					if line.next /= Void then
						set_line_to_next
						set_current_char (line.first_token, 1)
					end
				else
					set_current_char (token.next, 1)
				end
			else
					set_current_char (token, pos_in_token + 1)
			end
		end

	go_left_char is
			-- Move to previous character, if there is one.
		do
			if pos_in_token = 1 then
					-- Go to previous token, last character.
				if token.previous = Void then
						-- No previous token? Go to previous line.
					if line.previous /= Void then
						set_line_to_previous
						set_current_char (line.eol_token, line.eol_token.length)
					end
				else
					set_current_char (token.previous, token.previous.length)
				end
			else
					set_current_char (token, pos_in_token - 1)
			end
		end

	go_up_line is
			-- Move up one line (to preceding line), if possible.
		do
			set_line_to_previous
			update_current_char
		end

	go_down_line is
			-- Move down one line (to next line), if possible.
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
			set_current_char (line.eol_token, line.eol_token.length)
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := (y_in_lines < other.y_in_lines) or else (x_in_pixels < other.x_in_pixels)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is Current equal to `other'?
		do
			Result := (y_in_lines = other.y_in_lines) and then (x_in_pixels = other.x_in_pixels)
		end

feature -- Transformation

	insert_char (c: CHARACTER) is
			-- Insert `c' in text, at Current position.
		local
			t_before, t_after: EDITOR_TOKEN
			s: STRING
		do
			if c = '%N' then
				insert_eol
			else
					--| Update x_in_pixels, for retrieving cursor position later.
				update_x_in_pixels
					--| Add `c' in token image.
				if token = line.eol_token then
					s := c.out
				else
					s := clone (token.image)
					s.insert (c.out, pos_in_token)
				end
					--| As a simple insertion can change the whole line,
					--| We are obliged to retrieve previous and following
					--| tokens.
				from
					t_before := token.previous
				until
					t_before = Void
				loop
					s.prepend (t_before.image)
					t_before := t_before.previous
				end
				if token.next /= Void then
					from
						t_after := token.next
					until
						t_after = line.eol_token
					loop
						s.append (t_after.image)
						t_after := t_after.next
					end
				end
					--| New line parsing.
				whole_text.lexer.execute (s)
				line.make_from_lexer (whole_text.lexer)
					--| Cursor update.
				update_current_char
				go_right_char
			end
		end

	insert_string (s: STRING) is
			-- Insert `s' in text, at Current position.
		require
			s_valid: s /= Void and then not s.empty
		local
			first_image, last_image, aux: STRING
			t: EDITOR_TOKEN
			cline, new_line: EDITOR_LINE
			i,j : INTEGER
		do
			update_x_in_pixels
			aux := clone (s)
			aux.prune_all ('%R')
			if token = line.eol_token then
				first_image := line.image
				last_image := ""
			else
					--| Building `first_image', i.e. line part before Current.
				first_image := token.image.substring (1, pos_in_token - 1)
				from
					t := token.previous
				until
					t = Void
				loop
					first_image.prepend (t.image)
					t := t.previous
				end

					--| Building `last_image', i.e. line part after Current.
				last_image := token.image.substring (pos_in_token, token.length)
				from
					t := token.next
				until
					t = line.eol_token
				loop
					s.append (t.image)
					t := t.next
				end
			end
			i := aux.index_of ('%N', 1)
			if i = 0 then
						-- No eol insertion.
					whole_text.lexer.execute (first_image + aux + last_image)
					line.make_from_lexer (whole_text.lexer)
			else
				whole_text.lexer.execute (first_image + aux.substring (1, i-1))
				line.make_from_lexer (whole_text.lexer)
				from
					cline := line
					j := aux.index_of ('%N', i+1)
				until
					j = 0
				loop
					whole_text.lexer.execute (aux.substring (i+1, j-1))
					create new_line.make_from_lexer (whole_text.lexer)
					cline.add_right (new_line)
					cline := new_line
					i := j
				end
				whole_text.lexer.execute (aux.substring (i+1, aux.count) + last_image)
				create new_line.make_from_lexer (whole_text.lexer)
				cline.add_right (new_line)	
			end
			update_current_char
		end

	delete_char is
		local
			t_before, t_after: EDITOR_TOKEN
			s: STRING
		do
			update_x_in_pixels
			if token = line.eol_token then
				s := line.image + line.next.image
				line.next.delete
				whole_text.lexer.execute (s)
				line.make_from_lexer (whole_text.lexer)
			else
				s := clone (token.image)
				s.remove (pos_in_token)
				from
					t_before := token.previous
				until
					t_before = Void
				loop
					s.prepend (t_before.image)
					t_before := t_before.previous
				end
				check
					not_on_eol: token.next /= Void
				end
				from
					t_after := token.next
				until
					t_after = line.eol_token
				loop
					s.append (t_after.image)
					t_after := t_after.next
				end
				whole_text.lexer.execute (s)
				line.make_from_lexer (whole_text.lexer)
			end
			update_current_char				
		end

	delete_n_chars (n: INTEGER) is
		require
				n_big_enough: n > 0
		local
			s, aux: STRING
			cline: EDITOR_LINE
			t : EDITOR_TOKEN
			pos : INTEGER
		do
				--| Retrieving line before Current.
			t := token
			if t /= line.eol_token then
				from
					s := t.image.substring (1, pos_in_token - 1)
					t := t.previous
				until
					t = Void
				loop
					s.prepend (t.image)
					t := t.previous
				end
			else
				s := line.image
			end
				--| Computing last position (given by `cline', `t', `pos').
				--| Erase lines as they are completely scanned
				--| (except first and last line, of course).
			cline := line
			t := token
			if token.length <= pos_in_token + n then
					--| All the characters to erase are in the same token.
				pos := pos_in_token + n
			else
				from
					pos := n - token.length + pos_in_token
					t := token.next
					if t = Void and then cline.next /= Void then
							--| No next token? go to next line, if possible.
						cline := cline.next
						t := cline.first_token
					end
				until
					pos <= t.length or else t = Void
				loop
					pos := pos - t.length
					t := t.next
					if t = Void and then cline.next /= Void then
							--| No next token? go to next line, if possible.
						cline := cline.next
						if cline.previous /= line then
								--| Delete unwanted line.
							cline.previous.delete
						end
						t := cline.first_token
					end
				end
			end	
				--| Retrieving line after last position (given by `cline', `t', `pos').
			if t /= Void and then t /= line.eol_token then
				from
					s.append (t.image.substring (pos, t.image.count))
					t := t.next
				until
					t = line.eol_token
				loop
					s.append (t.image)
					t := t.next
				end
			end
				-- Removing last line, if different from first.
			if cline /= line then
				cline.delete
			end
				-- Rebuild line with previously collected parts.
			whole_text.lexer.execute (s)
			line.make_from_lexer (whole_text.lexer)
			update_current_char
		end

	replace_char (c: CHARACTER) is
		local
			s: STRING
			t_before, t_after: EDITOR_TOKEN
		do
			if c = '%N' then
				insert_eol
			elseif token = line.eol_token then
					s := line.image + c.out
					whole_text.lexer.execute (s)
					line.make_from_lexer (whole_text.lexer)
					set_current_char (line.eol_token, line.eol_token.length)
			else
				update_x_in_pixels
				s := clone (token.image)
				s.put (c, pos_in_token)
				from
					t_before := token.previous
				until
					t_before = Void
				loop
					s.prepend (t_before.image)
					t_before := t_before.previous
				end
				check
					not_on_eol: token.next /= Void
				end
				from
					t_after := token.next
				until
					t_after = line.eol_token
				loop
					s.append (t_after.image)
					t_after := t_after.next
				end
				whole_text.lexer.execute (s)
				line.make_from_lexer (whole_text.lexer)
				update_current_char
				go_right_char
			end
		end

	delete_previous is
		do
			if (line.previous /= Void) or else (token.previous /= Void)
					or else (pos_in_token > 1) then
				go_left_char
				delete_char
			end
		end


	insert_eol is
		local
			t_image, s: STRING
			i_t: EDITOR_TOKEN
			new_line : EDITOR_LINE
		do
			if token = line.eol_token then
				update_x_in_pixels
				create new_line.make_empty_line
				line.add_right (new_line)
			else
				t_image := token.image
				s := t_image.substring (pos_in_token, t_image.count)
				from
					i_t := token.next
				until
					i_t = line.eol_token
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
				line.add_right (new_line)
			end
			go_right_char
		end

	delete_after_cursor is
			-- Erase from cursor (included) to end of line.
		local
			t: EDITOR_TOKEN
			s: STRING
		do
			update_x_in_pixels
			if token /= line.eol_token then
				s := token.image.substring (1, pos_in_token - 1)
				from
					t := token.previous
				until
					t = Void
				loop
					s.prepend (t.image)
					t := t.previous
				end
				whole_text.lexer.execute (s)
				line.make_from_lexer (whole_text.lexer)
			end
			update_current_char
		end

--	delete_before_cursor is
--			-- Erase from beginning of line until cursor (non included).
--		local
--		do
--		end

feature {NONE} -- Implementation

	set_line_to_next is
			-- Make `line.next' the new value of `line'.
			-- Change `y_in_lines' accordingly.
			-- Do not update `pos' and `token',
			-- as it is done at a higher level.
		local
			last_line_displayed: INTEGER
		do
			if line.next /= Void then
				line := line.next
				y_in_lines := y_in_lines + 1

					-- Scroll the window if necessary
				last_line_displayed := associated_window.first_line_displayed
									 + associated_window.number_of_lines_displayed - 1
				if y_in_lines >= last_line_displayed then
					associated_window.on_vertical_scroll (Sb_linedown,0)
				end
			end
		end

	set_line_to_previous is
			-- Make `line.previous' the new value of `line'.
			-- Change `y_in_lines' accordingly.
			-- Do not update `pos' and `token',
			-- as it is done at a higher level.
		do
			if line.previous /= Void then
				line := line.previous
				y_in_lines := y_in_lines - 1

					-- Scroll the window if necessary
				if y_in_lines <= associated_window.first_line_displayed - 1 then
					associated_window.on_vertical_scroll (Sb_lineup,0)
				end
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
				token := line.eol_token
				pos_in_token := 1
			end
		end

	update_x_in_pixels is
			-- Update x_in_pixels from `token' and `pos_in_token'
		local
			current_width: INTEGER
			current_token: EDITOR_TOKEN
		do
				-- Compute the size of the current token.
			current_width := token.get_substring_width(pos_in_token - 1)

				-- Rewind the tokens of the line to get
				-- the width of each one.
			from
				current_token := token.previous
			until
				current_token = Void
			loop
				current_width := current_width + current_token.width
				current_token := current_token.previous
			end

				-- Update the value of `x_in_pixels'
			x_in_pixels := current_width
		end

feature {NONE} -- Private attributes

	whole_text: STRUCTURED_TEXT
		-- Whole text displayed.

	associated_window: CHILD_WINDOW

invariant
	x_in_pixels_positive_or_null	: x_in_pixels >= 0
	y_in_lines_positive_or_null		: y_in_lines >= 0
	pos_in_token_positive			: pos_in_token > 0
	whole_text_not_void				: whole_text /= Void

end -- class TEXT_CURSOR
