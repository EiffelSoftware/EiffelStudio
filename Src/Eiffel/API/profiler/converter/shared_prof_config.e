note

	description:
		"Holds the values from the profiler specific configuration file."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SHARED_PROF_CONFIG

feature {CONFIGURATION_LOADER} -- Status setting

	set_config_name (s: like configuration_name)
			-- Set the config_name to `s'.
		do
			configuration_name := s;
		end;

	set_number_of_columns (i: INTEGER)
			-- Set the column to `i'.
		do
			number_of_columns := i;
		end;

	set_index_column (i: INTEGER)
			-- Set the column to `i'.
		do
			index_column := i;
		end;

	set_function_time_column (i: INTEGER)
			-- Set the column to `i'.
		do
			function_time_column := i;
		end;

	set_descendant_time_column (i: INTEGER)
			-- Set the column to `i'.
		do
			descendant_time_column := i;
		end;

	set_number_of_calls_column (i: INTEGER)
			-- Set the column to `i'.
		do
			number_of_calls_column := i;
		end;

	set_function_name_column (i: INTEGER)
			-- Set the column to `i'.
		do
			function_name_column := i;
		end;

	set_percentage_column (i: INTEGER)
			-- Set the column to `i'.
		do
			percentage_column := i;
		end;

	set_leading_underscore (b: BOOLEAN)
			-- Set the leading_underscore to `b'.
		do
			leading_underscore := b;
		end;

feature -- Status report

	columns_of_interest: INTEGER
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

feature -- Access

	configuration_name: STRING_32
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

invariant

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class SHARED_PROF_CONFIG
