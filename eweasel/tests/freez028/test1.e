class TEST1

create
	make_from_integer

convert
	make_from_integer ({INTEGER})

feature

	make_from_integer (a: INTEGER) is
		do
		end

	my_function: like item is
		do
		end

	my_convert (o: like Current) is
		do
			o.less_than (0)
		end

	less_than (o: like Current) is
		do
		end

	item: TEST3

end
