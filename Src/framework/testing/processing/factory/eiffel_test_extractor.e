indexing
	description: "{
		Implementation of {EIFFEL_TEST_EXTRACTOR_I}.
	}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_EXTRACTOR

inherit
	EIFFEL_TEST_EXTRACTOR_I

	EIFFEL_TEST_PROCESSOR
		rename
			make as make_processor,
			is_valid_argument as is_valid_configuration,
			tests as created_tests,
			argument as configuration
		end

	SHARED_DEBUGGER_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create created_tests.make_default
		end

feature -- Access

	created_tests: !DS_HASH_SET [!EIFFEL_TEST_I]
			-- <Precursor>

feature {NONE} -- Access

	internal_configuration: ?like configuration
			-- Internal storage for `configuration'

	source_writer: !EIFFEL_TEST_EXTRACTED_SOURCE_WRITER
			-- Source writer for creating extracted test set classes
		once
			create Result.make
		end

	capturer: !EIFFEL_TEST_CAPTURER
			-- Capturer retrieving objects from running application.
		once
			create Result.make
			Result.observers.force_last (source_writer)
		end

feature -- Status report

	is_running: BOOLEAN
			-- <Precursor>
		do
			Result := internal_configuration /= Void
		end

	is_finished: BOOLEAN
			-- <Precursor>

feature {NONE} -- Status setting

	start_process_internal (a_arg: like configuration)
			-- <Precursor>
		do
			internal_configuration := a_arg
		end

	proceed_process
			-- <Precursor>
		local
			l_system: SYSTEM_I
			l_file: KL_TEXT_OUTPUT_FILE
			l_name: STRING
		do
			if not is_stop_requested then
				l_system := test_suite.eiffel_project.system.system
				l_name := l_system.root_creators.first.cluster.location.build_path ("", "new_extracted_test.e")
				create l_file.make (l_name)
				l_file.open_write
				if l_file.is_open_write then
					source_writer.prepare (l_file, "NEW_EXTRACTED_TEST")
					if {l_stat: APPLICATION_STATUS} debugger_manager.application_status then
						if {l_cs: EIFFEL_CALL_STACK} l_stat.current_call_stack then
							from
								capturer.prepare
								l_cs.start
							until
								l_cs.after
							loop
								if {l_cse: !EIFFEL_CALL_STACK_ELEMENT} l_cs.item then
									if capturer.is_valid_call_stack_element (l_cse) then
										capturer.capture_call_stack_element (l_cse)
									end
								end
								l_cs.forth
							end
							capturer.capture_objects
						end
					end
					l_file.close
				end
			end
			is_finished := True
		end

	stop_process
			-- <Precursor>
		do
			internal_configuration := Void
		end

feature -- Query

	is_valid_typed_argument (a_arg: like configuration; a_test_suite: like test_suite): BOOLEAN
			-- <Precursor>
		do
			if debugger_manager.application_is_executing  then
				Result := debugger_manager.application_is_stopped
			end
		ensure then
			result_implies_debugger_running: Result implies debugger_manager.application_is_executing
			result_implies_debugger_stopped: Result implies debugger_manager.application_is_stopped
		end

	configuration: !EIFFEL_TEST_CONFIGURATION_I
			-- <Precursor>
		do
			if {l_conf: !like configuration} internal_configuration then
				Result := l_conf
			end
		end


end
