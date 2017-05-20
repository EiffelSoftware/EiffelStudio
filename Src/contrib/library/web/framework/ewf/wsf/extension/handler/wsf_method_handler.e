note

	description: "Conforming handler for any HTTP 1.1 standard method"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"

deferred class	WSF_METHOD_HANDLER

feature -- Method

	do_method (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Respond to `req' using `res'.
		require
			req_not_void: req /= Void
			res_not_void: res /= Void
		deferred
		ensure
			valid_response_for_http_1_0: is_1_0 (req.server_protocol) implies
				valid_response_for_http_1_0 (res.status_code)
			empty_body_for_no_content_response: is_no_content_response (res.status_code) implies is_empty_content (res)
		end

feature -- Contract support

	is_1_0 (a_protocol: READABLE_STRING_8): BOOLEAN
			-- Is `a_protocol' (a variant of) HTTP 1.0?
		require
			a_protocol_not_void: a_protocol /= Void
		do
			Result := a_protocol.count >= 8 and then
				a_protocol.substring (1, 8) ~ "HTTP/1.0"
		end

	valid_response_for_http_1_0 (a_status_code: INTEGER): BOOLEAN
			-- Is `a_status_code' a valid response to HTTP 1.0?
		do
			-- 1XX is forbidden

			-- first approximation
			Result := a_status_code >= {HTTP_STATUS_CODE}.ok
		end

	is_no_content_response (a_status_code: INTEGER): BOOLEAN
			-- Is `a_status_code' one that does not permit an entity in the response?
		do
			inspect
				a_status_code
			when {HTTP_STATUS_CODE}.no_content then
				Result := True
			when {HTTP_STATUS_CODE}.reset_content then
				Result := True
			when {HTTP_STATUS_CODE}.not_modified then
				Result := True
			else
				-- default to False
			end
		end

	is_empty_content (res: WSF_RESPONSE): BOOLEAN
			-- Does `res' not contain an entity?
		require
			res_not_void: res /= Void
		do
			Result := res.transfered_content_length = 0 -- Is that the right measure?
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

