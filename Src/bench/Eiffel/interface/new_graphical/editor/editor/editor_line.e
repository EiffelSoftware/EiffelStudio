indexing
	description	: "Objects that represent a line in the editor."
	author		: "Christophe Bonnard / Arnaud PICHERY [ aranud@mail.dotcom.fr] "
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_LINE

inherit
	TREE_ITEM
		rename
			tree as paragraph
		redefine
			paragraph
		end

create
	make_empty_line,
	make_from_lexer

feature {NONE} -- Initialisation

	make_empty_line is
			-- Create an empty line.
		local
			t_eol: EDITOR_TOKEN_EOL
		do
			create t_eol.make
			first_token := t_eol
			eol_token := t_eol
		end

feature -- Initialisation

	make_from_lexer (lexer: EIFFEL_SCANNER) is
			-- Create a line using token from `lexer'
		require
			lexer_exists: lexer /= Void
		local
			t_eol: EDITOR_TOKEN_EOL
			t: EDITOR_TOKEN
		do
			create t_eol.make
			t := lexer.end_token
			if t /= Void then
					-- The lexer has parsed something.
				t.set_next_token (t_eol)
				t_eol.set_previous_token (t)
				first_token := lexer.first_token
			else
					-- We have given an empty string to the parser.
					-- He has not produced any token.
				first_token := t_eol
			end
			eol_token := t_eol
		end

feature -- Transformation

	replace_from_lexer (lexer: EIFFEL_SCANNER; t_before, t_after: EDITOR_TOKEN) is
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

	replace_beginning_from_lexer (lexer: EIFFEL_SCANNER; t_after: EDITOR_TOKEN) is
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
				first_token := lexer.first_token
			else
				first_token := t_after
			end
			t_after.set_previous_token (t)
		end

feature -- Access

	paragraph: PARAGRAPH
		-- This line belongs to the paragraph `paragraph'

	first_token: EDITOR_TOKEN
		-- First token in the
	
	eol_token: EDITOR_TOKEN_EOL
		-- Last token of the line.

feature -- Status Report

	after: BOOLEAN is
			-- Are we after the end of the line ?
		do
			Result := (curr_token = Void)
		end

	start is
			-- Set `curr_token' to `first_token'
		do
			curr_token := first_token
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

feature -- Element change

	set_width (a_width: INTEGER) is
		do
			width := a_width
		end

feature -- Transformation

	merge_with_next_line (lexer: EIFFEL_SCANNER) is
		local
			t_before : EDITOR_TOKEN
			s: STRING
		do
			t_before := eol_token.previous
			if t_before /= Void then
				s := clone (t_before.image)
				t_before := t_before.previous
				s.append (next.image)
			else
				s := next.image
			end
			lexer.execute (s)
			if t_before = Void then
				replace_beginning_from_lexer (lexer, eol_token)
			else
				replace_from_lexer (lexer, t_before, eol_token)
			end
			next.delete
		end

feature -- Status Report

	image: STRING is
			-- string representation of the line.
		local
			t: EDITOR_TOKEN
		do
			create Result.make (0)
			from
				t := first_token
			until
				t = eol_token
			loop
				Result.append (t.image)
				t := t.next
			end
		end

	width: INTEGER
		-- x position of last pixel of the string

feature {NONE} -- Implementation
	
	curr_token: EDITOR_TOKEN

end -- class EDITOR_LINE
