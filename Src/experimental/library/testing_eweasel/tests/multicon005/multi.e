indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		-- each class (A,B,C) has the features make, f and g
		-- A keeps nothing
		-- B keeps g and make
		-- C keeps f

		MULTI[	G->{	A rename make as make_a end,
						C rename make as make_c end,
						B rename count as count_of_b end} create make end,
				G2->{	A rename f as f_a2, g as g_a2, make as make_a2 end,
						C rename g as g_c2, make as make_c2 end,
						B rename f as f_b2 end} create make end]

create
	make
	
feature -- Initialize

	make is
			-- Do the testing
		do
			create mc.make
			create g1.make
			create g11.make
			create g2.make
			create g22.make
		end

feature -- Testing

	perform_testing is
			-- We test the feature contracts.
		do
				-- Test 1
			g1.set_count(3)
			if $VIOLATE_TEST_1 then
					-- Precondition violation
				test_contracts_simple (g1,2)
			else
				test_contracts_simple (g1,3)
				check count_is_4: g1.count = 4 end
			end

				-- Test 2
			g1.set_count(7)
			if $VIOLATE_TEST_2 then
					-- Precondition violation
				test_contracts_simple_extended (g1,2)
			else
				test_contracts_simple_extended (g1,7)
				check count_is_4: g1.count = 8 end
			end

				-- Test 3
			g1.set_count(4)
			g11.set_count(3)
			g2.set_valid (true)
			g22.set_valid (true)
				-- Check will be violated if VIOLATE_TEST_3 is True
			test_contracts (g1, g11, g2, g22, 4) 

				-- Test 4
			g1.set_count(6)
			g11.set_count(5)
			g2.set_valid (true)
			g22.set_valid (true)
				-- Postcondition will be violated if VIOLATE_TEST_4 is True
			test_contracts (g1, g11, g2, g22, 6) 

				-- Test 5
			if $VIOLATE_TEST_5 then
					-- Invariant, that g1.count has to be smaller than 10, is violated.
				g1.set_count (42)
			end



				
		end

feature -- Access

	g1,g11: G
	g2: G2
	g22: G2
	mc: G

feature -- Command
	test_contracts_simple (a_g: G; l_count: INTEGER)
			-- Test contracts
		require
			precondition_test1: a_g.count = l_count
		do
			a_g.increase_count
		ensure
			postcondition_test1: a_g.count = old a_g.count + 1
		end

	test_contracts_simple_extended (a_g: G; l_count: INTEGER)
			-- Test contracts
		require
			precondition_test2: a_g.count = l_count and then true
			precondition_test3: false or else a_g.same_as_count = l_count
		do
			a_g.increase_count
		ensure
			postcondition_test2: true and then ((a_g.count = old a_g.count + 1) and true) or else false or false
			postcondition_test3: ((a_g.count = old a_g.count + 1) and true) or else false or false
		end

	test_contracts (a_g1, a_g11: G; a_g2, a_g22: G2; l_count: INTEGER)
			-- Test contracts
		require
			precondition_test4: a_g2.is_valid
			precondition_test5: a_g1.count = l_count
			precondition_test6: a_g11.count = l_count - 1 and then true
			precondition_test7: a_g22.is_valid
		do
			if not $VIOLATE_TEST_3 then
				a_g2.set_valid (false)
			end
			check check_test1: not a_g2.is_valid end
			a_g1.increase_count
			a_g22.set_valid (not a_g22.is_valid)
			a_g11.increase_count
			if $VIOLATE_TEST_4 then
				a_g1.set_count (a_g1.count -2)
			end
		ensure
			postcondition_test4: old a_g22.is_valid /= a_g22.is_valid and true
			postcondition_test5: true and then ((a_g1.count = old a_g1.count + 1) and true) or else false or false
			postcondition_test6: ((a_g1.count - 1= old a_g1.count) and true) or else false or false
			postcondition_test7: (old a_g22.is_valid /= a_g22.is_valid) and (old a_g22.is_valid /= a_g22.is_valid) or ((false) and true)

		end

invariant
	invariant_test1: g1.count < 10


end
