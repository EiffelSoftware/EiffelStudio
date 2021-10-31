note
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HTML_IRON_NODE_ITERATOR

inherit
	IRON_NODE_ITERATOR
		redefine
			visit_package,
			visit_package_version,
			visit_package_iterable,
			visit_package_version_iterable
		end

create
	make

feature {NONE} -- Initialization

	make (buf: like buffer; req: WSF_REQUEST; a_iron: like iron; v: like version)
			-- Initialize `Current'.
		do
			iron := a_iron
			buffer := buf
			request := req
			version := v
		end

	buffer: STRING_8

	iron: IRON_NODE

	request: WSF_REQUEST

	version: IRON_NODE_VERSION

	user: detachable IRON_NODE_USER

	as_list_item: BOOLEAN
			-- Build the list item version?

feature -- Change	

	set_user (u: like user)
		do
			user := u
		end

	set_as_list_item (b: BOOLEAN)
		do
			as_list_item := b
		end

feature -- Visit

	visit_package (p: IRON_NODE_PACKAGE)
		local
			s: like buffer
		do
			s := buffer
			s.append ("<li class=%"package%">")
			if attached p.name as l_name then
				s.append ("<span class=%"name%"><a href=%""+ request.script_url (iron.package_view_web_page (p)) + "%">" + html_encoder.encoded_string (l_name) + "</a></span>")
				s.append ("<span class=%"packageid%">(")
				s.append (p.id)
				s.append (")</span>")
				if attached p.description as l_description then
					s.append ("<pre class=%"description%">")
					s.append (html_encoder.encoded_string (l_description))
					s.append ("</pre>")
				end
				if attached p.tags as l_tags and then not l_tags.is_empty then
					s.append ("<div class=%"tags%">")
					across
						l_tags as ic_tags
					loop
						s.append (html_encoder.encoded_string (ic_tags))
						s.append_character (',')
					end
					if s.ends_with (",") then
						s.remove_tail (1)
					end
					s.append ("</div>")
				end
				if as_list_item then
					if attached p.owner as l_owner then
						if attached user as u then
							if u.same_user (l_owner) then
								s.append ("<div class=%"owner%">")
								s.append ("<span>You are the maintainer</span>")
								s.append ("</div>")
							elseif u.is_administrator then
								s.append ("<div class=%"owner%">")
								s.append ("<span>Maintainer: ")
								s.append (html_encoder.encoded_string (l_owner.name))
								s.append ("</span>")
								s.append ("</div>")
							end
						end
					end
				end
				if attached p.last_modified as dt then
					s.append ("<div class=%"lastmodified%"><span>")
					append_formatted_date_to (dt, s)
					s.append ("</span></div>")
				end
			end
			s.append ("</li>")
		end

	package_version_template_to_string (p: IRON_NODE_VERSION_PACKAGE): detachable STRING
		local
			tpl: detachable TEMPLATE_FILE
			l_path: PATH
			ut: FILE_UTILITIES
			tpl_inspector: TEMPLATE_INSPECTOR
			tpl_name: READABLE_STRING_8
			l_ignore_cache: BOOLEAN
			l_uris: STRING_TABLE [READABLE_STRING_8]
		do
			debug ("no_cache")
				l_ignore_cache := True
			end

			if as_list_item then
				tpl_name := package_version_view_template_name
			else
				tpl_name := package_version_list_item_template_name
			end
			if not l_ignore_cache and templates.has_key (tpl_name) then
				tpl := templates.item (tpl_name)
			else
				l_path := iron.layout.html_template_path.extended (tpl_name)
				if ut.file_path_exists (l_path) then
					create tpl.make_from_file (l_path.name)
					tpl.analyze
					create {TEMPLATE_IRON_NODE_VERSION_PACKAGE_INSPECTOR} tpl_inspector.register (({detachable IRON_NODE_VERSION_PACKAGE}).out)
				elseif as_list_item then
					l_path := iron.layout.html_template_path.extended (package_version_list_item_template_name)
					if ut.file_path_exists (l_path) then
						create tpl.make_from_file (l_path.name)
						tpl.analyze
						create {TEMPLATE_IRON_NODE_VERSION_PACKAGE_INSPECTOR} tpl_inspector.register (({detachable IRON_NODE_VERSION_PACKAGE}).out)
					end
				end
				templates.force (tpl, tpl_name)
			end
			if tpl /= Void then
				tpl.add_value (p, "package")
				tpl.add_value (user, "user")
				if p.has_archive then
					tpl.add_value (iron.package_version_archive_resource (p), "archive_url")
				end
				tpl.add_value (iron.package_version_map_web_page (p, Void), "edit_uri_url")
				if attached iron.database.path_associated_with_package (p) as lst then
					create l_uris.make (2)
					across
						lst as c
					loop
						l_uris.force (request.script_url (p.version.value + c), c)
					end
					tpl.add_value (l_uris, "uris")
				end

				tpl.get_output
				Result := tpl.output
				tpl.clear_values
			end
		end

	package_version_list_item_template_name: STRING = "package-version-list-item.tpl"
	package_version_view_template_name: STRING = "package-version-view.tpl"

	templates: STRING_TABLE [detachable TEMPLATE_FILE]
			-- Cached template
		once ("thread")
			create Result.make (1)
		end

	visit_package_version (p: IRON_NODE_VERSION_PACKAGE)
		local
			s: like buffer
			v: READABLE_STRING_8
			l_size: INTEGER
			l_path: READABLE_STRING_8
			l_name, l_title: detachable READABLE_STRING_32
			i: INTEGER
		do
			if attached package_version_template_to_string (p) as l_tpl_string then
				buffer.append (l_tpl_string)
			else
				s := buffer
				s.append ("<li class=%"package version%">")
				l_name := p.name
				l_title := p.title
				if l_name /= Void then
					s.append ("<span class=%"name%"><a href=%""+ request.script_url (iron.package_version_view_web_page (p)) + "%">" + html_encoder.encoded_string (l_name))
					if l_title /= Void then
						s.append (" &quote;")
						s.append (html_encoder.encoded_string (l_title))
						s.append ("&quote;")
					end
					s.append ("</a></span>")
					s.append ("<span class=%"packageid%">(")
					s.append (p.id)
					s.append (")</span>")
					if attached p.description as l_description then
						s.append ("<pre class=%"description%">")
						s.append (html_encoder.encoded_string (l_description))
						s.append ("</pre>")
					end
					if attached p.tags as l_tags and then not l_tags.is_empty then
						s.append ("<div class=%"tags%">")
						across
							l_tags as ic_tags
						loop
							s.append (html_encoder.encoded_string (ic_tags))
							s.append_character (',')
						end
						if s.ends_with (",") then
							s.remove_tail (1)
						end
						s.append ("</div>")
					end
					if as_list_item then
						if attached p.archive_path as l_archive_path then
							s.append ("<div class=%"archive%"><a href=%""+ request.script_url (iron.package_version_archive_web_page (p)) + "%">Archive</a>")
							s.append (" (")
							l_size := p.archive_file_size
							s.append (size_as_string (l_size))

							if attached p.archive_last_modified as dt then
								s.append (" -- ")
								s.append (date_as_string (dt))
							end
							s.append (")</div>")
						end

						if attached iron.database.path_associated_with_package (p) as lst then
							s.append ("<ul class=%"uri-list%"><strong><a href=%""+ iron.package_version_map_web_page (p, Void) +"%">Edit associated URIs</a></strong>%N")
							v := version.value
							across
								lst as c
							loop
								s.append ("<li class=%"uri%">")
								l_path := c
								i := l_path.last_index_of ('/', l_path.count)
								if i > 0 then
									s.append ("<a href=%"" + "/" + v + l_path.substring (1, i) + "%">/" + v + l_path.substring (1, i) + "</a> ")
									s.append ("<a href=%"" + "/" + v + l_path + "%">" + l_path.substring (i + 1, l_path.count) + "</a>")
								else
									s.append ("<a href=%"" + "/" + v + l_path + "%">/" + v + l_path + "</a>")
								end
								s.append ("</li>%N")
							end
							s.append ("</ul>")
						end

						if attached p.owner as l_owner then
							if attached user as u then
								if u.same_user (l_owner) then
									s.append ("<div class=%"owner%">")
									s.append ("<span>You are the maintainer</span>")
									s.append ("</div>")
								elseif u.is_administrator then
									s.append ("<div class=%"owner%">")
									s.append ("<span>Maintainer: ")
									s.append (html_encoder.encoded_string (l_owner.name))
									s.append ("</span>")
									s.append ("</div>")
								end
							end
						end
					end
					if attached p.notes as l_notes and then not l_notes.is_empty then
						s.append ("<ul class=%"notes%">")
						across
							l_notes as ic_notes
						loop
							if attached ic_notes as l_note then
								s.append ("<li>")
								s.append (html_encoder.encoded_string (@ ic_notes.key.as_string_32))
								s.append_character (':')
								s.append (html_encoder.encoded_string (l_note))
								s.append ("</li>")
							end
						end
						s.append ("</ul>")
					end
					if attached p.last_modified as dt then
						s.append ("<div class=%"lastmodified%"><span>")
						append_formatted_date_to (dt, s)
						s.append ("</span></div>")
					end
					if p.download_count > 0 then
						s.append ("<div class=%"downloads%"><span>")
						s.append (p.download_count.out)
						s.append ("</span></div>")
					end
				end
				s.append ("</li>")
			end
		end

	visit_package_iterable (it: ITERABLE [IRON_NODE_PACKAGE])
		do
			buffer.append ("<ul>%N")
			across
				it as c
			loop
				visit_package (c)
				buffer.append_character ('%N')
			end
			buffer.append ("</ul>%N")
		end

	visit_package_version_iterable (it: ITERABLE [IRON_NODE_VERSION_PACKAGE])
		do
			buffer.append ("<ul class=%"list-group%">%N")
			across
				it as c
			loop
				visit_package_version (c)
				buffer.append_character ('%N')
			end
			buffer.append ("</ul>%N")
		end

feature {NONE} -- Implementation

	append_formatted_date_to (dt: DATE_TIME; s: STRING)
		local
			hd: HTTP_DATE
		do
			create hd.make_from_date_time (dt)
			hd.append_date_time_to_rfc1123_string (dt, s)
		end

	size_as_string (s: INTEGER): STRING_8
		do
			Result := s.out + " octets"
		end

	date_as_string (dt: DATE_TIME): READABLE_STRING_8
		do
			Result :=(create {HTTP_DATE}.make_from_date_time (dt)).rfc1123_string
		end

	html_encoder: HTML_ENCODER
		once
			create Result
		end

	url_encoder: URL_ENCODER
		once
			create Result
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
