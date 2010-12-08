note
	description: "Summary description for {ER_UICC_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_UICC_MANAGER

feature -- Command

	check_if_uicc_available: BOOLEAN
			--
		do

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
				l_process := l_process_factory.process_launcher ("uicc.exe", l_list, void)
				l_process.redirect_output_to_agent (agent on_output)
				l_process.launch
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
end
