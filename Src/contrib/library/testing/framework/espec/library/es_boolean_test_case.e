note
	description: "Objects that represent boolean test cases (pass/fail)"
	author: "Software Engineering Lab, York University"


class
	ES_BOOLEAN_TEST_CASE

inherit
	ES_TEST_CASE
		redefine
			case
		end

create
	make

feature -- Initialization

	make (name: STRING_8; c: PREDICATE [ANY, TUPLE])
			-- Create Current
		do
			case := c
			case_name := name
			violation_tag := ""
			bookmark_name := ""
		ensure then
			make_post_case: case = c
			make_post_case_name: case_name = name
		end

feature -- Basic Op

	run
			-- Run case test
		local
			error: BOOLEAN
		do
			if not error then
				check attached case as c then
					if c.item ([]) then
						passed := True
					end
				end
			end
		rescue
			contract_violated := True
			check attached exception_trace as et then
				violation_tag := (et).twin
				violation_type := exception
				error := True
				retry
			end
		end

	is_violation_case: BOOLEAN
			-- is this a violation test case of a boolean test case
		do
			Result := False
		end

feature {NONE} -- Implementation

	case: PREDICATE [ANY, TUPLE]

end -- class ES_BOOLEAN_TEST_CASE

