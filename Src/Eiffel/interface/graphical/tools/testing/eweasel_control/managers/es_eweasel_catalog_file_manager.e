indexing
	description: "[
					Manager which can generate eWeasel testing catalog file.
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_CATALOG_FILE_MANAGER

inherit
	ES_EWEASEL_SUB_MANAGER

create
	make

feature -- Command

	update_catalog_file (a_failed_first: BOOLEAN): BOOLEAN is
			-- Update catalog file contents
			-- Result false means catalog file generating failed
		local
			l_catalog_content: like catalog_file_content
			l_last_test_cases_folder: STRING
			l_short_name: STRING_32
		do
			Result := generate_catalog_file_from_test_case_grid (a_failed_first)
			if Result then
				check generated: catalog_file_content /= Void end
				manager.result_analyzer.set_all_test_cases_count (catalog_file_content.count)
				clear_file_content

				-- We start to generate catalog file
				from
					l_catalog_content := catalog_file_content
					l_catalog_content.start
				until

					l_catalog_content.after
				loop
					if l_last_test_cases_folder = Void or else not l_last_test_cases_folder.same_string (l_catalog_content.item.a_test_cases_folder) then
						l_last_test_cases_folder := l_catalog_content.item.a_test_cases_folder

						-- Convert to short name, otherwise eWeasel will not recognize the long names.
						if {lt_string: STRING_32} l_last_test_cases_folder.as_string_32 then
							l_short_name := short_name_of (lt_string)
							check not_void: l_short_name /= Void end
							if l_short_name.last_index_of ('\', l_short_name.count) = l_short_name.count then
								l_short_name.remove (l_short_name.count) -- Remove last '\' if exists
							end
						end

						manager.environment_manager.set_test_case_directory (create {DIRECTORY_NAME}.make_from_string (l_short_name.as_string_8))

						append_init_lines (not catalog_file_content.isfirst)
					end

					append_new_tast_case_line (l_catalog_content.item.a_test_case_name, l_catalog_content.item.a_test_case_directory)

					-- FIXIT: eWeasel bug? last test case line will be ignored.
					if l_catalog_content.islast then
						append_new_tast_case_line (l_catalog_content.item.a_test_case_name, l_catalog_content.item.a_test_case_directory)
					end

					l_catalog_content.forth
				end
				close_and_clear_file
			end
		end

	append_catalog_parameter (a_list: LIST [STRING]) is
			-- Append catalog parameter
			-- This feature used by Process library as eWeasel execution paramters
		require
			not_void: a_list /= Void
		do
			a_list.extend ("-catalog")
			a_list.extend (full_file_name)
		ensure
			added_two: old a_list.count = a_list.count - 2
		end

feature -- Query

	test_case_source_folder: STRING
			-- Directory which contain all test cases
		do
			Result := manager.environment_manager.test_case_directory
		end

	generate_catalog_file_from_test_case_grid (a_failed_first: BOOLEAN): BOOLEAN is
			-- Generate eWeasel catalog file base on selected rows in test case grid
			-- Result false if no catalog file content generated
		local
			l_selected: !ARRAYED_LIST [EVENT_LIST_TEST_CASE_ITEM]
			l_catalog_content: like catalog_file_content
		do
			l_selected := manager.testing_tool.test_case_grid_manager.selected_test_cases (a_failed_first)
			Result := l_selected.count > 0

			if Result then
				from
					create l_catalog_content.make (l_selected.count)
					catalog_file_content := l_catalog_content

					l_selected.start
				until
					l_selected.after
				loop
					test_information_of (l_selected.item, l_catalog_content)

					l_selected.forth
				end
			end
		ensure
			created: Result implies old catalog_file_content /= catalog_file_content
		end

feature {NONE} -- Implementation routines

	short_name_of (a_long_file_name: !STRING_32): !STRING_32 is
			-- Short name of `a_long_file_name'
		local
			l_helper: ES_FILE_NAME_HELPER
		do
			create l_helper
			if {l_result: !STRING_32} l_helper.short_name_of (a_long_file_name) then
				Result := l_result
			end
		end

	append_init_lines (a_new_line: BOOLEAN) is
			-- Append initial line for a catalog file.
		require
			ready: test_case_source_folder /= Void
					and then not test_case_source_folder.is_empty
--					and then test_case_source_folder.is_valid
		do
			if a_new_line then
				file.put_string ("%N")
			end
			file.put_string ("source_path	" + test_case_source_folder)
			file.put_string ("%N")
		end

	 append_new_tast_case_line (a_test_case_name, a_folder_name: STRING) is
			-- Append a new line to catalog file which describe a new test case.
		require
			valid: a_test_case_name /= Void and not a_test_case_name.is_empty
			valid: a_folder_name /= Void and not a_folder_name.is_empty
		do
			file.put_string ("%Ntest	" + a_test_case_name + "	" + a_folder_name + "  " + manager.environment_manager.tcf_file_name + " pass execution")
		end

	close_and_clear_file is
			-- Close and clean `internal_file'
		do
			if internal_file /= Void then
				if not file.is_closed then
					file.close
				end
				internal_file := Void
			end
		ensure
			cleared: internal_file = Void
		end

	test_information_of (a_test_case_item: EVENT_LIST_TEST_CASE_ITEM; a_catalog_content: like catalog_file_content) is
			-- Extract test information of `a_test_case_item'
			-- Including:
			-- Test case directory
			-- Test case folder name
			-- Test case name
		require
			not_void: a_test_case_item /= Void
		local

			l_test_case_folder_name, l_test_case_name: STRING
			l_file_name_list: LIST [STRING]
			l_dir: DIRECTORY_NAME
			l_class_i: CLASS_I
		do
			if {l_test_case_item: ES_EWEASEL_TEST_CASE_ITEM} a_test_case_item.data then

				l_class_i := l_test_case_item.class_i
				l_test_case_name := l_class_i.file_name

				l_file_name_list := l_test_case_name.split (operating_environment.directory_separator)

				-- At least a folder name and a class file name
				check at_lease_three_level: l_file_name_list.count > 2 end

				l_test_case_name := l_file_name_list.last
				-- test case class file name same as test case name for the moment
				-- See {NEW_UNIT_TEST_MANAGER}.test_name

				-- Removed ".e" file name extension
				check l_test_case_name.substring_index (".e", 1) = l_test_case_name.count - 1 end
				l_test_case_name.remove_substring (l_test_case_name.count - 1, l_test_case_name.count)

				l_test_case_folder_name := l_file_name_list.i_th (l_file_name_list.count - 1)

				from
					create l_dir.make
					l_file_name_list.start
				until
					l_file_name_list.index > l_file_name_list.count - 2
				loop
					l_dir.extend (l_file_name_list.item)

					l_file_name_list.forth
				end

				a_catalog_content.extend ([l_dir, l_test_case_folder_name, l_test_case_name])
			else
				check not_possible: False end
			end
		ensure
			generated: a_catalog_content.count = old catalog_file_content.count + 1
		end

	full_file_name: FILE_NAME is
			-- Full file name (path included) of eWeasel catalog file.
		local
			l_file_name_helper: ES_FILE_NAME_HELPER
			l_tmp_name: STRING_GENERAL
			l_file: RAW_FILE
		do
			create Result.make_from_string (manager.environment_manager.target_directory)
			Result.set_file_name (file_name)

			l_tmp_name := Result.twin
			create l_file_name_helper
			if {lt_string: STRING_GENERAL} l_tmp_name then
				-- File must exists before convert to short name
				create l_file.make (l_tmp_name.as_string_8)
				if not l_file.exists then
					l_file.create_read_write
				end
				if not l_file.is_closed then
					l_file.flush
					l_file.close
				end
				l_tmp_name := l_file_name_helper.short_name_of (lt_string)
			end

			create Result.make_from_string (l_tmp_name.as_string_8)
		ensure
			not_void: Result /= Void
		end

	clear_file_content is
			-- Clear catalog file content
		local
			l_file: RAW_FILE
		do
			close_and_clear_file
			create l_file.make (full_file_name)
			if l_file.exists then
				l_file.wipe_out
			end
			if not l_file.is_closed then
				l_file.close
			end
		end

	file: IO_MEDIUM is
			-- Control file instance
		local
			l_file: RAW_FILE
		do
			if internal_file = Void then
				create l_file.make (full_file_name)
				if not l_file.exists then
					l_file.create_read_write
				else
					l_file.open_read_write
				end
				internal_file := l_file
			end
			Result := internal_file
		ensure
			not_void: Result /= Void
			exist: Result.exists
		end

feature {NONE} -- Implementation attributes

	catalog_file_content: ARRAYED_LIST [TUPLE [a_test_cases_folder, a_test_case_directory, a_test_case_name: STRING]]
			-- Catalog file content generated by `test_informaion_of'

	folder_name: STRING is "control"
			-- Control file folder name

	file_name: STRING is "catalog"
			-- Catalog file name

	internal_file: like file;
			-- Instance holder for `file'
			-- Used by `file' ONLY.

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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

end
