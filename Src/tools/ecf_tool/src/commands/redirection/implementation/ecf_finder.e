note
	description: "Summary description for {ECF_FINDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_FINDER

inherit
	DIRECTORY_ITERATOR
		redefine
			process_file,
			directory_excluded,
			file_excluded
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create ecfs.make (0)
		end

feature -- Access

	reset
		do
			ecfs.wipe_out
		end

	ecfs: ARRAYED_LIST [PATH]

feature -- Visitor

	process_file (fn: PATH)
			-- Visit file `fn'
		do
			check is_ecf: fn.name.ends_with_general (".ecf") end
			ecfs.force (fn)
		end

feature -- Visitor status

	directory_excluded (dn: PATH): BOOLEAN
			-- Is Directory `dn' excluded?
		do
			Result := attached dn.entry as e and then
						(
								e.name.same_string_general ("EIFGENs")
							or  e.name.starts_with_general (".") -- exclude .svn, .git, .*
								-- a .* is not a great place for source files.
						)
		end

	file_excluded (fn: PATH): BOOLEAN
			-- Is file `fn' excluded?
		do
			Result := not fn.name.ends_with_general (".ecf")
		end

;note
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
