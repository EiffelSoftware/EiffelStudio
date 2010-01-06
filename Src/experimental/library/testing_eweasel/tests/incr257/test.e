class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			b: B
		do
			create b
			b.f
		end

end
