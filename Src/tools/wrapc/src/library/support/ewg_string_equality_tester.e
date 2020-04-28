note

	description:

		"Equality testers between strings that can be polymorphically unicode strings"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2003-2004, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

-- Borrowed from GOBO CVS, when GOBO 3.4 comes out, remove this class
class EWG_STRING_EQUALITY_TESTER

inherit

	KL_EQUALITY_TESTER [STRING]
		redefine
			test
		end

	KL_IMPORTED_STRING_ROUTINES

feature -- Status report

	test (v, u: detachable STRING): BOOLEAN
			-- Are `v' and `u' considered equal?
			-- They are considered equal if they have the same number of
			-- characters and these characters (possibly unicode characters,
			-- although not optimized in that case) have codes which are one
			-- by one equal.
		local
			i, nb: INTEGER
		do
			if v = Void then
				Result := (u = Void)
			elseif u = Void then
				Result := False
			elseif v = u then
				Result := True
			else
				nb := v.count
				if u.count = nb then
					Result := True
					from i := 1 until i > nb loop
						if v.item_code (i) /= u.item_code (i) then
							Result := False
							i := nb + 1 -- Jump out of the loop.
						else
							i := i + 1
						end
					end
				end
			end
		end

end
