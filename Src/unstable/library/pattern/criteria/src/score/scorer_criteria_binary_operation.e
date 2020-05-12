note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCORER_CRITERIA_BINARY_OPERATION [G]

inherit
	SCORER_CRITERIA [G]

feature {NONE} -- Initialization

	make (a_criteria, a_other_criteria: SCORER_CRITERIA [G])
			-- Initialize `Current'.
		do
			left := a_criteria
			right := a_other_criteria
			weight := (a_criteria.weight + a_other_criteria.weight) / 2
		ensure
			criteria_set: left = a_criteria
			other_criteria_set: right = a_other_criteria
		end

feature -- Access

	left,
	right: SCORER_CRITERIA [G]

	operator_string: detachable READABLE_STRING_32

	weight: REAL

feature -- Change

	set_criteria (a_criteria: like left)
		do
			left := a_criteria
			weight := a_criteria.weight + right.weight
		ensure
			criteria_set: left = a_criteria
		end

	set_other_criteria (a_other_criteria: like right)
		do
			right := a_other_criteria
			weight := left.weight + a_other_criteria.weight
		ensure
			other_criteria_set: right = a_other_criteria
		end

	set_operator_string (s: like operator_string)
		do
			if s = Void then
				operator_string := Void
			elseif s.is_empty then
				operator_string := " "
			else
				operator_string := {STRING_32} " " + s + " "
			end
		ensure
			attached operator_string as l_op implies (l_op[1] = ' ' and l_op[l_op.count] = ' ')
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
