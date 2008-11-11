indexing
	description: "[
		Objects providing base implementation for eiffel test factories.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CREATOR

inherit
	TEST_CREATOR_I
		undefine
			conf_type
		end

	TEST_PROCESSOR
		rename
			make as make_processor,
			tests as created_tests
		undefine
			conf_type
		redefine
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

	created_tests: !DS_LINEAR [!TEST_I]
			-- <Precursor>
		do
			Result := internal_created_tests
		end

feature {NONE} -- Access

	configuration: ?like conf_type
			-- Internal storage for `configuration'

	internal_created_tests: !DS_HASH_SET [!TEST_I]
			-- Internal storage for `created_tests'

feature -- Status report

	is_running: BOOLEAN
			-- <Precursor>
		do
			Result := configuration /= Void
		end

	is_finished: BOOLEAN
			-- <Precursor>

feature {NONE} -- Status report

	is_adding_tests: BOOLEAN
			-- Should tests added to the test suite also be added to `created_tests'?

feature {NONE} -- Status setting

	start_process_internal (a_arg: like conf_type)
			-- <Precursor>
		do
			is_finished := False
			configuration := a_arg
		end

	stop_process
			-- <Precursor>
		do
			configuration := Void
		end

feature {NONE} -- Query	

	is_valid_typed_configuration (a_arg: like conf_type): BOOLEAN
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

	on_test_added (a_collection: !ACTIVE_COLLECTION_I [!TEST_I]; a_item: !TEST_I)
			-- <Precursor>
		do
			if is_adding_tests then
				internal_created_tests.force_last (a_item)
				test_added_event.publish ([Current, a_item])
			end
		end

	on_test_removed (a_collection: !ACTIVE_COLLECTION_I [!TEST_I]; a_item: !TEST_I)
			-- <Precursor>
		do
			internal_created_tests.search (a_item)
			if internal_created_tests.found then
				internal_created_tests.remove_found_item
				test_removed_event.publish ([Current, a_item])
			end
		end

feature {NONE} -- Typing

	conf_type: !TEST_CREATOR_CONF_I
			-- <Precursor>
		deferred
		end

end
