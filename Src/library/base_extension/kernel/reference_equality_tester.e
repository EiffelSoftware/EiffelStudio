note
	description: "Reference equality testers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCE_EQUALITY_TESTER [G -> detachable ANY]

inherit
	EQUALITY_TESTER [G]
		redefine
			test
		end

feature -- Status report

	test (v, u: detachable G): BOOLEAN is
			-- Are `v' and `u' the same reference?
		do
			Result := v = u
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
