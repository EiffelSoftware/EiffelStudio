note
	description: "Equality tester to compare all kind of strings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_EQUALITY_TESTER

inherit
	EQUALITY_TESTER [READABLE_STRING_GENERAL]
		redefine
			test
		end

feature

feature -- Status report

	test (v, u: detachable READABLE_STRING_GENERAL): BOOLEAN is
			-- Are `v' and `u' considered equal?
			-- (Use '~' by default.)
		do
			if v = u then
				Result := True
			elseif v = Void or u = Void then
				Result := False
			else
				Result := v.same_string (u)
			end
		end

note
	copyright: "[
		Copyright (c) 1984-2011, Eiffel Software and others
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
