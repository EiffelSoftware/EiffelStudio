-- Language_contrib        : /* empty */
--                         | Language_name LEX_COLUMN File_list
--
-- Language_name           : /* empty */
--                         | Name

class LANG_TRIB_SD

inherit

	AST_LACE
		redefine
			adapt
		end

feature -- Attributes

	language_name: LANGUAGE_NAME_SD;
			-- Language name

	file_names: LACE_LIST [ID_SD];
			-- File names

feature -- Initialization

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0);
			file_names ?= yacc_arg (1)
		ensure then
			language_name_exists: language_name /= Void;
		end;

feature -- Lace compilation

	adapt is
			-- External analysis
		local
			vd34: VD34;
		do
			if language_name.is_make then
				System.set_makefile_names (file_names);
			elseif language_name.is_c then
				System.set_c_file_names (file_names);
			elseif language_name.is_object then
				System.set_object_file_names (file_names);
			elseif language_name.is_include_path then
				System.set_include_paths (file_names);
			else
				!!vd34;
				vd34.set_language_name (language_name.language_name);
				Error_handler.insert_error (vd34);
			end;
		end;

end
