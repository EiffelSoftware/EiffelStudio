note

	description:

		"Test task 'available'"

	library: "Gobo Eiffel Ant"
	copyright: "Copyright (c) 2008-2016, Sven Ehrke and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class GEANT_FUNCTIONAL_AVAILABLE_TEST

inherit

	GEANT_FUNCTIONAL_TEST_CASE

create

	make_default

feature -- Test

	test_available
			-- Test task 'available'
		do
			tasks := "{
				<available resource="${GOBO}/Readme.md" variable="available"/>
				<echo message="${available}" to_file="out.txt"/>
				}"
			expected_out_txt := "true"
			basic_test ("test_available")

				-- TODO: test with true/false-value,

		end

	test_available_dir
			-- Test task 'available'
		do
			tasks := "{
				<available resource="${GOBO}" variable="available"/>
				<echo message="${available}" to_file="out.txt"/>
				}"
			expected_out_txt := "true"
			basic_test ("test_available_dir")
		end

	test_available_subdir
			-- Test task 'available'
		do
			tasks := "{
				<available resource="${GOBO}/tool" variable="available"/>
				<echo message="${available}" to_file="out.txt"/>
				}"
			expected_out_txt := "true"
			basic_test ("test_available_dir")
		end

end
