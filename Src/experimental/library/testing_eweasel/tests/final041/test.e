class TEST

create
	make

feature

	make is
		local
			a: TEST2
		do
			create a
			io.put_string (a.new_tuple.item (2).out)
			io.put_new_line
		end

end

