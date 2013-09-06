note

	description: "[
						Default policy for responing to OPTIONS requests other than OPTIONS*
                  By overriding `execute_options', clients can add a body, for example.
						]"
	date: "$Date$"
	revision: "$Revision$"

class WSF_OPTIONS_POLICY

feature -- Basic operations

	execute_options (req: WSF_REQUEST; res: WSF_RESPONSE; a_router: WSF_ROUTER)
			-- Write response to `req' into `res'.
		require
			req_attached: req /= Void
			options_request: req.is_request_method ({HTTP_REQUEST_METHODS}.method_options)
			res_attached: res /= Void
			a_router_attached: a_router /= Void
		local
			l_methods: WSF_REQUEST_METHODS
			h: HTTP_HEADER
		do
			create h.make
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			h.put_content_type ({HTTP_MIME_TYPES}.text_plain)
			h.put_current_date
			h.put_content_length (0)
			l_methods := a_router.allowed_methods_for_request (req)
			if not l_methods.is_empty then
				h.put_allow (l_methods)
			end
			res.put_header_text (h.string)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
