note
	description : "simple application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DEMO_BASIC

inherit
	WSF_DEFAULT_SERVICE
		redefine
			initialize
		end

	SHARED_HTML_ENCODER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			set_service_option ("port", 9090)
			set_service_option ("verbose", True)
		end

feature -- Credentials

	is_known_login (a_login: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_login' a known username?
		do
			Result := valid_credentials.has (a_login)
		end

	is_valid_credential (a_login: READABLE_STRING_GENERAL; a_password: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_login:a_password' a valid credential?
		do
			if
				a_password /= Void and
				attached valid_credentials.item (a_login) as l_passwd
			then
				Result := a_password.is_case_insensitive_equal (l_passwd)
			end
		ensure
			Result implies is_known_login (a_login)
		end

	demo_credential: STRING_32
			-- First valid known credential display for demo in dialog.
		do
			valid_credentials.start
			create Result.make_from_string_general (valid_credentials.key_for_iteration)
			Result.append_character (':')
			Result.append (valid_credentials.item_for_iteration)
		end

	valid_credentials: STRING_TABLE [READABLE_STRING_32]
			-- Password indexed by login.
		once
			create Result.make_caseless (3)
			Result.force ("world", "eiffel")
			Result.force ("bar", "foo")
			Result.force ("password", "user")
		ensure
			not Result.is_empty
		end

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			auth: HTTP_AUTHORIZATION
			l_authenticated_username: detachable READABLE_STRING_32
			l_invalid_credential: BOOLEAN
		do
			if attached req.http_authorization as l_http_auth then
				create auth.make (l_http_auth)
				if attached auth.login as l_login and then is_valid_credential (l_login, auth.password) then
					l_authenticated_username := auth.login
				else
					l_invalid_credential := True
				end
			end
			if l_invalid_credential then
				handle_unauthorized ("ERROR: Invalid credential", req, res)
			else
				if l_authenticated_username /= Void then
					handle_authenticated (l_authenticated_username, req, res)
				elseif req.path_info.same_string_general ("/login") then
					handle_unauthorized ("Please provide credential ...", req, res)
				elseif req.path_info.starts_with_general ("/protected/") then
						-- any "/protected/*" url
					handle_unauthorized ("Protected area, please sign in before", req, res)
				else
					handle_anonymous (req, res)
				end
			end
		end

	handle_authenticated (a_username: READABLE_STRING_32; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- User `a_username' is authenticated, execute request `req' with response `res'.
		require
			valid_username: not a_username.is_empty
			known_username: is_known_login (a_username)
		local
			s: STRING
			page: WSF_HTML_PAGE_RESPONSE
		do
			create s.make_empty

			append_html_header (req, s)

			s.append ("<p>The authenticated user is <strong>")
			s.append (html_encoder.general_encoded_string (a_username))
			s.append ("</strong> ...</p>")

			append_html_menu (a_username, req, s)
			append_html_logout (a_username, req, s)
			append_html_footer (req, s)

			create page.make
			page.set_body (s)
			res.send (page)
		end

	handle_anonymous (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- No user is authenticated, execute request `req' with response `res'.
		local
			s: STRING
			page: WSF_HTML_PAGE_RESPONSE
		do
			create s.make_empty
			append_html_header (req, s)

			s.append ("Anonymous visitor ...<br/>")

			append_html_login (req, s)
			append_html_menu (Void, req, s)
			append_html_footer (req, s)

			create page.make
			page.set_body (s)
			res.send (page)
		end

	handle_unauthorized (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Restricted page, authenticated user is required.
			-- Send `a_description' as part of the response.
		local
			h: HTTP_HEADER
			s: STRING
			page: WSF_HTML_PAGE_RESPONSE
		do
			create s.make_from_string (a_description)

			append_html_login (req, s)
			append_html_menu (Void, req, s)
			append_html_footer (req, s)

			create page.make
			page.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			page.header.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate,
					"Basic realm=%"Please enter a valid username and password (demo [" + html_encoder.encoded_string (demo_credential) + "])%""
					--| warning: for this example: a valid credential is provided in the message, of course that for real application.
				)
			page.set_body (s)
			res.send (page)
		end

feature -- Helper

	append_html_header (req: WSF_REQUEST; s: STRING)
			-- Append header paragraph to `s'.
		do
			s.append ("<p>The current page is " + html_encoder.encoded_string (req.path_info) + "</p>")
		end

	append_html_menu (a_username: detachable READABLE_STRING_32; req: WSF_REQUEST; s: STRING)
			-- Append menu to `s'.
			-- when an user is authenticated, `a_username' is attached.
		do
			if a_username /= Void then
				s.append ("<li><a href=%""+ req.absolute_script_url ("") +"%">Your account</a> (displayed only is user is authenticated!)</li>")
			end
			s.append ("<li><a href=%""+ req.absolute_script_url ("") +"%">home</a></li>")
			s.append ("<li><a href=%""+ req.script_url ("/public/area") +"%">public area</a></li>")
			s.append ("<li><a href=%""+ req.script_url ("/protected/area") +"%">protected area</a></li>")
		end

	append_html_login (req: WSF_REQUEST; s: STRING)
			-- Append login link to `s'.
		do
			s.append ("<li><a href=%""+ req.script_url ("/login") +"%">sign in</a></li>")
		end

	append_html_logout (a_username: detachable READABLE_STRING_32; req: WSF_REQUEST; s: STRING)
			-- Append logout link to `s'.
		local
			l_logout_url: STRING
		do
			l_logout_url := req.absolute_script_url ("/login")
			l_logout_url.replace_substring_all ("://", "://_@") -- Hack to clear http authorization, i.e connect with bad username "_".
			s.append ("<li><a href=%""+ l_logout_url +"%">logout</a></li>")
		end

	append_html_footer (req: WSF_REQUEST; s: STRING)
			-- Append html footer to `s'.
		local
			hauth: HTTP_AUTHORIZATION
		do
			s.append ("<hr/>")
			if attached req.http_authorization as l_http_authorization then
				s.append ("Has <em>Authorization:</em> header: ")
				create hauth.make (req.http_authorization)
				if attached hauth.login as l_login then
					s.append (" login=<strong>" + html_encoder.encoded_string (l_login)+ "</strong>")
				end
				if attached hauth.password as l_password then
					s.append (" password=<strong>" + html_encoder.encoded_string (l_password)+ "</strong>")
				end
				s.append ("<br/>")
			end
			if attached req.raw_header_data as l_header then
					-- Append the raw header data for information
				s.append ("Raw header data:")
				s.append ("<pre>")
				s.append (l_header)
				s.append ("</pre>")
			end
		end

end
