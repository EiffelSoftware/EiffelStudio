indexing

	description:	"Holds the values from the profiler specific %
					% configuration file.";
	date:		   "Date: ";
	revision:	   "Revision: "

class SHARED_PROF_CONFIG

feature {CONFIGURATION_LOADER} -- Status setting

	set_config_name (s: STRING) is
			-- Set the config_name to `s'.
		do
			configuration_name := s;
		end;

	set_number_of_columns (i: INTEGER) is
			-- Set the column to `i'.
		do
			number_of_columns := i;
		end;

	set_index_column (i: INTEGER) is
			-- Set the column to `i'.
		do
			index_column := i;
		end;

	set_function_time_column (i: INTEGER) is
			-- Set the column to `i'.
		do
			function_time_column := i;
		end;

	set_descendent_time_column (i: INTEGER) is
			-- Set the column to `i'.
		do
			descendent_time_column := i;
		end;

	set_number_of_calls_column (i: INTEGER) is
			-- Set the column to `i'.
		do
			number_of_calls_column := i;
		end;

	set_function_name_column (i: INTEGER) is
			-- Set the column to `i'.
		do
			function_name_column := i;
		end;

	set_percentage_column (i: INTEGER) is
			-- Set the column to `i'.
		do
			percentage_column := i;
		end;

	set_leading_underscore (b: BOOLEAN) is
			-- Set the leading_underscore to `b'.
		do
			leading_underscore := b;
		end;

feature -- Status report

	get_config_name: STRING is
		do
			Result := configuration_name;
		end;

	get_number_of_columns: INTEGER is
		do
			Result := number_of_columns;
		end;

	get_index_column: INTEGER is
		do
			Result := index_column;
		end;

	get_function_time_column: INTEGER is
		do
			Result := function_time_column;
		end;

	get_descendent_time_column: INTEGER is
		do
			Result := descendent_time_column;
		end;

	get_number_of_calls_column: INTEGER is
		do
			Result := number_of_calls_column;
		end;

	get_function_name_column: INTEGER is
		do
			Result := function_name_column;
		end;

	get_percentage_column: INTEGER is
		do
			Result := percentage_column;
		end;

	get_leading_underscore: BOOLEAN is
		do
			Result := leading_underscore;
		end;
	
	columns_of_interest: INTEGER is
			-- How many columns are of interest in the profiler's
			-- output file.
		do
			if index_column /= 0 then
				Result := 1;
			end;
			if function_time_column /= 0 then
				Result := Result + 1;
			end;
			if descendent_time_column /= 0 then
				Result := Result + 1;
			end;
			if number_of_calls_column /= 0 then
				Result := Result + 1;
			end;
			if function_name_column /= 0 then
				Result := Result + 1;
			end;
			if percentage_column /= 0 then
				Result := Result + 1;
			end;
		end;

feature {NONE} -- Attributes

	configuration_name: STRING
		-- Name of the profiler.

	number_of_columns: INTEGER
		-- Number of columns in the profiler's output text file.

	index_column: INTEGER
		-- Column number where the index is to be found.
		-- Zero indicates that there is no index field in the
		-- output file.

	function_time_column: INTEGER
		-- Column number where the function time is to be found.
		-- Zero indicates that there is no function time field in
		-- the output file.

	descendent_time_column: INTEGER
		-- Column number where the descendent time is to be found.
		-- Zero indicates that there is no descendent time field in
		-- the output file.

	number_of_calls_column: INTEGER
		-- Column number where the number of calls is to be found.
		-- Zero indicates that there is no number of calls field in
		-- the output file.

	function_name_column: INTEGER
		-- Column number where the function name is to be found.
		-- Zero indicates that there is no function name field in
		-- the output file; although this is not likely, but you
		-- never know.

	percentage_column: INTEGER
		-- Column number where the percentage is to be found.
		-- Zero indicates that there is no percentage field in the
		-- output file.

	leading_underscore: BOOLEAN
		-- If the profiler generates a leading underscore, this
		-- value is true. The converter checks this one, to be able
		-- to retrieve the Eiffel feature names from any supported
		-- profiler.

end -- class SHARED_PROF_CONFIG
