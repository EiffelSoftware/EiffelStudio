class SHARED_CODE_FILES

inherit
	PROJECT_CONTEXT
	
feature {NONE}

	size_file (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the type sizes are generated
			--! This is not a once function since
			--! we want different postfix for the
			--! file name
		local
			dir_name: DIRECTORY_NAME;
			file_name: FILE_NAME;
			subdir_name: STRING;
			subdir: DIRECTORY;
			temp: STRING
		do
			subdir_name := clone (System_object_prefix);
			subdir_name.append_integer (1);
			if final_mode then
				!!dir_name.make_from_string (Final_generation_path);
				dir_name.extend (subdir_name);
				!!subdir.make (dir_name);
				if not subdir.exists then
					subdir.create_dir
				end;
				temp := clone (Esize);
				temp.append (Dot_x);
			else
				!!dir_name.make_from_string (Workbench_generation_path);
				dir_name.extend (subdir_name);
				!!subdir.make (dir_name);
				if not subdir.exists then
					subdir.create_dir
				end;
				temp := clone (Esize);
				temp.append (Dot_c);
			end;
			!!file_name.make_from_string (dir_name);
			file_name.set_file_name (temp);
			!!Result.make (file_name);
		end;

	History_file: INDENT_FILE is
			-- File containing history tables
		once
			!!Result.make (final_file_name (Ehisto, Dot_c));
		end;

	Reference_file: INDENT_FILE is
			-- File where the table of number of redeferences is generated
		once
			!!Result.make (final_file_name (Eref, Dot_c));
		end;

	Skeleton_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the skeletons correponding to the
			-- Eiffel class types are generated
		do
			!!Result.make (gen_file_name (final_mode, Eskelet));
		end;

	Cecil_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the datas for visible classes are generated
		do
			!!Result.make (gen_file_name (final_mode, Evisib));
		end;

	Conformance_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the conformance tables are generated.
		do
			!!Result.make (gen_file_name (final_mode, Econform));
		end;

	Parent_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the parent tables are generated.
		do
			!!Result.make (gen_file_name (final_mode, Eparents));
		end;

	Plug_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File miscellenaeous datas are generated for the run-time
		do
			!!Result.make (gen_file_name (final_mode, Eplug));
		end;

	Pattern_file: INDENT_FILE is
			-- File where all the pattern for the workbench mode
			-- are generated
		once
			!!Result.make (workbench_file_name (Epattern));
		end;

	Option_file: INDENT_FILE is
			-- File where the compilation option are generated
		once
			!!Result.make (workbench_file_name (Eoption));
		end;

	Address_table_file (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the encapsulation of function pointers are generated
		do
			!!Result.make (gen_file_name (final_mode, Ececil));
		end;

	Rout_info_file: INDENT_FILE is
			-- File where the compilation option are generated
		once
			!!Result.make (workbench_file_name (Ecall));
		end;

	Init_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the C routine `c_main' is generated
		do
			!!Result.make (gen_file_name (final_mode, Einit));
		end;

	Main_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the C routine `c_main' is generated
		do
			!!Result.make (gen_file_name (final_mode, Emain));
		end;

	Dispatch_file: INDENT_FILE is
			-- File where the dispatch table `dispatch' is generated
		once
			!!Result.make (workbench_file_name (Edispatch));
		end;

	Frozen_file: INDENT_FILE is
			-- File where the frozen routines array `frozen' is generated
		once
			!!Result.make (workbench_file_name (Efrozen));
		end;

	Make_f (final_mode: BOOLEAN): INDENT_FILE is
			-- Makefile for C compilation
		local
			p: STRING;
			f_name: FILE_NAME
		do
			if final_mode then
				p := Final_generation_path
			else
				p := Workbench_generation_path
			end;
			!!f_name.make_From_string (p);
			f_name.set_file_name (Makefile_SH);
			!!Result.make (f_name);
		end;

feature {NONE}

	final_file_name (base_name, extension: STRING): STRING is
		local
			subdir_name: STRING;
			subdir: DIRECTORY;
			dir_name: DIRECTORY_NAME;
			file_name: FILE_NAME;
			temp: STRING
		do
			subdir_name := clone (System_object_prefix);
			subdir_name.append_integer (1);

			!!dir_name.make_from_string (Final_generation_path);
			dir_name.extend (subdir_name);
			!! subdir.make (dir_name);
			if not subdir.exists then
				subdir.create_dir
			end;
			!!file_name.make_from_string (dir_name);
			temp := clone (base_name);
			temp.append (extension);
			file_name.set_file_name (temp);
			Result := file_name
		end;

	workbench_file_name (base_name: STRING): STRING is
		local
			subdir_name: STRING;
			subdir: DIRECTORY;
			dir_name: DIRECTORY_NAME;
			file_name: FILE_NAME;
			temp: STRING
		do
			subdir_name := clone (System_object_prefix);
			subdir_name.append_integer (1);

			!!dir_name.make_from_string (Workbench_generation_path);
			dir_name.extend (subdir_name);
			!! subdir.make (dir_name);
			if not subdir.exists then
				subdir.create_dir
			end;
			!!file_name.make_from_string (dir_name);
			temp := clone (base_name);
			temp.append (Dot_c);
			file_name.set_file_name (temp);
			Result := file_name
		end;

	gen_file_name (final_mode: BOOLEAN; base_name: STRING): STRING is
		do
			if final_mode then
				Result := final_file_name (base_name, Dot_c)
			else
				Result := workbench_file_name (base_name)
			end;
		end;

end
