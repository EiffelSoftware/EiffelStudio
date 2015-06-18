note
	description: "Summary description for {TEST_GENERAL_REQUEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GENERAL_REQUEST

inherit

	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Set up

	on_prepare
		local
			l_resp : detachable OAUTH_RESPONSE
		do
			create post_request.make ("POST", "http://example.com")
			post_request.add_body_parameter ("param", "value")
			post_request.add_body_parameter ("param with spaces", "value with spaces")
			l_resp := post_request.execute
			create get_request.make ("GET", "http://example.com/?qsparam=value&other+param=value+with+spaces")
			l_resp := get_request.execute
		end


feature -- Tests
	request_method
		do
			if attached post_request.executor as l_executor then
				assert ("Expected POST", l_executor.verb.same_string ("POST"))
			end
			if attached get_request.executor as l_executor then
				assert ("Expected GET", l_executor.verb.same_string ("GET"))
			end

		end

	test_url_sanitize
		local
			l_uri : URI
		do
			create l_uri.make_from_string ("http://example.com/?qsparam=value&other+param=value+with+spaces")
			print (l_uri.debug_output)
			l_uri.remove_query
			print (l_uri.debug_output)

		end

	get_query_string_parameters
		do
			assert ("Expected 2",get_request.query_string_parameters.count = 2)
			assert ("Expected 0",post_request.query_string_parameters.count = 0)
		end

feature {NONE} -- Implementation
	Get_request : BASE_REQUEST
	Post_request : BASE_REQUEST

;note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
