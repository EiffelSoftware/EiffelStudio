class
	TEST

create
	make,
	make_1,
	make_2,
	make_3,
	make_4,
	make_5

feature {NONE} -- Creation

	make
		do
				-- Attribute is initialized.
			create a.make_1
		end

	make_1
		do
				-- Attribute is not initialized.
		end

	make_2
		do
				-- Attribute is not initialized in body and in rescue.
		rescue
			a.do_nothing
		end

	make_3
		do
				-- Attribute is initialized in body, but not in rescue.
			create a.make_1
		rescue
			a.do_nothing
		end

	make_4
		do
				-- Attribute is initialized in rescue, but not in body.
		rescue
			create a.make_1
			a.do_nothing
		end

	make_5
		do
			-- Attribute is initialized in body and in rescue.
			create a.make_1
		rescue
			create a.make_1
			a.do_nothing
		end

feature {NONE} -- Access

	a: attached TEST

end