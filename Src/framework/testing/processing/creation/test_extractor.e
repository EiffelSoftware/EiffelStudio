indexing
	description: "{
		Implementation of {TEST_EXTRACTOR_I}.
	}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXTRACTOR

inherit
	TEST_EXTRACTOR_I

	TEST_CREATOR
		redefine
			make,
			is_valid_typed_configuration
		end

	SHARED_DEBUGGER_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- <Precursor>
		do
			create capturer.make
			Precursor (a_test_suite)
		end

feature {NONE} -- Access

	capturer: !TEST_CAPTURER
			-- Capturer retrieving objects from running application.

feature {NONE} -- Status report

	is_creating_new_class: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Status setting

	print_new_class (a_file: !KL_TEXT_OUTPUT_FILE; a_class_name: !STRING)
			-- <Precursor>
		local
			l_source_writer: !TEST_EXTRACTED_SOURCE_WRITER
		do
			create l_source_writer.make
			capturer.observers.force_last (l_source_writer)

			l_source_writer.prepare (a_file, a_class_name)
			if {l_stat: APPLICATION_STATUS} debugger_manager.application_status then
				if {l_cs: EIFFEL_CALL_STACK} l_stat.current_call_stack then
					from
						capturer.prepare
						l_cs.start
					until
						l_cs.after
					loop
						if {l_cse: !EIFFEL_CALL_STACK_ELEMENT} l_cs.item and then
						   configuration.call_stack_elements.has (l_cse.level_in_stack)
						then
							capturer.capture_call_stack_element (l_cse)
						end
						l_cs.forth
					end
					capturer.capture_objects
				end
			else
				test_suite.propagate_error (e_no_application_status, [], Current)
			end

			capturer.observers.start
			capturer.observers.search_forth (l_source_writer)
			check
				observer_found: not capturer.observers.off
			end
			capturer.observers.remove_at
		end

	proceed_process
			-- <Precursor>
		local
			l_filename: !STRING
			l_file: KL_TEXT_OUTPUT_FILE
			l_name: STRING
			l_source_writer: !TEST_EXTRACTED_SOURCE_WRITER
		do
			create_new_class
			is_finished := True
		end

feature -- Query

	is_valid_typed_configuration (a_arg: like conf_type): BOOLEAN
			-- <Precursor>
		do
			if debugger_manager.application_is_executing and then debugger_manager.application_is_stopped then
				if a_arg.is_interface_usable then
					Result := a_arg.call_stack_elements.for_all (agent is_valid_call_stack_element)
				end
			end
		ensure then
			result_implies_debugger_running: Result implies debugger_manager.application_is_executing
			result_implies_debugger_stopped: Result implies debugger_manager.application_is_stopped
		end

	is_valid_call_stack_element (a_index: INTEGER): BOOLEAN
			-- <Precursor>
		local
			l_cs: EIFFEL_CALL_STACK
			l_cse: EIFFEL_CALL_STACK_ELEMENT
		do
			if debugger_manager.application_is_executing and then debugger_manager.application_is_stopped then
				l_cs := debugger_manager.application_status.current_call_stack
				if l_cs /= Void and then l_cs.count >= a_index then
					l_cse ?= l_cs.i_th(a_index)
					if l_cse /= Void then
						Result := capturer.is_valid_call_stack_element (l_cse)
					end
				end
			end
		end

feature {NONE} -- Constants

	e_no_application_status: STRING = "Could not retrieve application status"

end
