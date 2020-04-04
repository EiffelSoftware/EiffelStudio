note
	description: "Sets of related testing operations."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_TEST_SET

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	frozen default_create
			-- <Precursor>
		local
			l_exec_env: EXECUTION_ENVIRONMENT
			l_exec_dir: PATH
			l_directory: DIRECTORY
			l_target_path: detachable PATH
		do
			create environment
			file_system := new_file_system

			create l_exec_env

			if attached environment.item ({EQA_TEST_SET}.target_path_key) as l_target then
				create l_target_path.make_from_string (l_target)
			else
				if
					attached environment.item ({EQA_TEST_SET}.testing_directory_key) as l_exec and then
					attached environment.item ({EQA_TEST_SET}.test_name_key) as l_test_name
				then
					create l_exec_dir.make_from_string (l_exec)
					l_target_path := l_exec_dir.extended (l_test_name)
					environment.put (l_target_path.name, {EQA_TEST_SET}.target_path_key)
				end
			end
				-- If launched from EiffelStudio's AutoTest we remove the previous executions.
			if l_target_path /= Void then
				create l_directory.make_with_path (l_target_path)
					-- We cannot assume that the directory does not already exist which sometimes
					-- happen since EiffelStudio let users keep their testing directory via a preference.
					-- This is why we do not assert its non-existence anymore, we will create it only if
					-- it does not exist.
				if not l_directory.exists then
					l_directory.recursive_create_dir
				else
						-- Remove existing file which could prevent a proper re-execution of the test
					l_directory.delete_content
				end
				assert_32 ({STRING_32} "testing_directory_exists " + l_target_path.name, l_directory.exists)
			end
			on_prepare
		ensure then
			prepared: is_prepared
			not_failed: not has_failed
		end

feature -- Access

	asserter: like new_asserter
			-- Assertions used to raise an exception to report unexpected behaviour.
			--
			-- Note: to extend or modify the asserter, redefine `new_asserter'.
		do
			if attached internal_asserter as l_asserter then
				Result := l_asserter
			else
				Result := new_asserter
				internal_asserter := Result
			end
		ensure
			asserter_attached: Result /= Void
		end

	file_system: like new_file_system
			-- File system for creating directories and files
			--
			-- Note: to extend or modify the file system, redefine `new_file_system'.

	environment: EQA_ENVIRONMENT
			-- Environment containing global settings

feature -- Access

	current_test_name: IMMUTABLE_STRING_32
			-- Name of test currently being executed
		obsolete
			"Use `environment.item ({EQA_TEST_SET}.test_name_key)` [2017-05-31]"
		do
			if attached environment.item ({EQA_TEST_SET}.test_name_key) as l_name then
				Result := l_name
			else
				create Result.make_empty
			end
		end

feature -- Status report

	is_prepared: BOOLEAN
			-- Is `Current' ready to execute test routines?
		do
			Result := True
		end

feature {NONE} -- Status report

	has_failed: BOOLEAN
			-- Has test routine thrown an exception?

feature -- Status setting

	set_asserter (a: like asserter)
			-- Set `asserter' with `a'.
		require
			a_attached: a /= Void
		do
			internal_asserter := a
		ensure
			asserter_set: asserter = a
		end

feature {EQA_TEST_EVALUATOR} -- Status setting

	frozen clean (a_has_failed: BOOLEAN)
			-- Release any resources allocated by `prepare'.
			--
			-- `a_failed': Indicates whether preceding test has thrown an exception.
		do
			has_failed := a_has_failed
			on_clean
			has_failed := False
		ensure
			not_failed: not has_failed
		end

feature -- Basic operations

	assert_32 (a_tag: READABLE_STRING_GENERAL; a_condition: BOOLEAN)
			-- Assert `a_condition'.
		require
			a_tag_not_void: a_tag /= Void
		do
			asserter.assert (a_tag, a_condition)
		end

	assert (a_tag: READABLE_STRING_GENERAL; a_condition: BOOLEAN)
			-- Assert `a_condition'.
		require
			a_tag_not_void: a_tag /= Void
		do
			asserter.assert (a_tag, a_condition)
		end

feature {NONE} -- Events

	on_prepare
			-- Called after all initializations in `default_create'.
		do
		ensure
			prepared: is_prepared
		end

	on_clean
			-- Called before `clean' performs any cleaning up.
		do
		end

feature {NONE} -- Implementation

	internal_asserter: detachable like asserter
			-- Once per object storage for `asserter'

feature {NONE} -- Factory

	new_asserter: EQA_ASSERTIONS
			-- Create new `assserter'
			--
			-- Note: redefine in order to specialize assertion handling.
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

	new_file_system: EQA_FILE_SYSTEM
			-- Create new `file_system'
			--
			-- Note: redefine in order to extend file system functionality.
		do
			create Result.make (asserter)
		ensure
			result_attached: Result /= Void
			result_valid: Result.asserter = asserter
		end

feature -- Constants

	test_name_key: STRING = "TEST_NAME"
			-- Key for test name setting in {EQA_ENVIRONMENT}
			--
			-- The test name is a string unique to each test wich can be used a file/directory name.

	testing_directory_key: STRING = "TESTING_DIRECTORY"
			-- Key for testing directory setting in {EQA_ENVIRONMENT}
			--
			-- The testing directory is where the test specific working directories are created.

	target_path_key: STRING = "TARGET_PATH"
			-- Key for path in which test of `Current' is executed

	source_path_key: STRING = "SOURCE_PATH"

invariant
	internal_file_system_valid: file_system.asserter = asserter

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
