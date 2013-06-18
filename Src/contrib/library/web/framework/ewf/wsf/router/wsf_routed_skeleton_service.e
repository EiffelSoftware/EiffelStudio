note
	description: "Summary description for {WSF_ROUTED_SKELETON_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTED_SKELETON_SERVICE

inherit
	WSF_ROUTED_SERVICE
		redefine
			execute
		end

	WSF_SYSTEM_OPTIONS_ACCESS_POLICY

	WSF_PROXY_USE_POLICY

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- If the service is available, and request URI is not too long, dispatch the request
			-- and if handler is not found, execute the default procedure `execute_default'.
		local
			l_sess: WSF_ROUTER_SESSION
		do
			--| When we reach here, the request has already passed check for 400 (Bad request),
			--|  which is implemented in WSF_REQUEST.make_from_wgi (when it calls `analyze').
			if unavailable then
				handle_unavailable (res)
			elseif requires_proxy (req) then
				handle_use_proxy (req, res)
			elseif 
				maximum_uri_length > 0 and then 
				req.request_uri.count.to_natural_32 > maximum_uri_length 
			then
				handle_request_uri_too_long (res)
			elseif 
					req.is_request_method ({HTTP_REQUEST_METHODS}.method_options) and then
					req.request_uri.same_string ("*") 
			then
				handle_server_options (req, res)
			else
				create l_sess
				router.dispatch (req, res, l_sess)
				if not l_sess.dispatched then
					execute_default (req, res)
				end
			end
		end

feature -- Measurement

	maximum_uri_length: NATURAL
			-- Maximum length in characters (or zero for no limit) permitted
			-- for {WSF_REQUEST}.request_uri

feature -- Status report

	unavailable: BOOLEAN
			-- Is service currently unavailable?

	unavailablity_message: detachable READABLE_STRING_8
			-- Message to be included as text of response body for {HTTP_STATUS_CODE}.service_unavailable

	unavailability_duration: NATURAL
			-- Delta seconds for service unavailability (0 if not known)

	unavailable_until: detachable DATE_TIME
			-- Time at which service becomes available again (if known)

feature -- Status setting

	set_available
			-- Set `unavailable' to `False'.
		do
			unavailable := False
			unavailablity_message := Void
			unavailable_until := Void
		ensure
			available: unavailable = False
			unavailablity_message_detached: unavailablity_message = Void
			unavailable_until_detached: unavailable_until = Void
		end

	set_unavailable (a_message: READABLE_STRING_8; a_duration: NATURAL; a_until: detachable DATE_TIME)
			-- Set `unavailable' to `True'.
		require
			a_message_attached: a_message /= Void
			a_duration_xor_a_until: a_duration > 0 implies a_until = Void
		do
			unavailable := True
			unavailablity_message := a_message
			unavailability_duration := a_duration
		ensure
			unavailable: unavailable = True
			unavailablity_message_aliased: unavailablity_message = a_message
			unavailability_duration_set: unavailability_duration = a_duration
			unavailable_until_aliased: unavailable_until = a_until
		end

	set_maximum_uri_length (a_len: NATURAL)
			-- Set `maximum_uri_length' to `a_len'.
			-- Can pass zero to mean no restrictions.
		do
			maximum_uri_length := a_len
		ensure
			maximum_uri_length_set: maximum_uri_length = a_len
		end

feature {NONE} -- Implementation

	handle_unavailable (res: WSF_RESPONSE)
			-- Write "Service unavailable" response to `res'.
		require
			unavailable: unavailable
			res_attached: res /= Void
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			check attached unavailablity_message as m then
					-- invariant `unavailability_message_attached' plus precondition `unavailable'
				h.put_content_length (m.count)
				h.put_current_date
				res.set_status_code ({HTTP_STATUS_CODE}.service_unavailable)
				if unavailability_duration > 0 then
					h.put_header_key_value ({HTTP_HEADER_NAMES}.header_retry_after, unavailability_duration.out)
				elseif attached unavailable_until as u then
						h.put_header_key_value ({HTTP_HEADER_NAMES}.header_retry_after,
							h.date_to_rfc1123_http_date_format (u))
				end
				res.put_header_text (h.string)
				res.put_string (m)
			end
		ensure
			response_status_is_set: res.status_is_set
			status_is_service_unavailable: res.status_code = {HTTP_STATUS_CODE}.service_unavailable
			body_sent: res.message_committed and then res.transfered_content_length > 0
			body_content_was_unavailablity_message: True -- doesn't seem to be any way to check
		end

	handle_request_uri_too_long (res: WSF_RESPONSE)
			-- Write "Request URI too long" response into `res'.
		require
			res_attached: res /= Void
		local
			h: HTTP_HEADER
			m: READABLE_STRING_8
		do
			create h.make
			h.put_content_type_text_plain
			h.put_current_date
			m := "Maximum permitted length for request URI is " + maximum_uri_length.out + " characters"
			h.put_content_length (m.count)
			res.set_status_code ({HTTP_STATUS_CODE}.request_uri_too_long)
			res.put_header_text (h.string)
			res.put_string (m)
		ensure
			response_status_is_set: res.status_is_set
			status_is_request_uri_too_long: res.status_code = {HTTP_STATUS_CODE}.request_uri_too_long
			body_sent: res.message_committed and then res.transfered_content_length > 0
		end

	frozen handle_server_options (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write response to OPTIONS * into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			method_is_options: req.is_request_method ({HTTP_REQUEST_METHODS}.method_options)
			server_options_requested: req.request_uri.same_string ("*")
		do
			--| First check if forbidden.
			--| (N.B. authentication requires an absoluteURI (RFC3617 page 3), and so cannot be used for OPTIONS *.
			--| Otherwise construct an Allow response automatically from the router.
			if is_system_options_forbidden (req) then
				handle_system_options_forbidden (req, res)
			else
				handle_system_options (req, res)
			end
		ensure
			response_status_is_set: res.status_is_set
			valid_response_code: res.status_code = {HTTP_STATUS_CODE}.forbidden or
				res.status_code = {HTTP_STATUS_CODE}.not_found or res.status_code = {HTTP_STATUS_CODE}.ok
			header_sent: res.header_committed and res.message_committed
		end

	frozen handle_system_options_forbidden (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write a 403 Forbidden or a 404 Not found response into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			method_is_options: req.is_request_method ({HTTP_REQUEST_METHODS}.method_options)
			server_options_requested: req.request_uri.same_string ("*")
		local
			m: detachable READABLE_STRING_8
			h: HTTP_HEADER
		do
			m := system_options_forbidden_text (req)
			if attached {READABLE_STRING_8} m as l_msg then
				create h.make
				h.put_content_type_text_plain
				h.put_current_date
				h.put_content_length (l_msg.count)
				res.set_status_code ({HTTP_STATUS_CODE}.forbidden)
				res.put_header_text (h.string)
				res.put_string (l_msg)
			else
				create h.make
				h.put_content_type_text_plain
				h.put_current_date
				h.put_content_length (0)
				res.set_status_code ({HTTP_STATUS_CODE}.not_found)
				res.put_header_text (h.string)
			end
		ensure
			response_status_is_set: res.status_is_set
			valid_response_code: res.status_code = {HTTP_STATUS_CODE}.forbidden or
				res.status_code = {HTTP_STATUS_CODE}.not_found
			header_sent: res.header_committed
			message_sent: res.message_committed
		end

	handle_system_options (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write response to OPTIONS * into `res'.
			-- This may be redefined by the user, but normally this will not be necessary.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			method_is_options: req.is_request_method ({HTTP_REQUEST_METHODS}.method_options)
			server_options_requested: req.request_uri.same_string ("*")
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_current_date
			h.put_allow (router.all_allowed_methods)
			h.put_content_length (0)
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
		ensure
			response_status_is_set: res.status_is_set
			response_code_ok: res.status_code = {HTTP_STATUS_CODE}.ok
			header_sent: res.header_committed and res.message_committed
			empty_body: res.transfered_content_length = 0
		end

	frozen handle_use_proxy (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write Use Proxy response `res'.
		require
			res_attached: res /= Void
			req_attached: req /= Void
			proxy_required: requires_proxy (req)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_current_date
			h.put_location (proxy_server (req).string)
			h.put_content_length (0)
			res.put_header_lines (h)
			res.set_status_code ({HTTP_STATUS_CODE}.use_proxy)
		ensure
			response_status_is_set: res.status_is_set
			response_code_use_proxy: res.status_code = {HTTP_STATUS_CODE}.use_proxy
		end

invariant

	unavailability_message_attached: unavailable implies attached unavailablity_message as m and then
		m.count > 0
	unavailability_duration_xor_unavailable_until: unavailability_duration > 0 implies unavailable_until = Void

;note
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
