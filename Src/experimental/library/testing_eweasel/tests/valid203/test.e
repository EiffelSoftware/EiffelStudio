class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_e0: E0
			l_e2: E2
		do
			-- All this stuff here should fail according to the bug-submitter.
			-- It does not with version 6.0.6.6309.
			-- However, E2 inherits from the expanded class E1 which is indeed a bug.
			l_e2.set_xy (l_e0, l_e0)
			check l_e2.x = l_e0 end
			check l_e2.y = l_e0 end
			print ("ok")
		end
end
