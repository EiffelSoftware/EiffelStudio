note
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

	process_redirection (a_redirect: CONF_REDIRECTION)
			-- Visit `a_redirect'.
		do
		end

	process_system (a_system: CONF_SYSTEM)
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
			if
				is_error and then
				attached exception_manager.last_exception as e and then
				attached {CONF_EXCEPTION} e.original
			then
				l_retried := True
				retry
			end
		end

	process_target (a_target: CONF_TARGET)
			-- Visit `a_target'.
		do
			if not is_error then
				if attached a_target.precompile as l_pre then
					l_pre.process (Current)
				end
				across a_target.libraries as i loop i.process (Current) end
				across a_target.assemblies as i loop i.process (Current) end
				across a_target.clusters as i loop i.process (Current) end
					-- Overrides must be processed at the end.
				across a_target.overrides as i loop i.process (Current) end
			end
		rescue
			if
				attached exception_manager.last_exception as e and then
				attached {CONF_EXCEPTION} e.original
			then
				retry
			end
		end

	process_group (a_group: CONF_GROUP)
			-- Visit `a_group'.
		do
		end

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- Visit `an_assembly'.
		do
		end

	process_physical_assembly (an_assembly: CONF_PHYSICAL_ASSEMBLY_INTERFACE)
			-- Visit `an_assembly'.
		do
		end

	process_library (a_library: CONF_LIBRARY)
			-- Visit `a_library'.
		do
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- Visit `a_precompile'.
		do
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- Visit `a_cluster'.
		do
		end

	process_test_cluster (a_test_cluster: CONF_TEST_CLUSTER)
			-- <Precursor>
		do
		end

	process_override (an_override: CONF_OVERRIDE)
			-- Visit `an_override'.
		do
		end

	process_namespace (n: CONF_NAMESPACE)
			-- <Precursor>
		do
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
