note
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CRITERIA_BINARY_OPERATION [G]

inherit
	CRITERIA [G]

feature {NONE} -- Initialization

	make (a_criteria, a_other_criteria: CRITERIA [G])
			-- Initialize `Current'.
		do
			criteria := a_criteria
			other_criteria := a_other_criteria
		ensure
			criteria_set: criteria = a_criteria
			other_criteria_set: other_criteria = a_other_criteria
		end

feature -- Status

	meet (d: G): BOOLEAN
		deferred
		end

feature -- Access

	criteria,
	other_criteria: CRITERIA [G]

	operator_string: detachable READABLE_STRING_32

feature -- Change

	set_criteria (a_criteria: like criteria)
		do
			criteria := a_criteria
		ensure
			criteria_set: criteria = a_criteria
		end

	set_other_criteria (a_other_criteria: like other_criteria)
		do
			other_criteria := a_other_criteria
		ensure
			other_criteria_set: other_criteria = a_other_criteria
		end

	set_operator_string (s: like operator_string)
		do
			if s = Void then
				operator_string := Void
			elseif s.is_empty then
				operator_string := " "
			else
				operator_string := " " + s + " "
			end
		ensure
			attached operator_string as l_op implies (l_op[1] = ' ' and l_op[l_op.count] = ' ')
		end

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
