indexing
	description: "[
		Sets of related testing operations.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_TEST_SET

feature -- Access

	asserter: EQA_ASSERTIONS is
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
			Result := current_test_name /= Void
		ensure
			result_implies_test_name_attached: Result implies current_test_name /= Void
		end

feature {NONE} -- Status report

	has_failed: BOOLEAN
			-- Has test routine thrown an exception?

feature -- Status setting

	set_asserter (a: like asserter) is
			-- Set `asserter' with `a'.
		require
			a_attached: a /= Void
		do
			internal_asserter := a
		ensure
			asserter_set: asserter = a
		end

feature {EQA_TEST_EVALUATOR} -- Status setting

	frozen prepare (a_name: STRING)
			-- Prepare `Current' to execute any test routine.
			--
			-- `a_name': Name of the test which will called after preparation.
		require
			a_name_not_void: a_name /= Void
			a_name_valid: is_valid_name (a_name)
		do
			create {IMMUTABLE_STRING_8} current_test_name.make_from_string (a_name)
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
			not_prepared: not is_prepared
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

	assert (a_tag: STRING; a_condition: BOOLEAN) is
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
			prepared: is_prepared
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
			current_test_name_attached: current_test_name /= Void
		end

feature {NONE} -- Implementation

	internal_asserter: like asserter
			-- Once per object storage for `asserter'.

invariant
	valid_test_name: current_test_name /= Void implies is_valid_name (current_test_name)

end
