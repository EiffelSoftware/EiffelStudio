class
	CAT_REAL_NAN_COMPARISON

feature {NONE} -- Test

	compare
		local
			l_r1: REAL
			l_r2: REAL_64
			l_r3: REAL_REF
			l_r4: REAL_64_REF
		do
			if l_r1 = {REAL_REF}.nan then
				do_nothing
			end

			if l_r2 = {REAL_64_REF}.nan then
				do_nothing
			end

			if l_r3 = {REAL}.nan then
				do_nothing
			end

			if l_r4 = {REAL_64}.nan then
				do_nothing
			end

			if {REAL_32}.nan = l_r1 then
				do_nothing
			end

			if {REAL_64}.nan = l_r2 then
				do_nothing
			end

			if {REAL_REF}.nan = l_r3 then
				do_nothing
			end

			if {REAL_64_REF}.nan = l_r4 then
				do_nothing
			end

		end

end
