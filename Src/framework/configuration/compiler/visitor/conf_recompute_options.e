note
	description: "Recompute options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_RECOMPUTE_OPTIONS

inherit
	CONF_ITERATOR
		export
			{NONE} process_system
		redefine
			process_target,
			process_group
		end

	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_new_target: CONF_TARGET)
			-- Create from `a_new_target'.
		require
			a_new_target_not_void: a_new_target /= Void
		do
			new_target := a_new_target
		end

feature -- Visit nodes

	process_target (a_target: CONF_TARGET)
			-- Visit `a_target'.
		require else
			new_target_group_equivalent: new_target.is_group_equivalent (a_target)
		local
			l_pre, l_old_pre: CONF_PRECOMPILE
			l_new_target: like new_target
		do
			if not is_error then
					-- process parent target
				if a_target.extends /= Void then
					l_new_target := new_target
					new_target := new_target.system.targets.item (a_target.extends.name)
					a_target.extends.process (Current)
					new_target := l_new_target
				end

				a_target.system.set_name (new_target.system.name)
				a_target.system.set_description (new_target.system.description)
				a_target.set_version (new_target.internal_version)
				a_target.set_settings (new_target.internal_settings)
				a_target.set_immediate_setting_concurrency (new_target.immediate_setting_concurrency)
				if new_target.internal_options /= Void then
					a_target.set_options (new_target.internal_options)
				end
				a_target.set_description (new_target.description)
				a_target.set_note_node (new_target.note_node)
				a_target.set_external_includes (new_target.internal_external_include)
				a_target.set_external_cflag (new_target.internal_external_cflag)
				a_target.set_external_objects (new_target.internal_external_object)
				a_target.set_external_libraries (new_target.internal_external_library)
				a_target.set_external_resources (new_target.internal_external_resource)
				a_target.set_external_linker_flag (new_target.internal_external_linker_flag)
				a_target.set_external_make (new_target.internal_external_make)
				a_target.set_pre_compile (new_target.internal_pre_compile_action)
				a_target.set_post_compile (new_target.internal_post_compile_action)
				a_target.set_file_rules (new_target.internal_file_rule)

				l_pre := a_target.precompile
				if l_pre /= Void then
					l_old_pre := new_target.precompile
					check
						l_old_pre_not_void: l_old_pre /= Void
					end
					l_pre.set_options (l_old_pre.internal_options)
					l_pre.set_class_options (l_old_pre.internal_class_options)
				end
				process_with_new (a_target.internal_libraries, new_target.internal_libraries)
				process_with_new (a_target.internal_assemblies, new_target.internal_assemblies)
				process_with_new (a_target.internal_clusters, new_target.internal_clusters)
				process_with_new (a_target.internal_overrides, new_target.internal_overrides)
			end
		end

	process_group (a_group: CONF_GROUP)
			-- Visit `a_group'.
		local
			l_cluster, l_cluster_new: CONF_CLUSTER
			l_lib, l_lib_new: CONF_LIBRARY
		do
			if not is_error then
				a_group.set_description (new_group.description)
				a_group.set_options (new_group.internal_options)
				a_group.set_class_options (new_group.internal_class_options)
				a_group.set_readonly (new_group.internal_read_only)
				a_group.set_readonly_set (new_group.is_readonly_set)
				a_group.set_note_node (new_group.note_node)
				if a_group.is_cluster then
					l_cluster ?= a_group
					l_cluster_new ?= new_group
					l_cluster.set_file_rule (l_cluster_new.internal_file_rule)
				elseif a_group.is_library then
					l_lib ?= a_group
					l_lib_new ?= new_group
					l_lib.set_use_application_options (l_lib_new.use_application_options)
				end
			end
		end

feature -- Access

	new_target: CONF_TARGET
			-- The new, compiled target that is group equivalent to the old target.

	new_group: CONF_GROUP
			-- The new group, for the group we are currently processing.

feature {NONE} -- Implementation

	process_with_new (an_old_groups, a_new_groups: STRING_TABLE [CONF_GROUP])
			-- Process `a_old_groups' and set `new_group' to the corresponding group of `a_new_groups'.
		local
			l_group: CONF_GROUP
		do
			from
				an_old_groups.start
			until
				an_old_groups.after
			loop
				l_group := an_old_groups.item_for_iteration
				new_group := a_new_groups.item (l_group.name)
				check
					new_group_found: new_group /= Void
				end
				l_group.process (Current)
				an_old_groups.forth
			end
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
