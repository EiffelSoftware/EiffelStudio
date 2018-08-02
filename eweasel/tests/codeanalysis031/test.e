class TEST

create

	make,
	make_from_other

feature {NONE} -- Creation

	make
			-- Run test.
		local
			t: TEST
		do
			t := Current
			create t.make_from_other (t)
			t.do_nothing
		end

	make_from_other (other: TEST)
			-- Initialize from `other`.
		do
		end

end
