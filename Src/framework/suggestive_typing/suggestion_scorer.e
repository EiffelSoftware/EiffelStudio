note
	description: "Given a pattern, compute the match score."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SUGGESTION_SCORER

inherit
	SUGGESTION_MATCHER

feature -- Status report

	score (a_string: READABLE_STRING_GENERAL): REAL
			-- Matching score for `a_string`.
		require
			is_ready: is_ready
		deferred
		end

	is_zero_score (a_score: REAL): BOOLEAN
		do
			Result := a_score < {REAL}.machine_epsilon
		end

	is_matching (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' a match for `pattern'?
		do
			Result := not is_zero_score (score (a_string))
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
