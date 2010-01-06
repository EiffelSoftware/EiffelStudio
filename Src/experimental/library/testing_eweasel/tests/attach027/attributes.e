class
	ATTRIBUTES

inherit
	BASE
		redefine
			test_b,
			test_c
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create test_a.make_from_string ("A")
			create test_b.make_from_string ("B")
		end

feature -- Access

	test_a: !STRING

	test_b: !STRING

	test_c: !STRING
		attribute
			Result := "C"
		end

end

