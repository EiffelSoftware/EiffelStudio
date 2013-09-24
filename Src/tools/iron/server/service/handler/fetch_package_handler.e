note
	description: "Summary description for {FETCH_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FETCH_PACKAGE_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_REPO_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				handle_fetch_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_fetch_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
--			md: WSF_DOWNLOAD_RESPONSE
			md: WSF_FORCE_DOWNLOAD_RESPONSE
--			md: WSF_FILE_RESPONSE
			m: like new_response_message
			s: STRING
			v: STRING_32
			u: FILE_UTILITIES
		do
			create v.make_empty
			if
				attached {WSF_TABLE} req.path_parameter ("vars") as l_vars
			then
				across
					l_vars as c
				loop
					if attached {WSF_STRING} c.item as v_string and then not v_string.is_empty then
						v.append_character ('/')
						v.append (v_string.value)
					end
				end
			end
			if attached iron.database.package_by_path (iron_version (req), v) as l_package then
				if
					attached l_package.archive_path as l_archive_path and then
					u.file_path_exists (l_archive_path)
				then
					create md.make (l_archive_path.utf_8_name)
					md.set_no_cache
					res.send (md)
				else
					res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
				end
			else
				if is_content_type_text_html_accepted (req) then
					if
						attached {ITERABLE [READABLE_STRING_32]} iron.database.path_browse_index (iron_version (req), v) as lst
					then
						m := new_response_message (req)
						create s.make_empty
						s.append ("<ul class=%"package-index%">")
						across
							lst as e
						loop
							if attached iron.database.package_by_path (iron_version (req), v + "/" + e.item) as l_package then
								s.append ("<li class=%"package-inline%">")
								s.append ("<a href=%""+ iron.package_view_web_page (iron_version (req), l_package) +"%"> ")
								s.append (m.html_encoded_string (e.item))
								if attached l_package.name as l_name and then not l_name.same_string (e.item) then
									s.append (" -&gt; package %"")
									s.append (m.html_encoded_string (l_name))
									s.append_character ('%"')
								end
								s.append ("</a> ")
								s.append ("<span class=%"packageid%">")
								s.append (l_package.id)
								s.append ("</span>")
								s.append ("</li>")
							elseif attached {ITERABLE [READABLE_STRING_32]} iron.database.path_browse_index (iron_version (req), v + "/" + e.item) then
								s.append ("<li class=%"package-folder-inline%">")
								s.append ("<a href=%""+ req.script_url (req.path_info))
								if s.item (s.count) /= '/' then
									s.append_character ('/')
								end
								s.append (url_encoder.encoded_string (e.item) +"%">")
								s.append (m.html_encoded_string (e.item))
								s.append ("/</a>")
								s.append ("</li>")
							else
								s.append ("<li class=%"package-inline-unknown%">? ")
								s.append (m.html_encoded_string (e.item))
								s.append (" ?</a>")
								s.append ("</li>")

							end
						end
						s.append ("</ul>")
						m.set_body (s)
						res.send (m)
					else
						res.send (new_not_found_response_message (req))
					end
				else
					res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
				end
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("Download archive associated with package containing current request uri.")
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
