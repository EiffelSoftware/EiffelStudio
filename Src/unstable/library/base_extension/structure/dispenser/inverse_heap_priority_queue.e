note
	description: "[
		Heap priority queue sorted such that the item with the lowest
		priority is placed at the head of the queue.
		]"
	author: "Olivier Jeger"
	date: "$Date$"
	revision: "$Revision$"

class
	INVERSE_HEAP_PRIORITY_QUEUE [G -> COMPARABLE]

inherit
	HEAP_PRIORITY_QUEUE [G]
		redefine
			safe_less_than
		end

create
	make

feature {NONE} -- Comparison

	safe_less_than (a, b: G): BOOLEAN
			-- Same as `a > b' when `a' and `b' are not Void.
			-- If `b' is Void and `a' is not, then True
			-- Otherwise False
		do
			if a /= Void and b /= Void then
				Result := a > b
			else
				Result := attached a
			end
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
