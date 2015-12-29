note
	description: "Summary description for {SEARCH_PACKAGE_API_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_PACKAGE_API_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_NODE_API_HANDLER
		rename
			set_iron as make
		end

	WSF_SELF_DOCUMENTED_HANDLER

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				if has_iron_version (req) then
					handle_search_package (req, res)
				else
					res.send (create {WSF_REDIRECTION_RESPONSE}.make (iron.resource (Void, "/")))
				end
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_search_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: WSF_HEADER
			s: detachable STRING
			coll: detachable IRON_NODE_VERSION_PACKAGE_COLLECTION
			lst: LIST [IRON_NODE_VERSION_PACKAGE]
			json_vis: JSON_V1_IRON_NODE_ITERATOR
			l_title: detachable READABLE_STRING_32
			l_found_count: INTEGER
			l_total_count: INTEGER
		do
			if
				attached {WSF_STRING} req.query_parameter ("name") as l_searched_name and then
				not l_searched_name.is_empty
			then
				l_title := {STRING_32} "Search IRON packages with name=%"" + l_searched_name.value + "%""
				coll := iron.database.version_packages (iron_version (req), 1, 0)
				if coll /= Void then
					l_total_count := coll.count
					lst := coll.items
					from
						lst.start
					until
						lst.after
					loop
						if
							attached lst.item.name as l_name and then
							l_name.is_case_insensitive_equal_general (l_searched_name.value)
						then
							lst.forth
						else
							lst.remove
						end
					end
					l_found_count := lst.count
				end
			else
				coll := iron.database.version_packages (iron_version (req), 1, 0)
				if coll /= Void then
					l_total_count := coll.count
					l_found_count := coll.count
				end
			end

			create json_vis.make (req, iron, iron_version (req))
			s := json_vis.package_versions_to_json (coll)

			create h.make
			h.put_content_type_application_json
			h.put_content_length (s.count)
			res.put_header_lines (h)
			res.put_string (s)
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- Documentation associated with Current handler, in the context of the mapping `m' and methods `a_request_methods'.
			--| `m' and `a_request_methods' are useful to produce specific documentation when the handler is used for multiple mapping.
		do
			create Result.make (m)
			Result.add_description ("List existing packages.")
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
