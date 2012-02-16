note
	description: "Given a string, find if this is part of another string."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SUBSTRING_SUGGESTION_MATCHER

inherit
	SUGGESTION_MATCHER
		redefine
			is_ready
		end

feature -- Status report

	is_ready: BOOLEAN = True
			-- <Precursor>
			-- We can always perform a match.

	is_matching (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
		do
			if attached pattern as l_pattern then
				Result := a_string.has_substring (l_pattern)
			end
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
