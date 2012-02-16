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
		require
			a_pattern_is_string_8: a_pattern.is_valid_as_string_8
		do
			create pattern.make_from_string (a_pattern.as_string_32)
		ensure
			pattern_set: attached pattern as l_pattern and then l_pattern.same_string_general (a_pattern)
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
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
