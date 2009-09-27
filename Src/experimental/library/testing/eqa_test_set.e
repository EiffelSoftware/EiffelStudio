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
			l_info: EQA_EVALUATION_INFO
			l_directory_name: DIRECTORY_NAME
			l_directory: DIRECTORY
		do
			create l_info
			create l_directory_name.make_from_string (l_info.test_directory)

			l_directory_name.extend (l_info.test_name)
			create l_directory.make (l_directory_name)
			assert ("testing_directory_already_exists", not l_directory.exists)
			l_directory.create_dir
			assert ("testing_directory_created", l_directory.exists)
			(create {EXECUTION_ENVIRONMENT}).change_working_directory (l_directory_name)

			on_prepare
		ensure then
			prepared: is_prepared
			not_failed: not has_failed
		end

feature -- Access

	asserter: EQA_ASSERTIONS
			-- Assertions used to raise an exception to report unexpected behaviour.
		local
			l_asserter: like internal_asserter
		do
			l_asserter := internal_asserter
			if l_asserter /= Void then
				Result := l_asserter
			else
				create Result
				internal_asserter := Result
			end
		ensure
			asserter_attached: Result /= Void
		end

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

	run_test (a_procedure: PROCEDURE [ANY, TUPLE [like Current]])
			-- Run the test `a_procedure' (from `Current').
			--
			-- Note: this routine can be redefined in order to wrap the actual test routine call.
		require
			a_procedure_attached: a_procedure /= Void
			prepared: is_prepared
		local
			l_operands: TUPLE [like Current]
		do
			l_operands := a_procedure.empty_operands
			check
				valid_operand_count: l_operands.count = 1
				valid_operand: l_operands.valid_type_for_index (Current, 1)
			end
			l_operands.put (Current, 1)
			a_procedure.call (l_operands)
		end

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
			-- Called after `prepare' has performed all initialization.
		do
		ensure
			prepared: is_prepared
		end

	on_clean
			-- Called before `clean' performs any cleaning up.
		require
			prepared: is_prepared
		do
		end

feature {NONE} -- Implementation

	internal_asserter: detachable like asserter
			-- Once per object storage for `asserter'.

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
