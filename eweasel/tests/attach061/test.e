class
	TEST

inherit
	A

create
	make

feature

	make
			-- Run tests.
		do
			test
		end

feature {NONE} -- Test

	test
		require else
			attached {STRING} Current as t implies not t.is_empty
		do
			io.put_boolean (attached {STRING} Current as p implies not p.is_empty)
			io.put_new_line
		ensure then
			attached {STRING} Current as s implies not s.is_empty
		end

end
