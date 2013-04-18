note
	description: "Authentication filter."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPO_AUTH_FILTER_HANDLER [G -> WSF_HANDLER]

inherit
	WSF_FILTER_HANDLER [G]

feature {NONE} -- Initialization

	make (i: like iron)
		do
			iron := i
		end

	make_with_next (i: like iron; n: like next)
		do
			make (i)
			set_next (n)
		end

	iron: IRON_REPO

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			l_auth: HTTP_AUTHORIZATION
		do
			create l_auth.make (req.http_authorization)
			if
				attached l_auth.is_basic and then
				attached l_auth.login as u and then
				attached l_auth.password as p and then
				iron.database.is_valid_credential (u, p) and then
				attached iron.database.user (u) as l_user
			then
				req.set_execution_variable ("{IRON_REPO}.user", l_user)
				execute_next (req, res)
			else
				handle_unauthorized ("Unauthorized", req, res)
			end
		end

	execute_next (req: WSF_REQUEST; res: WSF_RESPONSE)
		deferred
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
	copyright: "2011-2013, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
