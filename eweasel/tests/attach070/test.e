class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

feature {NONE} -- Access

	a: detachable STRING note option: stable attribute end
			-- Data

end
