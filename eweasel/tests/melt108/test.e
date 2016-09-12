class TEST

create

	make

feature

	make
		local
			x, y: NATURAL_8
		do
			x := 1
			y := 5
			across
				x |..| y as i
			loop
				io.put_integer (i.item)
			end
			io.put_new_line
		end

end