class
	TEST

create
	make

feature

	make
	    local
			t1, t2: TEST2
			is_ieee_comparison: BOOLEAN
	    do
			is_ieee_comparison := not $TOTAL_ORDER

			create t1.make
			create t2.make

			compare_reference_equality (t1, t1, True, "case 1")
			compare_reference_equality (t2, t2, True, "case 2")
			compare_reference_equality (t1, t2, False, "case 3")
			compare_reference_equality (t2, t1, False, "case 4")

			compare_equality (t1, t1, True, "case 5")
			compare_equality (t2, t2, True, "case 6")
			compare_equality (t1, t2, False, "case 7")
			compare_equality (t2, t1, False, "case 8")

			compare_equality (t1.u, t1.u, True, "case 9")
			compare_equality (t2.u, t2.u, True, "case 10")
			compare_equality (t1.u, t2.u, True, "case 11")
			compare_equality (t2.u, t1.u, True, "case 12")

			compare_deep_equality (t1, t1, True, "case 13")
			compare_deep_equality (t2, t2, True, "case 14")
			compare_deep_equality (t1, t2, True, "case 15")
			compare_deep_equality (t2, t1, True, "case 16")

			compare_deep_equality (t1.u, t1.u, True, "case 17")
			compare_deep_equality (t2.u, t2.u, True, "case 18")
			compare_deep_equality (t1.u, t2.u, True, "case 19")
			compare_deep_equality (t2.u, t1.u, True, "case 20")

			t1.u.set ({REAL_32}.nan, {REAL_64}.nan)
			t2.u.set ({REAL_32}.nan, {REAL_64}.nan)

			compare_reference_equality (t1, t1, True, "case 1.1")
			compare_reference_equality (t2, t2, True, "case 1.2")
			compare_reference_equality (t1, t2, False, "case 1.3")
			compare_reference_equality (t2, t1, False, "case 1.4")

			compare_equality (t1, t1, True, "case 1.5")
			compare_equality (t2, t2, True, "case 1.6")
			compare_equality (t1, t2, False, "case 1.7")
			compare_equality (t2, t1, False, "case 1.8")

			compare_equality (t1.u, t1.u, True, "case 1.9")
			compare_equality (t2.u, t2.u, True, "case 1.10")
			compare_equality (t1.u, t2.u, True, "case 1.11")
			compare_equality (t2.u, t1.u, True, "case 1.12")

			compare_deep_equality (t1, t1, True, "case 1.13")
			compare_deep_equality (t2, t2, True, "case 1.14")
			compare_deep_equality (t1, t2, not is_ieee_comparison, "case 1.15")
			compare_deep_equality (t2, t1, not is_ieee_comparison, "case 1.16")

			compare_deep_equality (t1.u, t1.u, True, "case 1.17")
			compare_deep_equality (t2.u, t2.u, True, "case 1.18")
			compare_deep_equality (t1.u, t2.u, not is_ieee_comparison, "case 1.19")
			compare_deep_equality (t2.u, t1.u, not is_ieee_comparison, "case 1.20")
	    end

	compare_reference_equality (t1, t2: ANY; expected_result: BOOLEAN; msg: STRING)
		do
			if expected_result /= (t1 = t2) then
				io.put_string (msg)
				io.put_new_line
			end
		end

	compare_equality (t1, t2: ANY; expected_result: BOOLEAN; msg: STRING)
		do
			if expected_result /= t1.is_equal (t2) then
				io.put_string (msg)
				io.put_new_line
			end
		end

	compare_deep_equality (t1, t2: ANY; expected_result: BOOLEAN; msg: STRING)
		do
			if expected_result /= t1.is_deep_equal (t2) then
				io.put_string (msg)
				io.put_new_line
			end
		end

end
