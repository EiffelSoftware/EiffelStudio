note
	description: "Summary description for {REQUEST_EXECUTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REQUEST_EXECUTOR

inherit
	HTTP_CLIENT_HELPER

	HTTP_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_url: like base_url; a_method: READABLE_STRING_8)
		do
			set_base_url (a_url)
			verb := a_method
			create context_executor.make
		ensure
			base_url_set: base_url = a_url
			method_set: verb = a_method
		end

	set_base_url (a_url: like base_url)
			-- Set base_url with `a_url'
		do
			base_url := a_url
		ensure
			base_url_set: base_url = a_url
		end

feature -- Access

	verb: READABLE_STRING_8
			-- HTTP METHOD (Get, Post, ...)

	body: detachable READABLE_STRING_8
			-- body content

feature -- Element Change

	set_body (a_body: like body)
			-- Set body with `a_body'.
		do
			body := a_body
		ensure
			body_set: body = a_body
		end

feature -- Execute

	execute: detachable HTTP_CLIENT_RESPONSE
			-- Http executor
		do
			if verb.same_string (method_connect) then
				Result := Void -- not supported for now
			elseif verb.same_string (method_delete) then
				Result := execute_delete ("")
			elseif verb.same_string (method_get) then
				Result := execute_get ("")
			elseif verb.same_string (method_head) then
				Result := Void
			elseif verb.same_string (method_options) then
				Result := Void
			elseif verb.same_string (method_patch) then
				Result := Void
			elseif verb.same_string (method_post) then
				Result := execute_post ("", body)
			elseif verb.same_string (method_put) then
				Result := execute_put ("", body)
			elseif verb.same_string (method_trace) then
				Result := Void
			end
		end

note
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
