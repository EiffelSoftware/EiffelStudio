note
	description: "[
		Sets of related testing operations.
	]"
	author: ""
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
			l_name, l_exec_dir: READABLE_STRING_8
			l_directory: detachable DIRECTORY
			l_target_path: detachable READABLE_STRING_8
		do
			create environment
			file_system := new_file_system

			create l_exec_env

			l_name := environment.get_attached ({EQA_TEST_SET}.test_name_key, asserter)
			if attached environment.get ({EQA_TEST_SET}.target_path_key) as l_target then
				l_target_path := l_target
			else
				if attached environment.get ({EQA_TEST_SET}.execution_directory_key) as l_exec then
					l_exec_dir := l_exec
				else
					l_exec_dir := l_exec_env.current_working_directory
				end
				l_target_path := file_system.build_path (l_exec_dir, << l_name >>)
				environment.put (l_target_path, {EQA_TEST_SET}.target_path_key)
			end

			create l_directory.make (l_target_path)
			assert ("testing_directory_already_exists", not l_directory.exists)
			l_directory.recursive_create_dir
			assert ("testing_directory_created", l_directory.exists)
			l_exec_env.change_working_directory (l_target_path)

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

	current_test_name: READABLE_STRING_8
			-- Name of test currently being executed
		obsolete
			"Use {EQA_EVALUATION_INFO}.test_name"
		do
			Result := (create {EQA_EVALUATION_INFO}).test_name
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

	assert (a_tag: STRING; a_condition: BOOLEAN)
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

	execution_directory_key: STRING = "EXECUTION_DIRECTORY"
			-- Key for execution directory setting in {EQA_ENVIRONMENT}
			--
			-- The execution directory is where the test specific working directories are created.

	target_path_key: STRING = "TARGET_PATH"
			-- Key for path in which test of `Current' is executed

invariant
	internal_file_system_valid: file_system.asserter = asserter

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
