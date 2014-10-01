note
	description: "Authentication filter."
	author: "Olivier Ligot"
	date: "$Date$"
	revision: "$Revision$"

class
	AUTHENTICATION_FILTER

inherit
	WSF_FILTER

	WSF_URI_TEMPLATE_HANDLER

	SHARED_DATABASE_API

	SHARED_EJSON

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			l_auth: detachable HTTP_AUTHORIZATION
		do
			if attached req.http_authorization as l_http_authorization then
				create l_auth.make (l_http_authorization)
			end
			if
				l_auth /= Void and then
				l_auth.is_basic and then
				attached l_auth.login as l_auth_login and then
				attached Db_access.user (0, l_auth_login) as l_user and then
				l_auth_login.same_string (l_user.name) and then
				attached l_auth.password as l_auth_password and then
				l_auth_password.same_string (l_user.password)
			then
				req.set_execution_variable ("user", l_user)
				execute_next (req, res)
			else
				handle_unauthorized ("Unauthorized", req, res)
			end
		end

feature {NONE} -- Implementation

	handle_unauthorized (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle forbidden.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_content_length (a_description.count)
			h.put_current_date
			h.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%"User%"")
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
			res.put_string (a_description)
		end

note
	copyright: "2011-2014, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
