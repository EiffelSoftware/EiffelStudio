note
	description: "Summary description for {NULL_OAUTH_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NULL_OAUTH_SERVICE

inherit

	OAUTH_SERVICE_I
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			version := "Null Implementation"
		end
feature -- Access

	request_token: detachable OAUTH_TOKEN
			-- retrieve the request token
		do
			-- Null implementation
		end

	access_token_get (a_request_token: detachable OAUTH_TOKEN; verifier: OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrive an access token using a request token using GET
			-- (obtained previously)
		do
			-- Null implementation
		end

	access_token_post (a_request_token: detachable OAUTH_TOKEN; verifier: detachable OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrive an access token using a request token using POST
			-- (obtained previously)
		do
			-- Null Implementation
		end


	sign_request (an_access_token: OAUTH_TOKEN; a_req: OAUTH_REQUEST)
			-- Signs an OAuth request using an access token (obtained previously)
		do
			-- Null implementation
		end

	authorization_url (a_request_token: detachable OAUTH_TOKEN): detachable STRING_8
			-- URL where you should redirect your users to authenticate
			-- your application.
			-- a request token needed to authorize
		do
			-- Null implementation	
		end


note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
