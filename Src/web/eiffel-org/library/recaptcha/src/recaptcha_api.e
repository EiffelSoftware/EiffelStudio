note
	description: "[
		Simple API to call {RECAPTCHA} Google API.
		Example call:
		https://www.google.com/recaptcha/api/siteverify?secret=your_secret&response=response_string&remoteip=user_ip_address
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=RECAPTCHA", "src=https://developers.google.com/recaptcha/", "protocol=uri"
	EIS: "name=RECAPTCHA API verify", "src=https://developers.google.com/recaptcha/docs/verify", "protocol=uri"

class
	RECAPTCHA_API

create
	make

feature {NONE} -- Initialization

	make (a_secret_key, a_response: READABLE_STRING_8)
			-- Create an object Recaptcha with secret key `a_secret_key' and response token `a_response'.
		do
			secret := a_secret_key
			response := a_response
		ensure
			secret_set: secret.same_string (a_secret_key)
			response_set: response.same_string (a_response)
		end

feature -- Access

	base_uri: STRING_8 = "https://www.google.com/recaptcha/api/siteverify"
			-- Recaptcha base URI

	secret: READABLE_STRING_8
			-- Required. The shared key between your site and ReCAPTCHA.

	response: READABLE_STRING_8
			-- Required. The user response token provided by the reCAPTCHA to the user and provided to your site on.

	remoteip: detachable READABLE_STRING_8
			-- Optional. The user's IP address.

feature -- Status Reports

	errors: detachable LIST [READABLE_STRING_8]
			-- optional table of error codes
			-- missing-input-secret		The secret parameter is missing.
			-- invalid-input-secret		The secret parameter is invalid or malformed.
			-- missing-input-response	The response parameter is missing.
			-- invalid-input-response	The response parameter is invalid or malformed.

feature -- Change Element

	set_remoteip (a_remoteip: READABLE_STRING_8)
			-- Set `remoteip' with `a_remoteip'.
		do
			remoteip := a_remoteip
		ensure
			remoteip_set: remoteip = a_remoteip
		end

feature -- API

	verify: BOOLEAN
			-- Verify the user's response
		local
			l_parser: JSON_PARSER
		do
			if attached get as l_response then
				if attached l_response.body as l_body then
					create l_parser.make_with_string (l_body)
					l_parser.parse_content
					if
						l_parser.is_parsed and then attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then
						attached {JSON_BOOLEAN} jv.item ("success") as l_success
					then
						Result := l_success.item
						if not Result and then attached {JSON_ARRAY} jv.item ("error-codes") as l_error_codes then
							across
								l_error_codes as c
							loop
								if attached {JSON_STRING} c.item as ji then
									put_error (ji.unescaped_string_32)
								end
							end
						end
					end
				else
					put_error (l_response.status.out)
				end
			else
				put_error ("unknown")
			end
		end

feature {NONE} -- REST API

	get: detachable RESPONSE
			-- Reading Data
		local
			l_request: REQUEST
		do
			create l_request.make ("GET", new_uri)
			Result := l_request.execute
		end

feature {NONE} -- Implementation

	new_uri: STRING_8
			-- new uri (BaseUri?secret=secret_value&response=response_value[&remoteip=remoteip_value]
		do
			create Result.make_from_string (base_uri)
			Result.append ("?secret=")
			Result.append (secret)
			Result.append ("&response=")
			Result.append (response)
			if attached remoteip as l_remoteip then
				Result.append ("&remoteip=" + l_remoteip)
			end
		end

	put_error (a_code: READABLE_STRING_GENERAL)
		local
			l_errors: like errors
			utf: UTF_CONVERTER
		do
			l_errors := errors
			if l_errors = Void then
				create {ARRAYED_LIST [STRING]} l_errors.make (1)
				errors := l_errors
			end
			l_errors.force (utf.utf_32_string_to_utf_8_string_8 (a_code))
		end

note
	copyright: "2011-2015 Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
