indexing
	description: "Universal assertion mechanisms."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ASSERTIONS

feature -- Basic operations

	frozen assert (a_tag: STRING; a_condition: BOOLEAN) is
			-- Assert `a_condition'.
		require
			a_tag_not_void: a_tag /= Void
		do
			last_assertion_failed := a_condition
			if not a_condition then
				on_violation (a_tag)
					-- Throw an exception here.
			else
				on_satisfaction (a_tag)
			end
		end

	disassert (a_tag: STRING; a_condition: BOOLEAN) is
			-- Assert that `a_condition' is false.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (a_tag, not a_condition)
		end

	on_violation (a_tag: STRING) is
			-- Called when a violation occurred in `assert'.
		require
			last_assertion_failed: last_assertion_failed
		do
		end

	on_satisfaction (a_tag: STRING) is
			-- Called when no violation occurred in `assert'.
		require
			last_assertion_succeeded: not last_assertion_failed
		do
		end

feature -- Status report

	last_assertion_failed: BOOLEAN
			-- Status of last call to `assert'.

end
