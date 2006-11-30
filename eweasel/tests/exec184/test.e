class TEST

create

	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		local
			aa: A [ANY]
			ab: A [BOOLEAN]
			ac: A [CHARACTER]
			ah: A [HASHABLE]
			ba: B [ANY]
			bb: B [BOOLEAN]
			bc: B [CHARACTER]
			bh: B [HASHABLE]
			s: STRING
			memory: MEMORY
		do
				-- Initialization
			create aa
			create ab
			create ac
			create ah
			create ba
			create bb
			create bc
			create bh
			s := aa.s

				-- Once manifest strings are equal to normal
			test_equality (     "abc",      "abc", 1)
			test_equality (     "abc", once "abc", 2)
			test_equality (once "abc",      "abc", 3)
			test_equality (once "abc", once "abc", 4)
			test_equality (         s,      "abc", 5)

				-- Different once manifest strings are different objects
			test_identity (     "abc",      "abc", 6, False)
			test_identity (     "abc", once "abc", 7, False)
			test_identity (once "abc",      "abc", 8, False)
			test_identity (once "abc", once "abc", 9, False)

				-- Once manifest strings are the same in derivations
			test_identity (s, aa.s, 10, True)
			test_identity (s, ab.s, 11, True)
			test_identity (s, ac.s, 12, True)
			test_identity (s, ah.s, 13, True)

				-- Once manifest strings are the same in descendants
			test_identity (s, ba.s, 14, True)
			test_identity (s, bb.s, 15, True)
			test_identity (s, bc.s, 16, True)
			test_identity (s, bh.s, 17, True)

				-- Once manifest string does not change in a loop
			test_loop (18)

				-- Once manifest string works properly in
				-- 	class invariant,
				-- 	precondition,
				-- 	postcondition,
				-- 	old expression
			report_test_result (
				19,
				not aa.invariant_tester.failed
			)
			report_test_result (
				20,
				not aa.precondition_tester.failed
			)
			report_test_result (
				21,
				not aa.postcondition_tester.failed
			)
			report_test_result (
				22,
				not aa.old_expression_tester1.failed
			)
			report_test_result (
				23,
				not aa.old_expression_tester2.failed
			)

				-- Once manifest string is not GC'ed
				-- Modify once manifest string object
			s.keep_head (0)
			s.append_string ("xyz")
				-- Remove all references to it
			aa := Void
			ab := Void
			ac := Void
			ah := Void
			ba := Void
			bb := Void
			bc := Void
			bh := Void
			s := Void
				-- Force GC
			create memory
			memory.collect
			memory.full_collect
				-- Check whether a once manifest string object
				-- has a previous value (and not an initial one)
			create bc
			test_equality (bc.s, "xyz", 24)
		end

feature {NONE} -- Output

	report_test_result (test_number: INTEGER; succeeded: BOOLEAN) is
			-- Report whether a test number `test_number'
			-- is `succeeded' or not.
		require
			positive_test_number: test_number > 0
		do
			io.put_string ("Test " + test_number.out + ": ")
			if succeeded then
				io.put_string ("OK%N")
			else
				io.put_string ("FAILED%N")
			end
		end

feature {NONE} -- Tests

	test_equality (s1, s2: STRING; test_number: INTEGER) is
			-- Check if `s1' and `s2' are not void and are equal
			-- for the test number `test_number'.
		require
			positive_test_number: test_number > 0
		do
			report_test_result (
				test_number, 
				s1 /= Void and then s2 /= Void and then equal (s1, s2)
			)
		end
		
	test_identity (s1, s2: STRING; test_number: INTEGER; res: BOOLEAN) is
			-- Check if `s1' and `s2' are the same non-void object
			-- for the test number `test_number' and assume the result `res'.
		require
			positive_test_number: test_number > 0
		do
			report_test_result (
				test_number, 
				s1 /= Void and then s2 /= Void and then (s1 = s2) = res
			)
		end
		
	test_loop (test_number: INTEGER) is
			-- Check if once manifest string in a loop
			-- is the same object and report result for
			-- the test number `test_number'.
		require
			positive_test_number: test_number > 0
		local
			i: INTEGER
			s1: STRING
			s2: STRING
		do
			from
				i := 1
			until
				i > 1000
			loop
				s1 := once "abc"
				if s2 = Void then
						-- Remember value of once string in `s2'
					check i = 1 end
					s2 := s1
				elseif s2 = s1 then
						-- Once string is the same
					i := i + 1
				else
						-- Once string is different
					i := 2000
				end
			end
			report_test_result (test_number, i = 1001)
		end

end