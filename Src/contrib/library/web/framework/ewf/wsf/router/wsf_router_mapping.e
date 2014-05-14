note
	description: "[
				Describes a route or mapping for the WSF_ROUTER
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTER_MAPPING

inherit
	DEBUG_OUTPUT

feature {NONE} -- Initialization

	make (a_resource: READABLE_STRING_8; h: like handler)
			-- Create mapping based on resource `a_resource' and handler `h'.
		require
			a_resource_attached: a_resource /= Void
			h_attached: h /= Void
		deferred
		end

feature -- Access

	associated_resource: READABLE_STRING_8
			-- Name (URI, or URI template or regular expression or ...) of handled resource
		deferred
		ensure
			assciated_resource_not_void: Result /= Void
		end

	handler: WSF_HANDLER
			-- Handler associated with `Current' mapping
		deferred
		ensure
			handler_attached: Result /= Void
		end

feature -- Documentation

	description: READABLE_STRING_32
			-- Short description of associated mapping
		deferred
		ensure
			description_attached: Result /= Void
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := description + {STRING_32} " : " + associated_resource.to_string_32
		end

feature -- Status

	is_mapping (req: WSF_REQUEST; a_router: WSF_ROUTER): BOOLEAN
			-- Does `Current' accept `req' when using `a_router'?
		require
			req_attached: req /= Void
			a_router_attached: a_router /= Void
		deferred
		end

	try (req: WSF_REQUEST; res: WSF_RESPONSE; sess: WSF_ROUTER_SESSION; a_router: WSF_ROUTER)
			-- Try using `Current' mapping and if it matches request `req'
			-- execute associated handler and set this handler in session `sess'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			sess_attached: sess /= Void
			a_router_attached: a_router /= Void
		deferred
		end

feature -- Helper

	path_from_request (req: WSF_REQUEST): READABLE_STRING_8
			-- Path used by `Current' to check that mapping matches request `req'
		require
			req_attached: req /= Void
		do
			Result := req.percent_encoded_path_info
		ensure
			path_from_request_attached: Result /= Void
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
