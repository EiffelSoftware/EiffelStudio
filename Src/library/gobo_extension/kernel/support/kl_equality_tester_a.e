note

	description:

		"Equality testers"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_EQUALITY_TESTER_A [G]

inherit
	ANY -- Needed for SE 2.1b1.

	KL_EQUALITY_TESTER [detachable G]
		rename
			test as internal_test
		redefine
			internal_test
		end

feature -- Status report

	test (v, u: attached G): BOOLEAN
			-- Are `v' and `u' considered equal?
			-- (Use `equal' by default.)
		do
			Result := ANY_.equal_objects (v, u)
		end

feature {NONE} -- Status report

	frozen internal_test (v, u: detachable G): BOOLEAN
			-- <Precursor>
		do
			if v ~ u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := test (v, u)
			end
		end

end
