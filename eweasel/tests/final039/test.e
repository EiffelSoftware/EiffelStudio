class TEST
		
create
	make

feature {NONE}

	make is
		local
			t1: TEST1 [ANY]
			t2: TEST1 [DOUBLE]
		do
			create t2.make (4.0, "foo", "bar")
			t1 := t2
			print (t1.a) print ("%N")
			print (t1.b) print ("%N")
			print (t1.c) print ("%N")

			print (t1.a.generating_type) print ("%N")
			print (t1.b.generating_type) print ("%N")
			print (t1.c.generating_type) print ("%N")
		end


end
