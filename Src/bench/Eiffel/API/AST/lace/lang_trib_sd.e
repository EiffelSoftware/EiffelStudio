indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class LANG_TRIB_SD

inherit

	AST_LACE
		redefine
			adapt
		end

feature {LACE_AST_FACTORY} -- Initialization

	initialize (ln: like language_name; fn: like file_names) is
			-- Create a new LANG_TRIB AST node.
		require
			ln_not_void: ln /= Void
			fn_not_void: fn /= Void
		do
			language_name := ln
			file_names := fn
		ensure
			language_name_set: language_name = ln
			file_names_set: file_names = fn
		end

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0);
			file_names ?= yacc_arg (1)
		ensure then
			language_name_exists: language_name /= Void;
		end;

feature -- Properties

	language_name: LANGUAGE_NAME_SD;
			-- Language name

	file_names: LACE_LIST [ID_SD];
			-- File names

feature {COMPILER_EXPORTER} -- Lace compilation

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

end -- class LANG_TRIB_SD
