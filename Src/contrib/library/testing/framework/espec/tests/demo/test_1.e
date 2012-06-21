note
	description: "Example of a Unit test class"
	author: "FT"
	date: "$April 29, 2010$"
	revision: "$1.0$"

class
	TEST_1
	--You may also use this class as the root of the system for small testing
	--Make sure to uncomment 'run_espec' command if this class is the root

inherit
	ES_TEST
	-- This class becomes a Unit class allowing us to add test cases
		redefine
			setup,   --optional, see below
			teardown --optional
		end

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
			add_violation_case_with_tag ("valid_index", agent t6) -- passes since exception is 'index_small_enough'
			set_html_name ("TEST1_OUT.html") -- customized name for the output file
			show_browser -- opens a browser with the test cases of this class
			show_errors -- this will show error traces for the output of this class
--			run_espec -- this is required if you make this unit class the root of this system (i.e., no suite)
		end

	setup
			-- this feature if redefined, will be executed before every test case
		do
			create a.make_filled (0, 1, 2)
		end

	teardown
			-- this feature if redefined, will be executed after every test case
		do
			check attached a as aa then
				aa.discard_items
			end
		end

	t1: BOOLEAN
		do
			comment ("This Boolean Test case passes")
			--allows us to add comments to the test cases (this is shown in the HTML result file)
			check attached a as aa then
				aa.put (1, 1)
				Result := aa.item (1) = 1
			end

			check Result end -- avoid putting operations, e.g., a.item(1) = 2 in the check clause
		end

	t2: BOOLEAN
		do
			comment ("This Boolean test case fails without violation")
			Result := false
		end

	t3: BOOLEAN
		do
			comment ("This Boolean test case fails with a contract violation")
			check attached a as aa then
				aa.put (2, 4)
			end
		end

	t4
		do
			comment ("This violation case should pass")
			check attached a as aa then
				aa.put (2, 4)
			end
		end

	t5
		do
			comment ("This violation case should fail")
			check attached a as aa then
				aa.put (2, 4)
			end
		end

	t6
		do
			comment ("This violation case should pass")
			check attached a as aa then
				aa.put (2, 4)
			end
		end

	a: detachable ARRAY[INTEGER]

end
