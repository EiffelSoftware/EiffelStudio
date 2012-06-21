note
	description: "Example of a Unit test class"
	author: "FT"
	date: "$April 29, 2010$"
	revision: "$1.0$"

class
	TEST_2
	--You may also use this class as the root of the system for small testing
	--Make sure to uncomment 'run_espec' command if this class is the root

inherit
	ES_TEST
	-- This class becomes a Unit class allowing us to add test cases

create
	make

feature
	make -- make routine in needed to initialize the test cases
		do
			add_boolean_case (agent t1)  -- adds a Boolean test case to this unit class
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_violation_case (agent t4) -- adds a violation test case to this unit class (expected to fail)
			add_violation_case_with_tag ("error", agent t5)
			-- adds a violation test case to this class, the failure should have the tag 'error'
			-- should fail due to wrong tag
			add_violation_case_with_tag ("valid_index", agent t6) -- passes since exception is 'valid_index'
			set_html_name ("NEW_NAME_T2.html")
--			show_browser
--			show_errors
--			run_espec -- this is required if you make this unit class the root of this system (i.e., no suite)
		end

	t1: BOOLEAN
		local
			a: ARRAY[INTEGER]
		do
			comment ("This Boolean Test case passes")
			--allows us to add comments to the test cases (this is shown in the HTML result file)
			create a.make_filled (0, 1, 2)
			a.put (1, 1)
			Result := a.item (1) = 1
			check Result end -- avoid putting operations, e.g., a.item(1) = 2 in the check clause
		end

	t2: BOOLEAN
		do
			comment ("This Boolean test case fails without violation")
			Result := false
		end

	t3: BOOLEAN
		local
			a: ARRAY[INTEGER]
		do
			comment ("This Boolean test case fails with a contract violation")
			create a.make_filled (0, 1, 2)
			a.put (2, 4)
		end

	t4
		local
			a: ARRAY[INTEGER]
		do
			comment ("This violation case should pass")
			create a.make_filled (0, 1, 2)
			a.put (2, 4)
		end



	t5
		local
			a: ARRAY[INTEGER]
		do
			comment ("This violation case should fail")
			create a.make_filled (0, 1, 2)
			a.put (2, 4)
		end

	t6
		local
			a: ARRAY[INTEGER]
		do
			comment ("This violation case should pass")
			create a.make_filled (0, 1, 2)
			a.put (2, 4)
		end

end
