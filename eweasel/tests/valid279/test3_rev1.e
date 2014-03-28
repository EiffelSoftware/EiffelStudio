class TEST3 [G]

create
	make

feature

	make (g: G)
		do
			create item
			create bar
		end

	item: like bar

	bar: TEST4 [G]

end
