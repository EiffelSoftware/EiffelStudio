indexing
	description	: "Objects that represent a line in the editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Christophe Bonnard / Arnaud PICHERY [ aranud@mail.dotcom.fr] "
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_LINE

inherit
	VIEWER_LINE
		rename
			wide_image_from_start_to_cursor as dummy1,
			wide_image_from_cursor_to_end as dummy2,
			image_from_start_to_cursor as dummy3,
			image_from_cursor_to_end as dummy4
		end

create
	make_empty_line,
	make_from_lexer

feature -- Initialization

	make_from_lexer (lexer: EDITOR_SCANNER) is
			-- Create a line using token from `lexer'
		require
			lexer_exists: lexer /= Void
		local
			t_eol				: EDITOR_TOKEN_EOL
			t_begin				: EDITOR_TOKEN_LINE_NUMBER
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
			update_token_information
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
			update_token_information
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
			update_token_information
		end

	rebuild_from_lexer (lexer: EDITOR_SCANNER; in_v_string: BOOLEAN) is
			-- Rebuild Current using token from `lexer'.  If lexer is scanning a line that is part of
			-- a verbatim string then `in_v_string' should be True.
		do
			if previous /= Void and then ((previous.part_of_verbatim_string and then not previous.end_of_verbatim_string) or previous.start_of_verbatim_string) then
				lexer.set_in_verbatim_string (True)
			else
				lexer.set_in_verbatim_string (False)
			end
			make_from_lexer (lexer)
		end

feature -- Status Report					

	wide_image_from_start_to_cursor (text_cursor: TEXT_CURSOR): STRING_32 is
			-- Substring of the line starting at the beginning of
			-- the line and ending at the cursor position (not
			-- included)
		require
			text_cursor.line = Current
		local
			local_token		: EDITOR_TOKEN
			cursor_token	: EDITOR_TOKEN
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
				l_string_32.append(local_token.wide_image)
				local_token := local_token.next
			end

				-- Append the current string with the portion of the current
				-- token that is before the cursor.
			l_string_32.append(local_token.wide_image.substring(1, text_cursor.pos_in_token - 1))
			Result := l_string_32
		ensure
			Result_not_void: Result /= Void
		end

	wide_image_from_cursor_to_end (text_cursor: TEXT_CURSOR): STRING_32 is
			-- Substring of the line starting at the cursor
			-- position (included) and ending at the end of the line
		require
			text_cursor.line = Current
		local
			local_token		: EDITOR_TOKEN
			cursor_token	: EDITOR_TOKEN
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
				l_string_32.append(local_token.wide_image)
				local_token := local_token.next
			end
			Result := l_string_32
		ensure
			Result_not_void: Result /= Void
		end

	auto_indented: BOOLEAN
			-- Was this line auto-indented by the editor (i.e. extra tabs were added when created)?

	part_of_verbatim_string: BOOLEAN
			-- Is Current part of a verbatim string, i.e part of a string which covers more than one line?
			-- Redefine this and have the lexer set this flag so you can tell if indeed this is the case.
			-- Required because gobo lexer works line by line.  Defult: False

	end_of_verbatim_string: BOOLEAN
			-- Is current the end of a verbatim string?

	start_of_verbatim_string: BOOLEAN
			-- Is current the start of a verbatim string?

feature -- Obsolete

	image_from_start_to_cursor (text_cursor: TEXT_CURSOR): STRING is
			-- Substring of the line starting at the beginning of
			-- the line and ending at the cursor position (not
			-- included)
		obsolete
			"Use `wide_image_from_start_to_cursor' instead."
		require
			text_cursor.line = Current
		do
			Result := wide_image_from_cursor_to_end (text_cursor).as_string_8
		ensure
			Result_not_void: Result /= Void
		end

	image_from_cursor_to_end (text_cursor: TEXT_CURSOR): STRING is
			-- Substring of the line starting at the cursor
			-- position (included) and ending at the end of the line
		obsolete
			"Use `wide_image_from_cursor_to_end' instead."
		require
			text_cursor.line = Current
		do
			Result := wide_image_from_cursor_to_end (text_cursor).as_string_8
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status Setting

	set_auto_indented (a_flag: BOOLEAN) is
			-- Set `auto_indented' to `a_flag'
		do
			auto_indented := a_flag
		ensure
			value_set: auto_indented = a_flag
		end

	set_part_of_verbatim_string (a_flag: BOOLEAN) is
			-- Set `part_of_verbatim_string' to `a_flag'
		do
			part_of_verbatim_string := a_flag
		ensure
			value_set: part_of_verbatim_string = a_flag
		end

	set_end_of_verbatim_string (a_flag: BOOLEAN) is
			-- Set `end_of_verbatim_string' to `a_flag'
		do
			end_of_verbatim_string := a_flag
		ensure
			value_set: end_of_verbatim_string = a_flag
		end

	set_start_of_verbatim_string (a_flag: BOOLEAN) is
			-- Set `start_of_verbatim_string' to `a_flag'
		do
			start_of_verbatim_string := a_flag
		ensure
			value_set: start_of_verbatim_string = a_flag
		end

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




end -- class EDITOR_LINE
