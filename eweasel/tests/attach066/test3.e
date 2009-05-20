class
	TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			b: B [detachable TEST]
		do
			create b
			b.f (Void)
		end

end