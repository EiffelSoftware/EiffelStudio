indexing
	description	: "Objects that represent the cursor of an editor window "
	author		: "Christophe Bonnard  / Arnaud PICHERY / Etienne Amodeo"
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

create
	make_from_relative_pos,
	make_from_character_pos, make_from_integer

feature -- Initialization

	make_from_relative_pos (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN;
				pos: INTEGER; a_text: SELECTABLE_TEXT) is
			-- Create a cursor for `text', at position given by
			-- `a_line', `a_token' and `pos'.
		do
			text := a_text
			line := a_line
			y_in_lines := line.index
			set_current_char (a_token, pos)
		end

	make_from_character_pos (ch_num, y: INTEGER; a_text: SELECTABLE_TEXT) is
			-- Create a cursor for `text', at the `ch_num'th
			-- character in line `y'.
		require
			text_valid: a_text /= Void
			ch_num_valid: ch_num >= 1
			y_valid: y >= 1
		do
			text := a_text
			y_in_lines := y
			line := text.line (y)
			set_x_in_characters (ch_num)
		end

	make_from_integer (ch_num: INTEGER; a_text: SELECTABLE_TEXT) is
			-- Create a cursor in `a_window', at the `ch_num'th
			-- character of the whole text.
		require
			txt_valid: a_text /= Void
			ch_num_valid: ch_num >= 1
		local
			pos: INTEGER
			cline: EDITOR_LINE
			t: EDITOR_TOKEN
			stop: BOOLEAN
		do
			text := a_text
			from
				pos := ch_num
				cline := text.first_line
				t := cline.first_token
			until
				stop or else pos <= t.length
			loop
				pos := pos - t.length
				if t.next = Void then
					if cline.next /= Void then
							--| No next token? go to next line, if possible.
						cline := cline.next
						t := cline.first_token
					else
--! FIXME EA: To detect problem with search & replace...
						debug ("EDITOR") 
							io.error.putstring ("%N EDITOR WARNING: Attempted to move cursor further than end of file.%N")
							io.error.putstring ("   Position: "+ ch_num.out + "   Text length: " + text.text_length.out + "%N")
						end
						stop := True
						pos := 1
					end
				else
					t:= t.next
				end
			end
			check
				token_exists: t /= Void
					-- position in file exists, therefore t exists.
			end
			make_from_relative_pos (cline, t, pos, text)
		end	

feature -- Access

--| Relative position

	token: EDITOR_TOKEN
			-- Token where `Current' is.

	pos_in_token: INTEGER
			-- Character (in `token') Current points on.

	line: EDITOR_LINE
			-- Line where `Current' is.

--| Absolute position

	y_in_lines: INTEGER
			-- Line number of `Current' in the whole text.

	x_in_visible_characters: INTEGER
			-- Position of `Current' in line in characters as
			-- it can be counted by someone who reads the text
			-- i.e. each tabulations is counted as several characters.

	x_in_characters: INTEGER is
			-- Position of `Current' in line in characters as
			-- it can be counted in a file, i.e. each tabulation
			-- is counted as only one character.
		local
			tok: EDITOR_TOKEN
		do
			Result := pos_in_token
			from
				tok := line.first_token
			until
				tok = Void or else tok = token
			loop
				Result := Result + tok.length
				tok := tok.next
			end
		end

	pos_in_text: INTEGER is
			-- Position, given in characters, from the beginning
			-- of the text. Tabulations are counted as one character.
		local
			current_token : EDITOR_TOKEN
			current_line: EDITOR_LINE
		do
			Result := pos_in_token
			from
				current_token := token.previous
				if current_token = Void then
					if line /= Void then
						if line.previous /= Void then
							current_line := line.previous
							current_token := current_line.eol_token
						end
					end
				else
					current_line := line
				end
			until
				current_token = Void
			loop
				Result := Result + current_token.length
				current_token := current_token.previous
				if current_token = Void and then current_line /= Void and then current_line.previous /= Void then
					current_line := current_line.previous
					current_token := current_line.eol_token
				end
			end
		end

--| Other functions

	item: CHARACTER is
			-- Character `Current' points on.
		do
			if token = line.eol_token then
				Result := '%N'
			else
				Result := token.image @ pos_in_token
			end
		end

	pos_in_characters: INTEGER is
			-- Position of Current, in characters from the start of the text.
		local
			a_line: EDITOR_LINE
		do
				--| First, we add the EOL characters
			Result := y_in_lines -1
				--| then we sum the lines
			from
				a_line := text.first_line
			until
				a_line = line
			loop
				--Result := Result + a_line.eol_token.x_in_characters
				Result := Result + a_line.image.count
				a_line := a_line.next
			end
			Result := Result + x_in_characters
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
			current_token: EDITOR_TOKEN
			tab: EDITOR_TOKEN_TABULATION
		do
				-- we are not in the left_margin
				-- Update the attributes.
			token := a_token
			pos_in_token := a_position
			from
				current_token := line.first_token
				x_in_visible_characters := 0
			until
				current_token = Void or else current_token = token
			loop
				x_in_visible_characters := x_in_visible_characters + token_length (current_token, x_in_visible_characters)
				current_token := current_token.next
			end
			tab ?= current_token
			if tab /= Void then
				x_in_visible_characters := x_in_visible_characters + 1 + equivalent_length (x_in_visible_characters, (pos_in_token - 1))
			else
				x_in_visible_characters := x_in_visible_characters + pos_in_token
			end
		end

	equivalent_length (position, tab_number: INTEGER): INTEGER is
			-- Length of a tabulation inserted after `position' in the text
			-- as it would appear to the reader.
		do
			if tab_number > 0 then
				Result := tab_length * tab_number - ((position) \\ tab_length)
			end
		end

	token_length (tok: EDITOR_TOKEN; pos: INTEGER): INTEGER is
			-- Length of token `tok' after `position' in the text
			-- as it would appear to the reader.
		require
			tok_not_void: tok /= Void
		local
			tab: EDITOR_TOKEN_TABULATION
		do
			tab ?= tok
			if tab /= Void then
				Result := equivalent_length (pos, tab.length)
			else
				Result := tok.length
			end
		end

	update_current_char is
			-- Update the current token and the the position in it.
			-- It is required that the cursor is not in the left margin.
		require
			x_in_visible_characters > 0
		local
			i: INTEGER
			current_token: EDITOR_TOKEN
			tab: EDITOR_TOKEN_TABULATION
			remaining_ch: INTEGER
		do
				-- Update the current token.
			from
				current_token := line.first_token
				remaining_ch := x_in_visible_characters
			until
				current_token = Void or else remaining_ch <= token_length (current_token, x_in_visible_characters - remaining_ch)
			loop
					-- Compute where we are in characters.
				remaining_ch := remaining_ch - token_length (current_token, x_in_visible_characters - remaining_ch)

					-- Prepare next iteration.
				current_token := current_token.next
			end
			check
				before_goal: remaining_ch > 0
			end
			if current_token /= Void then
					-- We stopped in a token. Now we look in the token. 
				token := current_token
				tab ?= token
				if tab /= Void then
					from
						i := 1
					until
						remaining_ch <= equivalent_length (x_in_visible_characters - remaining_ch, i)
					loop
						i := i + 1
					end
					pos_in_token := i
				else
					pos_in_token := remaining_ch
				end
			else
					-- The cursor is further than the end of the line, so
					-- we set the current token to the last of the line.
				token := line.eol_token
				pos_in_token := 1
			end
		end

	set_y_in_lines (y: INTEGER) is
			-- Make `y' be the new value of `y_in_lines'.
			-- Change `line' accordingly.
		require
			y_valid: y >= 1
		do
			y_in_lines := y

				-- Update the line attribute.
			line := text.line (y)
			update_current_char
		end

	set_x_in_characters (x_in_ch: INTEGER) is
			-- Set attributes so that `x_in_characters' return `x_in_ch'.
		require
			x_in_ch_valid: x_in_ch >= 1
		local
			x: INTEGER
			tok: EDITOR_TOKEN
		do
			from
				x := x_in_ch
				tok := line.first_token
			until
				tok = Void or else x <= tok.length
			loop
				x := x - tok.length
				tok := tok.next
			end
			if tok /= Void then
				set_current_char (tok, x)
			else
				set_current_char (line.eol_token, 1)
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
						line := line.next
						y_in_lines := y_in_lines + 1
						set_current_char (line.first_token, 1)
					end
				else
					set_current_char (token.next, 1)
				end
			else
				set_current_char (token, pos_in_token + 1)
			end
		end

	go_right_char_no_down_line is
			-- Move to next character, if there is one.
		do
			if pos_in_token = token.length then
					-- Go to next token, first character.
				if token.next /= Void then
					set_current_char (token.next, 1)
				end
			else
				set_current_char (token, pos_in_token + 1)
			end
		end

	go_left_char is
			-- Move to previous character, if there is one.
		local
			previous_token: EDITOR_TOKEN
		do
			if pos_in_token = 1 then
					-- Go to previous token, last character.
				previous_token := token.previous
				if previous_token = Void or else previous_token.is_beginning_token then
						-- No previous token? Go to previous line.
					if line.previous /= Void then
						line := line.previous
						y_in_lines := y_in_lines - 1
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
			if line.previous /= Void then
				set_line (line.previous)
			end
		end

	go_down_line is
			-- Move down one line (to next line), if possible.
		do
			if line.next /= Void then
				set_line (line.next)
			end
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

	go_start_word is
			-- Move to beginning of word.
		local
			image: STRING
			index: INTEGER
		do
			if char_is_blank (item) then
				from
					internal_go_left_char
				until
					(not char_is_blank (item)) or else bound_reached
				loop
					internal_go_left_char
				end
				if not char_is_blank (item) then
					go_right_char
				end
			elseif not char_is_separator (item) then
				image := token.image.mirrored
				if not image.is_empty then
					from
						index := image.count - pos_in_token + 1
					until
						index > image.count or else char_is_separator(image.item(index))
					loop
						index := index + 1
					end

					if index > image.count then
						pos_in_token := 1
					else
						pos_in_token := image.count - index + 2
					end
					set_current_char (token, pos_in_token)
				end
			end
		end

	go_end_word is
			-- Move to end of word.
		local
			image: STRING
			index: INTEGER
		do
			if token /= line.first_token or else pos_in_token /= 1 then
				if char_is_blank (item) then
					internal_go_left_char
					if char_is_blank (item) then
						from
							internal_go_right_char
						until
							(not char_is_blank(item)) or else bound_reached 
						loop
							internal_go_right_char
						end
					else
						internal_go_right_char
					end
				else
					image := token.image
					if not image.is_empty and then pos_in_token /= 1 and then not char_is_separator (image @ (pos_in_token - 1)) then
						from
							index := pos_in_token
						until
							index > image.count or else char_is_separator(image.item(index))
						loop
							index := index + 1
						end
						if index > image.count then
							token := token.next
							pos_in_token := 1
						else
							pos_in_token := index
						end
						set_current_char (token, pos_in_token)
					end
				end
			end
		end

	go_left_word is
			-- Move `Current' to the beginning of the previous word.
		do
			go_left_char
			go_start_word
		end


	go_right_word is
			-- Move `Current' to the end of the next word.
		do
			go_right_char
			go_end_word
		end
 
	char_is_separator (char: CHARACTER): BOOLEAN is
			-- Is `char' considered a word separator?
		do
			Result := char_is_blank (char) or else
					additional_separators.has (char) 
		end

	char_is_blank (char: CHARACTER): BOOLEAN is
			-- Is `char' a blank space or a tabulation?
		do
			Result := char = ' ' or char = '%T'
		end
			
feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := (y_in_lines < other.y_in_lines) or else
				((y_in_lines = other.y_in_lines) and then (x_in_visible_characters < other.x_in_visible_characters))
				--| We have to verify that Current and `other' are not equal.
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is Current equal to `other'?
		do
			Result := (y_in_lines = other.y_in_lines) and then (x_in_visible_characters = other.x_in_visible_characters)
		end

feature {NONE} -- Word-by-word Implementation

	internal_go_right_char is
			-- Move to next character, if there is one.
		do
			bound_reached := False
			if pos_in_token = token.length then
					-- Go to next token, first character.
				if token.next = Void then
						-- No next token?
					bound_reached := True
				else
					set_current_char (token.next, 1)
				end
			else
				set_current_char (token, pos_in_token + 1)
			end
		end

	internal_go_left_char is
			-- Move to previous character, if there is one.
		local
			previous_token: EDITOR_TOKEN
		do
			bound_reached := False
			if pos_in_token = 1 then
					-- Go to previous token, last character.
				previous_token := token.previous
				if previous_token = Void or else previous_token.is_beginning_token then
						-- No previous token?
					bound_reached := True
				else
					set_current_char (token.previous, token.previous.length)
				end
			else
				set_current_char (token, pos_in_token - 1)
			end
		end

	bound_reached: BOOLEAN
			-- Is cursor at end or beginning of line?

feature {SELECTABLE_TEXT} -- Implementation

	set_line_to_next is
			-- Make `line.next' the new value of `line'.
			-- Change `y_in_lines' accordingly.
		do
			if line.next /= Void then
				line := line.next
				y_in_lines := y_in_lines + 1
				update_current_char
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
				update_current_char
			end
		end

feature {NONE} -- Implementation

	tab_length: INTEGER is
		once
			Result := text.tabulation_size
		end

	text: SELECTABLE_TEXT
		-- Whole text displayed.
		
	additional_separators: ARRAY [CHARACTER] is
			-- separators other than blank spaces and brackets/parenthesis
			-- for word by word selection
		once
			Result := <<'%'', '%"' ,'%Q','%D','%A', '%L', '.', ':', '(', ')', '%%', ',', '\', '?', '<', '>', '/'>>
		end

invariant
	y_in_lines_positive_or_null		: y_in_lines >= 0
	pos_in_token_positive			: pos_in_token > 0
	text_not_void			: text /= Void

end -- class TEXT_CURSOR
