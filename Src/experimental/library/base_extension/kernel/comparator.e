note
	description: "Total order comparators"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPARATOR [G]

inherit
	PART_COMPARATOR [G]

	EQUALITY_TESTER [G]
		redefine
			test
		end

feature -- Status report

	order_equal (u, v: G): BOOLEAN
			-- Are `u' and `v' considered equal?
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := not less_than (u, v) and not less_than (v, u)
		ensure
			definition: Result = (not less_than (u, v) and not less_than (v, u))
		end

	less_equal (u, v: G): BOOLEAN
			-- Is `u' considered less than or equal to `v'?
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := not less_than (v, u)
		ensure
			definition: Result = (less_than (u, v) or order_equal (u, v))
		end

	greater_equal (u, v: G): BOOLEAN
			-- Is `u' considered greater than or equal to `v'?
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := not less_than (u, v)
		ensure
			definition: Result = (less_than (v, u) or order_equal (u, v))
		end

	test (v, u: detachable G): BOOLEAN
			-- Are `v' and `u' considered equal?
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := order_equal (u, v)
			end
		end

note
	copyright: "[
		Copyright (c) 1984-2009, Eiffel Software and others
		Copyright (c) 2000, Eric Bezault and others
		]"
	license: "[
		Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)
		MIT License (see http://www.eiffel.com/licensing/mit.txt)
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
