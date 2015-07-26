class A_3_1

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
			f (1, 8, 9)
			f (2, 3, 8, 9)
			f ("a", 4, "b", 8, 9)
			t := Current
			t (8, 9)
			t (1, 8, 9)
			t (2, 3, 8, 9)
			t ("a", 4, "b", 8, 9)
		end

feature

	f alias "()" (t: TUPLE; i, j: INTEGER)
		do
			print ("3 1: ")
			print_tuple (t)
			io.put_character (' ')
			print (i)
			io.put_character (' ')
			print (j)
			io.put_new_line
		end

end
