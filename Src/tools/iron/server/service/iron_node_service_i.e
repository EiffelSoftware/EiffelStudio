note
	description: "Summary description for {IRON_NODE_SERVICE_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_SERVICE_I

inherit
	WSF_ROUTED_SKELETON_SERVICE
		undefine
			requires_proxy
		end

	WSF_NO_PROXY_POLICY

	WSF_URI_HELPER_FOR_ROUTED_SERVICE

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

feature {NONE} -- Initialization

	make (a_iron: IRON_NODE; a_server: IRON_NODE_SERVER)
		do
			iron := a_iron
			server := a_server
			initialize_router
		end

feature -- Iron

	iron: IRON_NODE

	server: IRON_NODE_SERVER

feature -- Router setup

	setup_router
			-- Setup `router'
		deferred
		end

feature -- Access

	handle_debug (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: STRING_8
			h: HTTP_HEADER
		do
			if req.is_get_request_method then
				s := "debug"
				create h.make_with_count (1)
				h.put_content_type_text_html
				h.put_content_length (s.count)
				res.put_header_lines (h)
				res.put_string (s)
			else
				create s.make (30_000)
				across
					req.form_parameters as c
				loop
					s.append (c.item.url_encoded_name)
					s.append ("=")
					s.append (c.item.string_representation)
					s.append ("<br/>")
				end
				if s.is_empty then
					req.read_input_data_into (s)
				end
				create h.make_with_count (1)
				h.put_content_type_text_html
				h.put_content_length (s.count)
				res.put_header_lines (h)
				res.put_string (s)
			end
		end

feature -- Handler

	not_yet_implemented_uri_template_handler (msg: READABLE_STRING_8): WSF_URI_TEMPLATE_HANDLER
		do
			create {WSF_URI_TEMPLATE_AGENT_HANDLER} Result.make (agent not_yet_implemented(?, ?, msg))
		end

	not_yet_implemented (req: WSF_REQUEST; res: WSF_RESPONSE; msg: detachable READABLE_STRING_8)
		local
			m: WSF_NOT_IMPLEMENTED_RESPONSE
		do
			create m.make (req)
			if msg /= Void then
				m.set_body (msg)
			end
			res.send (m)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

