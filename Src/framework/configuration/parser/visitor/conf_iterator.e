indexing
	description: "Iterates through a configuration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ITERATOR

inherit
	CONF_VISITOR

feature -- Visit nodes

	process_system (a_system: CONF_SYSTEM) is
			-- Visit `a_system'.
		local
			l_targets: ARRAYED_LIST [CONF_TARGET]
			l_retried: BOOLEAN
		do
			if not l_retried then
				from
					l_targets := a_system.target_order
					l_targets.start
				until
					l_targets.after
				loop
					l_targets.item.process (Current)
					l_targets.forth
				end
			end
		rescue
			if is_error then
				l_retried := True
				retry
			end
		end

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		do
			if not is_error then
				if a_target.precompile /= Void then
					a_target.precompile.process (Current)
				end
				a_target.libraries.linear_representation.do_all (agent {CONF_LIBRARY}.process (Current))
				a_target.assemblies.linear_representation.do_all (agent {CONF_ASSEMBLY}.process (Current))
				a_target.clusters.linear_representation.do_all (agent {CONF_CLUSTER}.process (Current))
					-- overrides must be processed at the end
				a_target.overrides.linear_representation.do_all (agent {CONF_OVERRIDE}.process (Current))
			end
		rescue
			retry
		end

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		do
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		do
		end

	process_physical_assembly (an_assembly: CONF_PHYSICAL_ASSEMBLY_INTERFACE) is
			-- Visit `an_assembly'.
		do
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		do
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		do
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		do
		end

	process_test_cluster (a_test_cluster: CONF_TEST_CLUSTER) is
			-- <Precursor>
		do
			process_cluster (a_test_cluster)
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
