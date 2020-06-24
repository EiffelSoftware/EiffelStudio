note
	description: "Summary description for {CASE_INSENSITIVE_SUBSTRING_SUGGESTION_MATCHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CASE_INSENSITIVE_SUBSTRING_SUGGESTION_MATCHER

inherit
	SUBSTRING_SUGGESTION_MATCHER
		redefine
			score,
			prepare
		end

feature -- Preparation

	prepare (a_pattern: READABLE_STRING_GENERAL)
			-- Prepare a match for `a_pattern'.
		do
			create pattern.make_from_string_general (a_pattern.as_lower)
		ensure then
			pattern_set: attached pattern as p and then a_pattern.is_case_insensitive_equal (p)
		end

feature -- Status report

	score (a_string: READABLE_STRING_GENERAL): REAL
			-- <Precursor>
		do
			Result := Precursor (a_string.as_lower)
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
