class SHARED_CODE_FILES

inherit
	PROJECT_CONTEXT
	
feature {NONE}

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

	gen_file_name (final_mode: BOOLEAN; base_name: STRING): STRING is
			-- Generate a file either in workbench or final mode with
			-- a `.c' extension.
		do
			if final_mode then
				Result := final_file_name (base_name, Dot_c)
			else
				Result := workbench_file_name (base_name)
			end;
		end;

	x_gen_file_name (final_mode: BOOLEAN; base_name: STRING): STRING is
			-- Generate a file either in workbench or final mode with
			-- a `.x' extension.
		do
			if final_mode then
				Result := final_file_name (base_name, Dot_x)
			else
				Result := workbench_file_name (base_name)
			end;
		end

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

end
