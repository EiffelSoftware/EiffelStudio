note
	description: "[
					UICC.exe manager to compile ribbon resource files with ribbon markup XML
								]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_UICC_MANAGER

inherit
	EIFFEL_LAYOUT

	SYSTEM_ENCODINGS

feature -- Command

	is_uicc_available: BOOLEAN
			-- Setup the environment for generating the code for using a ribbon code.
			-- If not available then nothing can be done.
		local
			l_setup: COMPILER_SETUP
			l_layout: ER_ENVIRONMENT_LAYOUT
		once
			create l_layout
			set_eiffel_layout (l_layout)

			create l_setup.initialize (True, not {PLATFORM_CONSTANTS}.is_64_bits)
			Result := l_setup.found_c_config /= Void
		end

	compile (a_index: INTEGER)
			-- Using uicc.exe to compile xml markup file
		require
			valid: a_index >= 1
		local
			l_process: PROCESS
			l_process_factory: PROCESS_FACTORY
			l_list: ARRAYED_LIST [STRING_32]
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_TOOLS
		do
			-- prepare command
			-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
			create l_constants
			create l_list.make (4)
			l_list.extend (l_constants.Xml_file_name (a_index).name)
			l_list.extend (bml_file_name (a_index).name)
			l_list.extend ("/header:" + header_file_name (a_index).name)
			l_list.extend ("/res:" + rc_file_name (a_index).name)
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				create l_process_factory
				if attached l_info.project_location as l_loc then
					l_process := l_process_factory.process_launcher (uicc_name, l_list, l_loc.name)
				else
					l_process := l_process_factory.process_launcher (rc_name, l_list, Void)
				end
				l_process.set_separate_console (True)
				l_process.set_hidden (True)
				l_process.redirect_output_to_agent (agent on_process_output (?, True))
				on_output ({STRING_32} "Launching " + uicc_name, False)
				if attached l_info.project_location as l_loc then
					on_output ({STRING_32} "%NIn `" + l_loc.name + "'%N", False)
					on_output ({STRING_32} "Args: " + l_process.command_line + "%N", False)
				end
				on_output ({STRING_32} "%N", True)
				l_process.launch
				l_process.wait_for_exit
				if not l_process.launched or else l_process.exit_code /= 0 then
						-- Display error
					on_output ({STRING_32} "%N" + uicc_name + " launched failed%N", False)
				else
					on_output ({STRING_32} "%N" + uicc_name + " launched successfully%N", False)
				end
			end
		end

	convert_rc_to_res_file (a_index: INTEGER)
			-- Convert Ribbon makrup rc file to res file
		require
			valid: a_index >= 1
		local
			l_process: PROCESS
			l_process_factory: PROCESS_FACTORY
			l_list: ARRAYED_LIST [STRING_32]
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_TOOLS
		do
				-- prepare command
				-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
			create l_constants
			create l_list.make (2)
			l_list.extend ("/v")
			l_list.extend (rc_file_name (a_index).name)

			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				create l_process_factory
				if attached l_info.project_location as l_loc then
					l_process := l_process_factory.process_launcher (rc_name, l_list, l_loc.name)
				else
					l_process := l_process_factory.process_launcher (rc_name, l_list, Void)
				end
				l_process.set_separate_console (True)
				l_process.set_hidden (True)
				l_process.redirect_output_to_agent (agent on_process_output (?, True))
				on_output ({STRING_32} "Launching " + rc_name, False)
				if attached l_info.project_location as l_loc then
					on_output ({STRING_32} "%NIn `" + l_loc.name + "'%N", False)
					on_output ({STRING_32} "Args: " + l_process.command_line + "%N", False)
				end
				on_output ({STRING_32} "%N", True)
				l_process.launch
				l_process.wait_for_exit
				if not l_process.launched or else l_process.exit_code /= 0 then
						-- Display error
					on_output ({STRING_32} "%N" + rc_name + " launched failed%N", False)
				else
					on_output ({STRING_32} "%N" + rc_name + " launched successfully%N", False)
				end
			end
		end

	convert_res_to_dll (a_index: INTEGER)
			-- Convert Ribbon res file to DLL file
		require
			valid: a_index >= 1
		local
			l_process: PROCESS
			l_process_factory: PROCESS_FACTORY
			l_list: ARRAYED_LIST [STRING_32]
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_TOOLS
		do
				-- prepare command
				-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
			create l_constants
			create l_list.make (6)
			l_list.extend ("/VERBOSE")
			l_list.extend ("/NOENTRY")
			l_list.extend ("/DLL")
			if {PLATFORM_CONSTANTS}.is_64_bits then
				l_list.extend ("/MACHINE:X64")
			else
				l_list.extend ("/MACHINE:X86")
			end
			l_list.extend ({STRING_32} "/OUT:%"" + {ER_MISC_CONSTANTS}.dll_file_name_prefix + a_index.out + ".dll%"")
			l_list.extend (res_file_name (a_index).name)

			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				create l_process_factory
				if attached l_info.project_location as l_loc then
					l_process := l_process_factory.process_launcher (link_name, l_list, l_loc.name)
				else
					l_process := l_process_factory.process_launcher (link_name, l_list, Void)
				end
				l_process.set_separate_console (True)
				l_process.set_hidden (True)
				l_process.redirect_output_to_agent (agent on_process_output (?, True))
				on_output ({STRING_32} "Launching " + link_name, False)
				if attached l_info.project_location as l_loc then
					on_output ({STRING_32} "%NIn `" + l_loc.name + "'%N", False)
					on_output ({STRING_32} "Args: " + l_process.command_line + "%N", False)
				end
				on_output ({STRING_32} "%N", True)
				l_process.launch
				l_process.wait_for_exit
				if not l_process.launched or else l_process.exit_code /= 0 then
						-- Display error
					on_output ({STRING_32} "%N" + link_name + " launched failed%N", False)
				else
					on_output ({STRING_32} "%N" + link_name + " launched successfully%N", False)
				end
			end
		end

	on_process_output (a_string: STRING; a_is_tabbed: BOOLEAN)
			-- Handle output event
		do
			system_encoding.convert_to (utf32, a_string)
			if system_encoding.last_conversion_successful then
				on_output (system_encoding.last_converted_string_32, a_is_tabbed)
			else
				on_output (a_string, a_is_tabbed)
			end
		end

	on_output (a_string: STRING_32; a_is_tabbed: BOOLEAN)
			-- Handle output event
		local
			l_singleton: ER_SHARED_TOOLS
		do
			create l_singleton
			if attached l_singleton.main_window_cell.item as l_main_window then
				if a_is_tabbed then
					a_string.replace_substring_all ({STRING_32} "%R", {STRING_32} "")
					a_string.replace_substring_all ({STRING_32} "%N", {STRING_32} "%N%T")
				end
				l_main_window.output_tool.append_output (a_string)
			end
		end

feature {NONE} -- Implementation

	res_file_name (a_index: INTEGER): PATH
			-- res file name
		local
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			Result := l_constants.res_file_name (a_index)
		end

	rc_file_name (a_index: INTEGER): PATH
			-- rc file name
		local
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			Result := l_constants.rc_file_name (a_index)
		end

	bml_file_name (a_index: INTEGER): PATH
			-- bmp file name
		local
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			Result := l_constants.bml_file_name (a_index)
		end

	header_file_name (a_index: INTEGER): PATH
			-- header file name
		local
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			Result := l_constants.header_file_name (a_index)
		end

	uicc_name: STRING_32 = "UICC.exe"
	rc_name: STRING_32 = "rc.exe"
	link_name: STRING_32 = "link.exe"
	chcp_name: STRING_32 = "chcp"
			-- Name of the various tools used to generate the ribbon code.

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
