note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	CRITERIA_NOT [G]

inherit
	CRITERIA [G]

create
	make

feature {NONE} -- Initialization

	make (a_criteria: CRITERIA [G])
			-- Initialize `Current'.
		do
			criteria := a_criteria
		end

feature -- Status

	meet (d: G): BOOLEAN
		do
			Result := not criteria.meet (d)
		end

feature -- Access

	criteria: CRITERIA [G]

feature -- Change

	set_criteria (f: like criteria)
		do
			criteria := f
		end

feature -- Visitor

	accept (a_visitor: CRITERIA_VISITOR [G])
			-- <Precursor>
		do
			a_visitor.visit_not (Current)
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
