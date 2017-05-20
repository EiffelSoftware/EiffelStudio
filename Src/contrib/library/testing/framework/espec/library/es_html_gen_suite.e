note
	description: "HTML report generator. For TEST_SUITE."
	author: "Software Engineering Lab, York University"

class
	ES_HTML_GEN_SUITE

inherit
	ES_HTML_GEN

create
	make

feature {NONE} -- Creation

	make (name: STRING_8; file_name: STRING_8; classes: LINKED_LIST [ES_TEST]; show_err: BOOLEAN)
			-- Сreate HTML file.
		do
			make_gen (name, file_name, show_err)
			test_classes := classes
			write_html_report
		end

feature {NONE} -- Implementation

	write_html_report
			-- Write HTML file.
		do
			write_summary (output_file_name)
		end

	get_statistics
			-- Collect statistics information.
		local
			one_test: ES_TEST
		do
			check attached test_classes as tc then
			from
					number_of_boolean := 0
					number_passed_boolean := 0
					number_of_violation := 0
					number_passed_violation := 0
					number_of_tests := 0
					number_passed_tests := 0
					tc.start
				until
					tc.after
				loop
					one_test := tc.item
					check attached one_test then
						if attached one_test.cases as cases1 then
							from
								cases1.start
							until
								cases1.after
							loop
								check attached cases1.item as item1 then
									if item1.is_violation_case then
										if item1.passed then
											number_passed_violation := number_passed_violation + 1
											number_passed_tests := number_passed_tests + 1
										end
										number_of_violation := number_of_violation + 1
									else
										if item1.passed then
											number_passed_boolean := number_passed_boolean + 1
											number_passed_tests := number_passed_tests + 1
										end
										number_of_boolean := number_of_boolean + 1
									end
									number_of_tests := number_of_tests + 1
									cases1.forth
								end
							end
						else
							-- do nothing
						end
						tc.forth
					end
				end
			end
		end

	write_summary_details
			-- Write results for all cases into the HTML file.
		local
			one_test: ES_TEST
			counter: INTEGER_32
		do
			if attached test_classes as t then
				across
					t as i
				from
					counter := 0
				loop
					one_test := i.item
					counter := counter + 1
					output_file.putstring ("<tr><td bgcolor=%"#008080%" align=%"center%"><font color=%"#FFCC00%"><b>Test")
					output_file.putint (counter)
					output_file.putstring ("</b></font></td>%N<td bgcolor=%"#008080%" align=%"center%" colspan=%"2%"><font color=%"#FFCC00%">")
					if attached one_test then
						if attached one_test.name as tn1 then
							output_file.putstring (tn1)
						end
						output_file.putstring ("</font></td></tr>")
						if attached one_test.cases as cases1 then
							across
								cases1 as c
							loop
								write_one_case_details (c.item)
							end
						end
					end
				end
			end
		end

feature {NONE} -- Attributes

	test_classes: LINKED_LIST [ES_TEST]

end
