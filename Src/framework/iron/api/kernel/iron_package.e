note
	description: "Objects that represent an iron package"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

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

	make_named (a_id: READABLE_STRING_8; a_name: READABLE_STRING_GENERAL; repo: like repository)
			-- Initialize current with `a_id', `a_name' and a `repo'.
		require
			a_name_valid: not a_name.is_empty
		do
			make (a_id, repo)
			set_name (a_name)
		end

feature -- Status

	has_id: BOOLEAN
		do
			Result := not id.is_empty
		end

	is_local_working_copy: BOOLEAN
			-- Is Current package from a file system working-copy repository?
			-- (i.e: local working-copy repository as opposed to package hosted on remote iron server)
		do
			Result := attached {IRON_WORKING_COPY_REPOSITORY} repository
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
			if id.is_empty and other.id.is_empty then
				Result := is_same_package (other)
			else
				Result := (id ~ other.id) and (repository.is_same_repository (other.repository))
			end
		end

	is_same_package (other: IRON_PACKAGE): BOOLEAN
		do
			Result := identifier.same_string (other.identifier) and then (repository.is_same_repository (other.repository))
		end

	is_named (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is package named `a_name' ?
		local
			s: detachable READABLE_STRING_32
		do
			if a_name /= Void then
				s := name
				if s /= Void then
					Result := a_name.is_case_insensitive_equal (s)
				end
			end
		end

	is_identified_by (a_identifier: READABLE_STRING_GENERAL): BOOLEAN
			-- Is package identified by `a_identifier' ?
			-- i.e is identifier same as `a_identifier'?
		local
			s: detachable READABLE_STRING_32
		do
			if a_identifier /= Void then
				s := identifier
				if s /= Void then
					Result := a_identifier.is_case_insensitive_equal (s)
				end
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

	identifier: READABLE_STRING_32
			-- Safe package name
		do
			if attached name as l_name then
				Result := l_name
			else
				Result := id.to_string_32
			end
		end

	location: URI
			-- Associated URI.
		do
			create Result.make_from_uri (repository.location)
			if attached associated_paths as l_paths and then not l_paths.is_empty then
				across
					l_paths.first.split ('/') as ic
				loop
					Result.add_unencoded_path_segment (ic)
				end
			else
				Result.add_unencoded_path_segment (identifier)
			end
		end

	human_identifier: STRING_32
		local
			l_title: like title
			l_repo_location: READABLE_STRING_8
		do
			l_repo_location := repository.location_string
			l_title := title

			create Result.make (l_repo_location.count + 10)
			if attached name as l_name then
				debug
					Result.append_string_general (id)
					Result.append_character (' ')
				end

				Result.append (l_name)
			else
				Result.append_string_general (id)
			end
			Result.append_character (' ')
			Result.append_character ('(')
			Result.append_string_general (l_repo_location)
			Result.append_character (')')

			if l_title /= Void then
				Result.append_character (' ')
				Result.append_character ('"')
				Result.append_string_general (l_title)
				Result.append_character ('"')
			end

			debug
				across
					associated_paths as c
				loop
					Result.append_string_general (repository.location_string)
					Result.append_string_general (c)
					Result.append_character (' ')
				end
			end
		end

	id: IMMUTABLE_STRING_8
			-- Unique identifier.
			--| UUID

	name: detachable READABLE_STRING_32
			-- Optional unique friendly identifier.

	title: detachable READABLE_STRING_32
			-- Optional associated title for UI.

	description: detachable READABLE_STRING_32

	associated_paths: ARRAYED_LIST [READABLE_STRING_8]
			-- Associated path on the repositories.
			--| For local working copy repository, the first path is used to locate package inside repository

	tags: ARRAYED_LIST [READABLE_STRING_32]
			-- Tags

feature -- Access: archive

	archive_uri: detachable URI
			-- URI of the associated archive file.

	archive_path: detachable PATH
			-- Location of the associated archive file.
		do
			if has_archive_file_uri and then attached archive_uri as l_uri then
				Result := uri_to_path (l_uri)
			end
		end

	archive_revision: NATURAL
			-- Associated archive revision.
			--| for now, only apply to remote web iron server.

	archive_hash_string: detachable READABLE_STRING_8
			-- Hash of the archive file.
		local
			f: RAW_FILE
			sha1: SHA1
		do
			if archive_hash_set then
				Result := archive_hash
			else
				reset_archive_hash
				if attached archive_path as p then
					create f.make_with_path (p)
					if f.exists and then f.is_readable then
						f.open_read
						create sha1.make
						sha1.update_from_io_medium (f)
						f.close
						Result := "SHA1:" + sha1.digest_as_string
						archive_hash := Result
					end
				end
			end
		ensure
			archive_hash_computed: archive_hash_set
		end

	archive_size: INTEGER
			-- Size of the archive file in octects.			

feature {NONE} -- Basic operation: archive

	archive_hash: detachable READABLE_STRING_8
			-- Hash of the archive file.

	archive_hash_set: BOOLEAN
		do
			Result := archive_hash /= Void
		end

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
			if v /= Void and then not v.is_empty then
				name := v.to_string_32
			else
				name := Void
			end
		end

	set_title (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void and then not v.is_empty then
				title := v.to_string_32
			else
				title := Void
			end
		end

	set_description (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void and then not v.is_empty then
				description := v.to_string_32
			else
				description := Void
			end
		end

	set_archive_revision (v: NATURAL)
			-- Set `archive_revision' to `v'.
		do
			archive_revision := v
		end

	set_archive_size (v: INTEGER)
			-- Set `archive_size' to `v'.
		do
			archive_size := v
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
			reset_archive_hash
		end

	set_archive_path (p: detachable PATH)
		local
			path_uri: PATH_URI
		do
			if p = Void then
				set_archive_uri (Void)
			else
				create path_uri.make_from_path (p)
				if path_uri.is_valid then
					set_archive_uri (path_uri.string)
				else
					set_archive_uri (Void)
				end
			end
		end

	set_archive_hash (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void and then v.is_valid_as_string_8 then
				archive_hash := v.to_string_8
			else
				archive_hash := Void
			end
		end

	reset_archive_hash
		do
			archive_hash := Void
		end

feature {NONE} -- Implementation

	uri_to_path (u: URI): PATH
		require
			u_is_file: u.scheme.is_case_insensitive_equal ("file")
		local
			l_path: READABLE_STRING_32
			iri: IRI
			path_uri: PATH_URI
		do
			create path_uri.make_from_file_uri (u)
			if path_uri.is_valid then
				Result := path_uri.file_path
			else
					-- Old code
				create iri.make_from_uri (u)
				l_path := iri.decoded_path
				if
					{PLATFORM}.is_windows and then
					l_path.starts_with ("/")
				then
					l_path := l_path.substring (2, l_path.count)
				end
				create Result.make_from_string (l_path)
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
