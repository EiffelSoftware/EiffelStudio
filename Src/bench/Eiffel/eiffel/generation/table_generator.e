-- Description of a generator of table: the aim of this is the split
-- of the routine/attribute offset table generation into several files
-- because the C compilers don't support too heavy files of static
-- declarations

deferred class TABLE_GENERATOR 

inherit

	SHARED_CODE_FILES;
	SHARED_BYTE_CONTEXT;
	
feature

	size: INTEGER;
			-- Estimation of the size of the current generated file

	file_counter: INTEGER;
			-- Count of generated files

	current_file: INDENT_FILE;
			-- Current generate file

	infix_file_name: STRING is
			-- Infix string for file names
		deferred
		end;

	postfix_file_name: STRING is
			-- Postfix string for file names;
		deferred
		end;

	size_limit: INTEGER is
			-- Limit of size for each generated file
		deferred
		end;

	init is
			-- Initialization
		do
			file_counter := 0;
			current_file := new_file;
			current_file.open_write;
			init_file;
		end;

	new_file: INDENT_FILE is
			-- New file for generation
		local
			dir_name: DIRECTORY_NAME;
			file_name: FILE_NAME;
			temp: STRING;
			subdir: DIRECTORY
		do
			temp := clone (System_object_prefix);
			temp.append_integer (1);
			file_counter := file_counter + 1;

			!!dir_name.make_from_string (Final_generation_path);
			dir_name.extend (temp);

			!! subdir.make (dir_name);
			if not subdir.exists then
				subdir.create
			end;

			!!file_name.make_from_string (dir_name);
			temp := clone (infix_file_name);
			temp.append_integer (file_counter);
			temp.append (postfix_file_name);
			file_name.set_file_name (temp);

			!!Result.make (file_name);
		end;

	init_file is
			-- Initialization of new file
		deferred
		end; -- init_file

	generate (table: POLY_TABLE [ENTRY]) is
			-- Generation of `table'.
		require
			current_file_exists: current_file /= Void;
			is_open: current_file.is_open_write;
			good_argument: table /= Void;
		do
			update;
			size := size + table.final_table_size;
			table.generate (current_file);
		end;

	generate_workbench (table: POLY_TABLE [ENTRY]) is
			-- Generation of the workbench table `table'.
		do
			update;
			size := size + table.workbench_table_size;
			table.generate_workbench (current_file);
		end;

	generate_type_table (table: POLY_TABLE [ENTRY]; final_mode: BOOLEAN) is
			-- Generation of associated type table of `table'.
		require
			current_file_exists: current_file /= Void;
			is_open: current_file.is_open_write;
			good_argument: table /= Void;
			has_type_table: table.has_type_table;
		do
			update;
			size := size + table.final_table_size;
			table.generate_type_table (current_file, final_mode);
		end;

	update is
			-- Update current file
		do
			if size > Size_limit then
				size := 0;
				current_file.close;
				finish_file;
				current_file := new_file;
				current_file.open_write;
				init_file;
			end;
		end;

	finish is
			-- Close `current_file'.
		require
			current_file_exists: current_file /= Void;
			is_open: current_file.is_open_write;
		do
			current_file.close;
			finish_file;
		end;

	finish_file is
			-- finish generation of `current_file'.
		do
			-- Do nothing
		end;

end
