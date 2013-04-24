note
	description: "Universal assertion mechanisms."
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_ASSERTIONS

feature -- Basic operations

	frozen assert (a_tag: READABLE_STRING_GENERAL; a_condition: BOOLEAN)
			-- Assert `a_condition'.
		require
			a_tag_not_void: a_tag /= Void
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			last_assertion_failed := not a_condition
			if last_assertion_failed then
				on_violation (a_tag)
				create l_exception
				l_exception.set_description (a_tag)
				l_exception.raise
			else
				on_satisfaction (a_tag)
			end
		end

	disassert (a_tag: READABLE_STRING_GENERAL; a_condition: BOOLEAN)
			-- Assert that `a_condition' is false.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (a_tag, not a_condition)
		end

	on_violation (a_tag: READABLE_STRING_GENERAL)
			-- Called when a violation occurred in `assert'.
		require
			last_assertion_failed: last_assertion_failed
			a_tag_attached: a_tag /= Void
		do
		end

	on_satisfaction (a_tag: READABLE_STRING_GENERAL)
			-- Called when no violation occurred in `assert'.
		require
			last_assertion_succeeded: not last_assertion_failed
			a_tag_attached: a_tag /= Void
		do
		end

feature -- Status report

	last_assertion_failed: BOOLEAN
			-- Status of last call to `assert'.

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
