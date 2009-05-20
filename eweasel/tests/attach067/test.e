class
	TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: A [detachable TEST]
		do
			create a
			a.f (Void)
		end

end