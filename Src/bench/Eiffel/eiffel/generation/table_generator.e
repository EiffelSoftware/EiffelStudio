-- Description of a generator of table: the aim of this is the split
-- of the routine/attribute offset table generation into several files
-- because the C compilers don't support too heavy files of static
-- declarations

deferred class TABLE_GENERATOR 

inherit
	SHARED_CODE_FILES;
	SHARED_BYTE_CONTEXT;
	SHARED_GENERATION
	
feature

	size: INTEGER;
			-- Estimation of the size of the current generated file

	file_counter: INTEGER;
			-- Count of generated files

	current_buffer: GENERATION_BUFFER;
			-- Current buffer

	infix_file_name: STRING is
			-- Infix string for file names
		deferred
		end;

	postfix_file_name: STRING is
			-- Postfix string for file names;
		deferred
		end;

	Size_limit: INTEGER is 30000;
			-- Limit of size for each generated file

	init (buffer: GENERATION_BUFFER) is
			-- Initialization
		do
			file_counter := 1;
			current_buffer := buffer
			current_buffer.clear_all
			init_file;
		end;

	new_file: INDENT_FILE is
			-- New file for generation
		local
			temp: STRING
		do
			temp := clone (infix_file_name);
			temp.append_integer (file_counter);
			!! Result.make_open_write (final_file_name (temp, postfix_file_name))
			file_counter := file_counter + 1;
		end;

	init_file is
			-- Initialization of new file
		deferred
		end; -- init_file

	generate (table: POLY_TABLE [ENTRY]) is
			-- Generation of `table'.
		require
			current_buffer_exists: current_buffer /= Void;
			good_argument: table /= Void;
		do
			update;
			size := size + table.final_table_size;
			table.generate (current_buffer);
		end;

	generate_type_table (table: POLY_TABLE [ENTRY]) is
			-- Generation of associated type table of `table'
			-- in final mode.
		require
			current_buffer_exists: current_buffer /= Void;
			good_argument: table /= Void;
			has_type_table: table.has_type_table;
		do
			update;
			size := size + table.final_table_size;
			table.generate_type_table (current_buffer);
		end;

	update is
			-- Update current file
		do
			if size > Size_limit then
				size := 0;
				finish
				init_file;
			end;
		end;

	finish is
			-- Close `current_buffer'.
		require
			current_buffer_exists: current_buffer /= Void;
		local
			file: INDENT_FILE
		do
			file := new_file
			file.put_string (current_buffer)
			file.close
			finish_file;
		end;

	finish_file is
			-- finish generation of `current_buffer'.
		do
				-- Clear buffer for Current generation
			current_buffer.clear_all
		end;

end
