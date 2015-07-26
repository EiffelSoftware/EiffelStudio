class A_2_2

inherit
	A

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: like Current
		do
			f (8)
			f (8, 1)
			f (8, 2, 3)
			f (8, "a", 4, "b")
			t := Current
			t (8)
			t (8, 1)
			t (8, 2, 3)
			t (8, "a", 4, "b")
		end

feature

	f alias "()" (k: INTEGER; t: TUPLE)
		do
			print ("2 2: ")
			print (k)
			io.put_character (' ')
			print_tuple (t)
			io.put_new_line
		end

end
