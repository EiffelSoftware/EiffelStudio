--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

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
