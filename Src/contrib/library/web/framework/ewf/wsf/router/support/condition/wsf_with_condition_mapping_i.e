note
	description: "Summary description for WSF_WITH_CONDITION_MAPPING_I."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_WITH_CONDITION_MAPPING_I

inherit
	WSF_ROUTER_MAPPING

	WSF_SELF_DOCUMENTED_ROUTER_MAPPING

feature {NONE} -- Initialization

	make (a_condition: like condition; h: like handler)
		do
			set_handler (h)
			condition := a_condition
		end

feature -- Access

	condition: WSF_ROUTING_CONDITION

	associated_resource: READABLE_STRING_8
			-- Name (URI, or URI template or regular expression or ...) of handled resource
		do
			if attached condition_description as desc and then desc.is_valid_as_string_8 then
				Result := desc.to_string_8
			else
				Result := description
			end
		end

feature -- Access

	condition_description: detachable READABLE_STRING_32

feature -- Element change	

	set_condition_description (desc: detachable READABLE_STRING_GENERAL)
		do
			if desc = Void then
				condition_description := Void
			else
				condition_description := desc.as_string_32
			end
		end

	set_handler	(h: like handler)
			-- Set `handler' to `h'.
		require
			h_attached: h /= Void
		deferred
		ensure
			h_aliased: handler = h
		end

feature -- Documentation

	description: STRING_32 = "With-Condition"

feature -- Status

	is_mapping (a_path: READABLE_STRING_8; req: WSF_REQUEST; a_router: WSF_ROUTER): BOOLEAN
			-- <Precursor>
		do
			Result := condition.accepted (req)
		end

	try (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE; sess: WSF_ROUTER_SESSION; a_router: WSF_ROUTER)
			-- <Precursor>
		do
			if condition.accepted (req) then
				sess.set_dispatched_handler (handler)
				a_router.execute_before (Current)
				execute_handler (handler, req, res)
				a_router.execute_after (Current)
			end
		end

feature {NONE} -- Execution

	execute_handler (h: like handler; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler `h' with `req' and `res' for Current mapping.
		require
			h_attached: h /= Void
			req_attached: req /= Void
			res_attached: res /= Void
			path_validate_condition: condition.accepted (req)
		deferred
		end

invariant

	condition_attached: condition /= Void

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
