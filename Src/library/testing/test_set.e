indexing
	description: "Sets of related testing operations."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SET

feature -- Initialization

	set_up is
		do
		end

	tear_down is
		do
		end

feature -- Access

	asserter: TEST_ASSERTIONS is
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

feature -- Settings

	set_asserter (a: like asserter) is
			-- Set `asserter' with `a'.
		require
			a_attached: a /= Void
		do
			internal_asserter := a
		ensure
			asserter_set: asserter = a
		end

feature -- Basic operations

	assert (a_tag: STRING; a_condition: BOOLEAN) is
			-- Assert `a_condition'.
		require
			a_tag_not_void: a_tag /= Void
		do
			asserter.assert (a_tag, a_condition)
		end

feature {NONE} -- Implementation: Access

	internal_asserter: like asserter
			-- Once per object storage for `asserter'.

feature {NONE} -- Implementation

	frozen evaluator_root: ?TEST_ROOT_APPLICATION
			-- Anchor for {TEST_ROOT_APPLICATION}.
			--
			-- Note: this anchor prevents recompiling classes needed by {TEST_ROOT_APPLICATION} every time
			--       test execution is launched.
		do
		end

end
