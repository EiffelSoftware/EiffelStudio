indexing
	description:
		"Log output in text-only"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TEXT_LOG inherit

	LOG_OUTPUT_FORMAT

feature -- Output

	put_evaluation (d: TEST_DRIVER) is
			-- Output evaluation from driver `d'.
		local
			i: INTEGER
			runs: INTEGER
			passed: BOOLEAN
			timing: BOOLEAN
		do
			put_new_line
			if d.has_standard_output then put_new_line end
			if d.all_tests_passed then
				put_box ("SUCCESS!", '*')
			else
				put_box (" NOT SUCCESSFUL!", '*')
			end
			put_new_line
			put_new_line
			put_string ("Top level tests: " + d.test_count.out + ", ")
			put_string ("Passed: " + d.contained_passed_tests.out + " [" + 
				(d.contained_pass_percentage.rounded).out + "%%], " +
				"Failed: " + d.contained_failed_tests.out + " [" + 
				(d.contained_fail_percentage.rounded).out + "%%]")
			put_new_line
			put_new_line
			put_new_line
			put_header ("Test summary")
			d.put_summary (log)
			put_new_line
			runs := d.total_run_count
			from i := 1 until i > runs loop
				passed := d.has_passed (i)
				timing := d.timing_display_enabled and then 
					d.has_execution_time (i)
				if not passed or timing then
					put_header ("Run " + i.out)
					if d.timing_display_enabled and timing then
						put_string ("Timing:")
						put_new_line
						put_new_line
						d.put_timing_information (log, i)
						put_new_line
						put_new_line
					end
					if not passed then
						put_string ("Failed tests:")
						put_new_line
						put_new_line
						d.put_failure_information (log, i)
					end
				end
				i := i + 1
			end
			put_new_line
		end

	put_test_id (t: TESTABLE) is
			-- Output test identification for `t'.
		do
			put_string ("Test #: ")
			put_string (t.id)
			put_string ("   Name: ")
			put_string (t.name)
		end

	put_header (header: STRING) is
			-- Output `header' with underlining.
		local
			underline: STRING
		do
			create underline.make (header.count)
			underline.fill_character ('-')
			put_string (header)
			put_new_line
			put_string (underline)
			put_new_line
			put_new_line
		end

	put_box (s: STRING; c: CHARACTER) is
			-- Output `s' surrounded by a box out of `c'.
		local
			text: STRING
			box: STRING
		do
			text := clone (s)
			text.precede (' ')
			text.precede (c)
			text.extend (' ')
			text.extend (c)
			create box.make (text.count)
			box.fill_character (c)
			put_string (box)
			put_new_line
			put_string (text)
			put_new_line
			put_string (box)
			put_new_line
		end
		
	put_summary (t: TESTABLE) is
			-- Output result summary of test `t'.
		local
			f: FORMAT_INTEGER
			res: TEST_RESULT
		do
			create f.make (3)
			f.no_justify
			put_test_id (t)
			res := t.test_results
			put_string ("  Result: ")
			if res.run_count = 0 then
				put_string ("NOT RUN")
			else
				if res.failed_tests = 0 then
					put_string ("PASS")
				else
					put_string ("FAIL")
				end
				if t.has_random_generator then
					put_new_line
					put_string ("    (Seed: " + t.seed.out + ")")
				end
				if res.run_count > 1 then
					output_device.put_new_line
					put_string ("   (R:")
					output_device.put_integer (res.run_count)
					put_string (", P:")
					output_device.put_integer (res.passed_tests)
					put_string (" [")
					put_string (f.formatted
						(res.pass_percentage.rounded))
					put_string ("%%], F:")
					output_device.put_integer (res.failed_tests)
					put_string (" [")
					put_string (f.formatted
						(res.fail_percentage.rounded))
					put_string ("%%], E:")
					output_device.put_integer (res.exceptions)
					put_string (")")
				end
			end
			put_new_line
		end
					
	put_container_results (t: TEST_CONTAINER) is
			-- Output statistic information about tests contained in `t'.
		do
			put_string ("   (Contained tests: " + t.test_count.out + ", ")
			put_string ("Passed: " + t.contained_passed_tests.out + " [" + 
				(t.contained_pass_percentage.rounded).out + "%%], " +
				"Failed: " + t.contained_failed_tests.out + " [" + 
				(t.contained_fail_percentage.rounded).out + "%%])")
			put_new_line
		end

	put_failure_information (t: SINGLE_TEST; run: INTEGER) is
			-- Output failure information for `run' of test `t'
		local
			e: EXCEPTION_INFO
			f: EXTENDED_FORMAT_INTEGER
			i: INTEGER
			res: TEST_CASE_RESULT
			old_run: INTEGER
		do
			put_test_id (t)
			put_new_line
			res := t.test_results
			old_run := res.run
			res.select_run (run)
			create f.make_from_integer (res.assertions)
			f.right_justify
			from 
				i := 1
				put_string ("Reason: %N")
			until
				i > res.assertions
			loop
				if not res.is_assertion_pass (i) then
					put_string ("  ")
					put_string (f.formatted (i))
					put_string (") ")
					put_string (res.failure_reason (i))
					put_new_line
				end
				if res.is_assertion_exception (i) then
					put_new_line
					put_string ("Exception information:")
					put_new_line
					e := res.exception_info (i)
					put_string ("  Exception type: ")
					put_string (e.type)
					put_new_line
					put_string ("  Originating class: ")
					put_string (e.origin_class)
					put_new_line
					put_string ("  Originating feature: ")
					put_string (e.origin_feature)
					put_new_line
					put_string ("  Assertion tag name: ")
					put_string (e.tag_name)
					put_new_line
				end
				i := i + 1
			end
			put_new_line
			res.select_run (old_run)
		end

	put_timing_information (t: SINGLE_TEST; run: INTEGER) is
			-- Output timing information for `run' of test `t'.
		local
			f: FORMAT_DOUBLE
			old_run: INTEGER
			res: TEST_CASE_RESULT
		do
			create f.make (9, 4)
			f.no_justify
			put_test_id (t)
			res := t.test_results
			old_run := res.run
			res.select_run (run)
			put_string ("  Time: ")
			put_string (f.formatted (res.execution_time))
			put_string (" secs")
			put_new_line
			res.select_run (old_run)
		end
	
	put_new_line is
			-- Output new line.
		do
			output_device.put_new_line
		end
		
feature {NONE} -- Implementation

	standard_put_string (s: STRING) is
			-- Output `s'.
		do
			output_device.put_string (s)
		end

end -- class TEST_LOG

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
