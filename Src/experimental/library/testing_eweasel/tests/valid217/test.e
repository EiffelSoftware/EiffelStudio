class TEST

create
	make

feature

	make is
		local
			l_a: A
			l_b: B
		do
			create l_a
			create l_b
			print (l_a.some_string = l_b.some_string)
			io.put_new_line
		end


end
