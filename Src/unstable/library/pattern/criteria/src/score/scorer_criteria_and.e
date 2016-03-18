note
	description : "Objects that represent a AND criteria"
	date: "$Date$"
	revision: "$Revision$"

class
	SCORER_CRITERIA_AND [G]

inherit
	SCORER_CRITERIA_BINARY_OPERATION [G]
		redefine
			score
		end

create
	make

feature -- Status

	score (d: G): REAL
		local
			r1,r2: REAL_32
			w1,w2: REAL_32
		do
			r1 := left.score (d)
			w1 := left.weight
			r2 := right.score (d)
			w2 := right.weight
			if score_is_zero (r1) or score_is_zero (r2) then
				Result := 0.0
			else
				Result := (r1 * w1 + r2 * w2) / (w1 + w2)
			end
		end

feature -- Visitor

	accept (a_visitor: SCORE_VISITOR [G])
			-- <Precursor>
		do
			a_visitor.visit_and (Current)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
