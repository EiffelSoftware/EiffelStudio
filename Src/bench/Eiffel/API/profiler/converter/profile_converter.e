class PROFILE_CONVERTER

inherit

	STORABLE

creation
	make

feature -- Creation

	make (profile, project: STRING; s_p_config: SHARED_PROF_CONFIG) is
			-- Creates the converter.
			-- `profile' is the output file from the profile-tool,
			-- `project' is the directory where current project is
			-- located. 
		do
			config := s_p_config;
			profilename := profile;
			!! profile_information.make;
			!! cyclics.make;
			read_profile_file;
			read_translat_file (project);
		end

feature -- Converting

	convert_profile_listing is
			-- Converts the profile-tool-output listing.
		do
			analyse;
		end

feature {PROFILE_CONVERTER} -- analyzing

	analyse is
			-- Analyzes the profile output file (which should be
			-- ASCII !)
		do
			from
				init_analyse;
			until
				string_idx >= profile_string.count
			loop
				retrieve_first_next_token;
				if token_type = Error_token then
					resync_line;
				elseif token_type = Whitespace_token then
					get_next_column;
					if column_nr > config.get_number_of_columns then
						skip_line;
					end;
				else
					record_token;
					if columns_seen = columns_of_interest then
						perform_profile_line;
					end;
				end;
			end;
			end_analyse;
		end;

	init_analyse is
			-- Initializes the analyzation process.
		do
			string_idx := 1;
			column_nr := 1;
			token_type := Newline_token;
			columns_seen := 0;
			columns_of_interest := config.columns_of_interest;
			get_next_column;
		end;

	end_analyse is
			-- Reports end of analization and writes information to
			-- disk.
		local
				file: RAW_FILE;
				a: ANY
		do
			redo_cyclics;
			io.putstring ("Ready with analysis.%N%N");
			profilename.append (Profile_extension);
			!! file.make (profilename);
			if (file.exists and then file.is_writable) or else
					file.is_creatable then
				file.open_write;
				profile_information.independent_store (file);
				file.close;
			else
				a := ("write permission failure").to_c;
				eraise ($a, Io_exception);
			end;
		end;

	redo_cyclics is
			-- All cycles are read, so cyclic functions can be stored.
		local
			number: INTEGER
		do
			from
				cyclics.start;
			until
				cyclics.after
			loop
				number := cyclics.item.cycle_number;
				profile_information.add_function_to_cycle (cyclics.item, number);
				cyclics.forth;
			end;
		end;

	get_next_column is
			-- Goes on analyzing untill start of next column.
			-- A column's contents is every character except
			-- ' ' and '%T'.
			-- This feature reads over the ' ' and '%T' chars.
		do
			if profile_string.item (string_idx) = ' ' or else profile_string.item (string_idx) = '%T' then
				from
					string_idx := string_idx + 1
				until
					profile_string.item(string_idx) /= ' ' and then profile_string.item(string_idx) /= '%T'
				loop
					string_idx := string_idx + 1;
				end;
				column_nr := column_nr + 1;
			end;
		end

	record_token is
			-- Records a token. If it is (by configuration) not possible
			-- to record the token at this column, we skip the rest of
			-- the line.
		do
			if token_type = Real_token then
				perform_real_token;
			elseif token_type = Number_token then
				perform_number_token;
			elseif token_type = Index_token then
				perform_index_token;
			elseif token_type = String_token then
				perform_string_token;
			elseif token_type = Newline_token then
				perform_newline_token;
			end;
		end

	perform_real_token is
			-- Does the actual recording of a lexeme of
			-- token_type = Real_token.
		do
			if config.get_function_time_column = column_nr then
				function_time := token_string.to_real;
				columns_seen := columns_seen + 1;
			elseif config.get_descendent_time_column = column_nr then
				descendent_time := token_string.to_real;
				columns_seen := columns_seen + 1;
			elseif config.get_percentage_column = column_nr then
				percentage := token_string.to_real;
				columns_seen := columns_seen + 1;
			else
				skip_line;
			end;
		end

	perform_number_token is
			-- Does the actual recording of a lexeme of
			-- token_type = Number_token.
		do
			if config.get_number_of_calls_column = column_nr then
				number_of_calls := token_string.to_integer;
				columns_seen := columns_seen + 1;
			else
				skip_line;
			end;
		end

	perform_string_token is
			-- Does the actual recording of a lexeme of
			-- token_type = String_token.
		local
			space, number: INTEGER;
			num_str: STRING;
		do
			if config.get_function_name_column = column_nr then
				if token_string.item (1) = '<' then
					space := token_string.index_of (' ', 1);
					num_str := token_string.substring (space + 1, token_string.index_of (' ', space + 1));
					number := num_str.to_integer;
					!! cycle_function.make (number);
					is_cycle := true;
					is_eiffel := false;
					is_c := false;
				else
					function_name := token_string;
					function_name.right_adjust;

					if functions.has (function_name) then
						e_function := functions.item (function_name)
						is_eiffel := true;
						is_c := false;
						is_cycle := false;
					else
						!! c_function.make (function_name);
						is_c := true;
						is_cycle := false;
						is_eiffel := false;
					end;
					if profile_string.item (string_idx) = ' ' and then
							profile_string.item (string_idx + 1) = '<' then
						from
							string_idx := string_idx + 1;
							!! cycle_name.make (0);
							cycle_name.extend ('<');
						until
							profile_string.item (string_idx) = '>'
						loop
							cycle_name.extend (profile_string.item (string_idx));
							string_idx := string_idx + 1;
						end;
						cycle_name.extend ('>');
						string_idx := string_idx + 1;
						space := cycle_name.index_of (' ', 1);
						num_str := cycle_name.substring (space + 1, cycle_name.count - 1);
						number := num_str.to_integer;
						if is_eiffel then
							e_function.set_member_of_cycle (number);
							if profile_information.has_cycle (number) then
								profile_information.add_function_to_cycle (e_function, number);
							else
								cyclics.extend (e_function);
							end;
						else
							c_function.set_member_of_cycle (number);
							if profile_information.has_cycle (number) then
								profile_information.add_function_to_cycle (c_function, number);
							else
								cyclics.extend (c_function);
							end;
						end;
					end;
				end;
				columns_seen := columns_seen + 1;
			else
				skip_line;
			end;
		end

	perform_index_token is
			-- Does the actual recording of a lexeme of
			-- token_type = Index_token.
		do
			if config.get_index_column = column_nr then
				columns_seen := columns_seen + 1;
			else
				skip_line;
			end;
		end

	perform_newline_token is
			-- Does the actual recording of a lexeme of
			-- token_type = Newline_token.
		do
			if columns_seen = columns_of_interest then
				perform_profile_line;
			end;
			string_idx := string_idx + 1;
			columns_seen := 0;
			column_nr := 1;
			token_type := Newline_token;
		end
			
	perform_profile_line is
			-- Sets up a PROFILE_DATA object for storage into the
			-- `profile_information' object.
		local
			total_time: REAL;
			e_data: EIFFEL_PROFILE_DATA;
			c_data: C_PROFILE_DATA;
			cy_data: CYCLE_PROFILE_DATA
		do
			if config.get_config_name.is_equal ("win32_ms") then
					-- Currently ONLY win32_ms prints total_time rather than
					-- descendent_time only. To get the descendent_time
					-- we subtract the function_time at this point, because
					-- here it is guaranteed that we know the function_time.
				descendent_time := descendent_time - function_time;
			end;

			if is_eiffel then
				!! e_data.make (number_of_calls, percentage, function_time, descendent_time, e_function);
				profile_information.insert_eiffel_profiling_data (e_data);

			elseif is_c then
				!! c_data.make (number_of_calls, percentage, function_time, descendent_time, c_function);
				if function_name.is_equal ("main") then
					total_time := function_time + descendent_time;
					profile_information.set_total_execution_time (total_time);
				end;
				profile_information.insert_c_profiling_data (c_data);

			elseif is_cycle then
				!! cy_data.make (number_of_calls, percentage, function_time, descendent_time,cycle_function);
				profile_information.insert_cycle_profiling_data (cy_data);
			end;

			skip_line;
		end;

	skip_line is
			-- Reads up until just after the first appearance of
			-- '%N'.
		do
			from
			until
				profile_string.item (string_idx) = '%N'
			loop
				string_idx := string_idx + 1;
			end;
			string_idx := string_idx + 1;
			columns_seen := 0;
			column_nr := 1;
		end;

	resync_line is
			-- Reads in the line up to first legal character.
			-- A legal character any of the following:
			-- digits, alphas, '.', '_', '[', ']',
			-- ' ', '%T', and '%N'.
		local
			char: CHARACTER
		do
			from
				char := profile_string.item (string_idx);
			until
				char.is_digit or else char.is_alpha or else
				char ='[' or else char = ']' or else
				char = '.' or else char = '_' or else
				char = ' ' or else char = '%T' or else char = '%N'
			loop
				string_idx := string_idx + 1;
				char := profile_string.item (string_idx);
			end;
		end;

	retrieve_first_next_token is
			-- Checks whether the next characters can be grouped into
			-- one of the predefined tokens (string, number, real, index, new_line).
			-- If so 'token_type' is respectively String_token, Number_token, Real_token, Index_token, Newline_token.
			-- If not 'token_type' is Error_token.
		local
			next_char: CHARACTER
			temp_noc: INTEGER
		do
			next_char := profile_string.item (string_idx);
			if next_char.is_alpha or else next_char = '_' then
				!! token_string.make (0);
				token_string.extend (next_char);
				from
					string_idx := string_idx + 1;
					next_char := profile_string.item (string_idx);
				until
					not (next_char.is_alpha) and then
					not (next_char = '_') and then
					not (next_char.is_digit)
				loop
					token_string.extend (next_char);
					string_idx := string_idx + 1;
					next_char := profile_string.item (string_idx);
				end;
				if config.get_leading_underscore then
					if token_string.item(1) = '_' then
						token_string := token_string.substring (2, token_string.count);
					end;
				end;
				token_type := String_token;
			elseif next_char = '<' then
				from
					!! token_string.make (0);
					token_string.extend (next_char);
					string_idx := string_idx + 1;
					next_char := profile_string.item (string_idx);
				until
					next_char = '>'
				loop
					token_string.extend (next_char);
					string_idx := string_idx + 1;
					next_char := profile_string.item (string_idx);
				end;
				token_string.extend (next_char);
				string_idx := string_idx + 1;
				token_type := String_token;
			elseif next_char.is_digit then
				!! token_string.make (0);
				token_string.extend (next_char);
				from
					string_idx := string_idx + 1;
					next_char := profile_string.item (string_idx);
				until
					not (next_char.is_digit) and then
					not (next_char = '.')
				loop
					token_string.extend (next_char);
					string_idx := string_idx + 1;
					next_char := profile_string.item (string_idx);
				end;

				-- GPROF's output __CAN__ have x+y for call-cycles.
				if next_char = '+' then
					from
						temp_noc := token_string.to_integer;
						string_idx := string_idx + 1;
						next_char := profile_string.item (string_idx);
						!! token_string.make (0);
					until
						not (next_char.is_digit)
					loop
						token_string.extend (next_char);
						string_idx := string_idx + 1;
						next_char := profile_string.item (string_idx);
					end;
					temp_noc := temp_noc + token_string.to_integer;
					token_string := temp_noc.out;
				end;

				if token_string.is_integer then
					token_type := Number_token;
				elseif token_string.is_real then
					token_type := Real_token;
				else
					token_type := Error_token;
				end;
			elseif next_char = '[' then
				!! token_string.make (0);
				token_string.extend (next_char);
				from
					string_idx := string_idx + 1;
					next_char := profile_string.item (string_idx);
				until
					not (next_char.is_digit)
				loop
					token_string.extend (next_char);
					string_idx := string_idx + 1;
					next_char := profile_string.item (string_idx);
				end
				if next_char = ']' then
					token_string.extend (next_char);
					string_idx := string_idx + 1;
					token_type := Index_token;
				else
					token_type := Error_token;
				end;
			elseif next_char = '%N' then
				token_string := "%N"
				token_type := Newline_token;
			elseif next_char = '%T' or else next_char = ' ' then
				token_string := Void
				token_type := Whitespace_token;
			else
				token_type := Error_token
				string_idx := string_idx + 1;
			end
		end

feature {NONE} -- Commands

	read_profile_file is
			-- reads the profile listing into memory
		local
			file : PLAIN_TEXT_FILE
		do
			!!file.make_open_read (profilename);
			file.read_stream (file.count);
			profile_string := file.last_string;
			file.close
		end -- read_profile_file

	read_translat_file (filename: STRING) is
			-- reads the `TRANSLAT' file into memory
		local
			retried: BOOLEAN
			file: PLAIN_TEXT_FILE
			table_file: PLAIN_TEXT_FILE
			table_name: STRING
		do
			!!file.make (filename);
			table_name := clone(filename);
			table_name.append_string (Table_extension);
			!!table_file.make (table_name);

				-- Both files should exist. Existence of TRANSLAT
				-- is already checked in the root class
			if table_file.exists then
				if table_file.date < file.date or else retried then
					file.open_read
					file.read_stream (file.count);
					translat_string := file.last_string;
					file.close;
					make_function_table (table_name)
				else
					functions ?= retrieve_by_name(table_name)
					if functions = Void then
						file.open_read
						file.read_stream (file.count);
						translat_string := file.last_string;
						file.close;
						make_function_table (table_name)
					end
				end
			else
				file.open_read
				file.read_stream (file.count);
				translat_string := file.last_string;
				file.close;
				make_function_table (table_name)
			end
		rescue
			retried := true;
			retry;
		end

	make_function_table (filename: STRING) is
			-- creates the function table
			-- and stores it on disk in file `filename'
		local
			c_name, cluster_name, cl_name, feature_name, translat_line: STRING
			first_tab, second_tab: INTEGER
			new_function: EIFFEL_FUNCTION
			object_file: RAW_FILE
		do
			from
				!!functions.make (20);
				io.putstring ("Creating function table. Please wait...%N")
			until
				translat_string.count = 0
			loop
					-- Initialize function / feature name.
				!!c_name.make (0);
				!!cluster_name.make (0);
				!!cl_name.make (0);
				!!feature_name.make (0);

					-- Get a single line from the string.
				translat_line := get_translat_line;

					-- Get cludter name for Eiffel feature
				first_tab := translat_line.index_of ('%T', 1);
				cluster_name.append_string (translat_line.substring (1, first_tab - 1));

					-- Get class name (plus actual generics) for Eiffel feature
				second_tab := translat_line.index_of ('%T', first_tab + 1);
				cl_name.append_string (translat_line.substring (first_tab + 1, second_tab - 1));

					-- Get feature name for Eiffel feature
				first_tab := second_tab + 1;
				second_tab := translat_line.index_of ('%T', first_tab);
				feature_name.append_string (translat_line.substring (first_tab, second_tab - 1));

					-- Get function name for C function
				first_tab := second_tab + 1;
				second_tab := translat_line.index_of ('%T', first_tab);
				c_name.append_string (translat_line.substring (first_tab, second_tab - 1));

					-- Put function-feature in the hash table.
				!!new_function.make (cluster_name, cl_name, feature_name)
				functions.put (new_function, c_name)
			end
			!! object_file.make_open_write (filename)
			functions.independent_store(object_file)
			object_file.close
		end

	get_translat_line : STRING is
		local
			new_line_index : INTEGER
		do
			!!Result.make(0);
			new_line_index := translat_string.index_of('%N',1);
			Result.append_string(translat_string.substring(1, new_line_index));
			translat_string.tail(translat_string.count - new_line_index)
		end -- get_translat_line

feature {NONE} -- Attributes

	profilename: STRING

	profile_information: PROFILE_INFORMATION
		-- Information about the profiled application.

	functions: STORABLE_FUNCTION_TABLE [EIFFEL_FUNCTION, STRING]

	translat_string: STRING

	profile_string: STRING

	reals: ARRAY [REAL]

	e_function: EIFFEL_FUNCTION

	c_function: C_FUNCTION

	cycle_function: CYCLE_FUNCTION

	cycle_name: STRING

	index: STRING

	real_index: INTEGER

	is_cycle, is_eiffel, is_c: BOOLEAN

	cyclics: TWO_WAY_LIST [FUNCTION]

	Table_extension: STRING is ".function_table"
		-- Extension used to distinguish between compiler
		-- created TRANSLAT file and function table created
		-- by this application

	Profile_extension: STRING is ".profile_information"

	config: SHARED_PROF_CONFIG
		-- Values as retrieved from the resource file for the
		-- specific profiler-tool.

	string_idx: INTEGER

	column_nr: INTEGER
		-- At which column are we currently looking?

	token_type: INTEGER
		-- Type of last token seen. Is one out of the Constants.

	token_string: STRING
		-- Lexeme for `token_type'.

	columns_seen: INTEGER
		-- How many columns of interest did we see so far?

	columns_of_interest: INTEGER
		-- Columns of interest as specified by `config'.

	function_time: REAL

	descendent_time: REAL

	percentage: REAL

	number_of_calls: INTEGER

	function_name: STRING

feature {NONE} -- Constants

	String_token: INTEGER is unique

	Number_token: INTEGER is unique

	Real_token: INTEGER is unique

	Index_token: INTEGER is unique

	Newline_token: INTEGER is unique

	Whitespace_token: INTEGER is unique

	Error_token: INTEGER is unique
	
end -- class PROFILE_CONVERTER
