-- Generate_option         : /* empty */
--                         | LEX_LEFT_PARAM Generate_option_value LEX_RIGHT_PARAM
-- 
-- Generate_option_value   : LEX_YES
--                         | LEX_NO

class LANG_GEN_SD

inherit

	AST_LACE

feature -- Attributes

	language_name: LANGUAGE_NAME_SD;
			-- Language name

	generate_value: YES_OR_NO_SD;
			-- Generation value

	file__name: ID_SD;
			-- File name

feature -- Initialization

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0);
			generate_value ?= yacc_arg (1);
			file__name ?= yacc_arg (2)
		ensure then
			language_name_exists: language_name /= Void;
		end;

end
