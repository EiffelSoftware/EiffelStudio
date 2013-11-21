note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_PACKAGE

inherit
	DEBUG_OUTPUT
		redefine
			is_equal
		end

create
	make,
	make_empty

feature {NONE} -- Initialization

	make_empty (repo: like repository)
		do
			make ("", repo)
		end

	make (a_id: READABLE_STRING_8; repo: like repository)
			-- Initialize `Current'.
		do
			repository := repo
			create id.make_from_string (a_id)
			create associated_paths.make (0)
			create tags.make (0)
		end

feature -- Status

	has_id: BOOLEAN
		do
			Result := not id.is_empty
		end

	has_archive_file_uri: BOOLEAN
		do
			Result := attached archive_uri as l_uri and then l_uri.scheme.is_case_insensitive_equal ("file")
		end

	has_archive_uri: BOOLEAN
		do
			Result := archive_uri /= Void
		end

feature -- Comparison		

	is_equal (other: IRON_PACKAGE): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
			-- (from ANY)
		do
			Result := id ~ other.id
		end

	is_named (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			if a_name /= Void and attached name as l_name then
				Result := a_name.is_case_insensitive_equal (l_name)
			end
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := human_identifier
		end

feature -- Access

	repository: IRON_REPOSITORY
			-- Associated repository

	human_identifier: STRING_32
		do
			create Result.make_from_string (repository.url)
			Result.append_character (' ')
			if attached name as l_name then
				Result.append (l_name)
				debug
					Result.append_character (' ')
					Result.append_string_general (id)
				end
			else
				Result.append_string_general (id)
			end

			debug
				across
					associated_paths as c
				loop
					Result.append (repository.url)
					Result.append (c.item)
					Result.append_character (' ')
				end
			end

		end

	id: IMMUTABLE_STRING_8

	name: detachable READABLE_STRING_32

	description: detachable READABLE_STRING_32

	archive_uri: detachable URI

	archive_path: detachable PATH
		do
			if has_archive_file_uri and then attached archive_uri as l_uri then
				Result := uri_to_path (l_uri)
			end
		end

	associated_paths: ARRAYED_LIST [READABLE_STRING_8]
			-- Associated path on the repositories

	tags: ARRAYED_LIST [READABLE_STRING_32]
			-- Tags

feature -- Access: items	

	items: detachable STRING_TABLE [detachable READABLE_STRING_32]
			-- Optional info

	item (n: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached items as tb then
				Result := tb.item (n)
			end
		end

feature -- Helpers

	json_item: detachable READABLE_STRING_32
		do
			Result := item ("_json")
			if Result = Void then
				Result := item ("json")
			end
		end

	put_json_item (v: detachable READABLE_STRING_32)
		do
			put (v, "_json")
		end

feature {IRON_EXPORTER} -- Change

	update_id (a_id: READABLE_STRING_8)
		require
			valid_a_id: not a_id.is_empty
			has_no_id: not has_id
		do
			create id.make_from_string (a_id)
		ensure
			has_id: has_id
			id_set: id.is_case_insensitive_equal (a_id)
		end

	reset_id
		require
			has_id: has_id
		do
			create id.make_empty
		ensure
			has_no_id: not has_id
		end

feature -- Change

	put (v: detachable READABLE_STRING_32; k: READABLE_STRING_GENERAL)
		local
			tb: like items
		do
			tb := items
			if tb = Void then
				create tb.make (1)
				items := tb
			end
			tb.force (v, k)
		end

	set_name (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void then
				name := v.to_string_32
			else
				name := Void
			end
		end

	set_description (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void then
				description := v.to_string_32
			else
				description := Void
			end
		end

	set_archive_uri (v: detachable READABLE_STRING_GENERAL)
		local
			iri: IRI
		do
			if v /= Void then
				create iri.make_from_string (v)
				archive_uri := iri.to_uri
			else
				archive_uri := Void
			end
		end

feature {NONE} -- Implementation

	uri_to_path (u: URI): PATH
		require
			u_is_file: u.scheme.is_case_insensitive_equal ("file")
		local
			l_path: READABLE_STRING_32
			iri: IRI
		do
			create iri.make_from_uri (u)
			l_path := iri.decoded_path
			if {PLATFORM}.is_windows then
				if l_path.starts_with ("/") then
					l_path := l_path.substring (2, l_path.count)
				end
			end
			create Result.make_from_string (l_path)
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
