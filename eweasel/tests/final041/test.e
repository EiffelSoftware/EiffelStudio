class TEST

create
	make

feature

	make
		local
			a: TEST2
		do
			create a
			check attached {STRING} a.new_tuple.item (2).out as s then
				io.put_string (s)
			end
			io.put_new_line
		end

end

