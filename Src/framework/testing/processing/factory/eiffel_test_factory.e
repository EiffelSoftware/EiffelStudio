indexing
	description: "[
		Objects providing base implementation for eiffel test factories.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_FACTORY

inherit
	EIFFEL_TEST_FACTORY_I

	EIFFEL_TEST_PROCESSOR
		rename
			make as make_processor,
			tests as created_tests,
			argument as configuration,
			is_valid_argument as is_valid_configuration
		redefine
			configuration,
			on_test_added,
			on_test_removed
		end

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initialize `Current'.
		do
			create internal_created_tests.make_default
			make_processor (a_test_suite)
		end

feature -- Access

	created_tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		do
			Result := internal_created_tests
		end

	configuration: !like internal_configuration
			-- <Precursor>
		do
			if {l_conf: like configuration} internal_configuration then
				Result := l_conf
			end
		end

feature {NONE} -- Access

	internal_configuration: ?EIFFEL_TEST_CONFIGURATION_I
			-- Internal storage for `configuration'

	internal_created_tests: !DS_HASH_SET [!EIFFEL_TEST_I]
			-- Internal storage for `created_tests'

feature -- Status report

	is_running: BOOLEAN
			-- <Precursor>
		do
			Result := internal_configuration /= Void
		end

	is_finished: BOOLEAN
			-- <Precursor>

feature {NONE} -- Status report

	is_adding_tests: BOOLEAN
			-- Should tests added to the test suite also be added to `created_tests'?

feature {NONE} -- Status setting

	start_process_internal (a_arg: like configuration)
			-- <Precursor>
		do
			is_finished := False
			internal_configuration := a_arg
		end

	stop_process
			-- <Precursor>
		do
			internal_configuration := Void
		end

feature {NONE} -- Query	

	is_valid_typed_argument (a_arg: like configuration): BOOLEAN
			-- <Precursor>
		do
			Result := a_arg.is_interface_usable
		end

feature {NONE} -- Basic operations

	add_class (a_cluster: !CONF_CLUSTER; a_path, a_filename: !STRING)
			-- Add new test class to eiffel project and update test suite.
		do
			test_suite.eiffel_project_helper.add_class (a_cluster, a_path, a_filename)
			if test_suite.eiffel_project_helper.is_class_added then
				synchronize_class (test_suite.eiffel_project_helper.last_added_class)
			end
		end

	synchronize_class (a_class: !EIFFEL_CLASS_I)
			-- Synchronize `a_class' with test suite and add any new tests to `created_tests'.
		do
			is_adding_tests := True
			test_suite.synchronize_with_class (a_class)
			is_adding_tests := False
		end

feature {NONE} -- Events

	on_test_added (a_collection: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]; a_item: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			if is_adding_tests then
				internal_created_tests.force_last (a_item)
				test_added_event.publish ([Current, a_item])
			end
		end

	on_test_removed (a_collection: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]; a_item: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			internal_created_tests.search (a_item)
			if internal_created_tests.found then
				internal_created_tests.remove_found_item
				test_removed_event.publish ([Current, a_item])
			end
		end

end
