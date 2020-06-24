note
	description: "Summary description for {FILE_SUGGESTION_MATCHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_STARTS_WITH_SUGGESTION_MATCHER

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
				if i = 1 then
					Result := {REAL} 1.0 / (p.count - a_string.count).abs.max (1)
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

