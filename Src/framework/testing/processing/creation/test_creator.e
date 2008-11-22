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

	class_name_counter: NATURAL
			-- Counter used by `create_new_class' to generate class names

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

	is_creating_new_class: BOOLEAN
			-- Are we currently printing a new class?
		require
			running: is_running
		deferred
		end

feature {NONE} -- Status setting

	start_process_internal (a_conf: like conf_type)
			-- <Precursor>
		do
			internal_created_tests.wipe_out
			tests_reset_event.publish ([Current])
			is_finished := False
			configuration := a_conf
			class_name_counter := 1
			internal_progress := {REAL} 0.1
		end

	stop_process
			-- <Precursor>
		do
			configuration := Void
		end

feature {NONE} -- Query	

	is_valid_typed_configuration (a_conf: like conf_type): BOOLEAN
			-- <Precursor>
		do
			Result := a_conf.is_interface_usable
		end

feature {NONE} -- Basic operations

	create_new_class
			-- Create a new class according to `configuration'.
		require
			running: is_running
			creating_new_class: is_creating_new_class
			configuration_valid: configuration.is_new_class
		local
			l_location: DIRECTORY_NAME
			l_directory: DIRECTORY
			l_path: ?FILE_NAME
			l_file: !KL_TEXT_OUTPUT_FILE
			l_filename: STRING
			l_class_name: STRING
		do
			if not configuration.cluster.is_readonly then
				create l_location.make_from_string (configuration.cluster.location.build_path (configuration.path, ""))
				create l_directory.make (l_location)
				if l_directory.exists and l_directory.is_writable then
					from until
						l_filename /= Void
					loop
						create l_path.make_from_string (l_location)
						if configuration.is_multiple_new_classes then
							create l_filename.make (configuration.new_class_name.count + 6)
							l_filename.append (configuration.new_class_name.as_lower)
							l_filename.append_character ('_')
							if class_name_counter < 10 then
								l_filename.append ("00")
							elseif class_name_counter < 100 then
								l_filename.append ("0")
							end
							l_filename.append_natural_32 (class_name_counter)
						else
							l_filename := configuration.new_class_name.as_lower
						end
						l_filename.append (".e")
						l_path.set_file_name (l_filename)
						create l_file.make (l_path)
						if configuration.is_multiple_new_classes then
							if l_file.exists then
								class_name_counter := class_name_counter + 1
								if class_name_counter <= 999 then
									l_filename := Void
								end
							end
						end
					end

					if not l_file.exists then
						l_file.open_write
						if l_file.is_open_write then
							l_class_name := l_filename.substring (1, l_filename.count - 2)
							check l_class_name /= Void end
							l_class_name.to_upper
							print_new_class (l_file, l_class_name)
							if l_file.is_open_write then
								l_file.close
							end
							if l_file.exists and then l_file.count > 0 then
								add_class (l_filename)
							end
						else
							test_suite.propagate_error (e_file_not_creatable, [l_location, l_filename], Current)
						end
					else
						test_suite.propagate_error (e_file_already_exists, [l_location, l_filename], Current)
					end
				else
					if l_directory.exists then
						test_suite.propagate_error (e_directory_not_writable, [l_location], Current)
					else
						test_suite.propagate_error (e_directory_does_not_exist, [l_location], Current)
					end
				end
			else
				test_suite.propagate_error (e_cluster_read_only, [l_location], Current)
			end
		end

	print_new_class (a_file: !KL_TEXT_OUTPUT_FILE; a_class_name: !STRING)
			-- Print new class text to `a_file'.
		require
			running: is_running
			creating_new_class: is_creating_new_class
			a_file_open_write: a_file.is_open_write
		deferred
		end

	add_class (a_filename: !STRING)
			-- Add new test class to eiffel project and update test suite.
		require
			running: is_running
			configuration_valid: configuration.is_new_class
		do
			test_suite.eiffel_project_helper.add_class (configuration.cluster, configuration.path, a_filename)
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

feature {NONE} -- Constants

	e_can_not_create_new_class_file: !STRING = "Can not create new class file in $1:%N%N"
	e_cluster_read_only: !STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("Cluster is read only.")
		end
	e_directory_does_not_exist: !STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("Path does not exist.")
		end
	e_directory_not_writable: !STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("Path is not writable.")
		end
	e_file_already_exists: !STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("File $2 already exists.")
		end
	e_file_not_creatable: !STRING
		do
			Result := e_can_not_create_new_class_file.twin
			Result.append ("Unable to create file $2.")
		end

end
