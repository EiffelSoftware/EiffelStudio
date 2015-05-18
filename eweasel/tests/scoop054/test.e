class TEST

create
	default_create,
	make

feature {NONE} -- Creation
	
	make
			-- Run the test.
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
			e: E
		do
			t := s.tuple
			i := t.i       -- VUTA(3)
			x := t.x       -- VUTA(3)
			e := t.e       -- VUTA(3) VUER
			t.i := i       -- VUTA(3)
			t.x := Current -- VUTA(3) VUAR(3)
			t.e := e       -- VUTA(3) VUAR(4)
		end

	test_controlled (t: separate like tuple)
			-- Retrieve `t.t'.
		local
			i: INTEGER
			x: TEST
			e: E
		do
			i := t.i       -- ok
			x := t.x       -- VJAR
			e := t.e       -- VUER
			t.i := i       -- ok
			t.x := Current -- VUAR(3)
			t.e := e       -- VUAR(4)
		end

	tuple: TUPLE [i: INTEGER; x: TEST; e: E]
		do
			Result := [{INTEGER} 5, Current, create {E}]
		end

end
