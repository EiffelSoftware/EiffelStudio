class TEST

create

	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
		end

feature {NONE} -- Tests

	a: TEST

	b: TEST is
		indexing
			property: "a";
		do
		end

	c (x: TEST): TEST assign d is
		indexing
			property: "c";
		do
		end

	d (x, y: TEST) is
		indexing
			property: "d";
		do
		end

end
