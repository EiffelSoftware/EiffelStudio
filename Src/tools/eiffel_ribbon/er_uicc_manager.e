note
	description: "Summary description for {ER_UICC_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_UICC_MANAGER

feature -- Command

	check_if_uicc_available: BOOLEAN
			--
		local
			l_platform: PLATFORM_CONSTANTS
		do
			create l_platform
			Result := if_winsdk70_available (not l_platform.is_64_bits)
		end

	compile
			-- Using uicc.exe to compile xml markup file
		local
			l_process: PROCESS
			l_process_factory: PROCESS_FACTORY
			l_list: ARRAYED_LIST [STRING_8]
			l_constants: ER_MISC_CONSTANTS
		do
			-- prepare command
			-- uicc eiffel_ribbon.xml eiffel_ribbon.bml /header:eiffel_ribbon.h /res:eiffel_ribbon.rc
			create l_constants
			if attached rc_file_name as l_rc_file_name
				and then attached header_file_name as l_header_file_name
				and then attached bml_file_name as l_bml_file_name
				and then attached l_constants.xml_full_file_name as l_full_xml_name then
				create l_process_factory
				create l_list.make (4)
				l_list.extend (l_full_xml_name)
				l_list.extend (l_bml_file_name)
				l_list.extend ("/header:" + l_header_file_name)
				l_list.extend ("/res:" + l_rc_file_name)
				if attached uicc_full_path as l_uicc and then not l_uicc.is_empty then
					l_process := l_process_factory.process_launcher (l_uicc, l_list, void)
					l_process.redirect_output_to_agent (agent on_output)
					l_process.launch

					if not l_process.launched or else l_process.exit_code /= 0 then
						-- Display error
						print ("%N uicc launched failed%N")
					else
						print ("%N uicc launched successfully%N")
					end
				end
			end
		end

	on_output (a_string: STRING)
			--
		do
			print (a_string)
		end

feature {NONE} -- Implementation

	rc_file_name: detachable STRING
			--
		local
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_SINGLETON
			l_result: FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_item then
				if attached l_item.project_location as l_location then
					create l_result.make_from_string (l_location)
					create l_constants
					l_result.set_file_name (l_constants.rc_file_name)

					Result := l_result
				end
			end
		end

	bml_file_name: detachable STRING
			--
		local
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_SINGLETON
			l_result: FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_item then
				if attached l_item.project_location as l_location then
					create l_result.make_from_string (l_location)
					create l_constants
					l_result.set_file_name (l_constants.bml_file_name)

					Result := l_result
				end
			end
		end

	header_file_name: detachable STRING
			--
		local
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_SINGLETON
			l_result: FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_item then
				if attached l_item.project_location as l_location then
					create l_result.make_from_string (l_location)
					create l_constants
					l_result.set_file_name (l_constants.header_file_name)

					Result := l_result
				end
			end
		end

	uicc_full_path: detachable STRING
			--

feature -- C compiler

	if_winsdk70_available (a_for_32bits: BOOLEAN): BOOLEAN
			-- Lists the available C/C++ compilers
		local
			l_manager: C_CONFIG_MANAGER
			l_codes: LIST [STRING]
			l_cursor: CURSOR
			l_config: detachable C_CONFIG
			l_code, l_ver: STRING
			l_count: INTEGER
		do
			print ("Available C/C++ compilers:%N%N")
			create l_manager.make (a_for_32bits)
			l_codes := l_manager.applicable_config_codes

			if l_codes.is_empty then
				print ("   No applicable compilers could be found.%N")
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
								print ("Using " + l_code+ "%N")
								print ("installed at: " + l_config.install_path + "%N")

								create uicc_full_path.make_from_string (l_config.install_path + "Bin\UICC.exe")
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
