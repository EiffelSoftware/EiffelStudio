class
	TEST

inherit
	BASE

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
		end

feature -- Tests


	prop_aa: TEST
		indexing
			property: "prop_a"
		end
		
	prop_bb: TEST
		indexing
			property: "prop_b"
		end

end
