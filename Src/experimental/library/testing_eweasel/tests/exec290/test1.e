class
	TEST1 [G]

create
	make

feature

	make (v: G) is
		do
			item := v.as_attached
			io.put_string (item.out)
			io.put_new_line
		end

	item: G

end
