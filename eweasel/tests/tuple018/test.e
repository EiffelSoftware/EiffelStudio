class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: A [TUPLE [INTEGER, INTEGER]]
			b: B [TUPLE [INTEGER, INTEGER]]
			c: C [TUPLE [INTEGER, INTEGER]]
			d: D [TUPLE [INTEGER, INTEGER]]
		do
			create a
			create b
			create c
			create d
			a.foo ([1, 2])
			b.foo ([1, 2])
			c.foo ([1, 2])
			d.foo ([1, 2])
		end

end
