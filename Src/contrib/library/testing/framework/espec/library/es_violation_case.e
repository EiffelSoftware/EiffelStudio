note
	description: "Objects that represent cases that will throw exception"
	author: "Software Engineering Lab, York University"

class
	ES_VIOLATION_CASE

inherit
	ES_TEST_CASE

create
	make,
	make_with_tag

feature {NONE} -- Initialization

	make (name: STRING_8; c: ROUTINE)
			-- Create Current.
		require else
			make_pre_c: c /= Void
			make_pre_name: name /= Void
		do
			case := c
			case_name := name
			violation_tag := ""
			expected_tag_name := "NONE"
			bookmark_name := ""
		ensure then
			make_post_case: case = c
			make_post_case_name: case_name = name
		end

	make_with_tag (name: STRING_8; c: ROUTINE; expected_tag: STRING_8)
			-- Create Current.
		require
			make_pre_c: c /= Void
			make_pre_name: name /= Void
		do
			case := c
			case_name := name
			violation_tag := ""
			expected_tag_name := expected_tag.twin
			bookmark_name := ""
		end

	run
			-- Run and try to catch the exception.
		local
			error: BOOLEAN
		do
			if not error then
				check attached case as c then
					c.apply
				end
				passed := False
			end
		rescue
			if equal (tag_name, expected_tag_name) or equal (expected_tag_name, "NONE") then
				passed := True
			else
				contract_violated := True
				check attached exception_trace as et then
					violation_tag := et.twin
					violation_type := exception
				end
			end
			error := True
			retry
		end

	is_violation_case: BOOLEAN
			-- Is this a violation test case of a boolean test case?
		do
			Result := True
		end

	expected_tag_name: STRING_8

end
