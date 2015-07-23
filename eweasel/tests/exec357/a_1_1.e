class A_1_1

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
			f
			f (1)
			f (2, 3)
			f ("a", 4, "b")
			t := Current
			t (1)
			t (2, 3)
			t ("a", 4, "b")
		end

feature

	f alias "()" (t: TUPLE)
		do
			print ("1 1: ")
			print_tuple (t)
			io.put_new_line
		end

end
