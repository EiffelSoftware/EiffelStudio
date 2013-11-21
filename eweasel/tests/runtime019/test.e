class
	TEST

inherit
	MEMORY

create
	make

feature -- Initialization

	make
			-- Run application.
		local
			l_spec: SPECIAL [TEST1]
			t1: TEST1
		do
			create l_spec.make_filled (t1, 100000)
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_collect
			full_coalesce
			t1.set_person ("New")
			l_spec.put (t1, 1)
			full_collect
		end

end
