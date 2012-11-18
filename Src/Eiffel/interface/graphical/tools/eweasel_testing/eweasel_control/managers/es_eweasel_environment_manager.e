note
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

	path: PATH
			-- eweasel root path.
		do
			Result := eiffel_layout.shared_path.extended ("eweasel")
		end

	test_case_directory: PATH
			-- Directory where new eweasel test case exists and new test case will be created.

	tcf_file_name: STRING = "tcf"
			-- Testing control file name

	test_case_root_eiffel_class_name: STRING
			-- Test case root Eiffel class name

	eweasel_command: STRING
			-- Full eweasel command
		local
			l_platform: PLATFORM
			l_exe_name: STRING
		do
			create l_platform
			if l_platform.is_windows then
				l_exe_name := "eweasel.exe"
			else
				l_exe_name := "eweasel"
			end

			Result := path.extended ("spec").extended (ise_platform).extended ("bin").extended (l_exe_name).string_representation
		end

	target_directory: DIRECTORY_NAME_32
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

	set_test_case_directory (a_path: like test_case_directory)
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

	set_test_case_name (a_name: STRING)
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

	eweasel: attached STRING
			-- eweasel path
		do
			Result := path.twin.string_representation
		end

	include: attached STRING
			-- eweasel include folder
		do
			create Result.make_from_string (path.extended ("control").string_representation)
		end

	init: attached STRING
			-- eweasel init folder
		do
			create Result.make_from_string (path.extended ("control").extended ("init").string_representation)
		end

	eweasel_platform: attached STRING
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
				-- We must use lower case on Unix, otherwise eweasel/control/unix_platform will not found
				create Result.make_from_string ("unix")
			end
		end

	eweasel_platform_value: STRING = "1"
			-- eweasel platform value

	platform_type: attached STRING
			-- Platform type
		do
			Result := eweasel_platform
		end

	ise_eiffel: STRING_GENERAL
			-- $ISE_EIFFEL environment variable
		local
			l_tmp: STRING_32
			l_layout: EIFFEL_LAYOUT
			l_name_helper: ES_FILE_NAME_HELPER
		do
			create l_layout
			l_tmp := l_layout.eiffel_layout.Shared_path.string_representation

			create l_name_helper
			Result := l_name_helper.short_name_of (l_tmp)
		ensure
			not_void: Result /= Void
		end

	ise_platform: STRING
			-- $ISE_PLATFORM environment variable
		local
			l_layout: EIFFEL_LAYOUT
		do
			create l_layout
			Result := l_layout.eiffel_layout.eiffel_platform.twin
		ensure
			not_void: Result /= Void
		end

	output: STRING_32
			-- eweasel temporary output directory
		local
			l_dir_name: DIRECTORY_NAME_32
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
			create Result.make_from_string (l_short_name_helper.short_name_of (l_dir_name))
		ensure
			exists: (create {RAW_FILE}.make_with_name (Result)).exists
		end

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

