note
	description: "Summary description for {WSF_ROUTING_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTING_HANDLER

inherit
	WSF_HANDLER

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			create router.make (n)
		end

feature -- Access

	router: WSF_ROUTER

feature -- Access

	count: INTEGER
			-- Count of maps handled by current
		do
			Result := router.count
		end

	base_url: detachable READABLE_STRING_8
		do
			Result := router.base_url
		end

feature -- Element change

	set_base_url (a_base_url: like base_url)
			-- Set `base_url' to `a_base_url'
			-- make sure no map is already added (i.e: count = 0)
		require
			no_handler_set: count = 0
		do
			router.set_base_url (a_base_url)
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding in `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		local
			sess: WSF_ROUTER_SESSION
		do
			create sess
			router.dispatch (req, res, sess)
			if not sess.dispatched then
				res.put_header ({HTTP_STATUS_CODE}.not_found, <<[{HTTP_HEADER_NAMES}.header_content_length, "0"]>>)
			end
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
