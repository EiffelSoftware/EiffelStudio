note
	description: "Given a string, find if this is part of another string."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SUBSTRING_SUGGESTION_MATCHER

inherit
	SUGGESTION_SCORER

feature -- Status report

	is_ready: BOOLEAN = True
			-- <Precursor>
			-- We can always perform a match.

	score (a_string: READABLE_STRING_GENERAL): REAL
			-- <Precursor>
		local
			i: INTEGER
		do
			if attached pattern as p then
				i := a_string.substring_index (p, 1)
				if i > 0 then
					Result := {REAL} 1.0 / i
				end
			end
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
