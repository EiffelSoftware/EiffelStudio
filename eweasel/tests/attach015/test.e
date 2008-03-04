class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			test (Current, Current)
		end

feature {NONE} -- Test

	test (v, w: ?ANY)
		do
			report (1, (v /= Void and w /= Void) and then (v.out /= Void and w.out /= Void))
			report (2, not (v = Void or w = Void) and then (v.out /= Void and w.out /= Void))
			report (3, (v /= Void and then w /= Void) and then (v.out /= Void and w.out /= Void))
			report (4, not (v = Void or else w = Void) and then (v.out /= Void and w.out /= Void))
			report (5, (v = Void or w = Void) or else v.out /= Void and w.out /= Void)
			report (6, not (v /= Void and w /= Void) or else v.out /= Void and w.out /= Void)
			report (7, (v = Void or else w = Void) or else v.out /= Void and w.out /= Void)
			report (8, not (v /= Void and then w /= Void) or else v.out /= Void and w.out /= Void)
			report (9, (v /= Void implies w = Void) or else v.out /= Void or else w.out /= Void)
			report (10, not (not(v /= Void implies w = Void)) or else v.out /= Void or else w.out /= Void)
		end

feature {NONE} -- Output

	report (i: NATURAL_8; v: BOOLEAN)
			-- Report that test `i' has completed with value `v'.
		do
			if {o: STD_FILES} io then
				o.put_string ("Test ")
				o.put_string (i.out)
				o.put_string (": ")
				if v then
					o.put_string ("OK")
				else
					o.put_string ("FAILED")
				end
				o.put_new_line
			end
		end
		
end