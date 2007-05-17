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
			property: auto
		end

	b: TEST
		indexing
			property: "a"
		end

end
