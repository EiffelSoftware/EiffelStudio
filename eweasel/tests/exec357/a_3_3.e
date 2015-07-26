class A_3_3

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
			f (8, 9)
			f (8, 9, 1)
			f (8, 9, 2, 3)
			f (8, 9, "a", 4, "b")
			t := Current
			t (8, 9)
			t (8, 9, 1)
			t (8, 9, 2, 3)
			t (8, 9, "a", 4, "b")
		end

feature

	f alias "()" (i, j: INTEGER; t: TUPLE)
		do
			print ("3 3: ")
			print (i)
			io.put_character (' ')
			print (j)
			io.put_character (' ')
			print_tuple (t)
			io.put_new_line
		end

end
