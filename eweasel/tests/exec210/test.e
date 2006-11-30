class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			b: B
		do
			create b.make
			b.f
		end

end
