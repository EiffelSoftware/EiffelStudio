note
	description: "[
		Sets of related testing operations.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_TEST_SET

feature -- Access

	asserter: EQA_ASSERTIONS
			-- Assertions used to raise an exception to report unexpected behaviour.
		do
			if internal_asserter /= Void then
				Result := internal_asserter
			else
				create Result
				internal_asserter := Result
			end
		ensure
			asserter_attached: Result /= Void
		end

feature -- Access

	current_test_name: ?READABLE_STRING_8
			-- Name of test currently being executed

feature -- Status report

	is_prepared: BOOLEAN
			-- Is `Current' ready to execute test routines?
		do
			Result := has_valid_name
		ensure
			result_implies_test_name_attached: Result implies has_valid_name
		end

	has_valid_name: BOOLEAN
			-- Is `current_test_name' a valid test name?
		do
			Result := current_test_name /= Void
		ensure
			result_implies_attached: Result implies current_test_name /= Void
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

	frozen prepare (a_name: !READABLE_STRING_8)
			-- Prepare `Current' to execute any test routine.
			--
			-- `a_name': Name of the test which will called after preparation.
		require
			a_name_not_void: a_name /= Void
			a_name_valid: is_valid_name (a_name)
		do
			current_test_name := a_name.twin
			on_prepare
		ensure
			prepared: is_prepared
			not_failed: not has_failed
		end

	frozen clean (a_has_failed: BOOLEAN)
			-- Release any resources allocated by `prepare'.
			--
			-- `a_failed': Indicates whether preceding test has thrown an exception.
		do
			has_failed := a_has_failed
			on_clean
			has_failed := False
			current_test_name := Void
		ensure
			current_test_name_detached: current_test_name = Void
			not_failed: not has_failed
		end

feature -- Query

	frozen is_valid_name (a_name: STRING): BOOLEAN
			-- Is `a_name' a valid name for a test?
		local
			i: INTEGER
			c: CHARACTER
		do
			if not a_name.is_empty then
				from
					Result := a_name.item (1).is_alpha_numeric
					i := 2
				until
					not Result or i > a_name.count
				loop
					c := a_name.item (i)
					Result := c.is_alpha_numeric or c = '_'
					i := i + 1
				end
			end
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
		require
			has_valid_name: has_valid_name
		do
		ensure
			prepared: is_prepared
		end

	on_clean
			-- Called before `clean' performs any cleaning up.
		require
			prepared: is_prepared
		do
		ensure
			has_valid_name: has_valid_name
		end

feature {NONE} -- Implementation

	internal_asserter: like asserter
			-- Once per object storage for `asserter'.

invariant
	valid_test_name: current_test_name /= Void implies is_valid_name (current_test_name)

note
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
