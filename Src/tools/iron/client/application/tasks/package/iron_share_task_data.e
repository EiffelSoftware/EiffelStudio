note
	description: "Summary description for {IRON_SHARE_TASK_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_SHARE_TASK_DATA

create
	make,
	make_from_file

feature {NONE} -- Initialization

	make
		do
		end

	make_from_file (p: PATH)
			-- Create Current from sharing data file `p'
		do
			import (p)
		end

	make_from_package_file (pf: IRON_PACKAGE_FILE)
			-- Create Current from package file `pf'
		do
			name := pf.package_name
			title := pf.item ("title")
		end

feature -- Access

	id: detachable READABLE_STRING_32
			-- Iron id.

	name: detachable READABLE_STRING_32
			-- Short name of related iron package.

	title: detachable READABLE_STRING_32
			-- Long name of related iron package.

	description: detachable READABLE_STRING_32
			-- Description of related iron package.

	package_file_location: detachable PATH
			-- Location of iron package "package.iron" related file.

	archive: detachable PATH
			-- Location of archive file.

	source: detachable PATH
			-- Location of source code folder.

	indexes: detachable ARRAYED_LIST [READABLE_STRING_32]
			-- Iron mapping indexes, if any.

feature -- Status report

	has_name: BOOLEAN
		do
			Result := not is_whitespace_string (name)
		end

	has_title: BOOLEAN
		do
			Result := not is_whitespace_string (title)
		end

	has_description: BOOLEAN
		do
			Result := not is_whitespace_string (description)
		end

	has_source_or_archive: BOOLEAN
		do
			Result := archive /= Void or source /= Void
		end

feature {NONE} -- Helper

	is_whitespace_string (s: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := s = Void or else (s.is_empty or s.is_whitespace)
		end

feature -- Change

	set_id (v: like id)
		do
			if v = Void or else v.is_empty then
				id := Void
			else
				id := v
			end
		end

	set_name (v: like name)
		do
			if v = Void or else v.is_empty then
				name := Void
			else
				name := v
			end
		end

	set_title (v: like title)
		do
			if v = Void or else v.is_empty then
				title := Void
			else
				title := v
			end
		end

	set_description (v: like description)
		do
			if v = Void or else v.is_empty then
				description := Void
			else
				description := v
			end
		end

	set_package_file_location (p: detachable PATH)
			-- Set iron package file location to `p'.
		do
			package_file_location := p
		end

	set_archive (v: like archive)
		do
			if v = Void or else v.is_empty then
				archive := Void
			else
				archive := v
			end
		end

	set_source (v: like source)
		do
			if v = Void or else v.is_empty then
				source := Void
			else
				source := v
			end
		end

	add_index (m: READABLE_STRING_32)
		local
			l_indexes: like indexes
		do
			if not m.is_empty then
				l_indexes := indexes
				if l_indexes = Void then
					create l_indexes.make (1)
					indexes := l_indexes
				end
				l_indexes.force (m)
			end
		end

feature {NONE} -- Implementation

	import (p: PATH)
		local
			ini: INI_FILE
		do
			create ini.make_with_path (p)
			name := Void
			description := Void
			source := Void
			archive := Void
			indexes := Void

			name := ini.adjusted_item ("name")
			description := ini.adjusted_item ("description")
			if attached ini.adjusted_item ("source") as l_source then
				create source.make_from_string (l_source)
			end
			if attached ini.adjusted_item ("archive") as l_archive then
				create archive.make_from_string (l_archive)
			end

			across
				ini as c
			loop
				if attached c.item as s and then c.key.starts_with ("index") then
					add_index (s)
				end
			end
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
