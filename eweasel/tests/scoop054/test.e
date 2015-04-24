class TEST

create
	default_create,
	make

feature {NONE} -- Creation
	
	make
			-- Run the test.
		local
		do
			test (create {TEST})
		end

feature -- Test

	test (s: separate TEST)
		do
			test_uncontrolled (s)
			test_controlled (s.tuple)
		end

	test_uncontrolled (s: separate TEST)
		local
			t: separate like tuple
			i: INTEGER
			x: TEST
		do
			t := s.tuple
			i := t.i -- Error
			x := t.x -- Error
			t.i := i -- Error
			t.x := Current -- Error
		end

	test_controlled (t: separate like tuple)
			-- Retrieve `t.t'.
		local
			i: INTEGER
			x: TEST
		do
			i := t.i -- OK
			x := t.x -- Error
			t.i := i -- OK
			t.x := Current -- Error
		end

	tuple: TUPLE [i: INTEGER; x: TEST]
		do
			Result := [{INTEGER} 5, Current]
		end

end
