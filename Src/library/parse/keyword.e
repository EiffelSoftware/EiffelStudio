--|---------------------------------------------------------------
--|   Copyright (C) 1993 Interactive Software Engineering, Inc. --
--|    270 Storke Road, Suite 7 Goleta, California 93117		--
--|                   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Terminal constructs with just one specimen,
-- representing a language keyword or special symbol

indexing

	date: "$Date$";
	revision: "$Revision$"

class KEYWORD 

inherit

	TERMINAL
		rename
			make as construct_make
		redefine
			token_correct
		end

creation

	make

feature 

	make (s: STRING) is
		do
			construct_make;
			construct_name := s;
			lex_code := document.keyword_code (s)
		end; -- make

	construct_name: STRING;
			-- Name of the keyword

	lex_code: INTEGER
			-- Code of keyword in the lexical anayser

feature {NONE}

	token_correct: BOOLEAN is
			-- Is this keyword the active token?
		do
			Result := document.token.is_keyword (lex_code)
		end; -- token_correct

	token_type: INTEGER is 0
			-- Unused token type

end -- class KEYWORD
