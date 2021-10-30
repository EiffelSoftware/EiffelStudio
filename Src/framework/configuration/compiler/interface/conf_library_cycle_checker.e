note
	description: "Checker of library dependency cycles"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LIBRARY_CYCLE_CHECKER

inherit
	DIRECTED_GRAPH [CONF_TARGET]
		rename
			vertices as targets,
			out_bound_vertices as dependent_targets
		end

create
	make_with_targets

feature {NONE} -- Initialization

	make_with_targets (a_targets: like targets)
			-- Initialization
		do
			targets := a_targets
		ensure
			targets_set: targets = a_targets
		end

feature -- Access

	library_cycles: ARRAYED_LIST [SEARCH_TABLE [CONF_TARGET]]
			-- Does `a_system' have library dependency cycle?
		local
			l_cycle_finder: TARJAN_STRONGLY_CONNECTED_ALGORITHM [CONF_TARGET]
		do
			create l_cycle_finder.make_with_graph (Current)
			l_cycle_finder.compute_cycle
			Result := l_cycle_finder.cycles
		end

feature -- Access

	targets: ITERABLE [CONF_TARGET]
			-- Vertices

	dependent_targets (v: CONF_TARGET): ITERABLE [CONF_TARGET]
			-- Vertices lead away from the vertex `v'.
		local
			l_libraries: STRING_TABLE [CONF_LIBRARY]
			l_targets: ARRAYED_LIST [CONF_TARGET]
		do
			l_libraries := v.libraries
			create l_targets.make (l_libraries.count)
			across
				l_libraries as l_c
			loop
				if attached l_c.library_target as l_target then
					l_targets.extend (l_target)
				end
			end
			Result := l_targets
		end

feature {NONE} -- Implementation

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
