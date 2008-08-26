indexing
	description: "[
		Objects implementing {EIFFEL_TEST_SUITE_S}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_SUITE

inherit
	EIFFEL_TEST_SUITE_S

	EIFFEL_TEST_PROJECT
		undefine
			events
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_project_factory: SHARED_EIFFEL_PROJECT
			l_project: !E_PROJECT
		do
				-- Create registrar
			create processor_registrar.make

				-- Create events
			create processor_launched_event
			create processor_proceeded_event
			create processor_finished_event
			create processor_stopped_event

			create l_project_factory
			l_project ?= l_project_factory.eiffel_project
			make_with_project (l_project)

			register_locator (create {EIFFEL_TEST_COMPILED_LOCATOR})
			register_locator (create {EIFFEL_TEST_UNCOMPILED_LOCATOR})

			synchronize
		end

feature -- Access

	processor_registrar: !EIFFEL_TEST_PROCESSOR_REGISTRAR
			-- <Precursor>

feature -- Query

	is_test_class_name (a_name: !STRING): BOOLEAN
			-- <Precursor>
		do
			--Result := test_class_map.has (a_name)
		end

	tests_for_class_name (a_name: !STRING): !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		local
			l_array: !DS_ARRAYED_LIST [!EIFFEL_TEST_I]
		do

		end

feature -- Status report

	count_passing: NATURAL
			-- <Precursor>

	count_failing: NATURAL
			-- <Precursor>

feature -- Status setting

	synchronize_processors
			-- <Precursor>
		do
			processor_registrar.processors.do_all (
				agent (a_proc: !EIFFEL_TEST_PROCESSOR_I)
					do
						if a_proc.is_idle then
							a_proc.proceed
						end
					end)
		end

	launch_processor (a_type: !TYPE [!EIFFEL_TEST_PROCESSOR_I]; a_arg: !ANY; a_blocking: BOOLEAN)
			-- <Precursor>
		do

		end

feature -- Basic functionality

	synchronize_tests (a_class: !EIFFEL_CLASS_I)
			-- <Precursor>
		local
		do
		end

feature -- Events

	processor_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; factory: !EIFFEL_TEST_FACTORY_I [!EIFFEL_TEST_CONFIGURATION_I]]]
			-- <Precursor>

	processor_proceeded_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_finished_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_stopped_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- <Precursor>


end
