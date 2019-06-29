class 
	TEST

create

	make

feature {NONE} -- Initialization

	make
		local
			t: HASH_TABLE [INTEGER_32, INTEGER_32]
			s: STRING_TABLE [INTEGER_32]
		do
			create t.make (3)
			t [1] := 1
			t [2] := 2
			t [3] := 3
			t.remove (0); report (not t.removed, 1)
			t.remove (5); report (not t.removed, 2)
			t.remove (2); report (t.removed, 3)
			t.remove (2); report (not t.removed, 4)
			create s.make (3)
			s ["a"] := 1
			s ["b"] := 2
			s ["c"] := 3
			s.remove ("0"); report (not s.removed, 5)
			s.remove ("x"); report (not s.removed, 6)
			s.remove ("b"); report (s.removed, 7)
			s.remove ("b"); report (not s.removed, 8)
		end

feature {NONE} -- Output

	report (v: BOOLEAN; n: NATURAL_8)
			-- Report that test of number `n` has been completed with value `v`.
		do
			io.put_string ("Test ")
			io.put_natural_8 (n)
			io.put_string (if v then ": OK" else ": Failed" end)
			io.put_new_line
		end

end
