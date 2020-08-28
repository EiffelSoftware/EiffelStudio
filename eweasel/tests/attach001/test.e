class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			a: ANY
			b: BOOLEAN
			c: CHARACTER_8
			s: STRING
			e: E
			x: X
		do
			b := True
			c := 'A'
			e.put ("OK")

				-- Successful object tests

			io.put_string ("ot_b1: ")
			if attached {BOOLEAN} b as ot_b1 then
				io.put_boolean (ot_b1)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			io.put_string ("ot_e1: ")
			if attached {E} e as ot_e1 then
				io.put_string (ot_e1.item)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			a := c
			io.put_string ("ot_c1: ")
			if attached {CHARACTER} a as ot_c1 then
				io.put_character (ot_c1)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			a := e
			io.put_string ("ot_e2: ")
			if attached {E} a as ot_e2 then
				io.put_string (ot_e2.item)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			io.put_string ("ot_r1: ")
			if attached {attached COMPARABLE} c as ot_r1 then
				io.put_string (ot_r1.out)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			io.put_string ("ot_a1: ")
			if attached {attached ANY} e as ot_a1 then
				io.put_string (ot_a1.out)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

			io.put_string ("ot_r2: ")
			s := "OK"
			if attached {attached COMPARABLE} s as ot_r2 then
				io.put_string (ot_r2.out)
			else
				io.put_string ("FAILED")
			end
			io.put_new_line

				-- Failing object tests

			io.put_string ("ot_b2: ")
			if attached {BOOLEAN} c as ot_b2 then
				io.put_boolean (ot_b2)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_b3: ")
			if attached {BOOLEAN} e as ot_b3 then
				io.put_boolean (ot_b3)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_b4: ")
			s := "FAILED"
			if attached {BOOLEAN} s as ot_b4 then
				io.put_boolean (ot_b4)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_e3: ")
			if attached {E} c as ot_e3 then
				io.put_string (ot_e3.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_e4: ")
			if attached {E} x as ot_e4 then
				io.put_string (ot_e4.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_e5: ")
			s := "FAILED"
			if attached {BOOLEAN} s as ot_e5 then
				io.put_string (ot_e5.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_r3: ")
			if attached {attached COMPARABLE} b as ot_r3 then
				io.put_string (ot_r3.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_r4: ")
			if attached {attached COMPARABLE} e as ot_r4 then
				io.put_string (ot_r4.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("ot_r5: ")
			s := "FAILED"
			if attached {attached NUMERIC} s as ot_r5 then
				io.put_string (ot_r5.out)
			else
				io.put_string ("OK")
			end
			io.put_new_line

		end

end
