note
	description: "Summary description for {WSF_URI_TEMPLATE_MAPPING_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_URI_TEMPLATE_MAPPING_I

inherit
	WSF_ROUTER_MAPPING

	WSF_SELF_DOCUMENTED_ROUTER_MAPPING

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8; h: like handler)
			-- <Precursor>
		do
			make_from_template (create {URI_TEMPLATE}.make (s), h)
		end

	make_from_template (tpl: URI_TEMPLATE; h: like handler)
			-- Create with `h' as the handler for resources matching `tpl'
		require
			tpl_attached: tpl /= Void
			h_attached: h /= Void
		do
			template := tpl
			set_handler (h)
		ensure
			tpl_aliased: template = tpl
		end

feature -- Access		

	associated_resource: READABLE_STRING_8
			-- URI template text of handled resource
		do
			Result := template.template
		end

	template: URI_TEMPLATE

feature -- Change

	set_handler (h: like handler)
			-- Set `handler' to `h'.
		require
			h_attached: h /= Void
		deferred
		end

feature -- Documentation

	description: STRING_32 = "Match-URI-Template"

feature -- Status

	is_mapping (a_path: READABLE_STRING_8; req: WSF_REQUEST; a_router: WSF_ROUTER): BOOLEAN
			-- <Precursor>
		local
			tpl: URI_TEMPLATE
		do
			tpl := based_uri_template (template, a_router)
			Result := tpl.match (a_path) /= Void
		end

	try (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE; sess: WSF_ROUTER_SESSION; a_router: WSF_ROUTER)
			-- <Precursor>
		local
			tpl: URI_TEMPLATE
			new_src: detachable WSF_REQUEST_PATH_PARAMETERS_PROVIDER
		do
			tpl := based_uri_template (template, a_router)
			if attached tpl.match (a_path) as tpl_res then
				sess.set_dispatched_handler (handler)
				a_router.execute_before (Current)
					--| Applied the context to the request
					--| in practice, this will fill the {WSF_REQUEST}.path_parameters
				create new_src.make (tpl_res.path_variables.count, tpl_res.path_variables)
				new_src.apply (req)
				execute_handler (handler, req, res)
					--| Revert {WSF_REQUEST}.path_parameters_source to former value
					--| In case the request object passed by other handler that alters its values.
				new_src.revert (req)
				a_router.execute_after (Current)
			end
		rescue
			if new_src /= Void then
				new_src.revert (req)
			end
		end

feature {NONE} -- Execution

	execute_handler (h: like handler; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Run `h' to execute `req' responding in `res'.
		require
			h_attached: h /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		deferred
		end

feature {NONE} -- Implementation

	based_uri_template (a_tpl: like template; a_router: WSF_ROUTER): like template
			-- Version of `a_tpl' using bas URI of `a_router'
		require
			a_tpl_attached: a_tpl /= Void
			a_router_attached: a_router /= Void
		do
			if attached a_router.base_url as l_base_url then
				Result := a_tpl.duplicate
				Result.set_template (l_base_url + a_tpl.template)
			else
				Result := a_tpl
			end
		ensure
			based_uri_template_attached: Result /= Void
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
