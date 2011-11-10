note
	description: "[
					EiffelRibbon tool miscellaneous constants
							]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_MISC_CONSTANTS

inherit
	EIFFEL_ENV
		redefine
			on_check_environment_failure
		end

feature -- Query

	xml_file_name (a_index: INTEGER): STRING
			-- File name for saving ribbon makrup xml file
		do
			if a_index <= 1 then
				Result := "eiffel_ribbon.xml"
			else
				Result := "eiffel_ribbon_" + a_index.out + ".xml"
			end
		end

	bml_file_name(a_index: INTEGER): STRING
			-- Ribbon BML file name
		do
			Result := "ribbon_" + a_index.out + ".bml"
		end

	header_file_name(a_index: INTEGER): STRING
			-- Header file name
		do
			Result := "ribbon_" + a_index.out + ".h"
		end

	rc_file_name (a_index: INTEGER): STRING
			-- rc file name
		do
			if is_using_application_mode.item then
				check a_index = 1 end
				Result := "eiffelribbon.rc"
			else
				Result := "eiffelribbon" + a_index.out + ".rc"
			end

		end

	res_file_name (a_index: INTEGER): STRING
			-- res file name
		do
			Result := "eiffelribbon" + a_index.out + ".res"
		end

	dll_file_name_prefix: STRING = "eiffel_ribbon_"
			-- DLL file name prefix

	project_configuration_file_name: STRING = "ribbon_project.er"
			-- Project configuration file name

	tool_info_file_name: STRING = "eiffel_ribbon_info.sed"
			-- Tool info file name

	images: DIRECTORY_NAME
			-- Image folder
		do
			Result := eiffel_ribbon
			Result.set_subdirectory ("images")
		end

	eiffel_ribbon: DIRECTORY_NAME
			-- Eiffel ribbon tool folder
		do
			Result := eiffel_ribbon_imp.twin
		end

	ise_eiffel: detachable STRING
			-- $ISE_EIFFEL value if exists
		do
			Result := get_environment ({EIFFEL_CONSTANTS}.ise_eiffel_env)
		end

	template: DIRECTORY_NAME
			-- Template folder name
		do
			Result := eiffel_ribbon
			Result.set_subdirectory ("template")
		end

	xml_full_file_name (a_ribbon_index: INTEGER): detachable STRING_8
			-- (export status {NONE})
		require
			valid: a_ribbon_index >= 0
		local
			l_singleton: ER_SHARED_TOOLS
			l_file_name: detachable FILE_NAME
			l_constants: ER_MISC_CONSTANTS
		do
			create l_singleton
			if attached l_singleton.Project_info_cell.item as l_info then
				if attached l_info.project_location as l_location then
					create l_file_name.make_from_string (l_location)
					create l_constants
					l_file_name.set_file_name (l_constants.Xml_file_name (a_ribbon_index))
					Result := l_file_name
				end
			end
		end

	project_full_file_name: detachable STRING
			-- Project file name including full path
		local
			l_singleton: ER_SHARED_TOOLS
			l_file_name: detachable FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				if attached l_info.project_location as l_location and then not l_location.is_empty then
					create l_file_name.make_from_string (l_location)
					l_file_name.set_file_name (project_configuration_file_name)
				end
			end
			Result := l_file_name
		end

	header_full_file_name (a_index: INTEGER): detachable STRING
			-- Header file name including full path
		local
			l_singleton: ER_SHARED_TOOLS
			l_file_name: detachable FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				if attached l_info.project_location as l_location and then not l_location.is_empty then
					create l_file_name.make_from_string (l_location)
					l_file_name.set_file_name (header_file_name (a_index))
				end
			end
			Result := l_file_name
		end

	docking_tools_layout_file_name: STRING = "docking_tools_layout"
			-- Docking layout file name

feature -- Settings query

	is_using_application_mode: BOOLEAN
			-- If using application mode for multi windows support?
			-- Otherwise it's using DLL
		local
			l_shared_singleton: ER_SHARED_TOOLS
		do
			create l_shared_singleton
			if attached l_shared_singleton.tool_info_cell.item as l_tool_info then
				Result := l_tool_info.is_using_application_modes
			end
		end

feature -- Command

	set_using_application_mode (a_bool: BOOLEAN)
			-- Set `is_using_application_mode' with `a_bool'
		local
			l_shared_singleton: ER_SHARED_TOOLS
		do
			create l_shared_singleton
			if attached l_shared_singleton.tool_info_cell.item as l_tool_info then
				l_tool_info.set_using_application_modes (a_bool)
			end
		end

feature {NONE} -- Implementation

	application_name: STRING
			-- <Precursor>
		do
			Result := "eiffelribbon"
		end

	on_check_environment_failure
		do
			(create {EXCEPTIONS}).raise ("Invalid environment")
		end

	eiffel_ribbon_imp: DIRECTORY_NAME
			-- Eiffel ribbon tool folder
		local
			l_retried: BOOLEAN
			l_shared: ER_SHARED_TOOLS
			l_error: EV_ERROR_DIALOG
			l_interface_names: ER_INTERFACE_NAMES
		once
			if not l_retried then
				if not is_valid_environment then
					check_environment_variable
				end
				create Result.make_from_string (eiffel_install)
				Result.set_subdirectory ("tools")
				Result.set_subdirectory ("ribbon")
			else
				create Result.make
			end
		rescue
			-- `check_environment_variable' may raise exception if environment variable not valid
			 l_retried := True
			create l_shared
			create l_interface_names
			if attached ise_eiffel as l_ise_eiffel then
				create l_error.make_with_text (l_interface_names.cannot_find_ribbon_folders (l_ise_eiffel))
			else
				create l_error.make_with_text (l_interface_names.ise_eiffel_not_defined)
			end

			l_error.set_buttons (<<l_interface_names.ok>>)
			if attached l_shared.main_window_cell.item as l_win then
				l_error.show_modal_to_window (l_win)
			else
				l_error.show
			end

			retry
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
