--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sets of value used in lexical analysis

indexing

	date: "$Date$";
	revision: "$Revision$"

class TOKEN

feature

	set (typ, lin, pos, key: INTEGER; str: STRING) is
		do
			type := typ;
			line_number := lin;
			position_in_line := pos;
			keyword_code := key;
			if type = 0 then
				string_value := ""
			else
				string_value := str
			end
		end; -- set

	type: INTEGER;
			-- Type of the token

	line_number: INTEGER;
			-- Line number in the parsed text

	position_in_line: INTEGER;
			-- Column number in the parsed text

	keyword_code: INTEGER;
			-- Identification number if the token is a keyword

	string_value: STRING;
			-- The token's character string

	is_keyword (i: INTEGER): BOOLEAN is
			-- If the token is a keyword,
			-- is `i' its identification number?
		do
			Result := (i = keyword_code)
		end -- is_keyword

end -- class TOKEN
