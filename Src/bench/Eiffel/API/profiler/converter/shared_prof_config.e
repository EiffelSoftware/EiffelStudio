indexing

	description:
		"Holds the values from the profiler specific configuration file."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

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

	set_descendant_time_column (i: INTEGER) is
			-- Set the column to `i'.
		do
			descendant_time_column := i;
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

	get_descendant_time_column: INTEGER is
		do
			Result := descendant_time_column;
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
			if descendant_time_column /= 0 then
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

	descendant_time_column: INTEGER
		-- Column number where the descendant time is to be found.
		-- Zero indicates that there is no descendant time field in
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

feature {PROFILE_CONVERTER} -- Spit Information (for debugging)

	spit_info is
		do
			io.error.put_string ("Name: ");
			io.error.put_string (configuration_name);
			io.error.put_new_line;
			io.error.put_string ("Number of columns: ");
			io.error.put_integer (number_of_columns);
			io.error.put_new_line;
			io.error.put_string ("Index column: ");
			io.error.put_integer (index_column);
			io.error.put_new_line;
			io.error.put_string ("Function time column: ");
			io.error.put_integer (function_time_column);
			io.error.put_new_line;
			io.error.put_string ("descendant time column: ");
			io.error.put_integer (descendant_time_column);
			io.error.put_new_line;
			io.error.put_string ("Number of calls column: ");
			io.error.put_integer (number_of_calls_column);
			io.error.put_new_line;
			io.error.put_string ("Function name column: ");
			io.error.put_integer (function_name_column);
			io.error.put_new_line;
			io.error.put_string ("Percentage column: ");
			io.error.put_integer (percentage_column);
			io.error.put_new_line;
			io.error.put_string ("Leading underscore: ");
			io.error.put_boolean (leading_underscore);
			io.error.put_new_line;
			io.error.put_string ("Columns of interest: ");
			io.error.put_integer (columns_of_interest);
			io.error.put_new_line;
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SHARED_PROF_CONFIG
