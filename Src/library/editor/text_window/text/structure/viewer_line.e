indexing
	description	: "Objects that represent a line in the editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Christophe Bonnard / Arnaud PICHERY [ aranud@mail.dotcom.fr] "
	date		: "$Date$"
	revision	: "$Revision$"

class
	VIEWER_LINE

inherit
	TREE_ITEM

create
	make_empty_line

feature -- Initialisation

	make_empty_line is
			-- Create an empty line.
		local
			t_eol: EDITOR_TOKEN_EOL			
			t_begin: EDITOR_TOKEN_LINE_NUMBER
		do
			create t_eol.make
			create t_begin.make

			t_begin.set_next_token (t_eol)
			t_eol.set_previous_token (t_begin)

			eol_token := t_eol
			real_first_token := t_begin
			
			update_token_information
		end

feature -- Access

	real_first_token: EDITOR_TOKEN
			-- First token in the line (takes into account MARGIN_TOKENs)

	first_token: EDITOR_TOKEN is
			-- First token in the line (margin tokens discarded)
		do
			from
				Result := real_first_token
				start
			until
				after or Result = Void or not Result.is_margin_token
			loop
				Result := Result.next
			end
		end

	number_token: EDITOR_TOKEN_LINE_NUMBER is	
			-- Token containing the line number information for the line.
		do
			Result ?= real_first_token
		end

	eol_token: EDITOR_TOKEN_EOL
			-- Last token of the line.

	indentation: STRING is
			-- Create a string containing the same indentation as `ref_line'.
			-- New instance created at each call.
		local
			t_blank: EDITOR_TOKEN_BLANK
		do
			t_blank ?= first_token
			if t_blank = Void then
				Result := ""
			else
				Result := t_blank.image.twin
				from
					t_blank ?= t_blank.next
				until
					t_blank = Void
				loop
					Result.append (t_blank.image)
					t_blank ?= t_blank.next
				end
			end
		ensure
			indentation_not_void: Result /= Void
		end

	is_highlighted: BOOLEAN

feature -- Status Setting

	set_highlighted (a_flag: BOOLEAN) is
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

	update_token_information is
			-- 
		local
			t: like item
		do
			from
				t := first_token
			until
				t = eol_token
			loop				
				t.update_width
				t.update_position			
				t := t.next
			end	
			t.update_position
			set_width (eol_token.position)	
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

	count: INTEGER is
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

	has_token (tok: EDITOR_TOKEN): BOOLEAN is
			-- Does this line contain `tok' ?
		local
			token: EDITOR_TOKEN
		do
			if tok /= Void then
				from
					token := real_first_token
				until
					Result or else token = Void
				loop
					Result := token = tok
					token := token.next
				end
			end
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

	insert_token (tok: EDITOR_TOKEN; pos: INTEGER) is
			-- Insert `tok' to right at position
		require
			tok_not_void: tok /= Void
			not_has_tok: not has_token (tok)
			pos_valid: pos <= count
		local
			tok_index: INTEGER
			l_tok: EDITOR_TOKEN
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
				if l_tok.next /= Void then
					tok.set_next_token (l_tok.next)
					l_tok.next.set_previous_token (tok)
				end
				l_tok.set_next_token (tok)
				tok.set_previous_token (l_tok)				
			end
		end		

feature -- Status Report

	image: STRING is
			-- string representation of the line.
		local
			t: EDITOR_TOKEN
			prev_token: EDITOR_TOKEN
		do
			prev_token := item
			create Result.make (50) -- 50 = average number of characters per line
			from
				t := first_token
			until
				t = eol_token
			loop
				Result.append (t.image)
				t := t.next
			end
			curr_token := prev_token
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
	
	curr_token: EDITOR_TOKEN;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class VIEWER_LINE
