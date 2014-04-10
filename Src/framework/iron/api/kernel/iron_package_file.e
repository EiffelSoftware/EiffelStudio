note
	description: "[
			Package information file is represented by {IRON_PACKAGE_FILE}.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_PACKAGE_FILE

feature -- Access

	item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32 assign put
			-- Data associated with `item'
		deferred
		end

	path: PATH
			-- Associated path.

	package_name: detachable READABLE_STRING_32
			-- Associated package name.
		deferred
		end

	projects: detachable ARRAYED_LIST [TUPLE [name: READABLE_STRING_GENERAL; relative_uri: READABLE_STRING_8]]

	title: detachable READABLE_STRING_32 assign set_title
			-- Optional title.
		do
			Result := item ("title")
		end

	description: detachable READABLE_STRING_32 assign set_description
			-- Optional description.
		do
			Result := item ("description")
		end

	tags: detachable LIST [READABLE_STRING_32] assign set_tags
			-- Optional list of tags.
		local
			l_segments: LIST [READABLE_STRING_32]
			t: STRING_32
		do
			if attached item ("tags") as s_tags then
				l_segments := s_tags.split (',')
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (l_segments.count)
				across
					l_segments as ic
				loop
					t := ic.item
					t.adjust
					Result.force (t)
				end
			end
		end

feature -- Status report

	has_error: BOOLEAN
			-- Has error during loading?

	exists: BOOLEAN
			-- Does file associated to Current exists?
		local
			ut: FILE_UTILITIES
		do
			Result := ut.file_path_exists (path)
		end

feature -- Change

	set_title (a_title: like title)
			-- Set `a_title' to `title'.
		do
			if a_title = Void then
				remove ("title")
			else
				put (a_title, "title")
			end
		end

	set_description (a_description: like description)
			-- Set `a_description' to `description'.
		do
			if a_description = Void then
				remove ("description")
			else
				put (a_description, "description")
			end
		end

	set_tags (a_tags: like tags)
			-- Set `a_tags' to `tags'.
		local
			s: STRING_32
		do
			if a_tags = Void or else a_tags.is_empty then
				remove ("tags")
			else
				create s.make_empty
				across
					a_tags as ic
				loop
					if not s.is_empty then
						s.append_character (',')
					end
					s.append (ic.item)
				end
				put (s, "tags")
			end
		end

	put (a_value: detachable READABLE_STRING_32; a_name: READABLE_STRING_GENERAL)
			-- Put `a_value' data associated with `a_name'.
		deferred
		ensure
			added: item (a_name) ~ a_value
		end

	remove (a_name: READABLE_STRING_GENERAL)
			-- Remove data associated with `a_name'.
		deferred
		ensure
			removed: item (a_name) = Void
		end

	reset
			-- Reset Current package file
			-- except the `path' to the file.
		deferred
		end

feature -- Conversion	

	to_iron_uri_location (a_relative_ecf_path: PATH): detachable URI
			-- Iron uri location for `a_relative_ecf_path'.
			--| similar to "iron:package-name:relative_ecf_uri_path"
		local
			p1,p2: PATH_URI
			s1,s2: STRING
			p: READABLE_STRING_8
		do
			create p1.make_from_path (path.absolute_path.canonical_path)
			create p2.make_from_path (path.extended_path (a_relative_ecf_path).absolute_path.canonical_path)
			s1 := p1.string
			s2 := p2.string
			if s2.starts_with (s1) then
				s2.remove_head (s1.count + 1)
				if attached package_name as l_name then
					create Result.make_from_string ("iron:")
					Result.set_unencoded_path (l_name)
					p := Result.path
					Result.set_path (p + ":" + s2)
				end
			end
		end

	to_package (a_repo: IRON_REPOSITORY): IRON_PACKAGE
		deferred
		end

feature -- Change		

	load_package (p: IRON_PACKAGE)
		deferred
		end

	add_project (a_proj_name: READABLE_STRING_32; a_relative_uri: READABLE_STRING_8)
		local
			l_projects: like projects
			l_proj: detachable TUPLE [name: READABLE_STRING_GENERAL; relative_uri: READABLE_STRING_8]
		do
			l_projects := projects
			if l_projects = Void then
				create l_projects.make (1)
				projects := l_projects
			end
			across
				l_projects as ic
			until
				l_proj /= Void
			loop
				l_proj := ic.item
				if
					a_proj_name.is_case_insensitive_equal_general (l_proj.name) and then
					a_relative_uri.is_case_insensitive_equal_general (l_proj.relative_uri)
				then
						-- Found information
				else
					l_proj := Void
				end
			end
			if l_proj = Void then
				l_proj := [a_proj_name, a_relative_uri]
				l_projects.force ([a_proj_name, a_relative_uri])
			else
				l_proj.name := a_proj_name
				l_proj.relative_uri := a_relative_uri
			end
		end

feature -- Storage

	has_expected_file_name: BOOLEAN
			-- Has expected file name for Current package file?
		deferred
		end

	expected_file_name: PATH
			-- Expected file name for Current package file?
		deferred
		ensure
			not Result.is_empty
		end

	save
			-- Save Current file representation into file `expected_file_name'.
		deferred
		end

	text: STRING
			-- Current file representation as string.
		deferred
		end

feature -- Helper

	is_assistant_enabled: BOOLEAN
			-- If True, generated available information as comment.
			-- mainly used to help building package file from folder.

	enable_assistant
		do
			is_assistant_enabled := True
		ensure
			is_assistant_enabled: is_assistant_enabled
		end

	disable_assistant
		do
			is_assistant_enabled := False
		ensure
			assistant_disabled: not is_assistant_enabled
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
