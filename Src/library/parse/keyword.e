indexing

	description:
		"Terminal constructs with just one specimen, %
		%representing a language keyword or special symbol";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class KEYWORD inherit

	TERMINAL
		rename
			make as construct_make
		redefine
			token_correct
		end

create

	make

feature -- Initialization

	make (s: STRING) is
			-- Set up terminal to represent `s'.
		do
			construct_make;
			construct_name := s;
			lex_code := document.keyword_code (s)
		ensure
			construct_name = s;
			lex_code = document.keyword_code (s)
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
--| EiffelParse: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

