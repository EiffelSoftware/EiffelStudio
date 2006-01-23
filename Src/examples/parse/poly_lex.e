indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Lexical interface class for the Polynomial language

class POLY_LEX 
	
inherit

	L_INTERFACE

	CONSTANTS
		undefine
			copy, is_equal
		end

feature {NONE}

	obtain_analyzer is
			-- Create lexical analyzer for the Polynomial language
		do
			ignore_case
			keywords_ignore_case
			build_expressions
			build_keywords
			set_separator_type (Blanks)
		end -- obtain_analyzer

	build_expressions is
			-- Define regular expressions
			-- for the Polynomial language
		do
			put_expression (special_expression, Special, "Special")
			put_expression ("*('a'..'z')", Simple_identifier, "Simple_identifier")
			put_expression ("+('0'..'9')", Integer_constant, "Integer_constant")
			put_expression ("+('\t'|'\n'|' ')", Blanks, "Blanks")
		end -- build_expressions

	special_expression: STRING is
			-- Regular expression describing `Special'
		once
			create Result.make (80)
			Result.append ("('\050'..'\057')|")
			Result.append ("('\072'..'\076')|")
			Result.append ("'['|']'|'|'|'{'|'}'|%"->%"|%":=%"")
		end -- special_expression

	build_keywords is
			-- Define keywords (special symbols)
			-- for the Polynomial language
		do
			put_keyword ("+", Special)
			put_keyword ("-", Special)
			put_keyword (";", Special)
			put_keyword (":", Special)
			put_keyword ("(", Special)
			put_keyword (")", Special)
			put_keyword ("*", Special)
		end -- build_keywords
 
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


end -- class POLY_LEX

