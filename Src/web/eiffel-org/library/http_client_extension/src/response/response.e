note
	description: "Represent and HTTP Response"
	date: "$Date$"
	revision: "$Revision$"

class
	RESPONSE

create
	make

feature {NONE} --Initialization

	make (a_response: HTTP_CLIENT_RESPONSE)
		do
			http_response := a_response
			body := a_response.body
			status := a_response.status
			headers := a_response.headers
			status_message := a_response.status_line
			error_message := a_response.error_message
		ensure
			http_reponse_set: http_response = a_response
			headers_set: headers = a_response.headers
			status_set: status = a_response.status
			status_message_set: status_message = a_response.status_line
			error_message_set: error_message = a_response.error_message
		end

feature -- Access

	status: INTEGER

	status_message: detachable READABLE_STRING_8

	error_message: detachable READABLE_STRING_8

	body: detachable READABLE_STRING_8

	headers: LIST [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]

feature {NONE} -- Implementation

	http_response: HTTP_CLIENT_RESPONSE;

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
