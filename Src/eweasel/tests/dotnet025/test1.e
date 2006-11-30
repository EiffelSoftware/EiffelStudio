class TEST

inherit

	A
		redefine
			get_a,
			set_a
		end

create

	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
		end

feature {NONE} -- Tests

	get_a: TEST assign set_a is
		indexing
			property: "a"
		do
		end

	set_a (v: like a) is
		do
		end

end
