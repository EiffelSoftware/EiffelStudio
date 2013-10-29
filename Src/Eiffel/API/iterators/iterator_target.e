note
	description: "[
		Target of the current system (or library).
			-- Iterate groups in a target 
			-- cluster
			-- library
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ITERATOR_TARGET

create
	make

feature {NONE} -- Initialization

	make (a_conf_target: CONF_TARGET)
			-- Create an ITERATOR TARGET based on target `a_conf_target' of current system.
		require
			targe_not_void: a_conf_target /= Void
		do
			conf_target := a_conf_target
		ensure
			conf_target_set: conf_target = a_conf_target
		end

feature -- Access

	conf_target: CONF_TARGET
		-- Configuration Target.

feature -- Iterators

	children: ITERABLE [CONF_TARGET]
			-- Iterator on child targets.
		do
			Result := conf_target.child_targets
		end

	libraries: ITERABLE [CONF_LIBRARY]
			-- Iterator on used libraries.
		do
			Result := conf_target.libraries
		end

	clusters: ITERABLE [CONF_CLUSTER]
			-- Iterator on normal clusters.
		do
			Result := conf_target.clusters
		end

	groups: ITERABLE [CONF_GROUP]
			-- Iterator on all groups of this target (union of clusters, assemblies, overrides and libraries).
		do
			Result := conf_target.groups
		end

invariant
	conf_target_not_void: conf_target /= Void

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
