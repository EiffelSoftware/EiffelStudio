indexing
	description	: "Objects that represent a line in the editor."
	author		: "Christophe Bonnard / Arnaud PICHERY [ aranud@mail.dotcom.fr] "
	date		: "$Date$"
	revision	: "$Revision$"

class
	VIEWER_LINE

inherit
	TREE_ITEM

create
	make_empty_line

feature {NONE} -- Initialisation

	make_empty_line is
			-- Create an empty line.
		local
			t_eol: EDITOR_TOKEN_EOL
			t_begin: EDITOR_TOKEN_BREAKPOINT
		do
			create t_eol.make
			create t_begin.make
			
			t_begin.set_next_token (t_eol)
			t_eol.set_previous_token (t_begin)

			real_first_token := t_begin
			eol_token := t_eol
		end

feature -- Access

	real_first_token: EDITOR_TOKEN
			-- First token in the line (beginning token such as EDITOR_TOKEN_BREAKPOINT
			-- are taken into account)

	first_token: EDITOR_TOKEN is
			-- First token in the line (beginning token is discarded)
		do
			Result := real_first_token.next
		end

	breakpoint_token: EDITOR_TOKEN_BREAKPOINT is	
			-- Token containing the breakpoint information for the line.
		do
			Result ?= real_first_token
		end

	eol_token: EDITOR_TOKEN_EOL
			-- Last token of the line.

	indentation: STRING is
			-- Create a string containing the same indentation as `ref_line'.
		local
			t_blank: EDITOR_TOKEN_BLANK
		do
			t_blank ?= first_token
			if t_blank = Void then
				Result := ""
			else
				Result := clone (t_blank.image)	
				from
					t_blank ?= t_blank.next
				until
					t_blank = Void
				loop
					Result.append (t_blank.image)
					t_blank ?= t_blank.next
				end
			end
		end

feature -- Status Report

	after: BOOLEAN is
			-- Are we after the end of the line ?
		do
			Result := (curr_token = Void)
		end

	start is
			-- Set `curr_token' to `real_first_token'
		do
			curr_token := real_first_token
		end
		
	forth is
			-- Move `curr_token' to it's right brother.
		do
			curr_token := curr_token.next
		end

	item: like first_token is
			-- Current item
		do
			Result := curr_token
		end

	empty: BOOLEAN is
			-- Is Current empty (as a line)?
		do
			Result := (first_token = eol_token)
		end

feature -- Element change

	set_width (a_width: INTEGER) is
			-- Make `width' equal to `a_width'.
		do
			width := a_width
		end

	append_token (tok: EDITOR_TOKEN) is
			-- Insert `tok' just before the eol token.
		local
			t_before: EDITOR_TOKEN
		do
			t_before := eol_token.previous
			if t_before = Void then
				real_first_token := tok
			else
				t_before.set_next_token (tok)
				tok.set_previous_token (t_before)
			end
			tok.set_next_token (eol_token)
			eol_token.set_previous_token (tok)
		end

	prepend_breakpoint_token (tok: EDITOR_TOKEN_BREAKPOINT) is
			-- Insert `tok' on the beginning of the line.
		local
			t_after: EDITOR_TOKEN
		do
			t_after := real_first_token
			real_first_token := tok

			if t_after /= Void then
				tok.set_next_token (t_after)
				t_after.set_previous_token (tok)
			end
		end

feature -- Status Report

	image: STRING is
			-- string representation of the line.
		local
			t: EDITOR_TOKEN
		do
			create Result.make (50) -- 50 = average number of characters per line
			from
				t := first_token
			until
				t = eol_token
			loop
				Result.append (t.image)
				t := t.next
			end
		ensure
			Result_not_void: Result /= Void
		end

	image_from_start_to_cursor (text_cursor: VIEWER_CURSOR): STRING is
			-- Substring of the line starting at the beggining of
			-- the line and ending at the cursor position (not
			-- included)
		require
			text_cursor.line = Current
		local
			local_token		: EDITOR_TOKEN
			cursor_token	: EDITOR_TOKEN
		do
			cursor_token := text_cursor.token
			create Result.make (50)

				-- Retrieve the string in the token situated before
				-- the cursor
			from
				local_token := first_token
			until
				local_token = cursor_token or else local_token = eol_token
			loop
				Result.append(local_token.image)
				local_token := local_token.next
			end

				-- Append the current string with the portion of the current
				-- token that is before the cursor.
			Result.append(local_token.image.substring(1, text_cursor.pos_in_token - 1))
		ensure
			Result_not_void: Result /= Void
		end

	image_from_cursor_to_end (text_cursor: VIEWER_CURSOR): STRING is
			-- Substring of the line starting at the cursor
			-- position (included) and ending at the end of the line
		require
			text_cursor.line = Current
		local
			local_token		: EDITOR_TOKEN
			cursor_token	: EDITOR_TOKEN
		do
			cursor_token := text_cursor.token
			create Result.make (50)

				-- Append the current string with the portion of the current
				-- token that is after the cursor.
			Result.append(cursor_token.image.substring(text_cursor.pos_in_token, cursor_token.length))

				-- Retrieve the string in the token situated before
				-- the cursor
			from
				local_token := cursor_token.next
			until
				local_token = eol_token or else local_token = Void
			loop
				Result.append(local_token.image)
				local_token := local_token.next
			end
		ensure
			Result_not_void: Result /= Void
		end

	substring_image_by_character (start_char, end_char: INTEGER): STRING is
			-- Substring of the line starting at `start_char' and
			-- ending at `end_char' - included
		local
			local_token		: EDITOR_TOKEN
			local_char 		: INTEGER
			next_local_char	: INTEGER
			token_start_char: INTEGER
			token_end_char	: INTEGER
		do
			if start_char <= end_char then
				create Result.make (50)
				from
					local_token := first_token
					local_char := 1
				until
					local_char > end_char or else local_token = eol_token
				loop
					next_local_char := local_char + local_token.length

					if (local_char <= end_char) and then (next_local_char >= start_char) then
						-- This token is part of the selection
						token_start_char := local_char.max(start_char) - local_char + 1
						token_end_char := next_local_char.min(end_char) - local_char  + 1
						Result.append(local_token.image.substring(token_start_char, token_end_char))
					else
						-- This token is not part of the selection, we ignore it.
					end

						-- prepare next iteration
					local_char := next_local_char
					local_token := local_token.next
				end
			else
				-- start_char > end_char so, we return an empty string.
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end

	width: INTEGER
		-- x position of last pixel of the string

feature {NONE} -- Implementation
	
	curr_token: EDITOR_TOKEN

end -- class VIEWER_LINE
