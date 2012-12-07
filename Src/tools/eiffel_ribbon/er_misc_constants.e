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

	xml_file_name (a_index: INTEGER): PATH
			-- File name for saving ribbon makrup xml file
		do
			if a_index <= 1 then
				create Result.make_from_string ("eiffel_ribbon.xml")
			else
				create Result.make_from_string ("eiffel_ribbon_" + a_index.out + ".xml")
			end
		end

	bml_file_name(a_index: INTEGER): PATH
			-- Ribbon BML file name
		do
			create Result.make_from_string ("ribbon_" + a_index.out + ".bml")
		end

	header_file_name(a_index: INTEGER): PATH
			-- Header file name
		do
			create Result.make_from_string ("ribbon_" + a_index.out + ".h")
		end

	rc_file_name (a_index: INTEGER): PATH
			-- rc file name
		do
			if is_using_application_mode.item then
				check a_index = 1 end
				create Result.make_from_string ("eiffelribbon.rc")
			else
				create Result.make_from_string ("eiffelribbon" + a_index.out + ".rc")
			end
		end

	res_file_name (a_index: INTEGER): PATH
			-- res file name
		do
			create Result.make_from_string ("eiffelribbon" + a_index.out + ".res")
		end

	dll_file_name_prefix: STRING_32 = "eiffel_ribbon_"
			-- DLL file name prefix

	project_configuration_file_name: PATH
			-- Project configuration file name
		once
			create Result.make_from_string ("ribbon_project.er")
		end

	tool_info_file_name: PATH
			-- Tool info file name
		once
			create Result.make_from_string ("eiffel_ribbon_info.sed")
		end

	images: PATH
			-- Image folder
		do
			Result := eiffel_ribbon.extended ("images")
		end

	eiffel_ribbon: PATH
			-- Eiffel ribbon tool folder
		do
			Result := eiffel_ribbon_imp
		end

	ise_eiffel: detachable STRING_32
			-- $ISE_EIFFEL value if exists
		do
			Result := get_environment_32 ({EIFFEL_CONSTANTS}.ise_eiffel_env)
		end

	template: PATH
			-- Template folder name
		do
			Result := eiffel_ribbon.extended ("template")
		end

	xml_full_file_name (a_ribbon_index: INTEGER): detachable PATH
			-- (export status {NONE})
		require
			valid: a_ribbon_index >= 0
		local
			l_singleton: ER_SHARED_TOOLS
			l_constants: ER_MISC_CONSTANTS
		do
			create l_singleton
			if attached l_singleton.Project_info_cell.item as l_info then
				if attached l_info.project_location as l_location then
					create l_constants
					Result := l_location.extended_path (l_constants.Xml_file_name (a_ribbon_index))
				end
			end
		end

	project_full_file_name: detachable PATH
			-- Project file name including full path
		local
			l_singleton: ER_SHARED_TOOLS
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				if attached l_info.project_location as l_location and then not l_location.is_empty then
					Result := l_location.extended_path (project_configuration_file_name)
				end
			end
		end

	header_full_file_name (a_index: INTEGER): detachable PATH
			-- Header file name including full path
		local
			l_singleton: ER_SHARED_TOOLS
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				if attached l_info.project_location as l_location and then not l_location.is_empty then
					Result := l_location.extended_path (header_file_name (a_index))
				end
			end
		end

	docking_tools_layout_file_name: PATH
			-- Docking layout file name
		once
			create Result.make_from_string ("docking_tools_layout")
		end

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

	eiffel_ribbon_imp: PATH
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
				Result := shared_path.extended ("tools").extended ("ribbon")
			else
				create Result.make_empty
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
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
