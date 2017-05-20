note
	description: "New features for ESpec such as assert_equal and sub_comment"
	author: "Jonathan S. Ostroff, SEL, York University"
	date: "$Date$"
	revision: "$Revision$"

class APPLICATION inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run tests.
		do
			add_boolean_case (agent t0)
			add_violation_case_with_tag ("valid_index", agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			--show_errors
			show_browser
			run_espec
		end

feature -- Tests

	t0: BOOLEAN
			-- Boolean test and feature sub_comment.
		local
			a: ARRAY[INTEGER]
		do
			comment("t0: boolen test array of two elements")
			a := <<9, 56>>
			Result := a.count = 2
			sub_comment("Since Result is true, test passes. (Result := a.count = 2)")
			sub_comment("Value of a.count is: " + a.count.out + ".")
			sub_comment("The above two lines (and this one) are sub comments.")
		end

	t1
			-- Violation test.
		local
			a: ARRAY[INTEGER]
			b: BOOLEAN
		do
			comment("t1: violation test array of two elements")
			a := <<9, 56>>
			sub_comment("item (i: INTEGER_32): INT has precondition valid_index(i).")
			sub_comment("The statement (a[i] = 3).do_nothing is expected to fail with tag valid_index.")
			(a[3] = 2).do_nothing
		end

	t2: BOOLEAN
			-- Using assert_equal.
		local
			a: ARRAY[INTEGER]
		do
			comment("t2: test array of two elements using assert_equal")
			sub_comment("Note: This test should fail.")
			Result := true
			sub_comment("Note: Still need Result := true.")
			a := <<41, 27>>
			assert_equal ("should be equal ", 2, a.count)
			sub_comment("Passes: assert_equal (%"should be equal %", 2, a.count)")
			assert_equal ("a.count = 3 is false", 3, a.count)
			-- the above assert_equal test fails
		end

	t3: BOOLEAN
			-- Using assert_not_equal.
		local
			a: ARRAY[INTEGER]
		do
			comment("t3: test array of two elements with assert_not_equal")
			sub_comment("Note: This test should fail.")
			a := <<41, 27>>
			Result := true
			assert_not_equal ("True" + space, 3, a.count)
			sub_comment("Passes: assert_not_equal (%"True%" + space, 3, a.count)")
			assert_not_equal ("a.count" + space, 2, a.count)
		end

	t4: BOOLEAN
			-- Test of assert.
		local
			a: ARRAY[INTEGER]
		do
			comment("t4: test array of two elements with assert")
			sub_comment("Note: This test should fail.")
			Result := true
			a := <<41, 27>>
			assert("a.count = 2", a.count=2, a.count)
			assert("a.count /= 2", a.count/=2, a.count)
		end

	t5: BOOLEAN
			-- Formatting error test: not an input JSON string.
		do
			comment("t5: Problem with wrapping of subcomments to be fixed")
			sub_comment ("'deposit(999,55)' instead of 'deposit(Steve,99)'")
			Result := true
		end

end
