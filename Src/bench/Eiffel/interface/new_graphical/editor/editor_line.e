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

feature --- Initialisations

	make_empty_line is
			-- Create an empty line.
		local
			t_eol: EDITOR_TOKEN_EOL
		do
			create t_eol.make
			first_token := t_eol
			end_token := t_eol
		end

	make_from_lexer (lexer: EIFFEL_SCANNER) is
			-- Create a line using token from `lexer'
		local
			t_eol: EDITOR_TOKEN_EOL
			t: EDITOR_TOKEN
		do
			create t_eol.make
			t := lexer.last_token
			t.set_next_token (t_eol)
			t_eol.set_previous_token (t)
			first_token := lexer.first_token
			end_token := t_eol
		end

feature -- Access

	paragraph: PARAGRAPH
		-- This line belongs to the paragraph `paragraph'

	first_token: EDITOR_TOKEN
		-- First token in the
	
	end_token: EDITOR_TOKEN_EOL
		-- Last token of the line.

feature -- Element change

	set_width(a_width: INTEGER) is
		do
			width := a_width
		end

feature -- Status Report

	image: STRING
		-- string representation of the line.

	width: INTEGER
		-- x position of last pixel of the string

end -- class EDITOR_LINE
