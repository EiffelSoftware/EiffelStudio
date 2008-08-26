indexing
	description: "Performs tests on the built-in Eiffel parser."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent start (l_parser))
		end

	start (a_parser: ARGUMENT_PARSER) is
			-- Starts application
		require
			a_parser_attached: a_parser /= Void
		local
			l_parser: TEST_EIFFEL_PARSER
			l_parsers: ARRAYED_LIST [TEST_EIFFEL_PARSER]
			l_files: ARRAYED_LIST [STRING]
			l_error: NATURAL_8
			l_writer: IO_MEDIUM
		do
			l_writer := io.default_output
			l_writer.put_string ("Caching parsers...%N%N")

			create l_parsers.make (4)
			if a_parser.process_null_factory then
				create l_parser.make ("null", create {AST_NULL_FACTORY})
				l_parsers.extend (l_parser)
			end
			if a_parser.process_basic_factory then
				create l_parser.make ("basic", create {AST_FACTORY})
				l_parsers.extend (l_parser)
			end
			if a_parser.process_lite_factory then
				create l_parser.make ("lite", create {AST_ROUNDTRIP_LIGHT_FACTORY})
				l_parsers.extend (l_parser)
			end
			if a_parser.process_roundtrip_factory then
				create l_parser.make ("roundtrip", create {AST_ROUNDTRIP_FACTORY})
				l_parsers.extend (l_parser)
			end

				-- Retrieve file(s) to parse
			if not a_parser.use_file_location then
				l_writer.put_string ("Generating file list...")
				l_writer.new_line
				l_writer.new_line
				l_files := directory_content (a_parser.location, a_parser.recursive_lookup)
			else
				create l_files.make (1)
				l_files.extend (a_parser.location)
			end

			if not l_parsers.is_empty then
				if not l_files.is_empty then
					l_error := a_parser.error_count
					l_writer.put_string ("Results are formatted in the form of:%N")
					l_writer.put_string ("  Test: <file_name>%N")
					l_writer.put_string ("  <parser>: <speed in ticks> : <frozen speed in ticks> (<parse successful>)%N%N")

					l_writer.put_string ("Tesing parameters: using ")
					l_writer.put_string ("parser, ")
					l_writer.put_string ("parsing ")
					if a_parser.test_disk_access then
						l_writer.put_string ("disk access and")
					end
					l_writer.put_string ("content.%N%N")

					l_writer.put_string ("Beginning speed bench marks...%N%N")
					test_parsers (l_parsers, l_files, l_error, a_parser.test_disk_access, l_writer)
				else
					l_writer.put_string ("No files selected!")
					l_writer.new_line
				end
			else
				l_writer.put_string ("No parser selected!")
				l_writer.new_line
			end
		end

feature {NONE} -- Testing

	test_parsers (a_parsers: LIST [TEST_EIFFEL_PARSER]; a_fns: LIST [STRING]; a_error: NATURAL_8; a_disk: BOOLEAN; a_writer: IO_MEDIUM)
			-- Tests all parsers in `a_parsers' with file `a_fn'
		require
			a_parsers_attached: a_parsers /= Void
			not_a_parsers_is_empty: not a_parsers.is_empty
			a_fns_attached: a_fns /= Void
			not_a_fns_is_empty: not a_fns.is_empty
			a_error_positive: a_error > 0
			a_writer_attached: a_writer /= Void
			a_writer_writable: a_writer.is_open_write
		local
			l_cursor: CURSOR
			l_results: like test_parsers_with_file
			l_result: PARSE_TEST_RESULT
			l_times: HASH_TABLE [REAL_64, STRING]
			l_ftimes: HASH_TABLE [REAL_64, STRING]
			l_successes: HASH_TABLE [NATURAL_64, STRING]
			l_failures: HASH_TABLE [NATURAL_64, STRING]
			l_id: STRING
			l_summarize: BOOLEAN
		do
			l_summarize := a_fns.count > 1
			if l_summarize then
				create l_times.make (a_fns.count)
				create l_ftimes.make (a_fns.count)
				create l_successes.make (a_fns.count)
				create l_failures.make (a_fns.count)
			end

			l_cursor := a_fns.cursor
			from a_fns.start until a_fns.after loop
					-- Run pretest. This is for .NET systems to ensure that the information is cached.
					-- This pretest has to be run for every test to ensure all code executed prior to the
					-- actual test has been jitted.
				l_results := test_parsers_with_file (a_parsers, a_fns.item, 1, a_disk)

				l_results := test_parsers_with_file (a_parsers, a_fns.item, a_error, a_disk)
				write_test_results (a_writer, l_results)
				if not a_fns.islast then
					a_writer.new_line
				end
				a_fns.forth

				if l_summarize then
					from l_results.start until l_results.after loop
						l_result := l_results.item
						l_id := l_result.parser_id
						l_times.force (l_times[l_id] + l_result.completion_ticks, l_id)
						if l_result.successful then
							l_successes.force (l_successes[l_id] + 1, l_id)
						else
							l_failures.force (l_failures[l_id] + 1, l_id)
						end
						l_results.forth
					end
				end
			end
			a_fns.go_to (l_cursor)

			if l_summarize then
				a_writer.new_line
				a_writer.new_line
				a_writer.put_string ("Summary Information:")
				a_writer.new_line
				a_writer.new_line

					-- Total result time
				from l_results.start until l_results.after loop
					l_result := l_results.item
					l_id := l_result.parser_id
					l_results.put (create {PARSE_TEST_RESULT}.make ("summary_1", l_times[l_id], l_result.successful, l_result.parser_id))
					l_results.forth
				end
				a_writer.new_line
				a_writer.put_string ("Total time taken")
				write_results (a_writer, l_results, False)

					-- Mean result times
				from l_results.start until l_results.after loop
					l_result := l_results.item
					l_results.put (create {PARSE_TEST_RESULT}.make ("summary_2", (l_result.completion_ticks / a_fns.count), l_result.successful, l_result.parser_id))
					l_results.forth
				end
				a_writer.new_line
				a_writer.put_string ("Mean time")
				write_results (a_writer, l_results, False)

					-- Successes/Failures
				from l_results.start until l_results.after loop
					l_result := l_results.item
					l_id := l_result.parser_id
					l_results.put (create {PARSE_TEST_RESULT}.make ("summary_3", l_successes[l_id], l_result.successful, l_result.parser_id))
					l_results.item.set_frozen_completion_ticks (l_failures[l_id])
					l_results.forth
				end
				a_writer.new_line
				a_writer.put_string ("Successes/Failures")
				write_results (a_writer, l_results, True)
			end
		end

	test_parsers_with_file (a_parsers: LIST [TEST_EIFFEL_PARSER]; a_fn: STRING; a_error: NATURAL_8; a_disk: BOOLEAN): ARRAYED_LIST [PARSE_TEST_RESULT]
			-- Tests all parsers in `a_parsers' with file `a_fn'. `a_error' dictates the number of parses to perform for error-accurace
			-- and `a_frozen' indicates if the frozen parser should be tested.
		require
			a_parsers_attached: a_parsers /= Void
			not_a_parsers_is_empty: not a_parsers.is_empty
			a_fn_attached: a_fn /= Void
			not_a_fn_is_empty: not a_fn.is_empty
			a_fn_exists: (create {RAW_FILE}.make (a_fn)).exists
		local
			l_cursor: CURSOR
			l_results: ARRAYED_LIST [PARSE_TEST_RESULT]
			l_tester: like tester
		do
			create l_results.make (a_parsers.count)
			l_tester := tester
			l_cursor := a_parsers.cursor
			from a_parsers.start until a_parsers.after loop
				if a_disk then
					l_results.extend (l_tester.run_test_with_file (a_parsers.item, a_fn, a_error))
				else
					l_results.extend (l_tester.run_test (a_parsers.item, file_content (a_fn), a_fn, a_error))
				end
				a_parsers.forth
			end
			a_parsers.go_to (l_cursor)
			Result := l_results

		ensure
			result_attached: Result /= Void
			result_big_enough: Result.count = a_parsers.count
		end

feature {NONE} -- Reporting

	write_test_results (a_writer: IO_MEDIUM; a_results: LIST [PARSE_TEST_RESULT])
			-- Writes test results in `a_results' to `a_writer'
		require
			a_writer_attached: a_writer /= Void
			a_writer_writable: a_writer.is_open_write
			a_results_attached: a_results /= Void
			not_a_results_is_empty: not a_results.is_empty
		do
			a_writer.put_string (once "Test: ")
			a_writer.put_string (a_results.first.file_name)

			write_results (a_writer, a_results, True)
		end

	write_results (a_writer: IO_MEDIUM; a_results: LIST [PARSE_TEST_RESULT]; a_show_success: BOOLEAN)
			-- Writes test results in `a_results' to `a_writer'
		require
			a_writer_attached: a_writer /= Void
			a_writer_writable: a_writer.is_open_write
			a_results_attached: a_results /= Void
			not_a_results_is_empty: not a_results.is_empty
		local
			l_cursor: CURSOR
			l_result: PARSE_TEST_RESULT
			l_max_pad: INTEGER
			l_pad: INTEGER
		do
			l_max_pad := parser_id_max_len (a_results)
			l_cursor := a_results.cursor
			from a_results.start until a_results.after loop
				l_result := a_results.item
			a_writer.new_line
			a_writer.put_string (once "  > ")
				a_writer.put_string (l_result.parser_id)
				l_pad := l_max_pad - l_result.parser_id.count
				if l_pad > 0 then
					a_writer.put_string (create {STRING}.make_filled (' ', l_pad))
				end
				a_writer.put_string (once ": ")
				a_writer.put_real (l_result.completion_ticks)
				if a_show_success then
					a_writer.put_string (once " (")
					a_writer.put_boolean (l_result.successful)
					a_writer.put_character (')')
				end
				a_results.forth
			end
			a_writer.new_line
			a_results.go_to (l_cursor)
		end

feature {NONE} -- Implementation

	file_content (a_fn: STRING): STRING
			-- Retrieve file content of `a_fn'
		require
			a_fn_attached: a_fn /= Void
			not_a_fn_is_empty: not a_fn.is_empty
			a_fn_exists: (create {RAW_FILE}.make (a_fn)).exists
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_open_read (a_fn)
			l_file.read_stream (l_file.count)
			Result := l_file.last_string
		ensure
			result_attached: Result /= Void
		end

	directory_content (a_dir: STRING; a_recurse: BOOLEAN): ARRAYED_LIST [STRING] is
			-- Retrieves list of directory contents, and if `a_recurse' then all
			-- subdirectory contents too.
		require
			a_dir_attached: a_dir /= Void
			not_a_dir_is_empty: not a_dir.is_empty
			a_dir_exists: (create {DIRECTORY}.make (a_dir)).exists
		local
			l_files: SORTED_TWO_WAY_LIST [STRING]
			l_file: STRING
			l_fn: FILE_NAME
			l_dirs: ARRAYED_LIST [STRING]
			l_count: INTEGER
			l_rf: RAW_FILE
		do
			create Result.make (20)
			if a_recurse then
				create l_dirs.make (10)
			end
			create l_files.make
			l_files.append ((create {DIRECTORY}.make (a_dir)).linear_representation)
			l_files.sort
			from l_files.start until l_files.after loop
				l_file := l_files.item
				l_count := l_file.count

				if not l_file.is_equal (once ".") and not l_file.is_equal ("..") then
					create l_fn.make
					l_fn.set_directory (a_dir)
					l_fn.set_file_name (l_file)
					create l_rf.make (l_fn)
					if l_rf.is_directory then
						if a_recurse then
							l_dirs.extend (l_fn)
						end
					elseif l_count > 2 and then l_file.substring (l_count - 1, l_count).as_lower.is_equal (once ".e") then
						if not l_rf.is_device then
							Result.extend (l_fn)
						end
					end
				end

				l_files.forth
			end

			if a_recurse then
				from l_dirs.start until l_dirs.after loop
					Result.append (directory_content (l_dirs.item, a_recurse))
					l_dirs.forth
				end
			end
		ensure
			result_attached: Result /= Void
--			result_contains_e_files: Result.for_all (agent (a_item: STRING) do a_item.substring (a_item.count - 1, a_item.count).as_lower.is_equal (once ".e") end)
		end

	parser_id_max_len (a_results: LIST [PARSE_TEST_RESULT]): INTEGER
			-- Retrieve maximum parser id length from `a_results'
		require
			a_results_attached: a_results /= Void
			not_a_results_is_empty: not a_results.is_empty
		local
			l_cache: like internal_parser_id_max_len
			l_cursor: CURSOR
		do
			l_cache := internal_parser_id_max_len
			if l_cache = Void then
				l_cursor := a_results.cursor
				from a_results.start until a_results.after loop
					Result := Result.max (a_results.item.parser_id.count)
					a_results.forth
				end
				a_results.go_to (l_cursor)
				create internal_parser_id_max_len.put (Result)
			else
				Result := l_cache.item
			end
		ensure
			result_positive: Result > 0
		end

	tester: EIFFEL_PARSER_TESTER
			-- Tester used to test parser speed
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Internal implementation cache

	internal_parser_id_max_len: CELL [INTEGER];
			-- Cached version of `parser_id_max_len'
			-- Note: Do not use directly!

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {APPLICATION}
