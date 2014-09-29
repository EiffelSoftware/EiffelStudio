note
	description: "Summary description for {IRON_FS_PACKAGE_INFO_DIRECTORY_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_FS_PACKAGE_INFO_DIRECTORY_ITERATOR

inherit
	DIRECTORY_ITERATOR
		redefine
			process_directory,
			process_file,
			path_excluded,
			file_excluded
		end

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (lst: LIST [PATH])
		do
			list := lst
			depth := 0
		end

	make_empty
		do
			make (create {ARRAYED_LIST [PATH]}.make (0))
		end

	depth: INTEGER

feature -- Access: result

	list: LIST [PATH]
			-- List containing matching info path.	

feature -- Access

	scan_folder (dn: PATH)
			-- Scan directory `dn' for iron package files.
		local
			ut: FILE_UTILITIES
		do
			depth := 0
			if ut.directory_path_exists (dn) then
				process_directory (dn)
			end
		end

	process_directory (dn: PATH)
		do
			depth := depth + 1
			Precursor (dn)
			depth := depth - 1
		end

	process_file (fn: PATH)
			-- Visit file `fn'
		do
			list.force (fn)
		end

feature -- Status

	path_excluded (a_path: PATH): BOOLEAN
		do
			Result := Precursor (a_path) or depth > 2
		end

	file_excluded (fn: PATH): BOOLEAN
		do
			Result := not fn.name.ends_with (".info")
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
