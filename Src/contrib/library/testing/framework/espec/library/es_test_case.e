note
	description: "Objects that represent test cases"
	author: "Software Engineering Lab, York University"

deferred class
	ES_TEST_CASE

inherit
	EXCEPTIONS

feature {ES_HTML_GEN, ES_TEST} -- Basic Operation

	make (name: STRING_8; c: like case)
			-- Create Current.
		deferred
		end

	run
		deferred
		end

	is_violation_case: BOOLEAN
		deferred
		end

	set_bookmark_name (bm: STRING_8)
			-- Prepare HTML tag.
		require
			bm_valid: bm /= Void
		do
			bookmark_name := bm.twin
		end

	set_case_name (s: STRING_8)
			-- Set name to `s'.
		require
			s_exists: s /= Void
		do
			case_name := s
		ensure
			case_name_set: case_name = s
		end

feature {ES_HTML_GEN, ES_TEST} -- Access

	passed: BOOLEAN

	contract_violated: BOOLEAN

	case_name: STRING_8

	bookmark_name: STRING_8

	violation_tag: STRING_8

	violation_type: INTEGER_32

	case: ROUTINE

end -- class ES_TEST_CASE

