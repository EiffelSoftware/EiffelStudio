class TEST

create
	default_create,
	make

feature {NONE} -- Creation
	
	make
			-- Run the test.
		local
			s: separate TEST
			t: TEST
		do
			create s
			t := s.tuple.t -- Error
		end

feature -- Test

	tuple: TUPLE [i: INTEGER; t: TEST]
		do
			Result := [{INTEGER} 5, Current]
		end

	test (t: separate like tuple)
			-- Retrieve `t.t'.
		local
			v: TEST
		do
			v := t.t -- Error
			t.t := Current -- Error
		end

end
