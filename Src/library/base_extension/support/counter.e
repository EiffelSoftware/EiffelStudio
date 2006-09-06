indexing
	description: "Notion of counter."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: "

class COUNTER

feature -- Access

	value: INTEGER
			-- Counter value

	next: INTEGER is
			-- Next value
		do
			value := value + 1
			Result := value
		end

feature -- Settings

	reset is
			-- Reset the counter
		do
			value := 0
		ensure
			value_set: value = 0
		end

	set_value (val: INTEGER) is
			-- Assign `val' to `value'.
		do
			value := val
		ensure
			value_set: value = val
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
