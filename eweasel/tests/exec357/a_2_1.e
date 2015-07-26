class A_2_1

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
			f (1, 8)
			f (2, 3, 8)
			f ("a", 4, "b", 8)
			t := Current
			t (8)
			t (1, 8)
			t (2, 3, 8)
			t ("a", 4, "b", 8)
		end

feature

	f alias "()" (t: TUPLE; k: INTEGER)
		do
			print ("2 1: ")
			print_tuple (t)
			io.put_character (' ')
			print (k)
			io.put_new_line
		end

end
