note
	description: "HTML report generator. For TEST_SUITE"
	author: "Software Engineering Lab, York University"

class
	ES_HTML_GEN_SUITE

inherit
	ES_HTML_GEN

create
	make

feature -- Initialization

	make (name: STRING_8; file_name: STRING_8; classes: LINKED_LIST [ES_TEST]; show_err: BOOLEAN)
			-- create HTML file
		do
			make_gen (name, file_name, show_err)
			test_classes := classes
			write_html_report
		end


feature {NONE} -- Implementation

	write_html_report
			-- write HTML file
		do
			write_summary (output_file_name)
		end

	get_statistics
			-- collect statistics information
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
					check attached one_test as ot then
						if attached ot.cases as cases1 then
							from
								cases1.start
							until
								cases1.after
							loop
								check attached cases1.item as item1 then
									if (item1.is_violation_case) then
										if (item1.passed) then
											number_passed_violation := number_passed_violation + 1
											number_passed_tests := number_passed_tests + 1
										end
										number_of_violation := number_of_violation + 1
									else
										if (item1.passed) then
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
			-- write results for all cases into the HTML file
		local
			one_test: ES_TEST
			counter: INTEGER_32
			test_name1: STRING
		do
			if attached test_classes as t then
				from
					counter := 0
					t.start
				until
					t.after
				loop
					one_test := t.item
					counter := counter + 1
					output_file.putstring ("<tr><td bgcolor=%"#008080%" align=%"center%"><font color=%"#FFCC00%"><b>Test")
					output_file.putint (counter)
					output_file.putstring ("</b></font></td>%N<td bgcolor=%"#008080%" align=%"center%" colspan=%"2%"><font color=%"#FFCC00%">")
					if attached one_test as one_t then
							test_name1 := one_t.name
							if attached test_name1 as tn1 then
								output_file.putstring (tn1)
							else
							end
						output_file.putstring ("</font></td></tr>")
						if attached one_test.cases as cases1 then
							from
								cases1.start
							until
								cases1.after
							loop
								write_one_case_details (cases1.item)
								cases1.forth
							end
						end
						t.forth
					else
					end
				end
			end
		end

feature {NONE} -- Attributes

	test_classes: LINKED_LIST [ES_TEST]

end -- class ES_HTML_GEN_SUITE

