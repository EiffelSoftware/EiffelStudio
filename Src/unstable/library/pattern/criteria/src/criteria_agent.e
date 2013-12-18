note
	description: "Summary description for {CRITERIA_AGENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CRITERIA_AGENT [G]

inherit
	CRITERIA [G]

create
	make

feature {NONE} -- Initialization

	make (a_string: READABLE_STRING_GENERAL; fct: like meet_function)
		do
			meet_function := fct
			create string.make_from_string_general (a_string)
		end

	meet_function: FUNCTION [ANY, TUPLE [G], BOOLEAN]

feature -- Status report

	meet (d: G): BOOLEAN
		do
			Result := meet_function.item ([d])
		end

	string: IMMUTABLE_STRING_32

feature -- Visitor

	accept (a_visitor: CRITERIA_VISITOR [G])
			-- <Precursor>
		do
			a_visitor.visit_agent (Current)
		end

invariant
	string /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
