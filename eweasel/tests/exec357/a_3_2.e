class A_3_2

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
			f (8, 1, 9)
			f (8, 2, 3, 9)
			f (8, "a", 4, "b", 9)
			t := Current
			t (8, 9)
			t (8, 1, 9)
			t (8, 2, 3, 9)
			t (8, "a", 4, "b", 9)
		end

feature

	f alias "()" (i: INTEGER; t: TUPLE; j: INTEGER)
		do
			print ("3 2: ")
			print (i)
			io.put_character (' ')
			print_tuple (t)
			io.put_character (' ')
			print (j)
			io.put_new_line
		end

end
