note
	description: "Summary description for {IRON_NODE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_VISITOR

feature -- Visit

	visit_node (v: IRON_NODE)
		deferred
		end

	visit_version (v: IRON_NODE_VERSION)
		deferred
		end

	visit_package (p: IRON_NODE_PACKAGE)
		deferred
		end

	visit_package_version (p: IRON_NODE_VERSION_PACKAGE)
		deferred
		end

	visit_project (p: IRON_NODE_PACKAGE_PROJECT)
		deferred
		end

	visit_package_iterable (it: ITERABLE [IRON_NODE_PACKAGE])
		deferred
		end

	visit_package_version_iterable (it: ITERABLE [IRON_NODE_VERSION_PACKAGE])
		deferred
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
