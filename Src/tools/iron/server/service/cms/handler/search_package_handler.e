note
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_PACKAGE_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_NODE_HANDLER
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
					res.send (create {WSF_REDIRECTION_RESPONSE}.make (iron.page (Void, "/")))
				end
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_search_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: detachable STRING
			l_search_help: detachable STRING
			coll: detachable IRON_NODE_VERSION_PACKAGE_COLLECTION
			html_vis: HTML_IRON_NODE_ITERATOR
			html: IRON_NODE_HTML_RESPONSE
			l_title, l_desc: detachable READABLE_STRING_32
			l_desc_html, l_link_attribs: detachable STRING
			l_found_count: INTEGER
			l_total_count: INTEGER
			k: STRING
			l_search_query, l_sort_by: detachable READABLE_STRING_32
			l_uri, l_sort_uri: URI
		do
			html := new_response_message (req)
			create s.make_empty
			l_sort_by := req.string_item ("sort-by")
			if l_sort_by /= Void then
				if l_sort_by.is_whitespace then
					l_sort_by := Void
				else
					html.add_parameter (l_sort_by, "search_sort_by")
				end
			end
--			if l_sort_by = Void then
--				l_sort_by := "name"
--			end
			l_search_query := req.string_item ("query")
			if l_search_query /= Void and then l_search_query.is_whitespace then
				l_search_query := Void
			end
			if l_search_query = Void then
				if attached req.string_item ("name") as l_search_name and then not l_search_name.is_whitespace then
					l_search_query := {STRING_32} "name:%"" + l_search_name + "%""
				end
				if attached req.string_item ("title") as l_search_title and then not l_search_title.is_whitespace then
					l_search_query := {STRING_32} "title:%"" + l_search_title + "%""
				end
				if attached req.string_item ("tag") as l_search_tag and then not l_search_tag.is_whitespace then
					l_search_query := {STRING_32} "tag:" + l_search_tag
				end
			end

			create l_uri.make_from_string (req.percent_encoded_path_info)
			if l_search_query /= Void then
				l_uri.add_query_parameter ("query", l_search_query)
			end

			if
				attached iron.database.version_package_sorter_factory as l_sorter_factory and then
				l_sorter_factory.count > 0
			then
				s.append ("<ul class=%"sorters%">")
				s.append ("<strong>Sort by</strong>: ")
--				check sort_by_is_attached: l_sort_by /= Void end
				across
					l_sorter_factory as ic
				loop
					create l_link_attribs.make (0)
					l_desc := l_sorter_factory.sorter_description (@ ic.key)
					if l_desc /= Void then
						l_desc_html := html_encoder.general_encoded_string (l_desc)
						l_desc_html.replace_substring_all ("%N", "<br/>")
						if l_desc_html /= Void and then not l_desc_html.is_whitespace then
							l_link_attribs.append (" title=%"" + l_desc_html + "%"")
							l_link_attribs.append (" class=%"iron-tooltip%"")
						end
					end
					k := url_encoder.general_encoded_string (@ ic.key)
					create l_sort_uri.make_from_uri (l_uri)
					-- FIXME jfiat [2015/12/29] : remove dependency on bootstrap theme!
					if l_sort_by = Void then
							-- No specific sort!
							-- same as in the `else' part.
						s.append ("<li>")
						l_sort_uri.add_query_parameter ("sort-by", k)
						s.append ("<a href=%"" + l_sort_uri.string + "%"")
						s.append (l_link_attribs)
						s.append (">")
					elseif l_sort_by.is_case_insensitive_equal_general (@ ic.key) then
						s.append ("<li class=%"active%">")
						l_sort_uri.add_query_parameter ("sort-by", {STRING_32} "-" + k)
						s.append ("<a href=%"" + l_sort_uri.string + "%"")
						s.append (l_link_attribs)
						s.append (">")
						s.append ("<span class=%"glyphicon glyphicon-chevron-up%"></span> ")
					elseif l_sort_by.is_case_insensitive_equal_general ({STRING_32} "-" + @ ic.key) then
						s.append ("<li class=%"active%">")
						l_sort_uri.add_query_parameter ("sort-by", k)
						s.append ("<a href=%"" + l_sort_uri.string + "%"")
						s.append (l_link_attribs)
						s.append (">")
						s.append ("<span class=%"glyphicon glyphicon-chevron-down%"></span> ")
					else
						s.append ("<li>")
						l_sort_uri.add_query_parameter ("sort-by", k)
						s.append ("<a href=%"" + l_sort_uri.string + "%"")
						s.append (l_link_attribs)
						s.append (">")
					end
					s.append (k)
					s.append ("</a>")
					s.append ("</li>")
				end
				s.append ("</ul>")
			end
			l_search_help := iron.database.version_package_criteria_factory_description
			if
				l_search_query /= Void
			then
				html.add_parameter (l_search_query, "search_query_text")
				html.add_parameter (l_search_help, "search_query_description")
				html.add_parameter (iron.database.version_package_criteria_factory.short_description, "search_query_short_description")
				l_title := {STRING_32} "Results for %"" + l_search_query + "%""
				l_total_count := iron.database.version_packages_count (iron_version (req))
				coll := iron.database.query_version_packages (l_search_query, iron_version (req), 1, 0)
				l_found_count := coll.count
			else
				coll := iron.database.version_packages (iron_version (req), 1, 0)
				if coll /= Void then
					l_total_count := coll.count
					l_found_count := coll.count
				end
				if l_sort_by = Void then
					l_sort_by := "name"
				end
			end

			s.append ("<div>Found " + l_found_count.out + " out of " + l_total_count.out + " items.</div>")

			if coll /= Void and then coll.count > 0 then
				if
					l_sort_by /= Void and then
					attached iron.database.version_package_sorter_factory.sorter (l_sort_by) as l_sorter
				then
					if l_sorter.is_reversed then
						coll.reverse_sort_with (l_sorter.sorter)
					else
						coll.sort_with (l_sorter.sorter)
					end
				end

				create html_vis.make (s, req, iron, iron_version (req))
				html_vis.set_user (current_user (req))
				html_vis.visit_package_version_iterable (coll)
			end

				-- Create new package
			if l_title /= Void then
				html.set_title (html.html_encoded_string (l_title))
			else
				html.set_title ("All packages (version " + iron_version (req).value + ")")
			end
			s.append ("<div>Found " + l_found_count.out + " out of " + l_total_count.out + " items.</div>")
			if l_search_help /= Void then
				s.append ("<div id=%"advanced-help%"><strong>Advanced search help:</strong>")
				s.append ("<pre>")
				s.append (html_encoder.encoded_string (l_search_help))
				s.append ("</pre></div>")
			end
			html.set_body (s)
			res.send (html)
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
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
