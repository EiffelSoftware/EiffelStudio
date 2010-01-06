class TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			a: A [INTEGER]
		do
			create a.make (1)
			io.put_integer (a.item)
			io.put_new_line
		end

end
