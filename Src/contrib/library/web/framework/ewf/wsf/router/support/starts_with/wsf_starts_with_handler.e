note
	description: "Summary description for {WSF_STARTS_WITH_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_STARTS_WITH_HANDLER

inherit
	WSF_HANDLER

	WSF_ROUTER_MAPPING_FACTORY

feature -- Execution

	execute (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle `req' responding into `res'.
		require
			a_start_path_attached: a_start_path /= Void
			req_attached: req /= Void
			res_attached: res /= Void
			path_start_with_a_start_path: req.path_info.starts_with (a_start_path)
		deferred
		end

feature {WSF_ROUTER} -- Mapping

	new_mapping (a_uri: READABLE_STRING_8): WSF_ROUTER_MAPPING
			-- <Precursor>
		do
			create {WSF_STARTS_WITH_MAPPING} Result.make (a_uri, Current)
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
