indexing
	description: "[
						Environment values used by Eiffel Studio testing tool
						FIXIT: This class need an UI to config it
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_ENVIRONMENT_MANAGER

inherit
	ES_EWEASEL_SUB_MANAGER

	EIFFEL_LAYOUT
		export
			{NONE}
		end

create
	make

feature -- Query

	path: !DIRECTORY_NAME is
			-- eweasel root path.
		do
			Result := eiffel_layout.shared_path.twin
			Result.extend ("eweasel")
		end

	test_case_directory: STRING
			-- Directory where new eweasel test case exists and new test case will be created.

	tcf_file_name: STRING is "tcf"
			-- Testing control file name

	test_case_root_eiffel_class_name: STRING
			-- Test case root Eiffel class name

	eweasel_command: STRING is
			-- Full eweasel command
		local
			l_path: like path
		do
			l_path := path.twin
			l_path.extend_from_array (<<"bin">>)
			Result := l_path + Operating_environment.directory_separator.out + "eweasel.exe"
		end

	target_directory: DIRECTORY_NAME is
			-- target directory under EIFGENs
			-- Note: Result is long path name
		local
			l_shared: SHARED_EIFFEL_PROJECT
		do
			create l_shared
			Result := l_shared.eiffel_project.project_directory.target_path.twin
		end

	test_case_name: STRING
			-- Test case name

feature -- Command

	set_test_case_root_eiffel_class_name (a_name: like test_case_root_eiffel_class_name)
			-- Set `test_case_root_eiffel_class_name' with `a_name'.
		require
			not_void: a_name /= Void and then not a_name.is_empty
		do
			test_case_root_eiffel_class_name := a_name
		ensure
			set: test_case_root_eiffel_class_name = a_name
		end

	set_test_case_directory (a_path: like test_case_directory) is
			-- Set `test_case_directory' with `a_path'
		require
			not_void: a_path /= Void
--			valid: not a_path.is_empty and a_path.is_valid
			valid: not a_path.is_empty
		do
			test_case_directory := a_path
		ensure
			set: test_case_directory = a_path
		end

	set_test_case_name (a_name: STRING) is
			-- Set `test_case_name' with `a_name'
			-- This feature is used by {ES_EWEASEL_EXECUTION_MANAGER}.create_unit_test_case
		require
			not_void: a_name /= Void
		do
			test_case_name := a_name
		ensure
			set: test_case_name = a_name
		end

feature {ES_EWEASEL_INIT_PARAMETER_MANAGER} -- Environment variables used by eweasel command line

	eweasel: !STRING is
			-- eweasel path
		do
			Result := path.twin
		end

	include: !STRING is
			-- eweasel include folder
		local
			l_path: like path
		do
			l_path := path.twin
			l_path.extend ("control")
			create Result.make_from_string (l_path)
		end

	init: !STRING is
			-- eweasel init folder
		local
			l_path: like path
		do
			l_path := path.twin
			l_path.extend ("control")
			l_path.extend ("init")

			create Result.make_from_string (l_path)
		end

	eweasel_platform: !STRING is
			-- eweasel platform
		local
			l_platform: PLATFORM
		do
			create l_platform
			if l_platform.is_dotnet then
				create Result.make_from_string ("DOTNET")
			elseif l_platform.is_windows then
				create Result.make_from_string ("WINDOWS")
			elseif l_platform.is_unix then
				-- FIXIT: We have to check if following value works on Unix
				create Result.make_from_string ("UNIX")
			end
		end

	eweasel_platform_value: STRING is "1"
			-- eweasel platform value

	platform_type: !STRING is
			-- Platform type
		do
			Result := eweasel_platform
		end

	ise_eiffel: STRING_GENERAL is
			-- $ISE_EIFFEL environment variable
		local
			l_tmp: DIRECTORY_NAME
			l_layout: EIFFEL_LAYOUT
			l_name_helper: ES_FILE_NAME_HELPER
		do
			create l_layout
			l_tmp := l_layout.eiffel_layout.Shared_path.twin

			create l_name_helper
			if {lt_string: STRING_GENERAL} l_tmp then
				if {lt_string_32: STRING_32} lt_string.as_string_32 then
					Result := l_name_helper.short_name_of (lt_string_32)
				end
			else
				check not_possible: False end
			end
		ensure
			not_void: Result /= Void
		end

	ise_platform: STRING is
			-- $ISE_PLATFORM environment variable
		local
			l_layout: EIFFEL_LAYOUT
		do
			create l_layout
			Result := l_layout.eiffel_layout.eiffel_platform.twin
		ensure
			not_void: Result /= Void
		end

	output: !STRING_GENERAL  is
			-- eweasel temporary output directory
		local
			l_dir_name: DIRECTORY_NAME
			l_final_dir_name: STRING_GENERAL

			l_dir: DIRECTORY
			l_short_name_helper: ES_FILE_NAME_HELPER
		do
			l_dir_name := target_directory
			l_dir_name.extend ("testing_tool_tmp")

			-- We must first create the dir, then query the short name
			create l_dir.make (l_dir_name)
			if not l_dir.exists then
				l_dir.create_dir
			end
			if not l_dir.is_closed then
				l_dir.close
			end

			create l_short_name_helper
			if {lt_string: STRING_GENERAL} l_dir_name then
				if {lt_string_32: STRING_32} lt_string.as_string_32 then
					l_final_dir_name := l_short_name_helper.short_name_of (lt_string_32)
				end
			end

			create {STRING_32} Result.make_from_string (l_final_dir_name)
		ensure
			exists: (create {RAW_FILE}.make (Result.as_string_8)).exists
		end

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

