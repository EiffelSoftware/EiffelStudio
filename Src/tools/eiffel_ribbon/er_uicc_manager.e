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
			--
		local
			l_platform: PLATFORM_CONSTANTS
			l_dummy: BOOLEAN
			l_c_compiler_env: ER_VS_SETUP
			l_layout: ER_ENVIRONMENT_LAYOUT
		do
			create l_platform
			Result := if_winsdk70_available (not l_platform.is_64_bits)

			l_dummy := if_vc_available (not l_platform.is_64_bits)

			if Result then -- Setup C compiler enviroment
				create l_layout
				set_eiffel_layout (l_layout)
				create l_c_compiler_env.make (void, not {PLATFORM_CONSTANTS}.is_64_bits)
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
				and then attached l_constants.Xml_file_name (a_index) as l_full_xml_name then
				create l_process_factory
				create l_list.make (4)
				l_list.extend (l_full_xml_name)
				l_list.extend (l_bml_file_name)
				l_list.extend ("/header:" + l_header_file_name)
				l_list.extend ("/res:" + l_rc_file_name)
				if attached uicc_full_path as l_uicc and then not l_uicc.is_empty then
					create l_singleton
					if attached l_singleton.project_info_cell.item as l_info then
						l_process := l_process_factory.process_launcher (l_uicc, l_list, l_info.project_location)
						l_process.set_separate_console (True)
						l_process.set_hidden (True)
						l_process.redirect_output_to_agent (agent on_output)
						l_process.launch
						l_process.wait_for_exit
						debug ("Ribbon")
							if not l_process.launched or else l_process.exit_code /= 0 then
									-- Display error
								on_output ("%N uicc launched failed%N")
							else
								on_output ("%N uicc launched successfully%N")
							end
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

				create l_process_factory
				create l_list.make (2)
				l_list.extend ("936")

				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then
					l_process := l_process_factory.process_launcher ("chcp", l_list, l_info.project_location)
					l_process.set_separate_console (True)
					l_process.set_hidden (True)
					l_process.redirect_output_to_agent (agent on_output)
					l_process.launch

					debug ("Ribbon")
						if not l_process.launched or else l_process.exit_code /= 0 then
								-- Display error
							on_output ("%N chcp launched failed%N")
						else
							on_output ("%N chcp launched successfully%N")
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

				create l_process_factory
				create l_list.make (2)
				l_list.extend ("/v")
				l_list.extend (l_rc_file_name)

				if attached rc_full_path as l_rc and then not l_rc.is_empty then
					create l_singleton
					if attached l_singleton.project_info_cell.item as l_info then
						l_process := l_process_factory.process_launcher (l_rc, l_list, l_info.project_location)
						l_process.set_separate_console (True)
						l_process.set_hidden (True)
						l_process.redirect_output_to_agent (agent on_output)
						l_process.launch
						l_process.wait_for_exit
						debug ("Ribbon")
							if not l_process.launched or else l_process.exit_code /= 0 then
									-- Display error
								on_output ("%N rc (rc_to_res) launched failed%N")
							else
								on_output ("%N rc (rc_to_res) launched successfully%N")
							end
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
			l_platform: PLATFORM_CONSTANTS
		do
			-- prepare command
			-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
			create l_constants
			create l_platform
			if attached res_file_name (a_index) as l_res_file_name and
				attached vcvars_full_path as l_vcvars and
				attached link_full_path as l_link then

				create l_process_factory
				create l_list.make (2)
				l_list.extend ("/c")

				if l_platform.is_64_bits then
					l_list.extend ("(%"" + l_vcvars + "%") && (%"" + l_link + "%" /VERBOSE /NOENTRY /DLL /MACHINE:X64 /OUT:%""
					 + {ER_MISC_CONSTANTS}.dll_file_name_prefix + a_index.out + ".dll%" %"" + l_res_file_name + "%")")
				else
					l_list.extend ("(%"" + l_vcvars + "%") && (%"" + l_link + "%" /VERBOSE /NOENTRY /DLL /MACHINE:X32 /OUT:%""
					 + {ER_MISC_CONSTANTS}.dll_file_name_prefix + a_index.out + ".dll%" %"" + l_res_file_name + "%")")
				end

				if attached rc_full_path as l_rc and then not l_rc.is_empty then
					create l_singleton
					if attached l_singleton.project_info_cell.item as l_info then
						l_process := l_process_factory.process_launcher ("cmd", l_list, l_info.project_location)
						l_process.set_separate_console (True)
						l_process.set_hidden (True)
						l_process.redirect_output_to_agent (agent on_output)
						l_process.launch
						l_process.wait_for_exit

						debug ("Ribbon")
							if not l_process.launched or else l_process.exit_code /= 0 then
									-- Display error
								on_output ("%N vcvars launched failed%N")
							else
								on_output ("%N vcvars launched successfully%N")
							end
						end
					end
				end
			end
		end

	on_output (a_string: STRING) --FIXME: For non-English characters?
			--
		local
			l_singleton: ER_SHARED_SINGLETON
		do
			create l_singleton
			if attached l_singleton.main_window_cell.item as l_main_window then
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

	uicc_full_path: STRING = "UICC.exe"
			--

	rc_full_path: STRING = "rc.exe"
			--

	vcvars_full_path: detachable STRING
			--

	link_full_path: STRING = "link.exe"
			--

feature -- C compiler

	if_vc_available (a_for_32bits: BOOLEAN): BOOLEAN
			--
		local
			l_manager: C_CONFIG_MANAGER
			l_codes: LIST [STRING]
			l_config: detachable C_CONFIG
			l_code, l_ver: STRING
		do
			debug ("Ribbon")
				on_output ("Checking available C/C++ compilers:%N%N")
			end
			create l_manager.make (a_for_32bits)
			l_codes := l_manager.applicable_config_codes

			if l_codes.is_empty then
				debug ("Ribbon")
					on_output ("   No applicable compilers could be found.%N")
				end
			else
				from
				l_codes.start
				until
					l_codes.after or Result
				loop

					l_code := l_codes.item
					if l_code.starts_with ("VC") and l_code.count > 2 then
						-- Check if greater or equal 90
						l_ver := l_code.substring (3, l_code.count)
						if l_ver.to_integer = 90 then
							Result := True
						elseif l_ver.to_integer = 100 then
							Result := True
						end
						if a_for_32bits then
							create vcvars_full_path.make_from_string ("vcvars32.bat")
						else
							create vcvars_full_path.make_from_string ("vcvars64.bat") -- Only this path is different from vc90
						end
					end
					l_codes.forth
				end
			end
		ensure
			fill_path: Result implies (attached vcvars_full_path as l_path and then not l_path.is_empty)
		end

	if_winsdk70_available (a_for_32bits: BOOLEAN): BOOLEAN
			-- Lists the available C/C++ compilers
		local
			l_manager: C_CONFIG_MANAGER
			l_codes: LIST [STRING]
			l_config: detachable C_CONFIG
			l_code, l_ver: STRING
		do
			debug ("Ribbon")
				on_output ("Checking available C/C++ compilers:%N%N")
			end
			create l_manager.make (a_for_32bits)

			l_codes := l_manager.applicable_config_codes

			if l_codes.is_empty then
				debug ("Ribbon")
					on_output ("   No applicable compilers could be found.%N")
				end
			else
				from
				l_codes.start
				until
					l_codes.after or Result
				loop

					l_code := l_codes.item
					if l_code.starts_with ("WSDK") and l_code.count > 4 then
						-- Check if greater or equal 70
						l_ver := l_code.substring (5, l_code.count)
						if l_ver.to_integer >= 70 then
							Result := True

							l_config := l_manager.config_from_code (l_codes.item, False)
							if l_config /= Void then
								check l_config_exists: l_config.exists end
								debug ("Ribbon")
									on_output ("Using " + l_code+ "%N")
									on_output ("installed at: " + l_config.install_path + "%N")
								end
							else
								check False end
							end
						end
					end
					l_codes.forth
				end
			end
		ensure
			fill_path: Result implies (attached uicc_full_path as l_path and then not l_path.is_empty)
		end

end
