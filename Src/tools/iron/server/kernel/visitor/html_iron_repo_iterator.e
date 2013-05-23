note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HTML_IRON_REPO_ITERATOR

inherit
	IRON_REPO_ITERATOR
		redefine
			visit_package,
			visit_package_iterable
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

	iron: IRON_REPO

	request: WSF_REQUEST

	version: IRON_REPO_VERSION

	user: detachable IRON_REPO_USER

feature -- Change	

	set_user (u: like user)
		do
			user := u
		end

feature -- Visit

	visit_package (p: IRON_REPO_PACKAGE)
		local
			s: like buffer
			l_size: INTEGER
		do
			s := buffer
			s.append ("<li class=%"package%">")
			if attached p.name as l_name then
				s.append ("<span class=%"name%"><a href=%""+ request.script_url (iron.package_view_web_page (version, p)) + "%">" + html_encoder.encoded_string (l_name) + "</a></span>")
				s.append (" <span class=%"packageid%">(")
				s.append (p.id)
				s.append (")</span>")
				if attached p.description as l_description then
					s.append ("<div class=%"description%">")
					s.append (l_description)
					s.append ("</div>")
				end
				if attached p.archive_path as l_archive_path then
--					s.append ("<span>(archive=")
--					s.append (l_archive_path.name.to_string_8)
--					s.append (")</span>")
					s.append ("<div class=%"archive%"><a href=%""+ request.script_url (iron.package_archive_web_page (version, p)) + "%">Archive</a>")
					s.append (" (")
					l_size := p.archive_file_size
					s.append (size_as_string (l_size))

					if attached p.archive_last_modified as dt then
						s.append (" -- ")
						s.append (date_as_string (dt))
					end
					s.append (")</div>")
				end
				if attached p.owner as l_owner then
					if attached user as u then
						if u.same_user (l_owner) then
							s.append ("<div>")
							s.append ("<span class=%"owner%">You are the maintainer</span>")
							s.append ("</div>")
						elseif u.is_administrator then
							s.append ("<div>")
							s.append ("<span class=%"owner%">Maintainer: ")
							s.append (html_encoder.encoded_string (l_owner.name))
							s.append ("</span>")
							s.append ("</div>")
						end
					end
				end
			end
			s.append ("</li>")
		end

	visit_package_iterable (it: ITERABLE [IRON_REPO_PACKAGE])
		do
			buffer.append ("<ul>%N")
			across
				it as c
			loop
				visit_package (c.item)
			end
			buffer.append ("</ul>%N")
		end

feature {NONE} -- Implementation

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
