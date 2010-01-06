indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		MULTI [G->{COMPARABLE, NUMERIC}]

create
	default_create

feature -- do compuations

		abs_diff ( a_g1, a_g2: G): G is
			-- for testing
		do
			if a_g1 > a_g2 then
				Result := a_g1 - a_g2
			else
				Result := a_g2 - a_g1
			end
		end
end
