-- Description of a generator of table: the aim of this is the split
-- of the routine/attribute offset table generation into several files
-- because the C compilers don't support too heavy files of static
-- declarations

deferred class TABLE_GENERATOR 

inherit
	SHARED_CODE_FILES;
	SHARED_BYTE_CONTEXT;
	SHARED_GENERATION
	SHARED_WORKBENCH

feature -- Initialization

	init (buffer: GENERATION_BUFFER) is
			-- Initialization
		do
			file_counter_cell.set_item (1)
			current_buffer := buffer
			current_buffer.clear_all
		ensure
			file_counter_set: file_counter = 1
		end;
	
feature -- Access

	file_counter: INTEGER is
			-- Count of generated files.
		do
			Result := file_counter_cell.item
		end

	size: INTEGER;
			-- Estimation of the size of the current generated file

	current_buffer: GENERATION_BUFFER;
			-- Current buffer

	postfix_file_name: STRING is
			-- Postfix string for file names;
		deferred
		end;

	Size_limit: INTEGER is 20000;
			-- Limit of size for each generated file


	new_file: INDENT_FILE is
			-- New file for generation
		local
			temp: STRING
			n, packet_number: INTEGER
		do
			temp := clone (Epoly);
			n := file_counter
			temp.append_integer (n);
			packet_number := n // System.makefile_generator.System_packet_number + 2
			create Result.make_c_code_file (final_file_name (temp, postfix_file_name, packet_number))
		end;

	init_file (file: INDENT_FILE) is
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
			init_file (file)
			file.put_string (current_buffer)
			file.close
			finish_file;
			increment_file_counter
		end;

	finish_file is
			-- finish generation of `current_buffer'.
		do
				-- Clear buffer for Current generation
			current_buffer.clear_all
		end;

feature -- Settings

	increment_file_counter is
			-- Increment `file_counter' from 1.
		do
			file_counter_cell.set_item (file_counter + 1)
		ensure
			file_counter_incremented: file_counter = (old file_counter + 1)
		end

feature {NONE} -- Implementation

	file_counter_cell: INTEGER_REF is
			-- Shared value for file name generation in final mode only.
		once
			create Result
		end

end
