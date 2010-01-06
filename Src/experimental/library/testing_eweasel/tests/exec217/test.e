class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			b: B [BOOLEAN]
		do
			create b
			b.set_data (False)
		end

end
