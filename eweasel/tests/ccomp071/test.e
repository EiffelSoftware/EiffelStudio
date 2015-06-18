class TEST

create
	make

feature

	make
		local
			b: BOOLEAN
			a1, a2: A
		do
			b := ({BOOLEAN}).attempt (True)
			io.put_boolean (b)
			io.put_new_line
			
			a1.set (12, "TITI")
			a2 := ({A}).attempt (a1)
			io.put_integer (a2.a)
			io.put_new_line
			check attached {STRING} a2.s as s then
				io.put_string (s)
			end
			io.put_new_line
		end

end
