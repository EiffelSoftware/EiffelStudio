class TEST2
inherit
	TEST1
		redefine
			my_function,
			item
		end

feature

	item: TEST4

	my_function: like item is
		do
			Result := Precursor
		end

end
