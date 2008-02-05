indexing
	description: "System's root class, compare different compiler versions' tests"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

inherit
	ARGUMENTS

create

	make

feature -- Initialization

	make is
		local
			index_output, index_tests: INTEGER
			l_args: ANY
		do
			l_args := argument_array
			set_option_sign ('-')
			only_different_results := False
			index_output := index_of_beginning_with_word_option ("output")
			index_tests := index_of_beginning_with_word_option ("tests")

			if index_tests /= 0 then
				if index_of_beginning_with_word_option ("full") = 0 then
					only_different_results := True
				end
				if index_of_beginning_with_word_option ("tab") /= 0 then
					has_tab := True
				end
				non_interactive_execution
				sort
			elseif index_of_word_option ("loop") /= 0 then
				if equal (separate_word_option_value("loop"), "") then
					interactive_execution
					sort
				else
					throw_usage
				end
			else
				throw_usage
			end
		end

feature

	sort is
			-- Handlecompiler versions and compare tests
			-- Make result available in `output_file' file		
		local
			key, name, item, version_names, test_results: STRING
			list_items : LINKED_LIST [STRING]
			list_compiler_results : LINKED_LIST [COMPILER_RESULTS]
			compiler_results : COMPILER_RESULTS
			index: INTEGER
			list_test : LIST_TEST
			globals: PLAIN_TEXT_FILE
		do
			if output_file.is_equal ("stdout") then
				globals := io.default_output
			else
				create globals.make_open_write(output_file)
			end

			create list_compiler_results.make
			create list_test.make

			version_names := ""

			from
				index := 1
			until
				index > array.count
			loop
				create compiler_results.make (array @ index)
				list_compiler_results.extend (compiler_results)
				list_test.add_tests_from_compiler_results (compiler_results)
				version_names.append (formatted (array @ index, Result_column_count, has_tab))
				index := index + 1
			end

			globals.putstring (formatted ("Test name", First_column_count, has_tab) +
				formatted ("Code", Second_column_count, has_tab) + version_names + "%N")

			from
				list_test.start
			until
				list_test.after
			loop
				key := list_test.key_for_iteration
				name := list_test.item_for_iteration
				test_results := formatted (name, First_column_count, has_tab) +
					formatted (key, Second_column_count, has_tab)
				create list_items.make
				from
					index := 1
				until
					index > array.count
				loop
					compiler_results := list_compiler_results @ index
					item := compiler_results.result_of (key)
					list_items.extend (item)
					test_results.append (formatted (item, Result_column_count, has_tab))
					index := index + 1
				end

				if only_different_results and (same_elements ("passed", list_items) or same_elements ("failed", list_items)) then
				else
					globals.putstring (test_results)
					globals.put_new_line
				end
				list_test.forth
			end

		end

	non_interactive_execution is
			-- Set `output_file' and `array' from command line
			-- `-output' for `output_file'
			-- `-tests' for `array'
		local
			index: INTEGER
			first_test: STRING
			nb_to_remove: INTEGER
			l_test_index: INTEGER
		do
			if index_of_beginning_with_word_option ("output") /= 0 then
				output_file := separate_word_option_value ("output")
			else
					-- By default we redirect to the STDOUT.
				output_file := "stdout"
			end
			l_test_index := index_of_beginning_with_word_option ("tests")
			first_test := separate_word_option_value ("tests")

			if first_test.count * output_file.count /= 0 then
					-- argument_array has 4 or 5 extra words : output, output's path, tests,
					-- and `command line' at position 0..
					-- and sometimes differences
				if index_of_beginning_with_word_option ("full") /= 0 then
					nb_to_remove := nb_to_remove + 1
				end
				if index_of_beginning_with_word_option ("tab") /= 0 then
					nb_to_remove := nb_to_remove + 1
				end
				create array.make(1, argument_array.count - l_test_index - nb_to_remove - 1)
				array.put (first_test, 1)
				if array.count > 1 then
					from
						index := 2
					until
						index > array.count
					loop
						array.put (argument_array.item (index + l_test_index), index)
						index := index + 1
					end
				end
			else
				io.putstring ("Wrong number of files")
			end
		end

	interactive_execution is
			--  Set `output_file' and `array' from shell when `-loop' in command line.
		local
			index: INTEGER
			test_file, whole_name: STRING
		do
			io.putstring ("This application allows to follow tests' evolution through different compiler versions%N")
			io.putstring ("Please enter the whole path of output file (the file you want to see comparison in)%N")
			io.read_line
			output_file := io.last_string.twin
			io.putstring ("How many compiler versions do you want to compare?%N")
			io.read_integer
			create array.make (1, io.last_integer)
			whole_name := ""
			from
				index := 1
			until
				index > array.count
			loop
				io.putstring ("Please enter file number ")
				io.put_integer (index)
				io.putstring (":%N")
				io.read_line
				test_file := io.last_string.twin
				array.put (test_file, index)
				whole_name.append ("%N" + test_file)
				index := index + 1
			end
			io.putstring ("Do you want to save all results or just tests that have different result throuch compiler versions? (y/n)")
			io.read_line
			only_different_results := equal (io.last_string, "y")
			io.putstring ("Generated in: " + output_file + " using tests: " + whole_name + ".")
		end


	throw_usage is
		do
			io.putstring ("Usage:%N[[-output file_name] -tests file1 file2 ...][-full][-tab]")
			io.putstring ("%N[-loop]%N")
		end

	same_elements (res : STRING; list : LINKED_LIST [STRING]): BOOLEAN is
		local
			bool: BOOLEAN
		do
			bool := True
			from
				list.start
			until
				list.exhausted
			loop
				bool := bool and equal (list.first, list.item)
				list.forth
			end
			Result := bool
		end

feature --Access

	output_file: STRING
		-- Path of comparison file.

	array: ARRAY [STRING]
		-- Each item is a tests results file for a compiler version.

	only_different_results: BOOLEAN

	has_tab: BOOLEAN
			-- Do we separate columns with tabs?

feature {NONE} -- Constants

	First_column_count: INTEGER is 40
			-- Size in characters of first column.

	Second_column_count: INTEGER is 14
			-- Size in character of second column.

	Result_column_count: INTEGER is 16
			-- Size of column of results.

feature {NONE} -- Implementation

	formatted (s: STRING; n: INTEGER; with_tab: BOOLEAN): STRING is
			-- If `with_tab' add a tab character to the end of `s'.
			-- Otherwise format `s' to that its count is not less than `n',
			-- adding missing spaces if needed.
		require
			s_not_void: s /= Void
			n_nonnegative: n > 0
		do
			if with_tab then
				Result := s + "%T"
			else
				Result := s.twin
				if n > Result.count then
					Result.append (create {STRING}.make_filled (' ', n - Result.count))
				end
			end
		ensure
			formatted_not_void: Result /= Void
			formatted_count_valid: not with_tab implies Result.count >= n
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ROOT_CLASS
