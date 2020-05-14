note
	description: "Example test for the STRAVA OUATH API"
	author: "Mauricio Bustos"
	date: "$Date$"
	revision: "$Revision$"

class
	STRAVA_OAUTH_20_API_EXAMPLE

create
	make

feature {NONE} -- Creation

	make
		local
			strava: OAUTH_20_STRAVA_API
			config: OAUTH_CONFIG
			api_service: OAUTH_SERVICE_I
			request: OAUTH_REQUEST
			access_token: detachable OAUTH_TOKEN
			encode: UTF8_URL_ENCODER
			l_string: STRING
		do
			create config.make_default (api_key, api_secret)
			config.set_callback ("http://127.0.0.1:9991")
			create strava
			api_service := strava.create_service (config)
			print ("%N===STRAVA OAuth Workflow ===%N")
			if attached api_service.authorization_url (empty_token) as lauthorization_url then
				print ("%NRequesting authorization token from: " + lauthorization_url)
				l_string := authorization_code (lauthorization_url)
				create encode
				access_token := api_service.access_token_post (empty_token, create {OAUTH_VERIFIER}.make (encode.decoded_string (l_string)))
				if attached access_token as l_access_token then
					print ("%NGot the Access Token: " + l_access_token.debug_output + "%N")
					print ("%NNow we're going to access a protected resource: " + protected_resource_url + "%N")
					create request.make ("GET", protected_resource_url)
					request.add_header ("Authorization", "Bearer " + l_access_token.token)
					if attached request.execute as l_response then
						print ("%NOk, let see what we found...%N")
						print ("%N%TResponse: STATUS" + l_response.status.out)
						if attached l_response.body as l_body then
							print ("%N%TBody:" + l_body)
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	authorization_code (a_request_url: READABLE_STRING_8): STRING
			-- The authorization token as computed by calling `a_request_url'
		local
			socket: NETWORK_STREAM_SOCKET
			callback_string: STRING
			code_index: INTEGER
		do
			(create {EXECUTION_ENVIRONMENT}).system ("open -a Google\ Chrome '" + a_request_url + "'")
			Result := ""
	    	create socket.make_server_by_port(9991)
			socket.listen(5)
			socket.set_timeout_ns (10)
			socket.accept
			if attached socket.accepted as accepted_socket then
				from
					callback_string := ""
					accepted_socket.read_character
				until
					callback_string.has_substring ("%R%N%R%N") or callback_string.has ('&')
				loop
					callback_string.append (accepted_socket.last_character.out)
					if not callback_string.has_substring ("%R%N%R%N") then
						accepted_socket.read_character
					end
				end
				code_index := callback_string.substring_index ("code=", 1)
				if code_index > 0 then
					Result := callback_string.substring (code_index + 5, callback_string.substring_index ("&", code_index + 5) - 1)
					print ("%N%NAuthorization code ---> '" + Result + "'%N")
				end
				accepted_socket.put_string ("Thank you for the token. Received authorization code --> '" + Result + "'%N")
				accepted_socket.close
			end
			socket.close
		end

	empty_token: detachable OAUTH_TOKEN;

feature {NONE} -- Configuration

	api_key : STRING =""
	api_secret :STRING =""
	protected_resource_url : STRING = "https://www.strava.com/api/v3/athlete"

note
	copyright: "2013-2020, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
