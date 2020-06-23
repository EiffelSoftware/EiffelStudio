note

	description: "Loader of the profiler configuration file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONFIGURATION_LOADER

inherit
	SHARED_WORKBENCH

	SHARED_EIFFEL_PROJECT

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make_and_load

feature -- Initialization

	make_and_load (prof: like profiler_type)
			-- Load the specific profiler-configuration file.
			-- `prof' is the profiler type
		do
			create shared_prof_config;
			profiler_type := prof;
			prof.to_lower;
			read_config_file (prof);
			if not error_occurred then
				shared_prof_config.set_config_name (prof)
			end
		end

feature {NONE} -- Implementation

	read_config_file (prof: READABLE_STRING_GENERAL)
			-- Reads the values from the configuration file
		local
			file_name: PATH
			retried: BOOLEAN
		do
			if not retried then
				file_name := eiffel_layout.profile_path.extended (prof)

				create config_file.make_with_path (file_name)
				config_file.open_read
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
			else
				error_occurred := True;
			end;
		rescue
			retried := True;
			retry;
		end;

feature {NONE} -- Implementation

	get_number_of_columns
			-- Retrieves the number of columns from the configure file.
		local
			i: INTEGER
		do
			i := get_integer_value (NOC_string);
			if i = -1 then
				error_occurred := True;
			else
				shared_prof_config.set_number_of_columns (i);
			end;
		end

	get_index_column
			-- Retriees the position of the index field.
		local
			i: INTEGER
		do
			i := get_integer_value (IC_string);
			if i = -1 then
				error_occurred := True;
			else
				shared_prof_config.set_index_column (i);
			end;
		end

	get_function_time_column
			-- Retrieves the column of the function_time field.
		local
			i: INTEGER
		do
			i := get_integer_value (FTC_string);
			if i = -1 then
				error_occurred := True;
			else
				shared_prof_config.set_function_time_column (i);
			end;
		end

	get_descendant_time_column
			-- Retrieves the column of the descendant_time field.
		local
			i: INTEGER
		do
			i := get_integer_value (DTC_string);
			if i = -1 then
				error_occurred := True;
			else
				shared_prof_config.set_descendant_time_column (i);
			end;
		end

	get_number_of_calls_column
			-- Retrieves the column of the number_of_calls_field.
		local
			i: INTEGER
		do
			i := get_integer_value (NOCC_string);
			if i = -1 then
				error_occurred := True;
			else
				shared_prof_config.set_number_of_calls_column (i);
			end;
		end

	get_function_name_column
			-- Retrieves the column of the function_name field.
		local
			i: INTEGER
		do
			i := get_integer_value (FNC_string);
			if i = -1 then
				error_occurred := True;
			else
				shared_prof_config.set_function_name_column (i);
			end;
		end

	get_percentage_column
			-- Retrieves the column of the percentage field.
		local
			i: INTEGER
		do
			i := get_integer_value (PC_string);
			if i = -1 then
				error_occurred := True;
			else
				shared_prof_config.set_percentage_column (i);
			end;
		end

	get_leading_underscore
			-- Retrieves whether the profiler generates a leading
			-- underscore.
		local
			s: STRING
		do
			s := get_string_value (GLU_string)
			if s = Void then
				error_occurred := True
			else
				if s.is_case_insensitive_equal ("yes") then
					shared_prof_config.set_leading_underscore (True)
				elseif s.is_case_insensitive_equal ("no") then
					shared_prof_config.set_leading_underscore (False)
				else
					error_occurred := True
				end
			end
		end

	get_integer_value (s: STRING): INTEGER
			-- Retrieve the integer value for tag 's' in the
			-- configuration file.
			-- Return -1, if 's' is not found.
		local
			str_idx: INTEGER;
			result_str: STRING
		do
			create result_str.make (0);
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

	get_string_value (s: STRING): STRING
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
					create Result.make (0);
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

	NOC_string: STRING = "number_of_columns";
		-- number_of_columns

	IC_string: STRING = "index_column";
		-- index_column

	FTC_string: STRING = "function_time_column";
		-- functin_time_column

	DTC_string: STRING = "descendant_time_column";
		-- descendant_time_column

	NOCC_string: STRING = "number_of_calls_column";
		-- number_of_calls_column

	FNC_string: STRING = "function_name_column";
		-- function_name_column

	PC_string: STRING = "percentage_column";
		-- percentage_column

	GLU_string: STRING = "generates_leading_underscore";
		-- generates_leading_underscore

feature -- Error handling

	error_occurred: BOOLEAN
		-- Was there an error during the load of the config file?

	shared_prof_config: SHARED_PROF_CONFIG
		-- Shared configuration values

	profiler_type: STRING_32
		-- The profile tool used for profiling.

feature {NONE} -- Implementation: Access

	error_code: INTEGER
		-- Configure load error code

	Invalid_profiler_type: INTEGER = 1;
		-- No profiler information file found in
		-- Eiffel installation directory under "bench/profiler".

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end
