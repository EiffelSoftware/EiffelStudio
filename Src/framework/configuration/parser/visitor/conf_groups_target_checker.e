note
	description: "Check the validity of parent target (detect cycle, and missing target)."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_GROUPS_TARGET_CHECKER

inherit
	CONF_ACCESS

	CONF_INTERFACE_CONSTANTS

	CONF_ITERATOR
		redefine
			process_target,
			process_group,
			process_assembly,
			process_cluster,
			process_library,
			process_override,
			process_precompile
		end

create
	make,
	make_with_observer

feature {NONE} -- Creation

	make
			-- Build current checker.
		do
				-- Internal data			
			create group_list.make (0)
			create dependency_list.make (0)
			create overrides_list.make (0)
		end

	make_with_observer (o: CONF_ERROR_OBSERVER)
			-- Build Current checker, and associate with observer `o`,
			-- and report error (if any) to observer `o`.
		do
			observer := o
			make
		end

feature -- Basic operation

	check_system (cfg: CONF_SYSTEM)
		do
			reset
			across
				cfg.targets as ic
			until
				has_error
			loop
				check_target (ic)
			end
		end

	check_target (a_target: CONF_TARGET)
			-- Check target `a_target` for parent target validity, especially remote parent target issues.
		do
			reset
			report_issue_as_error
			process_target (a_target)
			if not has_error then
					-- Resolve overrides.
				resolve_overrides
			end
			if not has_error then
					-- Resolve dependencies.
				resolve_dependencies
			end
		end

feature {NONE} -- Implementation

	resolve_overrides
		local
			l_override: CONF_OVERRIDE
			l_e_ov: CONF_ERROR_OVERRIDE
			l_grundef_error: CONF_ERROR_GRUNDEF
		do
			if attached overrides_list as l_overrides_list and then not l_overrides_list.is_empty then
				across
					l_overrides_list as ic
				loop
					l_override := ic
					if attached l_override.override_group_names as l_grp_names then
						across
							l_grp_names as g_ic
						until
							has_error
						loop
							if attached group_list.item (g_ic) as g then
								if g.is_override then
									create l_e_ov
									l_e_ov.set_group (g.name)
								else
									l_override.add_override (g)
								end
							else
								create l_grundef_error
								l_grundef_error.set_group (g_ic)
								report_conf_error (l_grundef_error)
							end
						end
						l_override.reset_override_group_names
					end
				end
			end
		end

	resolve_dependencies
		local
			l_cluster: CONF_CLUSTER
			l_grundef_error: CONF_ERROR_GRUNDEF
		do
			if attached dependency_list as l_dependency_list and then not l_dependency_list.is_empty then
				across
					l_dependency_list as ic
				loop
					l_cluster := ic
					if attached l_cluster.dependency_names as l_dep_names then
						across
							l_dep_names as d_ic
						until
							has_error
						loop
							if attached group_list.item (d_ic) as g then
								l_cluster.add_dependency (g)
							else
								create l_grundef_error
								l_grundef_error.set_group (d_ic)
								report_conf_error (l_grundef_error)
							end
						end
						l_cluster.reset_dependency_names
					end
				end
			end
		end

feature -- Access

	current_library: detachable CONF_LIBRARY

	current_group: detachable CONF_GROUP

	current_target: detachable CONF_TARGET

	dependency_list: ARRAYED_LIST [CONF_CLUSTER]
			-- The list of clusters, that have a uses clause on something.
			-- Entries will be handled at the end.

	overrides_list: ARRAYED_LIST [CONF_OVERRIDE]
			-- List of CONF_OVERRIDE to resolve, once all groups are known.
			-- Entries will be handled at the end.

	group_list: STRING_TABLE [CONF_GROUP]
			-- All groups of `current_target', to check for name conflicts and to compute dependencies and overrides.

feature -- Visit nodes		

	process_target (a_target: CONF_TARGET)
		do
			if not is_checking_stopped then
				current_target := a_target
				if attached a_target.extends as l_parent then
					l_parent.process (Current)
				else
					check not a_target.has_unresolved_parent end
					-- It can occur if the location of the parent_reference is bad.
				end
--				Precursor (a_target)
				if not is_checking_stopped then
					if attached a_target.internal_precompile as l_pre then
						l_pre.process (Current)
					end
					across
						a_target.internal_libraries as i
					loop
						i.process (Current)
					end
					across
						a_target.internal_assemblies as i
					loop
						i.process (Current)
					end
					across
						a_target.internal_clusters as i
					loop
						i.process (Current)
					end
					across
						a_target.internal_overrides as i
					loop
						i.process (Current)
					end
				end
				current_target := a_target
			end
		end

	process_group (a_group: CONF_GROUP)
			-- Visit `a_group'.
		do
			if not is_checking_stopped then
				current_group := a_group
				Precursor (a_group)
				current_group := a_group
			end
		end

	process_assembly (a_assembly: CONF_ASSEMBLY)
		do
			if not is_checking_stopped then
				if group_list.has (a_assembly.name) then
					report_conf_error (create {CONF_ERROR_PARSE}.make (conf_interface_names.e_parse_incorrect_assembly_conflict (a_assembly.name)))
				else
					group_list.put (a_assembly, a_assembly.name)
				end

				current_group := a_assembly
				Precursor (a_assembly)
				current_group := a_assembly
			end
		end

	process_cluster (a_cluster: CONF_CLUSTER)
		do
			if not is_checking_stopped then
				if group_list.has (a_cluster.name) then
					report_conf_error (create {CONF_ERROR_PARSE}.make (conf_interface_names.e_parse_incorrect_cluster_conflict (a_cluster.name)))
				else
					group_list.put (a_cluster, a_cluster.name)
				end

				current_group := a_cluster
				if attached a_cluster.dependency_names as l_dep_names then
					dependency_list.force (a_cluster)
				end
				Precursor (a_cluster)
				current_group := a_cluster
			end
		end

	process_library (a_library: CONF_LIBRARY)
		do
			if not is_checking_stopped then
				if attached group_list.item (a_library.name) as l_group then
					if attached {CONF_LIBRARY} l_group as l_lib and then a_library.location.evaluated_path.same_as (l_lib.location.evaluated_path) then
							-- No error
					else
						report_conf_error (create {CONF_ERROR_PARSE}.make (conf_interface_names.e_parse_incorrect_library_conflict (a_library.name)))
					end
				else
					group_list.put (a_library, a_library.name)
				end

				current_group := a_library
				current_library := a_library
				Precursor (a_library)
				current_group := a_library
				current_library := a_library
			end
		end

	process_override (a_override: CONF_OVERRIDE)
		do
			if not is_checking_stopped then
				if attached a_override.override_group_names as l_grp_names then
					overrides_list.force (a_override)
				end
				process_cluster (a_override)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
		do
			if not is_checking_stopped then
				if group_list.has (a_precompile.name) then
					report_conf_error (create {CONF_ERROR_PARSE}.make (conf_interface_names.e_parse_incorrect_precompile_conflict (a_precompile.name)))
				else
					group_list.put (a_precompile, a_precompile.name)
				end

				current_group := a_precompile
				Precursor (a_precompile)
				current_group := a_precompile
			end
		end

feature -- Access	

	observer: detachable CONF_ERROR_OBSERVER

	report_conf_error (e: CONF_ERROR)
		do
			add_error (e)
			if attached observer as obs then
				if error_reported_as_warning then
					obs.report_warning (e)
				else
					obs.report_error (e)
				end
			end
		ensure
			has_error: has_error
		end

feature -- Status report		

	has_error: BOOLEAN
		do
			Result := is_error -- last_error /= Void
		end

	is_checking_stopped: BOOLEAN
		do
			Result := has_error
		end

feature -- Settings

	error_reported_as_warning: BOOLEAN

	error_reported_as_error: BOOLEAN
		do
			Result := not error_reported_as_warning
		end

	report_issue_as_warning
		do
			error_reported_as_warning := True
		end

	report_issue_as_error
		do
			error_reported_as_warning := False
		end

feature {NONE} -- Execution

	reset
		do
			report_issue_as_error
			last_errors := Void
			current_group := Void
			current_library := Void
			current_target := Void
			group_list.wipe_out
			dependency_list.wipe_out
			overrides_list.wipe_out
		ensure
			has_no_error: not has_error
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
