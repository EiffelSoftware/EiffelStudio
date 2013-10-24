note

	description: "[
						Policy-driven helpers to implement PUT.
					  ]"
	date: "$Date$"
	revision: "$Revision$"

class WSF_PUT_HELPER

inherit

	WSF_METHOD_HELPER
		redefine
			execute_new_resource
		end

feature -- Basic operations

	execute_new_resource (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER)
			-- Write response to non-existing resource requested by  `req.' into `res'.
			-- Policy routines are available in `a_handler'.
		do
			if a_handler.treat_as_moved_permanently (req) then
				handle_redirection_error (req, res, a_handler.previous_location (req), {HTTP_STATUS_CODE}.moved_permanently)
			else
				check attached {HTTP_HEADER} req.execution_variable (a_handler.Negotiated_http_header_execution_variable) as h then
						-- postcondition header_attached of `handle_content_negotiation'
					send_response (req, res, a_handler, h, True)
				end
			end
		end

feature {NONE} -- Implementation

	send_response (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER; a_header: HTTP_HEADER; a_new_resource: BOOLEAN)
			-- Write response to `req' into `res' in accordance with `a_media_type' etc. as a new URI.
		local
			l_code: NATURAL
		do
			a_handler.read_entity (req)
			if a_handler.is_entity_too_large (req) then
				handle_request_entity_too_large (req, res, a_handler)
			else
				a_handler.check_content_headers (req)
				l_code := a_handler.content_check_code (req)
				if l_code /= 0 then
					if l_code = 415 then
						handle_unsupported_media_type (req, res)
					else
						handle_not_implemented (req, res)
					end
				else
					a_handler.check_request (req, res)
					if a_handler.request_check_code (req) = 0 then
						if a_new_resource then
							a_handler.create_resource (req, res)
							-- 201 or 500 (add support for this?)
						else
							a_handler.check_conflict (req, res)
							if a_handler.conflict_check_code (req) = 0 then
								a_handler.update_resource (req, res)
								-- 204 or 500 (add support for this?)
								-- FIXME: more support, such as includes_response_entity
							end
						end
					end
				end
			end
		end

note
	copyright: "2011-2013, Colin Adams, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
