note
	description: "Summary description for {LOGIN_WITH_GITHUB_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_GITHUB_SERVICE

create
	make

feature {NONE} -- Initialization

	make (a_setup: LOGIN_WITH_GITHUB_SETUP; dft_cb: READABLE_STRING_8; req: WSF_REQUEST)
		local
			cb: detachable READABLE_STRING_8
			i: INTEGER
		do
				-- key and secret
			create config.make_default (a_setup.api_key, a_setup.api_secret)
				-- Callback
			default_callback_uri_path := dft_cb
			cb := a_setup.callback
			if cb = Void or else cb.is_whitespace then
				cb := req.absolute_script_url (default_callback_uri_path)
				callback_uri_path := default_callback_uri_path
			else
				i := cb.substring_index ("://", 1)
				if i > 0 then
					i := i + 3
				elseif cb.starts_with_general ("//") then
					i := 3
				end
				if i > 0 then
						-- Keep `cb` as it is, an absolute URL.
					i := cb.substring_index ("/", i + 1)
					if i > 0 then
						callback_uri_path := cb.substring (i, cb.count)
					else
						callback_uri_path := "" -- Should not occurs
					end
				else
					callback_uri_path := cb
					cb := req.absolute_script_url (cb)
				end
			end
			check cb /= Void end
			config.set_callback (cb.to_string_8)

				-- Scope
			config.set_scope (scope)
			create github
			api_service := github.create_service (config)
		end

feature -- Access

	error_procedure: detachable PROCEDURE [WSF_REQUEST, WSF_RESPONSE, READABLE_STRING_GENERAL]

	default_callback_uri_path: STRING

	callback_uri_path: STRING_8
			-- URI path of the callback

feature -- Element change

	set_error_procedure (proc: like error_procedure)
		do
			error_procedure := proc
		end

feature -- Execution

	process_login (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached authorization_url as l_url then
				res.redirect_now (l_url)
			elseif attached error_procedure as err then
				err.call (req, res, {STRING_32} "Internal error! Missing Github settings.")
			else
				process_error (req, res, {STRING_32} "Internal error! Missing Github settings.")
			end
		end

	process_oauth_callback (req: WSF_REQUEST; res: WSF_RESPONSE; a_cb: PROCEDURE [WSF_REQUEST, WSF_RESPONSE, OAUTH_TOKEN, READABLE_STRING_GENERAL])
		do
			if attached {WSF_STRING} req.query_parameter ("code") as l_code then
				sign_request (l_code.value)
				if
					status = 200 and then
					attached access_token as l_access_token and then
					attached user as l_user
				then
					a_cb.call (req, res, l_access_token, l_user)
				else
					process_error (req, res, "Login failed!")
				end
			end
		end

	process_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_error_message: READABLE_STRING_GENERAL)
 		local
			msg: WSF_PAGE_RESPONSE
			conv: UTF_CONVERTER
		do
			create msg.make_with_body (conv.utf_32_string_to_utf_8_string_8 (a_error_message))
			res.send (msg)
		end

feature -- Authorization

	authorization_url: detachable STRING_8
		do
			Result := api_service.authorization_url (Void)
		end

	sign_request (a_code: READABLE_STRING_32)
			-- Sign request with code `a_code'.
			--! To get the code `a_code' you need to do a request
			--! using the authorization_url
		local
			request: OAUTH_REQUEST
		do
			oauth_response := Void
			access_token := Void

				-- Get the access token.
			if attached api_service.access_token_post (Void, create {OAUTH_VERIFIER}.make (a_code)) as l_access_token then
				access_token := l_access_token
				create request.make ("GET", protected_resource_url)
				request.add_header ("Authorization", "Bearer " + l_access_token.token)
				request.add_header ("User-Agent", "EiffelWeb Login with Github") -- Required by Github API.
				api_service.sign_request (l_access_token, request)
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					oauth_response := l_response
				end
			end
		end

feature {NONE} -- Implementation

	github: OAUTH_20_GITHUB_API

	config: OAUTH_CONFIG

	api_service: OAUTH_SERVICE_I

	scope: STRING = "user,repo,public_repo"

	oauth_response: detachable OAUTH_RESPONSE

feature -- Access

	access_token: detachable OAUTH_TOKEN
			-- JSON representing the access token.


	protected_resource_url: STRING = "https://api.github.com/user"
			-- Resource URL

	status: INTEGER
			-- HTTP status error.
		do
			if attached oauth_response as l_response then
				Result := l_response.status
			else
				Result := {HTTP_STATUS_CODE}.internal_server_error
			end
		end

	user: detachable STRING_32
		do
			if
				attached oauth_response as l_oauth_response and then
				attached {JSON_OBJECT} parsed_json (l_oauth_response.body) as j and then
				attached {JSON_STRING} j.item ("login") as j_login
			then
				Result := j_login.unescaped_string_32
			end
		end

feature {NONE} -- Implementation

	parsed_json (a_json_text: detachable READABLE_STRING_8): detachable JSON_VALUE
		local
			j: JSON_PARSER
		do
			if a_json_text /= Void then
				create j.make_with_string (a_json_text)
				j.parse_content
				if j.is_parsed then
					Result := j.parsed_json_value
				end
			end
		end

end
