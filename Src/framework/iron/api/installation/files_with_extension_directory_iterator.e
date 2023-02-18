note
	date: "$Date$"
	revision: "$Revision$"

class
	FILES_WITH_EXTENSION_DIRECTORY_ITERATOR

inherit
	DIRECTORY_ITERATOR
		redefine
			process_directory,
			process_file,
			file_excluded,
			directory_excluded
		end

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (lst: LIST [PATH]; a_ext: like extension)
		do
			extension := a_ext
			list := lst
		end

	make_empty (a_ext: like extension)
		do
			make (create {ARRAYED_LIST [PATH]}.make (0), a_ext)
		end

feature -- Settings

	stopping_on_first_matching_file: BOOLEAN
			-- Do not process the remaining of the current directory
			-- as soon as a file matches criteria.
			--| default: False

feature -- Settings change

	stop_on_first_matching_file (b: BOOLEAN)
			-- Set `stopping_on_first_matching_file' to `b'.
		do
			stopping_on_first_matching_file := b
		end

feature -- Access: result

	list: LIST [PATH]
			-- List containing matching info path.	

	extension: READABLE_STRING_GENERAL
			-- Searched file extensions.

	excluded_directory_names: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Excluded directory names.

feature -- Change

	exclude_directory_names (a_names: ITERABLE [READABLE_STRING_GENERAL])
		local
			l_excluded_directory_names: like excluded_directory_names
		do
			l_excluded_directory_names := excluded_directory_names
			if l_excluded_directory_names = Void then
				create l_excluded_directory_names.make (1)
				l_excluded_directory_names.compare_objects
				excluded_directory_names := l_excluded_directory_names
			end
			across
				a_names as ic
			loop
				l_excluded_directory_names.force (ic)
			end
		end

feature -- Visitor

	process_directory (dn: PATH)
			-- <Precursor>
		do
			level := level + 1
			if level_to_skip > 0 and level >= level_to_skip then
					-- skipped ...
			else
				Precursor (dn)
			end
			if level_to_skip >= level +1 then
				level_to_skip := 0
			end
			level := level - 1
		end

	process_file (fn: PATH)
			-- Visit file `fn'
		do
			list.force (fn)
			if stopping_on_first_matching_file then
				level_to_skip := level + 1
			end
		end

feature -- Status

	directory_excluded (dn: PATH): BOOLEAN
		do
			if attached excluded_directory_names as lst then
				if attached dn.entry as e then
					Result := across lst as ic some e.name.same_string_general (ic) end
				end
			end
		end

	file_excluded (fn: PATH): BOOLEAN
		do
			if attached fn.extension as ext then
				Result := not ext.is_case_insensitive_equal_general (extension)
			else
				Result := True
			end
		end

feature {NONE} -- Implementation

	level: INTEGER

	level_to_skip: INTEGER

invariant

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
