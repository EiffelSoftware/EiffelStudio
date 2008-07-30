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

	EIFFEL_TEST_MANAGER
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
			make_collection

				-- Create events
			create executor_launched_event
			create factory_launched_event
			create processor_finished_event

				-- Create storage
			create test_class_map.make (0)
			create test_routine_map.make_default

			create l_project_factory
			l_project ?= l_project_factory.eiffel_project
			make_with_project (l_project)
			refresh
		end

feature -- Access

	default_executor: !TYPE [!EIFFEL_TEST_EXECUTOR_I]
			-- <Precursor>
		once

		end

	processor_registrar: !EIFFEL_TEST_PROCESSOR_REGISTRAR_I [!EIFFEL_TEST_PROCESSOR_I [ANY]]
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

feature -- Status settings

	run_list (a_type: !TYPE [!EIFFEL_TEST_EXECUTOR_I]; a_list: !DS_LINEAR [!EIFFEL_TEST_I]; a_blocking: BOOLEAN)
			-- <Precursor>
		do
		end

	create_tests (a_type: !TYPE [!EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I]]; a_conf: !EIFFEL_TEST_CONFIGURATION_I; a_blocking: BOOLEAN)
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

	executor_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; executor: !EIFFEL_TEST_EXECUTOR_I]]
			-- <Precursor>

	factory_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; factory: !EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I]]]
			-- <Precursor>

	processor_proceeded_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
			-- <Precursor>

	processor_finished_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
			-- <Precursor>

	processor_stopped_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
			-- <Precursor>

end
