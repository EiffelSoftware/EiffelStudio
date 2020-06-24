note
	description: "Given a pattern, find if there is a match."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SUGGESTION_MATCHER

feature -- Access

	pattern: detachable IMMUTABLE_STRING_32
			-- Pattern being searched.

feature -- Preparation

	prepare (a_pattern: READABLE_STRING_GENERAL)
			-- Prepare a match for `a_pattern'.
		do
			create pattern.make_from_string_general (a_pattern)
		ensure
			pattern_set: pattern /= Void
		end

feature -- Status report

	is_ready: BOOLEAN
			-- Is Current ready for a pattern match?
		deferred
		end

	is_matching (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' a match for `pattern'?
		require
			is_ready: is_ready
		deferred
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
