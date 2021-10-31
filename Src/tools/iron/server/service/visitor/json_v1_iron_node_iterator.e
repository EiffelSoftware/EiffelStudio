note
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	JSON_V1_IRON_NODE_ITERATOR

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

	make (req: WSF_REQUEST; a_iron: like iron; v: like version)
			-- Initialize `Current'.
		do
			iron := a_iron
			request := req
			version := v
		end

	iron: IRON_NODE

	request: WSF_REQUEST

	version: detachable IRON_NODE_VERSION

	content_type_version: IMMUTABLE_STRING_8
		do
			create Result.make_from_string ("1.0")
		end

	content_type: IMMUTABLE_STRING_8
		local
			s: STRING
		do
			s := "application/json+iron-v"
			s.append (content_type_version)
			create Result.make_from_string (s)
		end

feature -- Access	

	user: detachable IRON_NODE_USER

	last_json_value: detachable JSON_VALUE

	package_to_json (p: detachable IRON_NODE_PACKAGE): STRING_8
		local
			j: like last_json_value
			jo: JSON_OBJECT
			js: JSON_STRING
		do
			last_json_value := Void
			if p /= Void then
				visit_package (p)
				j := last_json_value
			else
				create {JSON_NULL} j
			end
			create jo.make
			js := content_type_version
			jo.put (js, "_version")
			if j /= Void then
				jo.put (j, "package")
			end
			Result := jo.representation
		end

	package_version_to_json (p: detachable IRON_NODE_VERSION_PACKAGE): STRING_8
		local
			j: like last_json_value
			jo: JSON_OBJECT
			js: JSON_STRING
		do
			last_json_value := Void
			if p /= Void then
				visit_package_version (p)
				j := last_json_value
			else
				create {JSON_NULL} j
			end
			create jo.make
			js := content_type_version
			jo.put (js, "_version")
			if j /= Void then
				jo.put (j, "package")
			end
			Result := jo.representation
		end

	packages_to_json (it: detachable ITERABLE [IRON_NODE_PACKAGE]): STRING
		local
			j: like last_json_value
			jo: JSON_OBJECT
			js: JSON_STRING
		do
			last_json_value := Void
			if it /= Void then
				visit_package_iterable (it)
				j := last_json_value
			else
				create {JSON_ARRAY} j.make_empty
			end
			create jo.make
			js := content_type_version
			jo.put (js, "_version")
			if j /= Void then
				jo.put (j, "packages")
			end
			Result := jo.representation
		end

	package_versions_to_json (it: detachable ITERABLE [IRON_NODE_VERSION_PACKAGE]): STRING
		local
			j: like last_json_value
			jo: JSON_OBJECT
			js: JSON_STRING
		do
			last_json_value := Void
			if it /= Void then
				visit_package_version_iterable (it)
				j := last_json_value
			else
				create {JSON_ARRAY} j.make_empty
			end
			create jo.make
			js := content_type_version
			jo.put (js, "_version")
			if j /= Void then
				jo.put (j, "packages")
			end
			Result := jo.representation
		end

	is_long_version: BOOLEAN

feature -- Change		

	set_is_long_version (b: like is_long_version)
		do
			is_long_version := b
		end

	set_user (u: like user)
		do
			user := u
		end

feature -- Visit

	visit_package (p: IRON_NODE_PACKAGE)
		local
			js: JSON_STRING
			j_object, j_notes, j_links: JSON_OBJECT
			j_array: JSON_ARRAY
		do
			create j_object.make
			js := p.id
			j_object.put (js, "id")
			if attached p.name as l_name then
				js := l_name
				j_object.put (js, "name")
			end
			if attached p.title as l_title then
				js := l_title
				j_object.put (js, "title")
			end
			if attached p.description as l_description then
				js := l_description
				j_object.put (js, "description")
			end
			if attached p.tags as l_tags and then not l_tags.is_empty then
				create j_array.make_empty
				across
					l_tags as ic_tags
				loop
					j_array.extend (create {JSON_STRING}.make_from_string_32 (ic_tags))
				end
				j_object.put (j_array, "tags")
			end
			if attached p.items as l_notes then
				create j_notes.make_with_capacity (l_notes.count)
				across
					l_notes as ic_notes
				loop
					if attached ic_notes as l_note_text then
						j_notes.put_string (l_note_text, @ ic_notes.key)
					end
				end
				j_object.put (j_notes, "notes")
			end
			if attached p.links as l_links then
				create j_links.make_with_capacity (l_links.count)
				across
					l_links as ic_links
				loop
						-- Ignore the link title for now.
					j_links.put_string (ic_links.url, @ ic_links.key)
				end
				j_object.put (j_links, "links")
			end
			last_json_value := j_object
		end

	visit_package_version (p: IRON_NODE_VERSION_PACKAGE)
		local
			js: JSON_STRING
--			l_size: INTEGER
			j_object, j_notes, j_links: JSON_OBJECT
			j_array: JSON_ARRAY
		do
			check same_version: attached version as v implies v ~ p.version end
			create j_object.make
			js := p.id
			j_object.put (js, "id")
			if attached p.name as l_name then
				js := l_name
				j_object.put (js, "name")
			end
			if attached p.archive_path as l_archive_path then
				js := request.absolute_script_url (iron.package_version_archive_resource (p))
				j_object.put (js, "archive")
				debug
					js := l_archive_path.name
					j_object.put (js, "archive_path")
				end
				js := p.archive_file_size.out
				j_object.put (js, "archive_size")

				j_object.put_natural (p.archive_revision, "archive_revision")

				if attached p.archive_hash as l_hash then
					js := l_hash.out
					j_object.put (js, "archive_hash")
				end

				if attached p.archive_last_modified as dt then
					js := date_as_string (dt)
					j_object.put (js, "archive_date")
				end

				j_object.put (create {JSON_NUMBER}.make_integer (p.download_count), "download_count")
			end
			if attached p.title as l_title then
				js := l_title
				j_object.put (js, "title")
			end
			if attached p.description as l_description then
				js := l_description
				j_object.put (js, "description")
			end
			if attached p.tags as l_tags and then not l_tags.is_empty then
				create j_array.make_empty
				across
					l_tags as ic_tags
				loop
					j_array.extend (create {JSON_STRING}.make_from_string_32 (ic_tags))
				end
				j_object.put (j_array, "tags")
			end
			if attached iron.database.path_associated_with_package (p) as l_paths then
				create j_array.make_empty
				across
					l_paths as c
				loop
					js := c
					j_array.add (js)
				end
				j_object.put (j_array, "paths")
			end
			if attached p.notes as l_notes then
				create j_notes.make_with_capacity (l_notes.count)
				across
					l_notes as ic_notes
				loop
					if attached ic_notes as l_note_text then
						j_notes.put_string (l_note_text, @ ic_notes.key)
					end
				end
				j_object.put (j_notes, "notes")
			end
			if attached p.links as l_links then
				create j_links.make_with_capacity (l_links.count)
				across
					l_links as ic_links
				loop
						-- Ignore the link title for now.
					j_links.put_string (ic_links.url, @ ic_links.key)
				end
				j_object.put (j_links, "links")
			end
			last_json_value := j_object
		end

	visit_package_iterable (it: ITERABLE [IRON_NODE_PACKAGE])
		local
			j_array: JSON_ARRAY
		do
			create j_array.make_empty
			across
				it as c
			loop
				last_json_value := Void
				visit_package (c)
				if attached last_json_value as v then
					j_array.add (v)
				end
			end
			last_json_value := j_array
		end

	visit_package_version_iterable (it: ITERABLE [IRON_NODE_VERSION_PACKAGE])
		local
			j_array: JSON_ARRAY
		do
			create j_array.make_empty
			across
				it as c
			loop
				last_json_value := Void
				visit_package_version (c)
				if attached last_json_value as v then
					j_array.add (v)
				end
			end
			last_json_value := j_array
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
