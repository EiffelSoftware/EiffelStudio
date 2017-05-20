note
	description: "HTML report generator."
	author: "Software Engineering Lab, York University"

deferred class
	ES_HTML_GEN

feature -- Initialization

	make_gen (name: STRING_8; file_name: STRING_8; show_err: BOOLEAN)
			-- Create HTML file.
		do
			output_file_name := file_name
			test_name := name
			show_error := show_err
		end

feature {NONE} -- Implementation

	show_error: BOOLEAN

	write_summary (file_name: STRING_8)
			-- Write the summary of the test in HTML format.
		require
			file_name_valid: file_name /= Void
		do
			get_statistics
			create output_file1.make_with_name (file_name)
			output_file.open_write
			write_summary_start
			write_summary_details
			write_summary_end
			output_file.close
		end

	write_summary_big (file_name: STRING_8)
			-- Write the summary of the test in HTML format.
		require
			file_name_valid: file_name /= Void
		do
			get_statistics
			create output_file1.make_with_name (file_name)
			output_file.open_write
			write_summary_start_big
			write_summary_details
			write_summary_end_big
			output_file.close
		end

	write_summary_start
			-- Start to write the HTML file.
		local
			date: DATE
			time: TIME
		do
			output_file.putstring ("<html>%N<head>%N<base target=%"main%">%N</head>%N")
			output_file.putstring ("<body>%N")
			create date.make_now
			create time.make_now
			output_file.put_string ("<p align=%"center%"><b>Test Run:")
			output_file.putstring (date.out)
			output_file.put_string ("   ")
			output_file.put_string (time.out)
			output_file.put_string ("</b></p>")
			output_file.putstring ("<font color=%"blue%">")
			output_file.putstring ("<H2  align=%"center%">")
			check attached test_name as tn then
				output_file.putstring (tn)
			end
			output_file.putstring ("</H2>")
			output_file.putstring ("</font>")
			output_file.putstring ("<p align=%"center%">Note: * indicates a violation test case</p>")
			output_file.putstring ("%N")
			output_file.putstring ("<table border=1 align=%"center%">")
			output_file.putstring ("%N")
			if number_of_tests > 0 then
				if number_passed_tests = number_of_tests then
					output_file.putstring ("<tr><td bgcolor=%"#00FF00%" colspan=%"3%">&nbsp;</td></tr>")
					output_file.putstring ("<tr><td align=%"center%" colspan=%"3%">")
					output_file.putstring ("PASSED (")
					output_file.putint (number_passed_tests)
					output_file.putstring (" out of ")
					output_file.putint (number_of_tests)
				else
					output_file.putstring ("<tr><td bgcolor=%"#FF0000%" colspan=%"3%">&nbsp;</td></tr>")
					output_file.putstring ("<tr><td align=%"center%" colspan=%"3%">")
					output_file.putstring ("FAILED (")
					output_file.putint (number_of_tests - number_passed_tests)
					output_file.putstring (" failed & ")
					output_file.putint (number_passed_tests)
					output_file.putstring (" passed out of ")
					output_file.putint (number_of_tests)
				end
				output_file.putstring (")</td></tr>%N")
			end
			output_file.putstring ("<tr><td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>Case Type</b></font></td>")
			output_file.putstring ("%N")
			output_file.putstring ("<td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>Passed</b></font></td>")
			output_file.putstring ("%N")
			output_file.putstring ("<td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>Total</b></font></td></tr>")
			output_file.putstring ("%N")
			write_statistics ("Violation", number_passed_violation, number_of_violation)
			write_statistics ("Boolean", number_passed_boolean, number_of_boolean)
			write_statistics ("All Cases", number_passed_tests, number_of_tests)
			output_file.putstring ("<tr><td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>State</b></font></td>")
			output_file.putstring ("%N")
			output_file.putstring ("<td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>Contract Violation</b></font></td>")
			output_file.putstring ("%N")
			output_file.putstring ("<td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>Test Name</b></font></td></tr>")
			output_file.putstring ("%N")
		end

	write_summary_end
			-- Finish writing the HTML file.
		do
			output_file.putstring ("</table>")
			output_file.putstring ("</body>%N")
			output_file.putstring ("</html>%N")
		end

	write_summary_start_big
			-- Start to write the HTML file.
		do
			output_file.putstring ("<html>%N<head>%N<base target=%"main%">%N</head>%N")
			output_file.putstring ("<body>%N")
			output_file.putstring ("<font size=%"16%">")
			output_file.putstring ("<P  align=%"center%">")
			check attached test_name as tn then
				output_file.putstring (tn)
			end
			output_file.putstring ("</p>")
			output_file.putstring ("<p align=%"center%">Note: * indicates a violation test case</p>")
			output_file.putstring ("%N")
			output_file.putstring ("<table border=1 align=%"center%">")
			output_file.putstring ("%N")
			if number_of_tests > 0 then
				if number_passed_tests = number_of_tests then
					output_file.putstring ("<tr><td bgcolor=%"#00FF00%" colspan=%"3%">&nbsp;</td></tr>")
					output_file.putstring ("<tr><td align=%"center%" colspan=%"3%">")
					output_file.putstring ("<font size=%"16%">PASSED (")
					output_file.putint (number_passed_tests)
					output_file.putstring (" out of ")
					output_file.putint (number_of_tests)
				else
					output_file.putstring ("<tr><td bgcolor=%"#FF0000%" colspan=%"3%">&nbsp;</td></tr>")
					output_file.putstring ("<tr><td align=%"center%" colspan=%"3%">")
					output_file.putstring ("<font size=%"16%">FAILED (")
					output_file.putint (number_of_tests - number_passed_tests)
					output_file.putstring (" failed & ")
					output_file.putint (number_passed_tests)
					output_file.putstring (" passed out of ")
					output_file.putint (number_of_tests)
				end
				output_file.putstring (")</td></tr>%N")
			end
			output_file.putstring ("<tr><td align=%"center%" bgcolor=%"#000080%"><font size=%"16%" color=%"#FFCC00%">")
			output_file.putstring ("<b>Case Type</b></font></td>")
			output_file.putstring ("%N")
			output_file.putstring ("<td align=%"center%" bgcolor=%"#000080%"><font size=%"16%" color=%"#FFCC00%">")
			output_file.putstring ("<b>Passed</b></font></td>")
			output_file.putstring ("%N")
			output_file.putstring ("<td align=%"center%" bgcolor=%"#000080%"><font size=%"16%" color=%"#FFCC00%">")
			output_file.putstring ("<b>Total</b></font></td></tr>")
			output_file.putstring ("%N")
			write_statistics_big ("Violation", number_passed_violation, number_of_violation)
			write_statistics_big ("Boolean", number_passed_boolean, number_of_boolean)
			write_statistics_big ("All Cases", number_passed_tests, number_of_tests)
			output_file.putstring ("<tr><td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>State</b></font></td>")
			output_file.putstring ("%N")
			output_file.putstring ("<td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>Contract Violation</b></font></td>")
			output_file.putstring ("%N")
			output_file.putstring ("<td align=%"center%" bgcolor=%"#000080%"><font color=%"#FFCC00%">")
			output_file.putstring ("<b>Test Name</b></font></td></tr>")
			output_file.putstring ("%N")
		end

	write_summary_end_big
			-- Finish writing the HTML file.
		do
			output_file.putstring ("</table>")
			output_file.putstring ("</font>")
			output_file.putstring ("</body>%N")
			output_file.putstring ("</html>%N")
		end

	write_statistics (case_type: STRING_8; passed: INTEGER_32; total: INTEGER_32)
			-- Write statistic information.
		require
			case_type_valid: case_type /= Void
			passed_valid: passed >= 0
			total_valid: total >= 0
		do
			output_file.putstring ("<tr>")
			output_file.putstring ("<td align=%"center%"><font color=%"blue%"><b>")
			output_file.putstring (case_type)
			output_file.putstring ("</b></font></td>%N")
			output_file.putstring ("<td align=%"center%">")
			output_file.putint (passed)
			output_file.putstring ("</td>")
			output_file.putstring ("<td align=%"center%">")
			output_file.putint (total)
			output_file.putstring ("</td>")
			output_file.putstring ("</tr>%N")
		end

	write_statistics_big (case_type: STRING_8; passed: INTEGER_32; total: INTEGER_32)
			-- Write statistic information.
		require
			case_type_valid: case_type /= Void
			passed_valid: passed >= 0
			total_valid: total >= 0
		do
			output_file.putstring ("<tr>")
			output_file.putstring ("<td align=%"center%"><font size=%"16%" color=%"blue%"><b>")
			output_file.putstring (case_type)
			output_file.putstring ("</b></font></td>%N")
			output_file.putstring ("<td align=%"center%">")
			output_file.putint (passed)
			output_file.putstring ("</td>")
			output_file.putstring ("<td align=%"center%">")
			output_file.putint (total)
			output_file.putstring ("</td>")
			output_file.putstring ("</tr>%N")
		end

	write_passed_case (one_case: ES_TEST_CASE)
			-- Output test result for one passed case.
		require
			one_case_valid: one_case /= Void
		do
			output_file.putstring ("<td><font color=%"green%"><b>PASSED</b></font></td>%N")
			output_file.putstring ("<td align=%"center%">")
			if one_case.contract_violated then
				output_file.putstring ("<font color=%"blue%">CAUGHT</font>")
			else
				output_file.putstring ("NONE")
			end
			output_file.putstring ("</td>%N")
			output_file.putstring ("<td>")

			if attached {ES_VIOLATION_CASE} one_case as l then
				output_file.putstring ("*")
			end

			output_file.putstring (wrap_html_comments (one_case.case_name))
			output_file.putstring ("</td>%N")
		end

	write_failed_case (one_case: ES_TEST_CASE)
			-- Output test result for one failed case.
		require
			one_case_valid: one_case /= Void
		local
			tag: STRING_8
		do
			output_file.putstring ("<td><font color=%"red%"><b>FAILED</b></font></td>%N")
			output_file.putstring ("<td align=%"center%">")
			if one_case.contract_violated then
				if show_error then
					check attached one_case.meaning (one_case.violation_type) as m then
						output_file.putstring ("<font color=%"blue%">" + m + "</font>")
					end
					if attached one_case.violation_tag as t then
						tag := t.twin
						tag.replace_substring_all ("%N", "<br>")
						output_file.putstring ("<p align=%"left%">" + "<font color=%"blue%" face=%"Courier%">" + "<font size=%"1%">" + "%N" + tag + "%N" + "</font>")
					end
				else
					check attached one_case.meaning (one_case.violation_type) as m then
						output_file.putstring (m)
					end
				end
			else
				output_file.putstring ("NONE")
			end
			output_file.putstring ("</td>%N")
			output_file.putstring ("<td>")

			if attached {ES_VIOLATION_CASE} one_case as l then
				output_file.putstring ("*")
			end

			output_file.putstring (wrap_html_comments (one_case.case_name))
			output_file.putstring ("</td>%N")
		end

	Wrap_length: INTEGER_32 = 100

	wrap_line (line : STRING) : STRING
		local
			ln, ws: INTEGER_32
			ls: LIST [STRING]
		do
			ls := line.split (' ')
			create Result.make (line.count + ls.count)
			from
				ln := 0
				ws := 0
				ls.start
			until
				ls.after
			loop
				if ln + ls.item.count + 1 <= wrap_length or ws = 0 then
					Result.append (ls.item)
					Result.extend (' ')
					ln := ln + ls.item.count + 1
					ws := ws + 1
					ls.forth
				else
					Result.append ("<br>")
					ln := 0
					ws := 0
				end
			variant
				2 * (ls.count - ls.index + 1) + ws
			end
		end

	wrap_html_comments (comment: STRING_8): attached STRING_8
			-- Wraps the comments in the HTML code.
		local
			ls: LIST [STRING]
			is_first: BOOLEAN
		do
			if comment.count > Wrap_length then
				ls := comment.split ('%N')
				create Result.make (comment.count)
				is_first := True
				across ls as line loop
					if not is_first then
						Result.append ("<br>")
					end
					Result.append (wrap_line (line.item))
					is_first := false
				end
			else
				Result := comment
			end
		end

	write_one_case_details (one_case: ES_TEST_CASE)
			-- Output test result for one case.
		require
			one_case_valid: one_case /= Void
		do
			output_file.putstring ("<tr>")
			if one_case.passed then
				write_passed_case (one_case)
			else
				write_failed_case (one_case)
			end
			output_file.putstring ("</tr>%N")
		end

	get_statistics
		deferred
		end

	write_summary_details
		deferred
		end

	output_file: attached PLAIN_TEXT_FILE
		do
			if attached output_file1 as output_file2  then
				Result := output_file2
			else
				create Result.make_with_name ("default_output")
			end

		end

feature {NONE} -- Attributes

	test_name: STRING_8

	output_file_name: STRING_8

	output_file1: PLAIN_TEXT_FILE

	number_of_boolean: INTEGER_32

	number_passed_boolean: INTEGER_32

	number_of_violation: INTEGER_32

	number_passed_violation: INTEGER_32

	number_of_tests: INTEGER_32

	number_passed_tests: INTEGER_32

end
