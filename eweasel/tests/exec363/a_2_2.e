class A_2_2 [G, T -> TUPLE]

inherit
	A

create
	make

feature

	f alias "()" (k: G; t: T)
		do
			print_name ("2 2")
			print (k)
			io.put_character (' ')
			print_tuple (t)
			io.put_new_line
		end

end
