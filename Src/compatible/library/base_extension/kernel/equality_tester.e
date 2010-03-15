note
	description: "Equality testers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EQUALITY_TESTER [G -> detachable ANY]

feature -- Status report

	test (v, u: detachable G): BOOLEAN is
			-- Are `v' and `u' considered equal?
			-- (Use '~' by default.)
		do
			if v = u then
				Result := True
			else
				Result := v ~ u
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
