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

	make (a_secret_key: READABLE_STRING_8; a_response: READABLE_STRING_GENERAL)
			-- Create an object Recaptcha with secret key `a_secret_key' and response token `a_response'.
		do
			secret := a_secret_key
			response := a_response
		ensure
			secret_set: a_secret_key.same_string (secret)
			response_set: a_response.same_string (response)
		end

feature -- Access

	secret: READABLE_STRING_8
			-- Required. The shared key between your site and ReCAPTCHA.

	response: READABLE_STRING_GENERAL
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
			sess: HTTP_CLIENT_SESSION
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
				-- BaseUri?secret=secret_value&response=response_value[&remoteip=remoteip_value]
			sess := (create {DEFAULT_HTTP_CLIENT}).new_session ({RECAPTCHA_CONFIG}.recaptcha_base_uri + "/api/siteverify")

			create ctx.make
			ctx.add_form_parameter ("secret", secret)
			ctx.add_form_parameter ("response", response)
			if attached remoteip as l_remoteip then
				ctx.add_form_parameter ("remoteip", l_remoteip)
			end
			if attached sess.post ("", ctx, Void) as l_response then
				if attached l_response.body as l_body then
					create l_parser.make_with_string (l_body)
					l_parser.parse_content
					if
						l_parser.is_parsed and then
						l_parser.is_valid and then
						attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then
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

	verify_score (a_score: REAL; a_action: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Verify response from user (for recaptcha v3)
		require
			valid_score: a_score >= 0.0 and a_score <= 1.0
		local
			l_parser: JSON_PARSER
			sess: HTTP_CLIENT_SESSION
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
				-- BaseUri?secret=secret_value&response=response_value[&remoteip=remoteip_value]
			sess := (create {DEFAULT_HTTP_CLIENT}).new_session ({RECAPTCHA_CONFIG}.recaptcha_base_uri + "/api/siteverify")

			create ctx.make
			ctx.add_form_parameter ("secret", secret)
			ctx.add_form_parameter ("response", response)
			if attached remoteip as l_remoteip then
				ctx.add_form_parameter ("remoteip", l_remoteip)
			end
			if attached sess.post ("", ctx, Void) as l_response then
				if attached l_response.body as l_body then
					create l_parser.make_with_string (l_body)
					l_parser.parse_content
					if
						l_parser.is_parsed and then
						l_parser.is_valid and then
						attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then
						attached {JSON_BOOLEAN} jv.item ("success") as l_success
					then
						Result := l_success.item
						if Result then
							if attached {JSON_NUMBER} jv.item ("score") as j_score then
								if j_score.real_64_item.truncated_to_real < a_score then
									Result := False
								elseif a_action /= Void then
									Result := attached {JSON_STRING} jv.item ("action") as j_action and then j_action.same_caseless_string (a_action)
								end
							end
						elseif attached {JSON_ARRAY} jv.item ("error-codes") as l_error_codes then
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

feature {NONE} -- Implementation

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
	copyright: "2011-2020 Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
