-- Lexical interface class for the Polynomial language

class POLY_LEX 
	
inherit

	L_INTERFACE;

	CONSTANTS
		undefine
			consistent, copy, is_equal, setup
		end

feature {NONE}

	obtain_analyzer is
			-- Create lexical analyzer for the Polynomial language
		do
			ignore_case;
			keywords_ignore_case;
			build_expressions;
			build_keywords;
			set_separator_type (Blanks)
		end; -- obtain_analyzer

	build_expressions is
			-- Define regular expressions
			-- for the Polynomial language
		do
			put_expression (special_expression, Special, "Special");
			put_expression ("*('a'..'z')", Simple_identifier, "Simple_identifier");
			put_expression ("+('0'..'9')", Integer_constant, "Integer_constant");
			put_expression ("+('\t'|'\n'|' ')", Blanks, "Blanks");
		end; -- build_expressions

	special_expression: STRING is
			-- Regular expression describing `Special'
		once
			create Result.make (80);
			Result.append ("('\050'..'\057')|");
			Result.append ("('\072'..'\076')|");
			Result.append ("'['|']'|'|'|'{'|'}'|%"->%"|%":=%"")
		end; -- special_expression

	build_keywords is
			-- Define keywords (special symbols)
			-- for the Polynomial language
		do
			put_keyword ("+", Special);
			put_keyword ("-", Special);
			put_keyword (";", Special);
			put_keyword (":", Special);
			put_keyword ("(", Special);
			put_keyword (")", Special);
			put_keyword ("*", Special)
		end -- build_keywords
 
end -- class POLY_LEX

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

