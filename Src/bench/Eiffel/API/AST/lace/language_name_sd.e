class LANGUAGE_NAME_SD

inherit

	AST_LACE

feature

	language_name: ID_SD;
			-- Language name

	is_c: BOOLEAN is
			-- Is the language "C" ?
		do
			-- Do nothing
		end;

	is_make: BOOLEAN is
			-- Is the language "Make" ?
		do
			-- do nothing
		end;

	is_object: BOOLEAN is
			-- Is the language "Object" ?
		do
			-- Do nothing
		end;

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0);
		ensure then
			language_name_exists: language_name /= Void;
		end

end
