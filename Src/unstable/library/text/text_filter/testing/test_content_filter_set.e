note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CONTENT_FILTER_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_line_break_filter
			-- New test routine
		local
			f: LINE_BREAK_TO_HTML_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "one%Ntwo%Nthree."
			expected_text := "one<br/>%Ntwo<br/>%Nthree."
			create f
			f.filter (text)

			assert ("expected line break filtered text", text.same_string (expected_text))
		end

	test_no_html_filter
			-- New test routine
		local
			f: NO_HTML_CONTENT_FILTER
			text: STRING
			expected_text: STRING
		do
			text := "<strong>Hello <em>Eiffel</em>, please visit <a href=%"location%">this page</a>."
			expected_text := "Hello Eiffel, please visit this page."
			create f
			f.filter (text)

			assert ("expected no html filtered text", text.same_string (expected_text))

			text := "<strong>Hel<lo <em>Eiffel</em>, please visit <a href=%"location%">this page</a>."
			expected_text := "Hel<lo Eiffel, please visit this page." -- error in html .. but this filter is not a checker.
			create f
			f.filter (text)

			assert ("expected no html filtered text", text.same_string (expected_text))

		end

end


