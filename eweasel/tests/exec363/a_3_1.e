class A_3_1 [T -> TUPLE, G, H]

inherit
	A

create
	make

feature

	f alias "()" (t: T; i: G; j: H)
		do
			print_name ("3 1")
			print_tuple (t)
			io.put_character (' ')
			print (i)
			io.put_character (' ')
			print (j)
			io.put_new_line
		end

end
