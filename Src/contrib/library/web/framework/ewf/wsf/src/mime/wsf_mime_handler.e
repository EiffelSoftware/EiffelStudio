note
	description: "Summary description for {WSF_MIME_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_MIME_HANDLER

feature -- Status report

	valid_content_type (a_content_type: HTTP_CONTENT_TYPE): BOOLEAN
		deferred
		end

feature -- Execution

	handle (a_content_type: HTTP_CONTENT_TYPE; req: WSF_REQUEST;
			a_vars: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL]; a_raw_data: detachable CELL [detachable STRING_8])
			-- Handle MIME content from request `req', eventually fill the `a_vars' (not yet available from `req')
			-- and if `a_raw_data' is attached, store any read data inside `a_raw_data'
		require
			valid_content_type: valid_content_type (a_content_type)
		deferred
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
