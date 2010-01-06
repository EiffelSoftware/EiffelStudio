class TEST

create

	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
		end

feature -- Tests

	a: TEST
		indexing
			property: "d"
		end

	b: TEST
		indexing
			property: "d"
		end

end
