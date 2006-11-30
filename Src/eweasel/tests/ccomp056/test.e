class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			p: MANAGED_POINTER
		do
			create p.make (sizeof)
			wrap (p.item)
		end

	sizeof: INTEGER is
		external
			"C inline use %"test.h%""
		alias
			"return (EIF_INTEGER) sizeof(struct test);"
		end

	wrap (p: POINTER) is
		external
			"C macro signature (struct test *) use %"test.h%""
		alias
			"BAD_MACRO"
		end

end
