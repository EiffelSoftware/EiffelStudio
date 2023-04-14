note
	description: "Objects that represent a line in the editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard / Arnaud PICHERY [ aranud@mail.dotcom.fr] "
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWER_LINE

inherit
	TREE_ITEM

create
	make_empty_line,
	make,
	make_windows_style,
	make_unix_style

feature -- Initialisation

	make_empty_line
			-- Create an empty line.
		obsolete
			"Use `make' instead. [2017-05-31]"
		do
			make_unix_style
		end

	make (a_windows_style: BOOLEAN)
			-- Create an empty line.
		local
			t_eol: EDITOR_TOKEN_EOL
			t_begin: EDITOR_TOKEN_LINE_NUMBER
		do
			create t_eol.make_with_style (a_windows_style)
			create t_begin.make

			t_begin.set_next_token (t_eol)
			t_eol.set_previous_token (t_begin)

			eol_token := t_eol
			real_first_token := t_begin

			update_token_information
		end

	make_windows_style
			-- Create an empty line in Windows style.
		do
			make (True)
		end

	make_unix_style
			-- Create an empty line in Unix style.
		do
			make (False)
		end

feature -- Access

	real_first_token: detachable EDITOR_TOKEN
			-- First token in the line (takes into account MARGIN_TOKENs)

	first_token: detachable EDITOR_TOKEN
			-- First token in the line (margin tokens discarded)
		local
			l_old_curr_token: like curr_token
		do
			l_old_curr_token := curr_token
			from
				Result := real_first_token
				start
			until
				after or else Result = Void or else not Result.is_margin_token
			loop
				Result := Result.next
			end
			curr_token := l_old_curr_token
		ensure
			same_curr_token: old curr_token = curr_token
		end

	number_token: detachable EDITOR_TOKEN_LINE_NUMBER
			-- Token containing the line number information for the line.
		do
			if attached {EDITOR_TOKEN_LINE_NUMBER}real_first_token as l_line_number then
				Result := l_line_number
			end
		end

	eol_token: detachable EDITOR_TOKEN_EOL
			-- Last token of the line.

	wide_indentation: STRING_32
			-- Create a string containing the same indentation as `ref_line'.
			-- New instance created at each call.
		local
			l_blank: detachable EDITOR_TOKEN_BLANK
		do
			create Result.make_empty
			if attached {EDITOR_TOKEN_BLANK} first_token as t_blank then
				from
					l_blank := t_blank
					Result.append (l_blank.wide_image)
				until
					l_blank = Void
				loop
					if attached {EDITOR_TOKEN_BLANK}l_blank.next as l_next then
						Result.append (l_next.wide_image)
						l_blank := l_next
					else
						l_blank := Void
					end
				end
			end
		ensure
			indentation_not_void: Result /= Void
		end

	is_highlighted: BOOLEAN

feature -- Status Setting

	set_highlighted (a_flag: BOOLEAN)
			-- Highlight
		do
			is_highlighted := a_flag
			from
				start
			until
				after
			loop
				item.set_highlighted (a_flag)
				forth
			end
		end

	update_token_information
			-- Update token information
		require
			eol_token_not_void: eol_token /= Void
		local
			t: detachable like item
			l_eol: like eol_token
		do
			from
				t := first_token
			until
				t = eol_token
			loop
				check t /= Void end -- The line is always linked by good tokens until the end. Otherwise it is a bug.
				t.set_userset_data (userset_data)
				t.update_width
				t.update_position
				t := t.next
			end
			check t /= Void end -- Implied by precondition, `end_token' is attached
			t.update_position
			l_eol := eol_token
			check l_eol /= Void end -- Implied by precondition
			set_width (l_eol.position)
		end

feature -- Status Report

	after: BOOLEAN
			-- Are we after the end of the line ?
		do
			Result := (curr_token = Void)
		end

	start
			-- Set `curr_token' to `real_first_token'
		do
			curr_token := real_first_token
		end

	forth
			-- Move `curr_token' to it's right brother.
		require
			not_after: not after
		local
			l_curr: like curr_token
		do
			l_curr := curr_token
			check l_curr /= Void end -- Implied by precondition
			curr_token := l_curr.next
		end

	item: EDITOR_TOKEN
			-- Current item
		require
			not_after: not after
		local
			l_curr: like curr_token
		do
			l_curr := curr_token
			check l_curr /= Void end -- Implied by precondition
			Result := l_curr
		end

	empty: BOOLEAN
			-- Is Current empty (as a line)?
		do
			Result := (first_token = eol_token)
		end

	count: INTEGER
			-- Number of tokens in current
		do
			from
				start
			until
				after
			loop
				Result := Result + 1
				forth
			end
		end

feature -- Query

	has_token (tok: detachable EDITOR_TOKEN): BOOLEAN
			-- Does this line contain `tok' ?
		local
			token: detachable EDITOR_TOKEN
		do
			if tok /= Void then
				from
					token := real_first_token
				until
					Result or else token = Void
				loop
					Result := token = tok
					if token /= Void then
						token := token.next
					end
				end
			end
		end

feature -- Element change

	set_width (a_width: INTEGER)
			-- Make `width' equal to `a_width'.
		do
			width := a_width
		end

	append_token (tok: EDITOR_TOKEN)
			-- Insert `tok' just before the eol token.
		require
			eol_token_not_void: eol_token /= Void
		local
			t_before: detachable EDITOR_TOKEN
			l_end_token: like eol_token
		do
			l_end_token := eol_token
			check l_end_token /= Void end
			t_before := l_end_token.previous
			if t_before = Void then
				real_first_token := tok
			else
				t_before.set_next_token (tok)
				tok.set_previous_token (t_before)
			end
			tok.set_next_token (eol_token)
			l_end_token.set_previous_token (tok)
		end

	insert_token (tok: EDITOR_TOKEN; pos: INTEGER)
			-- Insert `tok' to right at position
		require
			tok_not_void: tok /= Void
			not_has_tok: not has_token (tok)
			pos_valid: pos <= count
		local
			tok_index: INTEGER
			l_tok, l_next: detachable EDITOR_TOKEN
		do
			from
				start
			until
				tok_index = pos
			loop
				l_tok := item
				tok_index := tok_index + 1
				forth
			end

			if l_tok /= Void then
				l_next := l_tok.next
				if l_next /= Void then
					tok.set_next_token (l_next)
					l_next.set_previous_token (tok)
				end
				l_tok.set_next_token (tok)
				tok.set_previous_token (l_tok)
			end
		end

feature -- Status Report

	character_length: INTEGER
			-- Character length of current line including the EOL character.
		local
			t: detachable EDITOR_TOKEN
		do
			from
				t := first_token
			until
				t = Void
			loop
				Result := Result + t.character_length
				t := t.next
			end
		end

	wide_image: STRING_32
			-- string representation of the line.
		local
			t: detachable EDITOR_TOKEN
			l_string_32: STRING_32
		do
			create l_string_32.make (50) -- 50 = average number of characters per line
			from
				t := first_token
			until
				t = eol_token
			loop
				check t /= Void end -- The line is always linked by good tokens until the end. Otherwise it is a bug.
				l_string_32.append (t.wide_image)
				t := t.next
			end
			Result := l_string_32
		ensure
			Result_not_void: Result /= Void
		end

	wide_image_from_start_to_cursor (text_cursor: VIEWER_CURSOR): STRING_32
			-- Substring of the line starting at the beggining of
			-- the line and ending at the cursor position (not
			-- included)
		require
			text_cursor.line = Current
		local
			local_token: detachable EDITOR_TOKEN
			cursor_token: EDITOR_TOKEN
			l_string_32		: STRING_32
		do
			cursor_token := text_cursor.token
			create l_string_32.make (50)

				-- Retrieve the string in the token situated before
				-- the cursor
			from
				local_token := first_token
			until
				local_token = cursor_token or else local_token = eol_token
			loop
				check local_token /= Void end -- Tokens before the `end_token' are not void.
				l_string_32.append (local_token.wide_image)
				local_token := local_token.next
			end

				-- Append the current string with the portion of the current
				-- token that is before the cursor.
			if local_token /= Void then
				l_string_32.append (local_token.wide_image.substring(1, text_cursor.pos_in_token - 1))
			end
			Result := l_string_32
		ensure
			Result_not_void: Result /= Void
		end

	wide_image_from_cursor_to_end (text_cursor: VIEWER_CURSOR): STRING_32
			-- Substring of the line starting at the cursor
			-- position (included) and ending at the end of the line
		require
			text_cursor.line = Current
		local
			local_token: detachable EDITOR_TOKEN
			cursor_token: EDITOR_TOKEN
			l_string_32		: STRING_32
		do
			cursor_token := text_cursor.token
			create l_string_32.make (50)

				-- Append the current string with the portion of the current
				-- token that is after the cursor.
			l_string_32.append(cursor_token.wide_image.substring(text_cursor.pos_in_token, cursor_token.length))

				-- Retrieve the string in the token situated before
				-- the cursor
			from
				local_token := cursor_token.next
			until
				local_token = eol_token or else local_token = Void
			loop
				l_string_32.append (local_token.wide_image)
				local_token := local_token.next
			end
			Result := l_string_32
		ensure
			Result_not_void: Result /= Void
		end

	wide_substring_image_by_character (start_char, end_char: INTEGER): STRING_32
			-- Substring of the line starting at `start_char' and
			-- ending at `end_char' - included
		local
			local_token: detachable EDITOR_TOKEN
			local_char 		: INTEGER
			next_local_char: INTEGER
			token_start_char: INTEGER
			token_end_char: INTEGER
			l_string_32		: STRING_32
		do
			if start_char <= end_char then
				create l_string_32.make (50)
				from
					local_token := first_token
					local_char := 1
				until
					local_char > end_char or else local_token = eol_token
				loop
					check local_token /= Void end -- Tokens before the `end_token' are not void.
					next_local_char := local_char + local_token.length

					if (local_char <= end_char) and then (next_local_char >= start_char) then
						-- This token is part of the selection
						token_start_char := local_char.max(start_char) - local_char + 1
						token_end_char := next_local_char.min(end_char) - local_char  + 1
						l_string_32.append(local_token.wide_image.substring(token_start_char, token_end_char))
					else
						-- This token is not part of the selection, we ignore it.
					end

						-- prepare next iteration
					local_char := next_local_char
					local_token := local_token.next
				end
			else
				-- start_char > end_char so, we return an empty string.
				l_string_32 := ""
			end
			Result := l_string_32
		ensure
			Result_not_void: Result /= Void
		end

	width: INTEGER
		-- x position of last pixel of the string

feature {TEXT_PANEL} -- Userset data

	set_userset_data (a_data: like userset_data)
			-- Set `userset_data' with `a_data'
		do
			userset_data := a_data
		ensure
			userset_data_set: userset_data = a_data
		end

	userset_data: detachable TEXT_PANEL_BUFFERED_DATA assign set_userset_data
			-- Userset editor data

feature -- Obsolete

	image: STRING
			-- string representation of the line.
		obsolete
			"Use `wide_image' instead. [2017-05-31]"
		do
			Result := wide_image.as_string_8
		ensure
			Result_not_void: Result /= Void
		end

	indentation: STRING
			-- Create a string containing the same indentation as `ref_line'.
			-- New instance created at each call.
		obsolete
			"Use `wide_indentation' instead. [2017-05-31]"
		do
			Result := wide_indentation.as_string_8
		ensure
			indentation_not_void: Result /= Void
		end

	image_from_start_to_cursor (text_cursor: VIEWER_CURSOR): STRING
			-- Substring of the line starting at the beggining of
			-- the line and ending at the cursor position (not
			-- included)
		obsolete
			"Use `wide_image_from_start_to_cursor' instead. [2017-05-31]"
		require
			text_cursor.line = Current
		do
			Result := wide_image_from_start_to_cursor (text_cursor).as_string_8
		ensure
			Result_not_void: Result /= Void
		end

	image_from_cursor_to_end (text_cursor: VIEWER_CURSOR): STRING
			-- Substring of the line starting at the cursor
			-- position (included) and ending at the end of the line
		obsolete
			"Use `wide_image_from_cursor_to_end' instead. [2017-05-31]"
		require
			text_cursor.line = Current
		do
			Result := wide_image_from_cursor_to_end (text_cursor).as_string_8
		ensure
			Result_not_void: Result /= Void
		end

	substring_image_by_character (start_char, end_char: INTEGER): STRING
			-- Substring of the line starting at `start_char' and
			-- ending at `end_char' - included
		obsolete
			"Use `wide_substring_image_by_character' instead. [2017-05-31]"
		do
			Result := substring_image_by_character (start_char, end_char).as_string_8
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	curr_token: detachable EDITOR_TOKEN;

invariant
	real_first_token_set: real_first_token /= Void
	eol_token_set: eol_token /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class VIEWER_LINE
