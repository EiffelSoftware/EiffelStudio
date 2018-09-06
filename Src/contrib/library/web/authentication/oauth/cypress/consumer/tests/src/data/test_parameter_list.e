note
	description: "Summary description for {TEST_PARAMETER_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PARAMETER_LIST

inherit

	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
		do
			create parameters.make (5)
		end

feature -- Tests

	not_append_to_query_string_with_empty_map
 		local
 			l_uri : STRING_8
 			l_uri_expected: STRING_8
 		do
 			l_uri := "http://www.eiffelroom.com"
 			l_uri_expected := "http://www.eiffelroom.com"
 			parameters.append_to_url (l_uri)
 			assert("Expected same string",l_uri.same_string (l_uri_expected))
 		end

	append_parameters_to_simple_url
		local
	 			l_uri,l_uri_expected : STRING_8
	 		do
	 		  l_uri := "http://www.example.com"
   			  l_uri_expected := "http://www.example.com?param1=value1&param2=value%%20with%%20spaces"
			  l_uri_expected.trim

   			  parameters.add_parameter ("param1", "value1")
   			  parameters.add_parameter ("param2", "value with spaces")

			  parameters.append_to_url (l_uri)
  			  assert("Expected same uri", l_uri.same_string (l_uri_expected))
	 		end


	 append_parameters_to_url_with_query_strings
		local
	 			l_uri,l_uri_expected : STRING_8
	 		do
	 		  l_uri := "http://www.example.com?already=present"
   			  l_uri_expected := "http://www.example.com?already=present&param1=value1&param2=value%%20with%%20spaces"
			  l_uri_expected.trim

   			  parameters.add_parameter ("param1", "value1")
   			  parameters.add_parameter ("param2", "value with spaces")

			  parameters.append_to_url (l_uri)
  			  assert("Expected same uri", l_uri.same_string (l_uri_expected))
	 		end

		sort_parameters
			do
				parameters.add_parameter ("param1", "v1")
				parameters.add_parameter ("param6", "v2")
				parameters.add_parameter ("a_param", "v3")
				parameters.add_parameter ("param2", "v4")
				assert ("Expected equal",parameters.sort.as_form_url_encoded_string.same_string("a_param=v3&param1=v1&param2=v4&param6=v2"))
 			end


		sort_parameters_with_same_name
			do
				parameters.add_parameter ("param1", "v1")
				parameters.add_parameter ("param6", "v2")
				parameters.add_parameter ("a_param", "v3")
				parameters.add_parameter ("param1", "v4")
				assert ("Expected equal",parameters.sort.as_form_url_encoded_string.same_string("a_param=v3&param1=v1&param1=v4&param6=v2"))
 			end

feature {NONE} -- Implementation

	parameters: OAUTH_PARAMETER_LIST

;note
	copyright: "2013-2017, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
