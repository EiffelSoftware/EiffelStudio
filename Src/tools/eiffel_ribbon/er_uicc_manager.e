note
	description: "Summary description for {ER_UICC_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_UICC_MANAGER

inherit
	EIFFEL_LAYOUT

feature -- Command

	check_if_uicc_available: BOOLEAN
			-- Setup the environment for generating the code for using a ribbon code.
			-- If not available then nothing can be done.
		local
			l_c_compiler_env: VS_SETUP
			l_layout: ER_ENVIRONMENT_LAYOUT
		do
			create l_layout
			set_eiffel_layout (l_layout)

				-- We try first the SDK and then VS.
			if if_winsdk70_available (not {PLATFORM_CONSTANTS}.is_64_bits) or else if_vc8_available (not {PLATFORM_CONSTANTS}.is_64_bits) then
					-- Setup C compiler enviroment			
				create l_c_compiler_env.make (void, not {PLATFORM_CONSTANTS}.is_64_bits)
				Result := True
			end
		end

	compile (a_index: INTEGER)
			-- Using uicc.exe to compile xml markup file
		require
			valid: a_index >= 1
		local
			l_process: PROCESS
			l_process_factory: PROCESS_FACTORY
			l_list: ARRAYED_LIST [STRING_8]
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_SINGLETON
		do
			-- prepare command
			-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
			create l_constants
			if attached rc_file_name (a_index) as l_rc_file_name
				and then attached header_file_name (a_index) as l_header_file_name
				and then attached bml_file_name (a_index) as l_bml_file_name
--				and then attached l_constants.xml_full_file_name as l_full_xml_name then
				and then attached l_constants.Xml_file_name (a_index) as l_full_xml_name
			then
				create l_list.make (4)
				l_list.extend (l_full_xml_name)
				l_list.extend (l_bml_file_name)
				l_list.extend ("/header:" + l_header_file_name)
				l_list.extend ("/res:" + l_rc_file_name)
				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then
					create l_process_factory
					l_process := l_process_factory.process_launcher (uicc_name, l_list, l_info.project_location)
					l_process.set_separate_console (True)
					l_process.set_hidden (True)
					l_process.redirect_output_to_agent (agent on_output (?, True))
					debug ("Ribbon")
						on_output ("Launching " + uicc_name + "%N", True)
					end
					l_process.launch
					l_process.wait_for_exit
					debug ("Ribbon")
						if not l_process.launched or else l_process.exit_code /= 0 then
								-- Display error
							on_output ("%N" + uicc_name + " launched failed%N", False)
						else
							on_output ("%N" + uicc_name + " launched successfully%N", False)
						end
					end
				end
			end
		end

	code_page_to_936
			-- We need set code page to 936, otherwise `rc_to_res' would complain invalid code page
			local
				l_process: PROCESS
				l_process_factory: PROCESS_FACTORY
				l_list: ARRAYED_LIST [STRING_8]
				l_constants: ER_MISC_CONSTANTS
				l_singleton: ER_SHARED_SINGLETON
			do
					-- prepare command
					-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
				create l_constants

				create l_list.make (2)
				l_list.extend ("936")

				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then
					create l_process_factory
					l_process := l_process_factory.process_launcher (chcp_name, l_list, l_info.project_location)
					l_process.set_separate_console (True)
					l_process.set_hidden (True)
					l_process.redirect_output_to_agent (agent on_output (?, True))
					debug ("Ribbon")
						on_output ("Launching " + chcp_name + "%N", True)
					end
					l_process.launch
					l_process.wait_for_exit
					debug ("Ribbon")
						if not l_process.launched or else l_process.exit_code /= 0 then
								-- Display error
							on_output ("%N " + chcp_name + " launched failed%N", False)
						else
							on_output ("%N " + chcp_name + " launched successfully%N", False)
						end
					end
				end
			end

	rc_to_res (a_index: INTEGER)
			-- Convert Ribbon makrup rc file to res file
		require
			valid: a_index >= 1
		local
			l_process: PROCESS
			l_process_factory: PROCESS_FACTORY
			l_list: ARRAYED_LIST [STRING_8]
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_SINGLETON
		do
--			code_page_to_936
				-- prepare command
				-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
			create l_constants
			if attached rc_file_name (a_index) as l_rc_file_name then

				create l_list.make (2)
				l_list.extend ("/v")
				l_list.extend (l_rc_file_name)

				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then
					create l_process_factory
					l_process := l_process_factory.process_launcher (rc_name, l_list, l_info.project_location)
					l_process.set_separate_console (True)
					l_process.set_hidden (True)
					l_process.redirect_output_to_agent (agent on_output (?, True))
					debug ("Ribbon")
						on_output ("Launching " + rc_name + "%N", True)
					end
					l_process.launch
					l_process.wait_for_exit
					debug ("Ribbon")
						if not l_process.launched or else l_process.exit_code /= 0 then
								-- Display error
							on_output ("%N" + rc_name + " launched failed%N", False)
						else
							on_output ("%N" + rc_name + " launched successfully%N", False)
						end
					end
				end
			end
		end

	res_to_dll (a_index: INTEGER)
			-- Convert Ribbon res file to DLL file
		require
			valid: a_index >= 1
		local
			l_process: PROCESS
			l_process_factory: PROCESS_FACTORY
			l_list: ARRAYED_LIST [STRING_8]
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_SINGLETON
		do
				-- prepare command
				-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
			create l_constants
			if attached res_file_name (a_index) as l_res_file_name then
				create l_list.make (6)
				l_list.extend ("/VERBOSE")
				l_list.extend ("/NOENTRY")
				l_list.extend ("/DLL")
				if {PLATFORM_CONSTANTS}.is_64_bits then
					l_list.extend ("/MACHINE:X64")
				else
					l_list.extend ("/MACHINE:X32")
				end
				l_list.extend ("/OUT:%"" + {ER_MISC_CONSTANTS}.dll_file_name_prefix + a_index.out + ".dll%"")
				l_list.extend (l_res_file_name)

				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then
					create l_process_factory
					l_process := l_process_factory.process_launcher (link_name, l_list, l_info.project_location)
					l_process.set_separate_console (True)
					l_process.set_hidden (True)
					l_process.redirect_output_to_agent (agent on_output (?, True))
					debug ("Ribbon")
						on_output ("Launching " + link_name + "%N", True)
					end
					l_process.launch
					l_process.wait_for_exit
					debug ("Ribbon")
						if not l_process.launched or else l_process.exit_code /= 0 then
								-- Display error
							on_output ("%N" + link_name + " launched failed%N", False)
						else
							on_output ("%N" + link_name + " launched successfully%N", False)
						end
					end
				end
			end
		end

	on_output (a_string: STRING; a_is_tabbed: BOOLEAN) --FIXME: For non-English characters?
			--
		local
			l_singleton: ER_SHARED_SINGLETON
		do
			create l_singleton
			if attached l_singleton.main_window_cell.item as l_main_window then
				if a_is_tabbed then
					a_string.replace_substring_all ("%R", "")
					a_string.replace_substring_all ("%N", "%N%T")
				end
				l_main_window.output_tool.append_output (a_string)
			end
		end

feature {NONE} -- Implementation

	res_file_name (a_index: INTEGER): detachable STRING
			--
		local
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			Result := l_constants.res_file_name (a_index)
		end

	rc_file_name (a_index: INTEGER): detachable STRING
			--
		local
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			Result := l_constants.rc_file_name (a_index)
		end

	bml_file_name (a_index: INTEGER): detachable STRING
			--
		local
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			Result := l_constants.bml_file_name (a_index)
		end

	header_file_name (a_index: INTEGER): detachable STRING
			--
		local
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			Result := l_constants.header_file_name (a_index)
		end

	uicc_name: STRING = "UICC.exe"
	rc_name: STRING = "rc.exe"
	link_name: STRING = "link.exe"
	chcp_name: STRING = "chcp"
			-- Name of the various tools used to generate the ribbon code.

feature -- C compiler

	if_vc8_available (a_for_32bits: BOOLEAN): BOOLEAN
			-- Is VisualStudio 2008 or greater available?
		local
			l_manager: C_CONFIG_MANAGER
			l_codes: LIST [C_CONFIG]
			l_code, l_ver: STRING
		do
			debug ("Ribbon")
				on_output ("Checking available C/C++ compilers:%N%N", False)
			end
			create l_manager.make (a_for_32bits)
			l_codes := l_manager.applicable_configs

			if l_codes.is_empty then
				debug ("Ribbon")
					on_output ("   No applicable compilers could be found.%N", False)
				end
			else
				from
					l_codes.start
				until
					l_codes.after or Result
				loop
					if attached {VS_CONFIG} l_codes.item as l_config then
						l_code := l_config.code
						if l_code.starts_with ("VC") and l_code.count > 2 then
								-- Check if greater or equal 90
							l_ver := l_code.substring (3, l_code.count)
							Result := l_ver.to_integer >= 90
						end
					end
					l_codes.forth
				end
			end
		end

	if_winsdk70_available (a_for_32bits: BOOLEAN): BOOLEAN
			-- Is Windows SDK v7.0 or greater available?
		local
			l_manager: C_CONFIG_MANAGER
			l_codes: LIST [C_CONFIG]
			l_code, l_ver: STRING
		do
			debug ("Ribbon")
				on_output ("Checking available C/C++ compilers:%N%N", False)
			end
			create l_manager.make (a_for_32bits)

			l_codes := l_manager.applicable_configs

			if l_codes.is_empty then
				debug ("Ribbon")
					on_output ("No applicable compilers could be found.%N", False)
				end
			else
				from
					l_codes.start
				until
					l_codes.after or Result
				loop
					if attached {WSDK_CONFIG} l_codes.item as l_config then
						l_code := l_config.code
						if l_code.starts_with ("WSDK") and l_code.count > 4 then
								-- Check if greater or equal 70
							l_ver := l_code.substring (5, l_code.count)
							Result := l_ver.to_integer >= 70
							debug ("Ribbon")
								if Result then
									on_output ("Using " + l_code + "installed at: " + l_config.install_path + "%N", False)
								end
							end
						end
					end
					l_codes.forth
				end
			end
		end

end
