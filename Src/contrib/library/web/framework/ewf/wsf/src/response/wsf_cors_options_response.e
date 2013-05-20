note
	description: "Response to an OPTIONS request, with Cross-Origin Resource Sharing support."
	author: "Olivier Ligt"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Cross-Origin Resource Sharing", "src=http://www.w3.org/TR/cors/", "tag=W3C"

class
	WSF_CORS_OPTIONS_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; a_router: like router)
		do
			request := req
			router := a_router
			create header.make
		end

feature -- Access

	request: WSF_REQUEST
			-- Associated request

	router: WSF_ROUTER
			-- Associated router

	header: HTTP_HEADER
			-- Response' header

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			l_methods: WSF_REQUEST_METHODS
		do
			res.set_status_code ({HTTP_STATUS_CODE}.Ok)
			header.put_content_type ({HTTP_MIME_TYPES}.text_plain)
			header.put_current_date
			header.put_content_length (0)
			if attached request.http_access_control_request_headers as l_headers then
				header.put_access_control_allow_headers (l_headers)
			end
			l_methods := router.allowed_methods_for_request (request)
			if not l_methods.is_empty then
				header.put_allow (l_methods)
				header.put_access_control_allow_methods (l_methods)
			end
			res.put_header_text (header.string)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
