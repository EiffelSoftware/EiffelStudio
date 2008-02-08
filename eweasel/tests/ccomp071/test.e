class TEST

create
	make

feature

	make is
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
			io.put_string (a2.s)
			io.put_new_line
		end

end
