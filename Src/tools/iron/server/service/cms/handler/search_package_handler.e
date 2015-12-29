note
	description: "Summary description for {SEARCH_PACKAGE_HANDLER}."
	author: ""
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
			lst: detachable LIST [IRON_NODE_VERSION_PACKAGE]
			html_vis: HTML_IRON_NODE_ITERATOR
			html: IRON_NODE_HTML_RESPONSE
			l_title: detachable READABLE_STRING_32
			l_found_count: INTEGER
			l_total_count: INTEGER
			kmp: KMP_WILD
			l_url: READABLE_STRING_8
			k: STRING
			l_sort_by: detachable READABLE_STRING_32
		do
			html := new_response_message (req)
			create s.make_empty

			if
				attached iron.database.version_package_sorter_factory as l_sorter_factory and then
				l_sorter_factory.count > 0
			then
				l_sort_by := req.string_item ("sort-by")

				s.append ("<ul class=%"sorters%">")
				s.append ("<strong>Sort by</strong>: ")
				l_url := req.percent_encoded_path_info
				if l_url.has ('?') then
					l_url := l_url + "&sort-by="
				else
					l_url := l_url + "?sort-by="
				end
				across
					l_sorter_factory as ic
				loop
					k := url_encoder.general_encoded_string (ic.key)
					s.append ("<li>")
					s.append (html_encoder.general_encoded_string (ic.key))
					s.append (" ")
					-- FIXME jfiat [2015/12/29] : remove dependency on bootstrap theme!
					if l_sort_by /= Void and then l_sort_by.is_case_insensitive_equal_general (ic.key) then
						s.append ("<span class=%"glyphicon glyphicon-chevron-down%"></span>")
					else
						s.append ("<a href=%"" + l_url + k + "%">")
						s.append ("<span class=%"glyphicon glyphicon-chevron-down%"></span>")
						s.append ("</a>")
					end
					if l_sort_by /= Void and then l_sort_by.is_case_insensitive_equal_general ({STRING_32} "-" + ic.key) then
						s.append ("<span class=%"glyphicon glyphicon-chevron-up%"></span>")
					else
						s.append ("<a href=%"" + l_url + "-" + k + "%">")
						s.append ("<span class=%"glyphicon glyphicon-chevron-up%"></span>")
						s.append ("</a>")
					end
					s.append ("</li>")
				end
				s.append ("</ul>")
			end
			l_search_help := iron.database.version_package_criteria_factory.description

			if
				attached req.string_item ("name") as l_searched_name and then
				not l_searched_name.is_whitespace
			then
				l_title := {STRING_32} "Search for name=%"" + l_searched_name + "%""
				coll := iron.database.version_packages (iron_version (req), 1, 0)
				if coll /= Void then
					l_total_count := coll.count
					create kmp.make_empty
					kmp.disable_case_sensitive
					kmp.set_pattern (l_searched_name)
					lst := coll.items
					from
						lst.start
					until
						lst.after
					loop
						if attached lst.item.name as l_name then
							kmp.set_text (l_name)
							if kmp.pattern_matches then
								lst.forth
							else
								lst.remove
							end
						else
							lst.remove
						end
					end
					l_found_count := lst.count
				end
			elseif
				attached req.string_item ("query") as l_search_query and then
				not l_search_query.is_whitespace
			then
				html.add_parameter (l_search_query, "search_query_text")
				html.add_parameter (l_search_help, "search_query_description")
				html.add_parameter (iron.database.version_package_criteria_factory.short_description, "search_query_short_description")
				l_title := {STRING_32} "Search for query=%"" + l_search_query + "%""
				l_total_count := iron.database.version_packages_count (iron_version (req))
				coll := iron.database.query_version_packages (l_search_query, iron_version (req), 1, 0)
				l_found_count := coll.count
			else
				coll := iron.database.version_packages (iron_version (req), 1, 0)
				if coll /= Void then
					l_total_count := coll.count
					l_found_count := coll.count
				end
			end
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
