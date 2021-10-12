note

	description: "Converts ASCII output of profiler into the internal representation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PROFILE_CONVERTER

inherit

	SHARED_EIFFEL_PROJECT
	COMPILER_EXPORTER
	PROJECT_CONTEXT
	SYSTEM_CONSTANTS
	EXCEPTIONS

create
	make

feature {NONE} -- Creation

	make (profile: like profilename; translat: PATH; s_p_config: SHARED_PROF_CONFIG; a_is_final: BOOLEAN)
			-- Create the converter.
			-- `profile' is the output file from the profile-tool,
			-- `translat' is the name of the TRANSLAT file for this
			-- project; the directory is included as well.
		do
			config := s_p_config
			profilename := profile
			is_finalized_profile := a_is_final
			create profile_information.make
			create cyclics.make
			read_profile_file
			read_translat_file (translat)
		end

feature -- Converting

	convert_profile_listing
			-- Converts the profile-tool-output listing.
		do
			analyse
		rescue
				-- A crash occurred, make sure to flag the conversion as unsuccessful.
			is_conversion_ok := False
		end

feature {PROFILE_CONVERTER} -- analyzing

	analyse
			-- Analyzes the profile output file (which should be
			-- ASCII !)
		do
			from
				init_analyse
			until
				string_idx >= profile_string.count
			loop
				retrieve_first_next_token
				if token_type = Error_token then
					resync_line
					is_conversion_ok := False
				elseif token_type = Whitespace_token then
					get_next_column
					if column_nr > config.number_of_columns then
						skip_line
					end
				else
					record_token
					if columns_seen = columns_of_interest then
						perform_profile_line
					end
				end
			end
			end_analyse
		end

	init_analyse
			-- Initializes the analyzation process.
		do
			string_idx := 1
			column_nr := 1
			token_type := Newline_token
			columns_seen := 0
			columns_of_interest := config.columns_of_interest
			get_next_column
			is_conversion_ok := True
		end

	end_analyse
			-- Reports end of analization and writes information to
			-- disk.
		local
			out_file_name: PATH
			file: RAW_FILE
			io_except: IO_FAILURE
		do
			redo_cyclics
			out_file_name := profilename.appended ("." + Dot_profile_information)
			create file.make_with_path (out_file_name)
			if
				(file.exists and then file.is_writable)
				or else file.is_creatable
			then
				file.open_write
				file.independent_store (profile_information)
				file.close
			else
				create io_except
				io_except.set_description ("write permission failure")
				io_except.raise
			end
		end

	redo_cyclics
			-- All cycles are read, so cyclic functions can be stored.
		local
			number: INTEGER
		do
			from
				cyclics.start
			until
				cyclics.after
			loop
				number := cyclics.item.cycle_number
				profile_information.add_function_to_cycle (cyclics.item, number)
				cyclics.forth
			end
		end

	get_next_column
			-- Goes on analyzing untill start of next column.
			-- A column's contents is every character except
			-- ' ' and '%T'.
			-- This feature reads over the ' ' and '%T' chars.
		do
			if
				profile_string.item (string_idx) = ' ' or else
				profile_string.item (string_idx) = '%T'
			then
				from
					string_idx := string_idx + 1
				until
					profile_string.item (string_idx) /= ' ' and then profile_string.item (string_idx) /= '%T'
				loop
					string_idx := string_idx + 1
				end
				column_nr := column_nr + 1
			end
		end

	record_token
			-- Records a token. If it is (by configuration) not possible
			-- to record the token at this column, we skip the rest of
			-- the line.
		do
			if token_type = Real_token then
				perform_real_token
			elseif token_type = Number_token then
				perform_number_token
			elseif token_type = Index_token then
				perform_index_token
			elseif token_type = String_token then
				perform_string_token
			elseif token_type = Newline_token then
				perform_newline_token
			end
		end

	perform_real_token
			-- Does the actual recording of a lexeme of
			-- token_type = Real_token.
		do
			if config.function_time_column = column_nr then
				function_time := token_string.to_double
				columns_seen := columns_seen + 1
			elseif config.descendant_time_column = column_nr then
				descendant_time := token_string.to_double
				columns_seen := columns_seen + 1
			elseif config.percentage_column = column_nr then
				percentage := token_string.to_double
				columns_seen := columns_seen + 1
			else
				is_conversion_ok := False
				skip_line
			end
		end

	perform_number_token
			-- Does the actual recording of a lexeme of
			-- token_type = Number_token.
		do
			if config.number_of_calls_column = column_nr then
				number_of_calls := token_string.to_integer
				columns_seen := columns_seen + 1
			else
				is_conversion_ok := False
				skip_line
			end
		end

	perform_string_token
			-- Does the actual recording of a lexeme of
			-- token_type = String_token.
		local
			space, number: INTEGER
			num_str: STRING
			class_n, feature_n: STRING
			dtype: INTEGER
			eclass: CLASS_C
		do
			if config.function_name_column = column_nr then
				if token_string.item (1) = '<' then
					space := token_string.index_of (' ', 1)
					num_str := token_string.substring (space + 1, token_string.index_of (' ', space + 1))
					number := num_str.to_integer
					create cycle_function.make (number)
					is_cycle := True
					is_eiffel := False
					is_c := False
				else
					function_name := token_string
					function_name.right_adjust

					if functions.has_key (function_name) then
						e_function := functions.found_item
						is_eiffel := True
						is_c := False
						is_cycle := False
					elseif function_name.substring_index (" from ", 1) > 0 then
						feature_n := function_name.substring (1, function_name.substring_index (" from ", 1) - 1)
						debug ("PROFILE_CONVERT")
							io.error.put_string ("Total token: ")
							io.error.put_string (function_name)
							io.error.put_new_line
							io.error.put_string ("dtype representation is: ")
							io.error.put_string (function_name.substring (function_name.substring_index (" from ", 1) + 6, function_name.count))
							io.error.put_new_line
						end
						dtype := function_name.substring (function_name.substring_index (" from ", 1) + 6, function_name.count).to_integer + 1
						if
							Eiffel_project.initialized and then
							Eiffel_project.system_defined and then
							Eiffel_system.valid_dynamic_id (dtype)
						then
							eclass := Eiffel_system.class_of_dynamic_id (dtype, is_finalized_profile)
							if eclass /= Void then
								class_n := eclass.name_in_upper
							else
								class_n := dtype.out
							end
						else
							class_n := dtype.out
						end

						create e_function.make (Void, class_n, feature_n)
						if eclass /= Void then
							e_function.set_class_id (eclass.class_id)
						else
								-- Looks like we retrieved an incorrect `profinfo' file, probably
								-- from a different project, let's put `-1' to prevent `append_to'
								-- from EIFFEL_FUNCTION to look for a class that it cannot find.
							e_function.set_class_id (-1)
						end
						is_eiffel := True
						is_c := False
						is_cycle := False
					else
						create c_function.make (function_name)
						is_c := True
						is_cycle := False
						is_eiffel := False
					end
					if
						profile_string.item (string_idx) = ' ' and then
						profile_string.item (string_idx + 1) = '<'
					then
						from
							string_idx := string_idx + 1
							create cycle_name.make (0)
							cycle_name.extend ('<')
						until
							profile_string.item (string_idx) = '>'
						loop
							cycle_name.extend (profile_string.item (string_idx))
							string_idx := string_idx + 1
						end
						cycle_name.extend ('>')
						string_idx := string_idx + 1
						space := cycle_name.index_of (' ', 1)
						num_str := cycle_name.substring (space + 1, cycle_name.count - 1)
						number := num_str.to_integer
						if is_eiffel then
							e_function.set_member_of_cycle (number)
							if profile_information.has_cycle (number) then
								profile_information.add_function_to_cycle (e_function, number)
							else
								cyclics.extend (e_function)
							end
						else
							c_function.set_member_of_cycle (number)
							if profile_information.has_cycle (number) then
								profile_information.add_function_to_cycle (c_function, number)
							else
								cyclics.extend (c_function)
							end
						end
					end
				end
				columns_seen := columns_seen + 1
			else
					-- An error occurred
				is_conversion_ok := False
				skip_line
			end
		end

	perform_index_token
			-- Does the actual recording of a lexeme of
			-- token_type = Index_token.
		do
			if config.index_column = column_nr then
				columns_seen := columns_seen + 1
			else
				is_conversion_ok := False
				skip_line
			end
		end

	perform_newline_token
			-- Does the actual recording of a lexeme of
			-- token_type = Newline_token.
		do
			if columns_seen = columns_of_interest then
				perform_profile_line
			end
			string_idx := string_idx + 1
			columns_seen := 0
			column_nr := 1
			token_type := Newline_token
		end

	perform_profile_line
			-- Sets up a PROFILE_DATA object for storage into the
			-- `profile_information' object.
		local
			e_data: EIFFEL_PROFILE_DATA
			c_data: C_PROFILE_DATA
			cy_data: CYCLE_PROFILE_DATA
		do
			if config.configuration_name.is_equal ("win32_ms") then
					-- Currently ONLY win32_ms prints total_time rather than
					-- descendant_time only. To get the descendant_time
					-- we subtract the function_time at this point, because
					-- here it is guaranteed that we know the function_time.
				descendant_time := descendant_time - function_time
			end

			if is_eiffel then
				create e_data.make (number_of_calls, percentage, function_time, descendant_time, e_function)
				profile_information.insert_eiffel_profiling_data (e_data)

			elseif is_c then
				create c_data.make (number_of_calls, percentage, function_time, descendant_time, c_function)
				if function_name.is_equal ("main") then
					profile_information.set_total_execution_time (function_time + descendant_time)
				end
				profile_information.insert_c_profiling_data (c_data)

			elseif is_cycle then
				create cy_data.make (number_of_calls, percentage, function_time, descendant_time, cycle_function)
				profile_information.insert_cycle_profiling_data (cy_data)
			end

			skip_line
		end

	skip_line
			-- Reads up until just after the first appearance of
			-- '%N'.
		do
			from
			until
				profile_string.item (string_idx) = '%N'
			loop
				string_idx := string_idx + 1
			end
			string_idx := string_idx + 1
			columns_seen := 0
			column_nr := 1
		end

	resync_line
			-- Reads in the line up to first legal character.
			-- A legal character any of the following:
			-- digits, alphas, '.', '_', '[', ']',
			-- ' ', '%T', and '%N'.
		local
			char: CHARACTER
		do
			from
				char := profile_string.item (string_idx)
			until
				char.is_digit or else char.is_alpha or else
				char = '[' or else char = ']' or else
				char = '.' or else char = '_' or else
				char = ' ' or else char = '%T' or else char = '%N'
			loop
				string_idx := string_idx + 1
				char := profile_string.item (string_idx)
			end
		end

	retrieve_first_next_token
			-- Checks whether the next characters can be grouped into
			-- one of the predefined tokens (string, number, real, index,.put_new_line).
			-- If so 'token_type' is respectively String_token, Number_token, Real_token, Index_token, Newline_token.
			-- If not 'token_type' is Error_token.
		local
			next_char: CHARACTER
			temp_noc: INTEGER
			l_from_pos: INTEGER
		do
			next_char := profile_string.item (string_idx)
			if next_char.is_alpha or else next_char = '_' then
				create token_string.make (0)
				token_string.extend (next_char)
				from
					string_idx := string_idx + 1
					next_char := profile_string.item (string_idx)
				until
					not next_char.is_alpha and then
					(next_char /= '_') and then
					not next_char.is_digit
				loop
					token_string.extend (next_char)
					string_idx := string_idx + 1
					next_char := profile_string.item (string_idx)
				end

					-- Handle prefixes and infixes like: infix "+" or prefix "-".
					-- Get anything before " from".
				if token_string.is_case_insensitive_equal ("infix") or token_string.is_case_insensitive_equal ("prefix") then
					l_from_pos := profile_string.substring_index (" from", string_idx)
					if l_from_pos > string_idx then
						token_string.append_string (profile_string.substring (string_idx, l_from_pos - 1))
						string_idx := l_from_pos
					end
				end

					-- Eiffel generates ` from ABC' as well...

				debug ("PROFILE_CONVERT")
					io.error.put_string ("Substring (string_idx, string_idx + 4) is: ")
					io.error.put_string (profile_string.substring (string_idx, string_idx + 4))
					io.error.put_new_line
				end

				if profile_string.substring (string_idx, string_idx + 4).is_equal (" from") then
					token_string.append (" from ")
					string_idx := string_idx + 6

					debug ("PROFILE_CONVERT")
						io.error.put_string ("Detecting Eiffel feature name...")
						io.error.put_new_line
						io.error.put_string ("Character at string_idx is ")
						io.error.put_character (profile_string [string_idx])
						io.error.put_new_line
					end

						-- Reading class name...
					from
						next_char := profile_string.item (string_idx)
					until
						not next_char.is_alpha and then
						(next_char /= '_') and then
						not next_char.is_digit
					loop
						token_string.extend (next_char)
						string_idx := string_idx + 1
						next_char := profile_string.item (string_idx)
					end
				end

					-- Remove the leading underscore if necessary.
				if
					config.leading_underscore and then
					token_string.item (1) = '_'
				then
					token_string := token_string.substring (2, token_string.count)
				end
				token_type := String_token
			elseif next_char = '<' then
				from
					create token_string.make (0)
					token_string.extend (next_char)
					string_idx := string_idx + 1
					next_char := profile_string.item (string_idx)
				until
					next_char = '>'
				loop
					token_string.extend (next_char)
					string_idx := string_idx + 1
					next_char := profile_string.item (string_idx)
				end
				token_string.extend (next_char)
				string_idx := string_idx + 1
				token_type := String_token
			elseif next_char.is_digit then
				create token_string.make (0)
				token_string.extend (next_char)
				from
					string_idx := string_idx + 1
					next_char := profile_string.item (string_idx)
				until
					not next_char.is_digit and then (next_char /= '.')
				loop
					token_string.extend (next_char)
					string_idx := string_idx + 1
					next_char := profile_string.item (string_idx)
				end

					-- GPROF's output __CAN__ have x+y for call-cycles.
				if next_char = '+' then
					from
						temp_noc := token_string.to_integer
						string_idx := string_idx + 1
						next_char := profile_string.item (string_idx)
						create token_string.make (0)
					until
						not next_char.is_digit
					loop
						token_string.extend (next_char)
						string_idx := string_idx + 1
						next_char := profile_string.item (string_idx)
					end
					temp_noc := temp_noc + token_string.to_integer
					token_string := temp_noc.out
				end

				if token_string.is_integer then
					token_type := Number_token
				elseif token_string.is_real then
					token_type := Real_token
				else
					token_type := Error_token
				end
			elseif next_char = '[' then
				create token_string.make (0)
				token_string.extend (next_char)
				from
					string_idx := string_idx + 1
					next_char := profile_string.item (string_idx)
				until
					not next_char.is_digit
				loop
					token_string.extend (next_char)
					string_idx := string_idx + 1
					next_char := profile_string.item (string_idx)
				end
				if next_char = ']' then
					token_string.extend (next_char)
					string_idx := string_idx + 1
					token_type := Index_token
				else
					token_type := Error_token
				end
			elseif next_char = '%N' then
				token_string := "%N"
				token_type := Newline_token
			elseif next_char = '%T' or else next_char = ' ' then
				token_string := Void
				token_type := Whitespace_token
			else
				token_type := Error_token
				string_idx := string_idx + 1
			end
		end

feature {NONE} -- Commands

	read_profile_file
			-- reads the profile listing into memory
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make_with_path (profilename)
			file.open_read
			file.read_stream (file.count)
			profile_string := file.last_string
			file.close
		end

	read_translat_file (filename: PATH)
			-- reads the `TRANSLAT' file into memory
		local
			retried: BOOLEAN
			file: PLAIN_TEXT_FILE
			table_file: PLAIN_TEXT_FILE
			binary_file: RAW_FILE
			table_name: PATH
		do
			if not config.configuration_name.is_equal ("eiffel") then

					-- Other profile tools use C names, so we need
					-- Valid translation.
					-- TRANSLAT should be there, but it might not when
					-- using precompiled stuff. This desperately needs
					-- a FIX.
					-- ***** FIXME *****

				create file.make_with_path (filename)
				create table_name.make_from_string (filename.name + "." + Table_extension)
				create table_file.make_with_path (table_name)

					-- Both files should exist. Existence of TRANSLAT
					-- is already checked in the root class
				if table_file.exists then
					if table_file.date < file.date or else retried then
						file.open_read
						file.read_stream (file.count)
						translat_string := file.last_string
						file.close
						make_function_table (table_name)
					else
						create binary_file.make_with_path (table_name)
						if binary_file.exists and then binary_file.is_readable then
							binary_file.open_read
							functions ?= binary_file.retrieved
							binary_file.close
						end
						if functions = Void then
							file.open_read
							file.read_stream (file.count)
							translat_string := file.last_string
							file.close
							make_function_table (table_name)
						end
					end
				else
					file.open_read
					file.read_stream (file.count)
					translat_string := file.last_string
					file.close
					make_function_table (table_name)
				end
			else
					-- Dummy instance just to make sure the rest of the
					-- converter keeps working.
				create functions.make (0)
			end
		rescue
			retried := True
			retry
		end

	make_function_table (filename: PATH)
			-- creates the function table
			-- and stores it on disk in file `filename'.
			--| This will only be called when needed.
		local
			c_name, cluster_name, cl_name, feature_name, translat_line: STRING
			first_tab, second_tab: INTEGER
			new_function: EIFFEL_FUNCTION
			object_file: RAW_FILE
		do
			from
				create functions.make (20)
				io.put_string ("Creating function table. Please wait...%N")
			until
				translat_string.is_empty
			loop
					-- Initialize function / feature name.
				create c_name.make (0)
				create cluster_name.make (0)
				create cl_name.make (0)
				create feature_name.make (0)

					-- Get a single line from the string.
				translat_line := get_translat_line

					-- Get cludter name for Eiffel feature
				first_tab := translat_line.index_of ('%T', 1)
				cluster_name.append_string (translat_line.substring (1, first_tab - 1))

					-- Get class name (plus actual generics) for Eiffel feature
				second_tab := translat_line.index_of ('%T', first_tab + 1)
				cl_name.append_string (translat_line.substring (first_tab + 1, second_tab - 1))

					-- Get feature name for Eiffel feature
				first_tab := second_tab + 1
				second_tab := translat_line.index_of ('%T', first_tab)
				feature_name.append_string (translat_line.substring (first_tab, second_tab - 1))

					-- Get function name for C function
				first_tab := second_tab + 1
				second_tab := translat_line.index_of ('%T', first_tab)
				c_name.append_string (translat_line.substring (first_tab, second_tab - 1))

					-- Put function-feature in the hash table.
				create new_function.make (cluster_name, cl_name, feature_name)
				functions.put (new_function, c_name)
			end
			create object_file.make_with_path (filename)
			object_file.open_write
			object_file.independent_store (functions)
			object_file.close
		end

	get_translat_line: STRING
		local
			new_line_index: INTEGER
		do
			create Result.make (0)
			new_line_index := translat_string.index_of ('%N', 1)
			Result.append_string (translat_string.substring (1, new_line_index))
			translat_string.remove_head (new_line_index)
		end

feature -- Access

	is_conversion_ok: BOOLEAN
			-- Has the conversion worked properly?

feature {NONE} -- Attributes

	is_finalized_profile: BOOLEAN
			-- Is converter done on the finalized profile?

	profilename: PATH

	profile_information: PROFILE_INFORMATION
			-- Information about the profiled application

	functions: HASH_TABLE [EIFFEL_FUNCTION, STRING]

	translat_string: STRING

	profile_string: STRING

	e_function: EIFFEL_FUNCTION

	c_function: C_FUNCTION

	cycle_function: CYCLE_FUNCTION

	cycle_name: STRING

	index: STRING

	real_index: INTEGER

	is_cycle, is_eiffel, is_c: BOOLEAN

	cyclics: TWO_WAY_LIST [LANGUAGE_FUNCTION]

	Table_extension: STRING = "ftt"
			-- Extension used to distinguish between compiler
			-- created TRANSLAT file and function table

	config: SHARED_PROF_CONFIG
			-- Values as retrieved from the resource file for the
			-- specific profiler-tool

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
			-- Columns of interest as specified by `config'

	function_time: REAL_64

	descendant_time: REAL_64

	percentage: REAL_64

	number_of_calls: INTEGER

	function_name: STRING

feature {NONE} -- Constants

	String_token: INTEGER = 1
	Number_token: INTEGER = 2
	Real_token: INTEGER = 3
	Index_token: INTEGER = 4
	Newline_token: INTEGER = 5
	Whitespace_token: INTEGER = 6
	Error_token: INTEGER = 7;

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
