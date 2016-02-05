class
	CAT_LOOP_INVARIANT_COMPUTATION

feature {NONE} -- Test

	loops
		local
			l_dummy: INTEGER
			l_list: ARRAY[INTEGER]
		do
			-- Should violate the rule.
			across l_list as int loop
				l_dummy := 4
				foo (l_dummy)
			end

			-- Should not violate the rule.
			across l_list as int loop
				foo (l_dummy)
				l_dummy := 4
			end

			-- Should not violate the rule.
			across l_list as int loop
				l_dummy := 4
				foo (l_dummy)
				l_dummy := 3
			end

			-- Should violate the rule.
			across l_list as int loop
				l_dummy := 4
				foo (l_dummy)
				foo (l_dummy)
			end

			-- Should not violate the rule (technically it should but the rule
			-- doesn't cover cases with multiple assignments).
			across l_list as int loop
				l_dummy := 4
				l_dummy := 3
				foo (l_dummy)
				foo (l_dummy)
			end

		end

	foo (a_int: INTEGER)
		do
			foo (a_int)
		end

end
