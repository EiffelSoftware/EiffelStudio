note
	description: "Summary description for {TEST_SECURITY_HTML_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SECURITY_HTML_FILTER_SET

inherit
	EQA_TEST_SET

feature -- Test routines	

	test_script_element
		local
			text: STRING
			expected_text: STRING
		do
			text := "<script>alert('XSS')</script>."
			expected_text := "alert('XSS')."
			assert ("expected no script element", filtered (text).same_string (expected_text))
		end

	test_attribute_value
		local
			text: STRING
			expected_text: STRING
		do
			text := "<img src=%"javascript:alert('XSS');%">"
			expected_text := "<img >"
			assert ("expected no javascript: in attribute value", filtered (text).same_string (expected_text))

			text := "<IMG SRC=JaVaScRiPt:alert('XSS')/>"
			expected_text := "<IMG />"
			assert ("expected no javascript: in attribute value", filtered (text).same_string (expected_text))


		end

	test_attribute_name
		local
			text: STRING
			expected_text: STRING
		do
			text := "<a onmouseover=%"alert(document.cookie)%">xxs link</a>."
			expected_text := "<a >xxs link</a>."
			assert ("expected no on* attribute name", filtered (text).same_string (expected_text))
		end


feature {NONE} -- Implementation

	filtered (a_text: STRING_GENERAL): STRING_GENERAL
		do
			(create {SECURITY_HTML_CONTENT_FILTER}).filter (a_text)
			Result := a_text
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
