class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: ANY
			b: BOOLEAN
			c: CHARACTER_8
			e: E
			x: X
		do
			b := True
			c := 'A'
			e.put ("OK")

				-- Successful object tests

			io.put_string ("ot_b1: ")
			if {ot_b1: BOOLEAN} b then
				io.put_boolean (ot_b1)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			io.put_string ("ot_e1: ")
			if {ot_e1: E} e then
				io.put_string (ot_e1.item)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			a := c
			io.put_string ("ot_c1: ")
			if {ot_c1: CHARACTER} a then
				io.put_character (ot_c1)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			a := e
			io.put_string ("ot_e2: ")
			if {ot_e2: E} a then
				io.put_string (ot_e2.item)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			io.put_string ("ot_r1: ")
			if {ot_r1: !COMPARABLE} c then
				io.put_string (ot_r1.out)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			io.put_string ("ot_a1: ")
			if {ot_a1: !ANY} e then
				io.put_string (ot_a1.out)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			io.put_string ("ot_r2: ")
			if {ot_r2: !COMPARABLE} "OK" then
				io.put_string (ot_r2.out)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

				-- Failing object tests

			io.put_string ("ot_b2: ")
			if {ot_b2: BOOLEAN} c then
				io.put_boolean (ot_b2)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_b3: ")
			if {ot_b3: BOOLEAN} e then
				io.put_boolean (ot_b3)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_b4: ")
			if {ot_b4: BOOLEAN} "FAILED" then
				io.put_boolean (ot_b4)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_e3: ")
			if {ot_e3: E} c then
				io.put_string (ot_e3.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_e4: ")
			if {ot_e4: E} x then
				io.put_string (ot_e4.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_e5: ")
			if {ot_e5: BOOLEAN} "FAILED" then
				io.put_string (ot_e5.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_r3: ")
			if {ot_r3: !COMPARABLE} b then
				io.put_string (ot_r3.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_r4: ")
			if {ot_r4: !COMPARABLE} e then
				io.put_string (ot_r4.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_r5: ")
			if {ot_r5: !NUMERIC} "FAILED" then
				io.put_string (ot_r5.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

		end

end