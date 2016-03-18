note
	description : "Objects that represent a AND criteria"
	date: "$Date$"
	revision: "$Revision$"

class
	CRITERIA_AND [G]

inherit
	CRITERIA_BINARY_OPERATION [G]

create
	make

feature -- Status

	meet (d: G): BOOLEAN
		do
			Result := criteria.meet (d) and other_criteria.meet (d)
		end

feature -- Visitor

	accept (a_visitor: CRITERIA_VISITOR [G])
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
