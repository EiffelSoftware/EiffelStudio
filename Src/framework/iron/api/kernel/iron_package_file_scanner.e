note
	description: "[
				Directory visitor that list *.iron files recursively.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_FILE_SCANNER

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

	make (lst: LIST [PATH])
		do
			list := lst
		end

	make_empty
		do
			make (create {ARRAYED_LIST [PATH]}.make (0))
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

	set_default_iron_file_name (fn: like default_iron_file_name)
			-- Set `default_iron_file_name' to `fn'.
		do
			default_iron_file_name := fn
		end

feature -- Access: result

	list: LIST [PATH]
			-- List containing matching info path.	

	extension: STRING_32 = "iron"
			-- Searched iron file extensions.

	default_iron_file_name: detachable READABLE_STRING_GENERAL assign set_default_iron_file_name
			-- Default iron file name.
			--| if attached, search first for this file, otherwise search for other *.iron files.

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
		local
			f: RAW_FILE
			done: BOOLEAN
		do
			level := level + 1
			if level_to_skip > 0 and level >= level_to_skip then
					-- skipped ...
			else
					-- Search first for `default_iron_file_name'
				if
					stopping_on_first_matching_file and
					attached default_iron_file_name as dft
				then
					create f.make_with_path (dn.extended (dft))
					if f.exists then
						process_file (f.path)
						done := True
					end
				end
				if not done then
					Precursor (dn)
				end
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
			if level_to_skip > 0 and level >= level_to_skip then
				Result := True
			elseif attached excluded_directory_names as lst then
				if attached dn.entry as e then
					Result := across lst as ic some e.name.same_string_general (ic) end
				end
			end
		end

	file_excluded (fn: PATH): BOOLEAN
		do
			if level_to_skip > 0 and level >= level_to_skip then
				Result := True
			elseif attached fn.extension as ext then
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

