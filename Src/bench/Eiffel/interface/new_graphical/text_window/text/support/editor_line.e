indexing
	description	: "Objects that represent a line in the editor."
	author		: "Christophe Bonnard / Arnaud PICHERY [ aranud@mail.dotcom.fr] "
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_LINE

inherit
	VIEWER_LINE
		rename
			image_from_start_to_cursor as dummy1,
			image_from_cursor_to_end as dummy2
		end
--| FIXME: Supress that rename by making VIEWER_CURSOR a descendant of EDITOR_CURSOR

create
	make_empty_line,
	make_from_lexer

feature -- Initialisation

	make_from_lexer (lexer: EDITOR_SCANNER) is
			-- Create a line using token from `lexer'
		require
			lexer_exists: lexer /= Void
		local
			t_eol				: EDITOR_TOKEN_EOL
			t_begin				: EDITOR_TOKEN_BREAKPOINT
			lexer_first_token	: EDITOR_TOKEN
			lexer_end_token		: EDITOR_TOKEN
		do
			create t_eol.make
			create t_begin.make

			lexer_end_token := lexer.end_token
			if lexer_end_token /= Void then
					-- The lexer has parsed something.
				lexer_first_token := lexer.first_token

				lexer_end_token.set_next_token (t_eol)
				t_eol.set_previous_token (lexer_end_token)
				t_begin.set_next_token (lexer_first_token)
				lexer_first_token.set_previous_token (t_begin)
			else
					-- We have given an empty string to the parser.
					-- He has not produced any token.
				t_begin.set_next_token (t_eol)
				t_eol.set_previous_token (t_begin)
			end
			real_first_token := t_begin
			eol_token := t_eol
			set_width (eol_token.position)
		end

feature -- Transformation

	replace_from_lexer (lexer: EDITOR_SCANNER; t_before, t_after: EDITOR_TOKEN) is
			-- Replace tokens between `t_before' and `t_after'
			-- by tokens from `lexer'.
		require
			lexer_exists: lexer /= Void
			t_before_exists: t_before /= Void
			t_after_exists: t_after /= Void
		local
			first_t, last_t: EDITOR_TOKEN
		do
			last_t := lexer.end_token
			if last_t /= Void then
					-- The lexer has parsed something.
				first_t := lexer.first_token
				last_t.set_next_token (t_after)
				t_after.set_previous_token (last_t)
				first_t.set_previous_token (t_before)
				t_before.set_next_token (first_t)
			else
				t_before.set_next_token (t_after)
				t_after.set_previous_token (t_before)
			end
		end

--| FIXME
--| Christophe, 27 jan 2000
--| Should we avoid the case "t_before = Void" or
--| redirect it to `replace_beginning_from_lexer'? 

	replace_beginning_from_lexer (lexer: EDITOR_SCANNER; t_after: EDITOR_TOKEN) is
			-- Replace tokens before `t_after' by tokens from `lexer'.
		require
			lexer_exists: lexer /= Void
			t_after_exists: t_after /= Void
		local
			t: EDITOR_TOKEN
		do
			t := lexer.end_token
			if t /= Void then
					-- The lexer has parsed something.
				t.set_next_token (t_after)
				real_first_token := lexer.first_token
			else
				real_first_token := t_after
			end
			t_after.set_previous_token (t)
		end

feature -- Status Report

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
						

	image_from_start_to_cursor (text_cursor: TEXT_CURSOR): STRING is
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

	image_from_cursor_to_end (text_cursor: TEXT_CURSOR): STRING is
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

end -- class EDITOR_LINE
