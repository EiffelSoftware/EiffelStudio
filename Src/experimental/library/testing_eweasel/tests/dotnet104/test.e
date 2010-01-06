class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			a: EIFFEL_COLLECTION [ANY]
			b: ARRAY_LIST
		do
			create a.make_from_capacity (1)
			create b.make_from_capacity (1)
		end

end
