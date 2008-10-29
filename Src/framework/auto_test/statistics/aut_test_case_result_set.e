indexing
	description:

		"Set of test cases results"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_TEST_CASE_RESULT_SET

create

	make,
	make_empty

feature {NONE} -- Initialization

	make (a_list: like list) is
			-- Create new set of test cases containing the test cases stored in `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_doesnt_have_void: not a_list.has (Void)
		do
			list := a_list
			update_status
		ensure
			list_set: list = a_list
		end

	make_empty is
			-- Create new empty test case set.
		do
			create {DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]} list.make (0)
			update_status
		ensure
			list_is_empty: list.is_empty
		end

feature -- Status report

	is_bad_response: BOOLEAN
			-- Is this set considered a 'bad response'?

	is_fail: BOOLEAN
			-- Is this set considered a 'fail'?

	is_invalid: BOOLEAN
			-- Is this set considered 'invalid'?

	is_pass: BOOLEAN
			-- Is this set considered a 'pass'?

	is_untested: BOOLEAN
			-- Is this set considered 'untested'?

feature -- Access

	list: DS_LIST [AUT_TEST_CASE_RESULT]
			-- Test cases in set

	total_count: INTEGER
			-- Total number of test cases

	bad_response_count: INTEGER
			-- Number of test cases that had a bad response

	fail_count: INTEGER
			-- Number of test cases that failed

	invalid_count: INTEGER
			-- Number of test cases that were invalid

	pass_count: INTEGER
			-- Number of test cases that passed

	unique_fail_count: INTEGER is
			-- Number of test cases that failed in a unique way
		do
			Result := unique_failure_list.count
		end


feature {NONE} -- Status update

	update_status is
			-- Update the status attributes
		local
			cs: DS_LINEAR_CURSOR [AUT_TEST_CASE_RESULT]
			tester: AUT_TEST_CASE_RESULT_EQUALITY_TESTER
		do
			is_bad_response := False
			is_fail := False
			is_invalid := False
			is_pass := False
			is_untested := False
			total_count := list.count
			bad_response_count := 0
			fail_count := 0
			invalid_count := 0
			pass_count := 0
			create unique_failure_list.make (list.count)
			create tester
			unique_failure_list.set_equality_tester (tester)

			if list.count = 0 then
				is_untested := True
			else
				from
					cs := list.new_cursor
					cs.start
				until
					cs.off or is_fail
				loop
					if cs.item.is_pass then
						pass_count := pass_count + 1
					elseif cs.item.is_fail then
						fail_count := fail_count + 1
						if not unique_failure_list.has (cs.item) then
							unique_failure_list.force_last (cs.item)
						end
					elseif cs.item.is_invalid then
						invalid_count := invalid_count + 1
					elseif cs.item.is_bad_response then
						bad_response_count := bad_response_count + 1
					else
						check
							dead_end: False
						end
					end
					cs.forth
				end
				cs.go_after
				if fail_count > 0 then
					is_fail := True
				elseif bad_response_count > 0 then
					is_bad_response := True
				elseif pass_count > 0 then
					is_pass := True
				elseif invalid_count > 0 then
					is_invalid := True
				else
					check
						dead_end: False
					end
				end
			end
		end

	unique_failure_list: DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]
			-- List of unique failures contained in set (using heuristics from witness)

invariant

	list_not_void: list /= Void
	list_does_not_have_void: not list.has (Void)
	exclusiveness: is_bad_response xor is_fail xor is_invalid xor is_pass xor is_untested
	unique_failure_list_not_void: unique_failure_list /= Void

end
