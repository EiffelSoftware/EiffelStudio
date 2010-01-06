class TEST2
inherit
	TEST1
		redefine
			my_function,
			less_than,
			item
		end

feature

	item: TEST4

	my_function: like item is
		do
			Result := Precursor
		end

	less_than (other: TEST1)
		do
		end

end
