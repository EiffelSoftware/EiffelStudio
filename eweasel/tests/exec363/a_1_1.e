class A_1_1 [T -> TUPLE]

inherit
	A

create
	make

feature

	f alias "()" (t: T)
		do
			print_name ("1 1")
			print_tuple (t)
			io.put_new_line
		end

end
