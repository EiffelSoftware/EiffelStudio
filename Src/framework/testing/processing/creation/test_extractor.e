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
			internal_configuration,
			is_valid_typed_argument
		end

	SHARED_DEBUGGER_MANAGER

create
	make

feature {NONE} -- Access

	internal_configuration: ?TEST_EXTRACTOR_CONF_I
			-- <Precursor>

	source_writer: !TEST_EXTRACTED_SOURCE_WRITER
			-- Source writer for creating extracted test set classes
		once
			create Result.make
		end

	capturer: !TEST_CAPTURER
			-- Capturer retrieving objects from running application.
		once
			create Result.make
			Result.observers.force_last (source_writer)
		end

feature {NONE} -- Status setting

	proceed_process
			-- <Precursor>
		local
			l_filename: !STRING
			l_file: KL_TEXT_OUTPUT_FILE
			l_name: STRING
		do
			l_filename := configuration.new_class_name.as_lower
			l_filename.append (".e")
			l_name := configuration.cluster.location.build_path (configuration.path, l_filename)
			create l_file.make (l_name)
			l_file.open_write
			if l_file.is_open_write then
				source_writer.prepare (l_file, configuration.new_class_name)
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
				l_file.close
				add_class (configuration.cluster, configuration.path, l_filename)
			else
				test_suite.propagate_error (e_file_not_writable, [l_file.name], Current)
			end
			is_finished := True
		end

feature -- Query

	is_valid_typed_argument (a_arg: like configuration): BOOLEAN
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

	e_file_not_writable: STRING = "Could not create new class file $1"
	e_no_application_status: STRING = "Could not retrieve application status"

end
