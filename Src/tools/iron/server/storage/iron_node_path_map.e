note
	description: "[
			Path association map between `path' and `package' for a specific version
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_PATH_MAP

create
	make

feature {NONE} -- Initialization

	make (v: like version)
			-- Initialize `Current'.
		do
			version := v
			create maps.make (1)
		end

feature -- Status

	version: IRON_NODE_VERSION
			-- Associated version.

	maps: STRING_TABLE [attached like paths]
			-- Paths indexed by package's `id'.

feature -- Access

	paths (a_package_id: READABLE_STRING_GENERAL): ARRAYED_LIST [READABLE_STRING_32]
			-- Path associated with package
		local
			lst: detachable like paths
		do
			lst := maps.item (a_package_id)
			if lst = Void then
				create lst.make (1)
				maps.force (lst, a_package_id)
			end
			Result := lst
		end

feature -- Change

	register_path (a_package_id: READABLE_STRING_GENERAL; a_path: READABLE_STRING_32)
		do
			paths (a_package_id).force (a_path)
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
