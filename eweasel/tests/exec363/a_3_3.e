class A_3_3 [G, H, T -> TUPLE]

inherit
	A

create
	make

feature

	f alias "()" (i: G; j: H; t: T)
		do
			print_name ("3 3")
			print (i)
			io.put_character (' ')
			print (j)
			io.put_character (' ')
			print_tuple (t)
			io.put_new_line
		end

end
