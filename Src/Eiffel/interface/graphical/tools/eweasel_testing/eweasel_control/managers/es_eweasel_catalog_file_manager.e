note
	description: "[
					Manager which can generate eweasel testing catalog file.
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

	update_catalog_file (a_failed_first: BOOLEAN): BOOLEAN
			-- Update catalog file contents
			-- Result false means catalog file generating failed
		local
			l_catalog_content: like catalog_file_content
			l_last_test_cases_folder: PATH
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
					if l_last_test_cases_folder = Void or else not l_last_test_cases_folder.same_as (l_catalog_content.item.a_test_cases_folder) then
						l_last_test_cases_folder := l_catalog_content.item.a_test_cases_folder
						manager.environment_manager.set_test_case_directory (l_last_test_cases_folder)
						append_init_lines (not catalog_file_content.isfirst)
					end

					append_new_tast_case_line (l_catalog_content.item.a_test_case_name, l_catalog_content.item.a_test_case_directory)

					-- FIXIT: eweasel bug? last test case line will be ignored.
					if l_catalog_content.islast then
						append_new_tast_case_line (l_catalog_content.item.a_test_case_name, l_catalog_content.item.a_test_case_directory)
					end

					l_catalog_content.forth
				end
				close_and_clear_file
			end
		end

	append_catalog_parameter (a_list: LIST [STRING_32])
			-- Append catalog parameter
			-- This feature used by Process library as eweasel execution paramters
		require
			not_void: a_list /= Void
		do
			a_list.extend ("-catalog")
			a_list.extend (full_file_name.name)
		ensure
			added_two: old a_list.count = a_list.count - 2
		end

feature -- Query

	test_case_source_folder: PATH
			-- Directory which contain all test cases
		do
			Result := manager.environment_manager.test_case_directory
		end

	generate_catalog_file_from_test_case_grid (a_failed_first: BOOLEAN): BOOLEAN
			-- Generate eweasel catalog file base on selected rows in test case grid
			-- Result false if no catalog file content generated
		local
			l_selected: attached ARRAYED_LIST [EVENT_LIST_TEST_CASE_ITEM]
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

	short_name_of (a_long_file_name: attached STRING_32): attached STRING_32
			-- Short name of `a_long_file_name'
		local
			l_helper: ES_FILE_NAME_HELPER
		do
			create l_helper
			if attached l_helper.short_name_of (a_long_file_name) as l_result then
				Result := l_result
			end
		end

	append_init_lines (a_new_line: BOOLEAN)
			-- Append initial line for a catalog file.
		require
			ready: test_case_source_folder /= Void
					and then not test_case_source_folder.is_empty
		local
			l_source_path: STRING_32
			u: UTF_CONVERTER
		do
			if a_new_line then
				file.put_string ("%N")
			end

			l_source_path := "source_path	"

			if not {PLATFORM}.is_windows then
					-- Add '/' for Linux, otherwise directory not found
				l_source_path.append (Operating_environment.directory_separator.out)
			end
			l_source_path.append (test_case_source_folder.name)

			file.put_string (u.utf_32_string_to_utf_8_string_8 (l_source_path))
			file.put_string ("%N")
		end

	 append_new_tast_case_line (a_test_case_name, a_folder_name: STRING)
			-- Append a new line to catalog file which describe a new test case.
		require
			valid: a_test_case_name /= Void and not a_test_case_name.is_empty
			valid: a_folder_name /= Void and not a_folder_name.is_empty
		do
			file.put_string ("%Ntest	" + a_test_case_name + "	" + a_folder_name + "  " + manager.environment_manager.tcf_file_name + " pass execution")
		end

	close_and_clear_file
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

	test_information_of (a_test_case_item: EVENT_LIST_TEST_CASE_ITEM; a_catalog_content: like catalog_file_content)
			-- Extract test information of `a_test_case_item'
			-- Including:
			-- Test case directory
			-- Test case folder name
			-- Test case name
		require
			not_void: a_test_case_item /= Void
		local
			l_test_case_folder_name: STRING_32
			l_test_case_name: PATH
			l_file_name_list: LIST [PATH]
			l_dir: PATH
			l_name: STRING_32
			l_class_i: CLASS_I
		do
			if attached {ES_EWEASEL_TEST_CASE_ITEM} a_test_case_item.data as l_test_case_item then

				l_class_i := l_test_case_item.class_i
				l_test_case_name := l_class_i.file_name

				l_file_name_list := l_test_case_name.components

				-- At least a folder name and a class file name
				check at_lease_three_level: l_file_name_list.count > 2 end

				l_test_case_name := l_file_name_list.last
				-- test case class file name same as test case name for the moment
				-- See {NEW_UNIT_TEST_MANAGER}.test_name

				l_test_case_folder_name := l_file_name_list.i_th (l_file_name_list.count - 1).name

				from
					l_file_name_list.start
					if l_file_name_list.count > 2 then
						l_dir := l_file_name_list.item
						l_file_name_list.forth
					else
						create l_dir.make_empty
					end
				until
					l_file_name_list.index > l_file_name_list.count - 2
				loop
					l_dir := l_dir.extended_path (l_file_name_list.item)
					l_file_name_list.forth
				end

				-- Removed ".e" file name extension
				l_name := l_test_case_name.name
				check l_name.substring_index (".e", 1) = l_name.count - 1 end
				l_name.remove_tail (2)
				a_catalog_content.extend ([l_dir, l_test_case_folder_name.to_string_8, l_name.to_string_8])
			else
				check not_possible: False end
			end
		ensure
			generated: a_catalog_content.count = old catalog_file_content.count + 1
		end

	full_file_name: PATH
			-- Full file name (path included) of eweasel catalog file.
		local
			l_file_name_helper: ES_FILE_NAME_HELPER
			l_file: RAW_FILE
		do
			Result := manager.environment_manager.target_directory.extended (file_name)

				-- File must exists before convert to short name
			create l_file.make_with_path (Result)
			if not l_file.exists then
				l_file.create_read_write
			end
			if not l_file.is_closed then
				l_file.flush
				l_file.close
			end
				-- Why do we need a short version here?
			create l_file_name_helper
			create Result.make_from_string (l_file_name_helper.short_name_of (Result.name))
		ensure
			not_void: Result /= Void
		end

	clear_file_content
			-- Clear catalog file content
		local
			l_file: RAW_FILE
		do
			close_and_clear_file
			create l_file.make_with_path (full_file_name)
			if l_file.exists then
				l_file.wipe_out
			end
			if not l_file.is_closed then
				l_file.close
			end
		end

	file: IO_MEDIUM
			-- Control file instance
		local
			l_file: RAW_FILE
		do
			if internal_file = Void then
				create l_file.make_with_path (full_file_name)
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

	catalog_file_content: ARRAYED_LIST [TUPLE [a_test_cases_folder: PATH; a_test_case_directory, a_test_case_name: STRING]]
			-- Catalog file content generated by `test_informaion_of'

	folder_name: STRING = "control"
			-- Control file folder name

	file_name: STRING = "catalog"
			-- Catalog file name

	internal_file: like file;
			-- Instance holder for `file'
			-- Used by `file' ONLY.

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
