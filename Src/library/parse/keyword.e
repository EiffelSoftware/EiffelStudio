indexing

	description:
		"Terminal constructs with just one specimen, %
		%representing a language keyword or special symbol";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class KEYWORD inherit

	TERMINAL
		rename
			make as construct_make
		redefine
			token_correct
		end

creation

	make

feature -- Initialization

	make (s: STRING) is
		do
			construct_make;
			construct_name := s;
			lex_code := document.keyword_code (s)
		end; 

feature -- Access

	construct_name: STRING;
			-- Name of the keyword

	lex_code: INTEGER
			-- Code of keyword in the lexical anayser

feature {NONE} -- Implementation

	token_correct: BOOLEAN is
			-- Is this keyword the active token?
		do
			Result := document.token.is_keyword (lex_code)
		end; 

	token_type: INTEGER is 0
			-- Unused token type

end -- class KEYWORD
 

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
