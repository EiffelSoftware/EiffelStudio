note
	description: "Authentication filter."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_AUTH_FILTER_API_HANDLER [G -> WSF_HANDLER]

inherit
	WSF_FILTER_HANDLER [G]

	IRON_NODE_API_HANDLER
		rename
			set_iron as make
		end

	SHARED_HTML_ENCODER

feature {NONE} -- Initialization

	make_with_next (i: like iron; n: like next)
		do
			make (i)
			set_next (n)
		end

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			l_auth: detachable HTTP_AUTHORIZATION
		do
			if attached req.http_authorization as l_req_http_auth then
				create l_auth.make (l_req_http_auth)
			end
			if
				l_auth /= Void and then
				attached l_auth.is_basic and then
				attached l_auth.login as u and then
				attached l_auth.password as p
			then
				if
					iron.database.is_valid_credential (u, p) and then
					attached iron.database.user (u) as l_user
				then
					req.set_execution_variable ("{IRON_REPO}.user", l_user)
					execute_next (req, res)
				else
					req.set_execution_variable ("{IRON_REPO}.user", Void)
					handle_unauthorized ("Unauthorized user " + html_encoder.encoded_string (u), req, res)
				end
			else
				req.set_execution_variable ("{IRON_REPO}.user", Void)
				handle_unauthorized ("Unauthorized", req, res)
			end
		end

	execute_next (req: WSF_REQUEST; res: WSF_RESPONSE)
		deferred
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- <Precursor>
		do
			create Result.make (m)
			Result.set_is_hidden (True)
			Result.add_description ("Authorization filtering...")
		end

feature {NONE} -- Implementation

	handle_unauthorized (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle forbidden.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_current_date
			h.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%"User%"")

			h.put_content_type_text_plain
			h.put_content_length (a_description.count)
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
			res.put_string (a_description)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
