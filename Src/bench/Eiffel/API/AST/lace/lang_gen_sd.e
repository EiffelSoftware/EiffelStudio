indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class LANG_GEN_SD

inherit

	AST_LACE
		redefine
			adapt
		end

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0);
			generate_value ?= yacc_arg (1);
			file__name ?= yacc_arg (2)
		ensure then
			language_name_exists: language_name /= Void;
		end;

feature -- Properties

	language_name: LANGUAGE_NAME_SD;
			-- Language name

	generate_value: YES_OR_NO_SD;
			-- Generation value

	file__name: ID_SD;
			-- File name

feature {COMPILER_EXPORTER}

	adapt is
			-- Generate analysis
		local
			is_yes: BOOLEAN;
			vd33: VD33;
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
				!!vd33;
				vd33.set_language_name (language_name.language_name);
				Error_handler.insert_error (vd33);
			end;
		end;

end -- class LANG_GEN_SD
