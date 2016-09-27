note
	description: "Summary description for {HTTP_CLIENT_HELPER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTP_CLIENT_HELPER

feature -- Access

	http_session: detachable HTTP_CLIENT_SESSION

	get_http_session
		local
			h: DEFAULT_HTTP_CLIENT
			b: like base_url
		do
			create h
			b := base_url
			if b = Void then
				b := ""
			end
			base_url.left_adjust
			base_url.right_justify
			if attached {HTTP_CLIENT_SESSION} h.new_session (base_url) as sess then
				http_session := sess
				sess.set_timeout (-1)
				sess.set_connect_timeout (-1)
				sess.set_is_insecure (True)
				sess.set_any_auth_type
				debug ("curl")
					sess.set_is_debug (True)
				end
				debug ("proxy8888")
					sess.set_proxy ("127.0.0.1", 8888) --| inspect traffic with http://www.fiddler2.com/					
				end
			end
		end

feature -- HTTP client helpers

	execute_get (command_name: READABLE_STRING_8): detachable HTTP_CLIENT_RESPONSE
		do
			get_http_session
			if attached http_session as sess then
				Result := sess.get (command_name, context_executor)
			end
		end

	execute_post (command_name: READABLE_STRING_8; data: detachable READABLE_STRING_8): detachable HTTP_CLIENT_RESPONSE
		do
			get_http_session
			if attached http_session as sess then
				Result := sess.post (command_name, context_executor, data)
			end
		end

	execute_delete (command_name: READABLE_STRING_8): detachable HTTP_CLIENT_RESPONSE
		do
			get_http_session
			if attached http_session as sess then
				Result := sess.delete (command_name, context_executor)
			end
		end

	execute_put (command_name: READABLE_STRING_8; data: detachable READABLE_STRING_8): detachable HTTP_CLIENT_RESPONSE
		do
			get_http_session
			if attached http_session as sess then
				Result := sess.put (command_name, context_executor, data)
			end
		end

feature -- Context Executor

	context_executor: HTTP_CLIENT_REQUEST_CONTEXT
			-- request context for each request

	base_url: STRING
			-- URL

;note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
