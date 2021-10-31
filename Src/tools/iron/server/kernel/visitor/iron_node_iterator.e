note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_ITERATOR

inherit
	IRON_NODE_VISITOR

feature -- Visit

	visit_node (v: IRON_NODE)
		local
			l_versions: IRON_NODE_VERSION_COLLECTION
		do
			l_versions := v.database.versions
			l_versions.reverse_sort
			across
				l_versions as ic
			loop
				ic.accept (Current)
			end
		end

	visit_version (v: IRON_NODE_VERSION)
		do

		end

	visit_package (p: IRON_NODE_PACKAGE)
		do
			-- Iterate on version?
		end

	visit_package_version (p: IRON_NODE_VERSION_PACKAGE)
		do
		end

	visit_project (p: IRON_NODE_PACKAGE_PROJECT)
		do
		end

	visit_package_iterable (it: ITERABLE [IRON_NODE_PACKAGE])
		do
			across
				it as ic
			loop
				ic.accept (Current)
			end
		end

	visit_package_version_iterable (it: ITERABLE [IRON_NODE_VERSION_PACKAGE])
		do
			across
				it as ic
			loop
				ic.accept (Current)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
