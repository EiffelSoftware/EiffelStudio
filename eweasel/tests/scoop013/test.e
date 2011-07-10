
class TEST

create
	make

feature

	make
		local
			a: separate ARRAY [INTEGER]
		do
			create a.make_filled (47, 1, 5)
			display (a)
		end

	display (a: separate ARRAY [INTEGER])
		do
			print (a.item (1))
			io.new_line
		end

end

