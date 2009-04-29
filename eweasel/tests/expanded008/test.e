class
	TEST

create
	make

feature

	make is
		local
			t1: TEST1
			s: STRING
			i: INTEGER
		do
			s := "Object"
			t1.set_a (s)
			from
				i := 1
			until
				i > Max
			loop
				t1 := t1.twin
				if t1.a /~ s then
					io.put_string ("Not OK%N")
					i := Max
				end
				i := i + 1
			end
		end

	Max: INTEGER = 1_000_000

end

