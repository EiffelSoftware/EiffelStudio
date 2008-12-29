note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_GROUPS_SECTION

inherit
	TARGET_SECTION
		redefine
			name,
			icon,
			context_menu,
			create_select_actions,
			update_toolbar_sensitivity
		end

create
	make

feature -- Access

	clusters: like internal_clusters
			-- Clusters.
		do
			if internal_clusters /= Void and then has (internal_clusters) then
				Result := internal_clusters
			end
		end

	overrides: like internal_overrides
			-- Overrides.
		do
			if internal_overrides /= Void and then has (internal_overrides) then
				Result := internal_overrides
			end
		end

	assemblies: like internal_assemblies
			-- Assemblies.
		do
			if internal_assemblies /= Void and then has (internal_assemblies) then
				Result := internal_assemblies
			end
		end

	libraries: like internal_libraries
			-- Libraries.
		do
			if internal_libraries /= Void and then has (internal_libraries) then
				Result := internal_libraries
			end
		end

	precompile: like internal_precompile
			-- Precompile.
		do
			if internal_precompile /= Void and then has (internal_precompile) then
				Result := internal_precompile
			end
		end

	name: STRING_GENERAL
			-- Name of the section.
		once
			Result := conf_interface_names.section_groups
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.project_settings_groups_icon
		end

feature -- Simple operation

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.add_cluster_button.select_actions.wipe_out
			toolbar.add_cluster_button.select_actions.extend (agent add_cluster)
			toolbar.add_cluster_button.enable_sensitive

			toolbar.add_override_button.select_actions.wipe_out
			toolbar.add_override_button.select_actions.extend (agent add_override)
			toolbar.add_override_button.enable_sensitive

			toolbar.add_assembly_button.select_actions.wipe_out
			toolbar.add_assembly_button.select_actions.extend (agent add_assembly)
			toolbar.add_assembly_button.enable_sensitive

			toolbar.add_library_button.select_actions.wipe_out
			toolbar.add_library_button.select_actions.extend (agent add_library)
			toolbar.add_library_button.enable_sensitive

			if target.internal_precompile = Void then
				toolbar.add_precompile_button.select_actions.wipe_out
				toolbar.add_precompile_button.select_actions.extend (agent add_precompile)
				toolbar.add_precompile_button.enable_sensitive
			end
		end

feature -- Element update

	add_cluster
			-- Add a new cluster.
		do
			if clusters = Void then
				create internal_clusters.make (target, configuration_window)
				extend (internal_clusters)
			end
			internal_clusters.add_group

			order_headers
		end

	add_override
			-- Add a new override.
		do
			if overrides = Void then
				create internal_overrides.make (target, configuration_window)
				extend (internal_overrides)
			end
			internal_overrides.add_group

			order_headers
		end

	add_assembly
			-- Add a new assembly.
		do
			if assemblies = Void then
				create internal_assemblies.make (target, configuration_window)
				extend (internal_assemblies)
			end
			internal_assemblies.add_group

			order_headers
		end

	add_library
			-- Add a new library.
		do
			if libraries = Void then
				create internal_libraries.make (target, configuration_window)
				extend (internal_libraries)
			end
			internal_libraries.add_group

			order_headers
		end

	add_precompile
			-- Add a new precompile.
		do
			if precompile = Void then
				create internal_precompile.make (target, configuration_window)
				extend (internal_precompile)
			end
			internal_precompile.add_group

			order_headers
		end

	set_clusters (a_groups: HASH_TABLE [CONF_CLUSTER, STRING])
			-- Set groups.
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create internal_clusters.make (target, configuration_window)

				internal_clusters.set_groups (a_groups)

				order_headers
			end
		end

	set_overrides (a_groups: HASH_TABLE [CONF_OVERRIDE, STRING])
			-- Set overrides.
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create internal_overrides.make (target, configuration_window)

				internal_overrides.set_groups (a_groups)

				order_headers
			end
		end

	set_assemblies (a_groups: HASH_TABLE [CONF_ASSEMBLY, STRING])
			-- Set assemblies.
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create internal_assemblies.make (target, configuration_window)

				internal_assemblies.set_groups (a_groups)

				order_headers
			end
		end

	set_libraries (a_groups: HASH_TABLE [CONF_LIBRARY, STRING])
			-- Set libraries.
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create internal_libraries.make (target, configuration_window)

				internal_libraries.set_groups (a_groups)

				order_headers
			end
		end

	set_precompile (a_group: CONF_PRECOMPILE)
			-- Set precompile.
		local
			l_ht: HASH_TABLE [CONF_PRECOMPILE, STRING]
		do
			if a_group /= Void then
				create internal_precompile.make (target, configuration_window)

				create l_ht.make (1)
				l_ht.force (a_group, a_group.name)

				internal_precompile.set_groups (l_ht)

				order_headers
			end
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (5)

			create l_item.make_with_text_and_action (conf_interface_names.group_add_cluster, agent add_cluster)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_cluster_icon)

			create l_item.make_with_text_and_action (conf_interface_names.group_add_override, agent add_override)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_override_cluster_icon)

			create l_item.make_with_text_and_action (conf_interface_names.group_add_assembly, agent add_assembly)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_reference_icon)

			create l_item.make_with_text_and_action (conf_interface_names.group_add_library, agent add_library)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_library_icon)

			create l_item.make_with_text_and_action (conf_interface_names.group_add_precompile, agent add_precompile)
			Result.extend (l_item)
			if target.internal_precompile /= Void then
				l_item.disable_sensitive
			end
			l_item.set_pixmap (conf_pixmaps.new_precompiled_library_icon)
		end

feature {NONE} -- Implementation

	internal_clusters: TARGET_CLUSTERS_SECTION
			-- Clusters (Could still be present even if it removed from Current)

	internal_overrides: TARGET_OVERRIDES_SECTION
			-- Overrides (Could still be present even if it removed from Current)

	internal_assemblies: TARGET_ASSEMBLIES_SECTION
			-- Assemblies (Could still be present even if it removed from Current)

	internal_libraries: TARGET_LIBRARIES_SECTION
			-- Libraries (Could still be present even if it removed from Current)

	internal_precompile: TARGET_PRECOMPILES_SECTION
			-- Precompile (Could still be present even if it removed from Current)

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_empty_section (conf_interface_names.selection_tree_select_node))
		end

	order_headers
			-- Order headers in correct order.
		local
			l_cl, l_ov, l_as, l_lib, l_pre: BOOLEAN
		do
			if internal_clusters /= Void then
				l_cl := internal_clusters.is_expanded
			end
			if internal_overrides /= Void then
				l_ov := internal_overrides.is_expanded
			end
			if internal_assemblies /= Void then
				l_as := internal_assemblies.is_expanded
			end
			if internal_libraries /= Void then
				l_lib := internal_libraries.is_expanded
			end
			if internal_precompile /= Void then
				l_pre := internal_precompile.is_expanded
			end

			wipe_out

			if internal_clusters /= Void and then not internal_clusters.is_empty then
				extend (internal_clusters)
				if l_cl then
					internal_clusters.expand
				end
			end
			if internal_overrides /= Void and then not internal_overrides.is_empty then
				extend (internal_overrides)
				if l_ov then
					internal_overrides.expand
				end
			end
			if internal_assemblies /= Void and then not internal_assemblies.is_empty then
				extend (internal_assemblies)
				if l_as then
					internal_assemblies.expand
				end
			end
			if internal_libraries /= Void and then not internal_libraries.is_empty then
				extend (internal_libraries)
				if l_lib then
					internal_libraries.expand
				end
			end
			if internal_precompile /= Void and then not internal_precompile.is_empty then
				extend (internal_precompile)
				if l_pre then
					internal_precompile.expand
				end
			end
		end

note
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
