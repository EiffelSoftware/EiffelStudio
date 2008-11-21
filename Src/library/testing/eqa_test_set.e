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

	frozen prepare
			-- Prepare `Current' to execute any test routine.
		do
			on_prepare
		end

	frozen clean
			-- Release any resources allocated by `prepare'.
		do
			on_clean
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
			-- Called immediatly before `prepare' returns.
		do
		end

	on_clean
			-- Called immediatly before `clean' return.
		do
		end

feature {NONE} -- Implementation

	internal_asserter: like asserter
			-- Once per object storage for `asserter'.

end
