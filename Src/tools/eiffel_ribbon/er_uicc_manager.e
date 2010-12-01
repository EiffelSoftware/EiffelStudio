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
			create l_process_factory
			create l_list.make (4)
			create l_constants
			l_list.extend (l_constants.xml_file_name)
			l_list.extend (l_constants.bml_file_name)
			l_list.extend ("/header:" + l_constants.header_file_name)
			l_list.extend ("/res:" + l_constants.rc_file_name)
			l_process := l_process_factory.process_launcher ("uicc.exe", l_list, void)
			l_process.redirect_output_to_agent (agent on_output)
			l_process.launch
		end

	on_output (a_string: STRING)
			--
		do
			print (a_string)
		end
end
