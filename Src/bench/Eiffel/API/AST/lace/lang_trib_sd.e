indexing
	description: "Describe one external clause node";
	date: "$Date$";
	revision: "$Revision$"

class LANG_TRIB_SD

inherit

	AST_LACE
		redefine
			adapt
		end

feature {LANG_TRIB_SD, LACE_AST_FACTORY} -- Initialization

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

feature -- Properties

	language_name: LANGUAGE_NAME_SD;
			-- Language name

	file_names: LACE_LIST [ID_SD];
			-- File names

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result
			Result.initialize (language_name.duplicate, file_names.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then language_name.same_as (other.language_name)
					and then file_names.same_as (other.file_names)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			st.new_line
			language_name.save (st)
			st.putstring (":%N%T%T")
			file_names.save_with_interval_separator (st, ",%N%T%T")
		end

feature {COMPILER_EXPORTER} -- Lace compilation

	adapt is
			-- External analysis
		local
			vd34: VD34;
		do
			if language_name.is_object then
				System.set_object_file_names (file_names)
			elseif language_name.is_include_path then
				System.set_include_paths (file_names)
			elseif language_name.is_assembly then
				System.set_assembly_names (file_names)
			elseif language_name.is_make then
				System.set_makefile_names (file_names)
			elseif language_name.is_c then
				System.set_c_file_names (file_names)
			else
				create vd34
				vd34.set_language_name (language_name.language_name)
				Error_handler.insert_error (vd34)
			end;
		end;

end -- class LANG_TRIB_SD


