indexing
	description: "A partial line in the editor.  Unlinke full lines a partial line has not breakpoint and no eol token."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_PARTIAL_LINE

inherit
	EDITOR_LINE
		redefine
			make_from_lexer
		end
		
create
	make_empty_line,
	make_from_lexer

feature -- Initialisation

	make_from_lexer (lexer: EDITOR_SCANNER) is
			-- Create a line using token from `lexer'
		local
			lexer_first_token	: EDITOR_TOKEN
			lexer_end_token		: EDITOR_TOKEN
		do
			lexer_end_token := lexer.end_token
			if lexer_end_token /= Void then
					-- The lexer has parsed something.
				real_first_token := lexer.first_token
			end
			set_part_of_verbatim_string (lexer.in_verbatim_string)
		end

end -- class EDITOR_PARTIAL_LINE
