class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: A
			b: B
		do
			create a
			create b
		end

end
