indexing

	description:
		"Retrieves the profiler configuration file.";
	date: "Date: ";
	revision: "Revision: "

class CONFIGURATION_LOADER

inherit
	EIFFEL_ENV;
	SHARED_WORKBENCH;
	SHARED_EIFFEL_PROJECT

creation
	make_and_load

feature -- Initialization

	make_and_load (prof: STRING) is
			-- Load the specific profiler-configuration file.
		do
			!! shared_prof_config;
			profiler_type := prof;
			prof.to_lower;
			read_config_file (prof);
			if not error_occured then
				shared_prof_config.set_config_name (prof)
			end
		end

feature {NONE} -- Implementation

	read_config_file (prof: STRING) is
			-- Reads the values from the configuration file
		local
			file_name: FILE_NAME;
			retried: BOOLEAN
		do
			if not retried then
				!! file_name.make_from_string (profile_path);
				file_name.extend (prof);

				if not file_name.is_valid then
					error_occured := true;
					error_code := Invalid_profiler_type
				else
					!! config_file.make_open_read (file_name);
					config_file.read_stream (config_file.count);
					file_contents := config_file.last_string;
					config_file.close;
					get_number_of_columns;
					get_index_column;
					get_function_time_column;
					get_descendant_time_column;
					get_number_of_calls_column;
					get_function_name_column;
					get_percentage_column;
					get_leading_underscore;
				end;
			else
				error_occured := true;
			end;
		rescue
			retried := true;
			retry;
		end;

feature {NONE} -- Implementation

	get_number_of_columns is
			-- Retrieves the number of columns from the configure file.
		local
			i: INTEGER
		do
			i := get_integer_value (NOC_string);
			if i = -1 then
				error_occured := true;
			else
				shared_prof_config.set_number_of_columns (i);
			end;
		end

	get_index_column is
			-- Retriees the position of the index field.
		local
			i: INTEGER
		do
			i := get_integer_value (IC_string);
			if i = -1 then
				error_occured := true;
			else
				shared_prof_config.set_index_column (i);
			end;
		end

	get_function_time_column is
			-- Retrieves the column of the function_time field.
		local
			i: INTEGER
		do
			i := get_integer_value (FTC_string);
			if i = -1 then
				error_occured := true;
			else
				shared_prof_config.set_function_time_column (i);
			end;
		end

	get_descendant_time_column is
			-- Retrieves the column of the descendant_time field.
		local
			i: INTEGER
		do
			i := get_integer_value (DTC_string);
			if i = -1 then
				error_occured := true;
			else
				shared_prof_config.set_descendant_time_column (i);
			end;
		end

	get_number_of_calls_column is
			-- Retrieves the column of the number_of_calls_field.
		local
			i: INTEGER
		do
			i := get_integer_value (NOCC_string);
			if i = -1 then
				error_occured := true;
			else
				shared_prof_config.set_number_of_calls_column (i);
			end;
		end

	get_function_name_column is
			-- Retrieves the column of the function_name field.
		local
			i: INTEGER
		do
			i := get_integer_value (FNC_string);
			if i = -1 then
				error_occured := true;
			else
				shared_prof_config.set_function_name_column (i);
			end;
		end

	get_percentage_column is
			-- Retrieves the column of the percentage field.
		local
			i: INTEGER
		do
			i := get_integer_value (PC_string);
			if i = -1 then
				error_occured := true;
			else
				shared_prof_config.set_percentage_column (i);
			end;
		end

	get_leading_underscore is
			-- Retrieves whether the profiler generates a leading
			-- underscore.
		local
			s: STRING
		do
			s := get_string_value (GLU_string);
			if s = Void then
				error_occured := true;
			else
				s.to_lower;
				if s.is_equal ("yes") then
					shared_prof_config.set_leading_underscore (true);
				elseif s.is_equal ("no") then
					shared_prof_config.set_leading_underscore (false);
				else
					error_occured := true;
				end;
			end;
		end

	get_integer_value (s: STRING): INTEGER is
			-- Retrieve the integer value for tag 's' in the
			-- configuration file.
			-- Return -1, if 's' is not found.
		local
			str_idx: INTEGER;
			result_str: STRING
		do
			!! result_str.make (0);
			str_idx := file_contents.substring_index (s, 1);
			if str_idx = 0 then
				Result := -1;
			else
				str_idx := file_contents.substring_index (":", str_idx);
				from
					str_idx := str_idx + 1
				until
					file_contents.item(str_idx).is_digit
				loop
					str_idx := str_idx + 1
				end

				from
				until
					not file_contents.item(str_idx).is_digit
				loop
					result_str.extend (file_contents.item(str_idx));
					str_idx := str_idx + 1;
				end
				Result := result_str.to_integer;
			end;
		end;

	get_string_value (s: STRING): STRING is
			-- Retrieve the integer value for tag 's' in the
			-- configuration file.
			-- Return Void, if 's' is not found.
		local
			str_idx: INTEGER;
		do
			str_idx := file_contents.substring_index (s, 1);
			if str_idx /= 0 then
				str_idx := file_contents.substring_index (":", str_idx);
				from
					str_idx := str_idx + 1
				until
					file_contents.item(str_idx).is_alpha
				loop
					str_idx := str_idx + 1
				end

				from
					!! Result.make (0);
				until
					not file_contents.item(str_idx).is_alpha
				loop
					Result.extend (file_contents.item(str_idx));
					str_idx := str_idx + 1;
				end
			end;
		end;

feature {NONE} -- Attributes

	config_file: PLAIN_TEXT_FILE;
		-- The configuration file.

	file_contents: STRING;
		-- The contents of the configuration file.

feature {NONE} -- Constants

	NOC_string: STRING is "number_of_columns";
		-- number_of_columns

	IC_string: STRING is "index_column";
		-- index_column

	FTC_string: STRING is "function_time_column";
		-- functin_time_column

	DTC_string: STRING is "descendant_time_column";
		-- descendant_time_column

	NOCC_string: STRING is "number_of_calls_column";
		-- number_of_calls_column

	FNC_string: STRING is "function_name_column";
		-- function_name_column

	PC_string: STRING is "percentage_column";
		-- percentage_column

	GLU_string: STRING is "generates_leading_underscore";
		-- generates_leading_underscore

feature {EWB_GENERATE, GENERATE_PROFILE_INFO_CMD, EB_GENERATE_PROFILE_INFO_CMD, EB_PROFILER_WIZARD_GENERATOR} -- Error handling

	error_occured: BOOLEAN
		-- Was there an error during the load of the config file?

	error_code: INTEGER
		-- Configure load error code

	shared_prof_config: SHARED_PROF_CONFIG
		-- Shared configuration values

	profiler_type: STRING
		-- The profile tool used for profiling.

	Invalid_profiler_type: INTEGER is unique
		-- No profiler information file found in
		-- Eiffel installation directory under "bench/profiler".

end -- class CONFIGURATION_LOADER
