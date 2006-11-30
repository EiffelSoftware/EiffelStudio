class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			t: TEST2
		do
			t.anchor.f (<<t>>)
		end

end
