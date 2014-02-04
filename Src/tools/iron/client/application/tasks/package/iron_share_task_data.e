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
		do
			import (p)
		end

feature -- Access

	id: detachable READABLE_STRING_32

	name: detachable READABLE_STRING_32

	title: detachable READABLE_STRING_32

	description: detachable READABLE_STRING_32

	archive: detachable PATH

	source: detachable PATH

	indexes: detachable ARRAYED_LIST [READABLE_STRING_32]

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
			utf: UTF_CONVERTER
		do
			create ini.make_with_path (p)
			name := Void
			description := Void
			source := Void
			archive := Void
			indexes := Void

			if attached ini.item ("name") as l_name_8 then
				name := utf.utf_8_string_8_to_escaped_string_32 (l_name_8)
			end
			if attached ini.item ("description") as l_description_8 then
				description := utf.utf_8_string_8_to_escaped_string_32 (l_description_8)
			end
			if attached ini.item ("source") as l_source_8 then
				create source.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (l_source_8))
			elseif attached ini.item ("archive") as l_archive_8 then
				create archive.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (l_archive_8))
			end

			across
				ini as c
			loop
				if attached c.item as s and then c.key.starts_with ("index") then
					add_index (utf.utf_8_string_8_to_escaped_string_32 (s))
				end
			end
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
