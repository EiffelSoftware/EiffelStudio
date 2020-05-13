note
	description: "[
			Package information file is represented by {IRON_PACKAGE_INI_FILE}.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_INI_FILE

inherit
	IRON_PACKAGE_FILE

create {IRON_PACKAGE_FILE_FACTORY}
	make_from_path

feature {NONE} -- Initialization

	make_from_path (a_path: PATH)
		do
			path := a_path
			create ini.make_with_path (a_path)
			has_error := not ini.is_valid
		end

feature -- Access

	item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Data associated with `item'
		do
			Result := ini.item (a_name)
		end

	package_name: detachable READABLE_STRING_32
			-- <Precursor>
		do
			Result := item ("name")
		end

feature -- Change

	reset
			-- <Precursor>
		do
			ini.reset
		end

	put (a_value: detachable READABLE_STRING_32; a_name: READABLE_STRING_GENERAL)
			-- Put `a_value' data associated with `a_name'.
		do
			if a_value = Void then
				remove (a_name)
			else
				ini.put (a_value, a_name)
			end
		end

	remove (a_name: READABLE_STRING_GENERAL)
			-- Remove data associated with `a_name'
		do
			ini.remove (a_name)
		end

feature -- Conversion	

	to_package (a_repo: IRON_REPOSITORY): IRON_PACKAGE
		local
			s: STRING_8
			t: READABLE_STRING_8
			l_path_uri: PATH_URI
		do
			if attached item ("id") as l_id and then l_id.is_valid_as_string_8 then
				create Result.make (l_id.to_string_8, a_repo)
			elseif attached item ("name") as l_name and then l_name.is_valid_as_string_8 then
				create Result.make (l_name.to_string_8 + "@" + a_repo.location_string, a_repo)
			else
				create Result.make_empty (a_repo)
			end
			Result.set_name (item ("name"))
			Result.set_title (item ("title"))
			Result.set_description (item ("description"))
			if attached ini.item ("tags") as l_tags then
				across
					l_tags.split (',') as ic
				loop
					Result.tags.force (ic.item)
				end
			end
			create l_path_uri.make_from_path (path)
			s := l_path_uri.string
			t := a_repo.location_string
			if s.starts_with (t) then
					-- remove repository dir
				s := s.substring (t.count + 1, s.count) -- keep first \
					-- remove repository .iron file
				if attached path.entry as e then
					s.remove_tail (e.name.count + 1)
				end
				Result.associated_paths.force (s)
			end
		end

	load_package (p: IRON_PACKAGE)
		local
			s: STRING_32
		do
			ini.reset
			ini.put (p.name, "name")
			ini.put (p.title, "title")
			ini.put (p.description, "description")
			create s.make_empty
			across
				p.tags as ic
			loop
				if not s.is_empty then
					s.append_character (',')
				end
				s.append (ic.item)
			end
			ini.put (s, "tags")
		end

feature {NONE} -- Implementation

	ini: INI_FILE
			-- Internal data.

feature -- Storage

	has_expected_file_name: BOOLEAN
			-- Has expected file name for Current package file?
		do
			Result := attached path.entry as e and then e.name.same_string (expected_file_name.name)
		end

	expected_file_name: PATH
			-- Expected file name for Current package file?
		do
			create Result.make_from_string ("iron")
			Result := Result.appended_with_extension ("ini")
		end

	save
			-- Save Current file representation into file `fn'.
		do
			ini.save_to (path)
		end

	text: STRING
		do
			Result := ini.text
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
