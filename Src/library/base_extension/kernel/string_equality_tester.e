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

create
	default_create,
	make_caseless

feature {NONE} -- Initialization

	make_caseless
			-- Create string equality tester ignoring case 
			-- when comparing keys
		do
			default_create
			is_case_insensitive := True
		end

feature -- Status report

	is_case_insensitive: BOOLEAN
			-- Ignoring case when comparing keys?
			-- (Default: False)

feature -- Comparison

	test (v, u: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Are `v' and `u' considered equal?
		do
			if v = u then
				Result := True
			elseif v = Void or u = Void then
				Result := False
			else
				if is_case_insensitive then
					Result := v.is_case_insensitive_equal (u)
				else
					Result := v.same_string (u)
				end
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
