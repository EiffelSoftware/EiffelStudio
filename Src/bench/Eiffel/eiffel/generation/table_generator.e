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

	current_file: UNIX_FILE;
			-- Current generate file

	infix_file_name: STRING is
			-- Infix string for file names
		deferred
		end;

	postfix_file_name: CHARACTER is
			-- Postfix character for file names (after `.');
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

	new_file: UNIX_FILE is
			-- New file for generation
		local
			file_name: STRING;
		do
			file_counter := file_counter + 1;
			!!file_name.make
				(infix_file_name.count + 4 + generation_path.count);
			file_name.append (generation_path);
			file_name.append (infix_file_name);
			file_name.append_integer (file_counter);
			file_name.append_character ('.');
			file_name.append_character (postfix_file_name);
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
