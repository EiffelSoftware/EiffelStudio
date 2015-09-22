class A_3_2 [G, T -> TUPLE, H]

inherit
	A

create
	make

feature

	f alias "()" (i: G; t: T; j: H)
		do
			print_name ("3 2")
			print (i)
			io.put_character (' ')
			print_tuple (t)
			io.put_character (' ')
			print (j)
			io.put_new_line
		end

end
