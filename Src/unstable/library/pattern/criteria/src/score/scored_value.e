note
	date: "$Date$"
	revision: "$Revision$"

class
	SCORED_VALUE [G]

inherit
	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_value: G; a_score: REAL)
		do
			value := a_value
			score := a_score
		end

feature -- Access

	value: G

	score: REAL

feature -- Status

	score_is_zero: BOOLEAN
		do
			Result := score <= {REAL_32}.machine_epsilon
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
			-- higher score is less.
		do
			if score > other.score then
				Result := True
			elseif other.score - score <= {REAL_32}.machine_epsilon then
					-- Same score.
				if
					attached {COMPARABLE} value as l_value and
					attached {COMPARABLE} other.value as l_other_value
				then
					Result := l_value < l_other_value
				end
			end
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make (5)
			Result.append_character ('[')
			Result.append_real (score)
			Result.append_character (']')
			Result.append_character (' ')
			if attached {DEBUG_OUTPUT} value as dbg then
				Result.append_string_general (dbg.debug_output)
			elseif attached {ANY} value as v then
				Result.append (v.generating_type.name_32)
			end
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
