-- Generate_option         : /* empty */
--                         | LEX_LEFT_PARAM Generate_option_value LEX_RIGHT_PARAM
-- 
-- Generate_option_value   : LEX_YES
--                         | LEX_NO

class LANG_GEN_SD

inherit

	AST_LACE
		redefine
			adapt
		end

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

	adapt is
			-- Generate analysis
		local
			is_yes: BOOLEAN;
		do
			is_yes := (generate_value = Void) or else
					generate_value.is_yes;

			if language_name.is_executable then
				if is_yes then
					System.set_executable_directory (file__name);
				end;
			elseif language_name.is_c then
				if is_yes then
					System.set_c_directory (file__name);
				end;
			elseif language_name.is_object then
				if is_yes then
					System.set_object_directory (file__name);
				end;
			else
				-- Is it an error ?
				io.error.putstring ("%NWARNING: undefined name in Generate clause ");
				io.error.putstring (language_name.language_name);
				io.error.new_line;
			end;
		end;

end
