class A_2_1 [T -> TUPLE, G]

inherit
	A

create
	make

feature

	f alias "()" (t: T; k: G)
		do
			print_name ("2 1")
			print_tuple (t)
			io.put_character (' ')
			print (k)
			io.put_new_line
		end

end
