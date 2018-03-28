note
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
			if attached internal_clusters as c and then has (c) then
				Result := c
			end
		end

	overrides: like internal_overrides
			-- Overrides.
		do
			if attached internal_overrides as o and then has (o) then
				Result := o
			end
		end

	assemblies: like internal_assemblies
			-- Assemblies.
		do
			if attached internal_assemblies as a and then has (a) then
				Result := a
			end
		end

	libraries: like internal_libraries
			-- Libraries.
		do
			if attached internal_libraries as l and then has (l) then
				Result := l
			end
		end

	precompile: like internal_precompile
			-- Precompile.
		do
			if attached internal_precompile as p and then has (p) then
				Result := p
			end
		end

	name: READABLE_STRING_32
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
		local
			c: like clusters
		do
			c := clusters
			if not attached c then
				create c.make (target, configuration_window)
				internal_clusters := c
				extend (c)
			end
			c.add_group
			order_headers
		end

	add_override
			-- Add a new override.
		local
			o: like overrides
		do
			o := overrides
			if not attached o then
				create o.make (target, configuration_window)
				internal_overrides := o
				extend (o)
			end
			o.add_group
			order_headers
		end

	add_assembly
			-- Add a new assembly.
		local
			a: like assemblies
		do
			a := assemblies
			if not attached a then
				create a.make (target, configuration_window)
				internal_assemblies := a
				extend (a)
			end
			a.add_group
			order_headers
		end

	add_library
			-- Add a new library.
		local
			l: like libraries
		do
			l := libraries
			if not attached l then
				create l.make (target, configuration_window)
				internal_libraries := l
				extend (l)
			end
			l.add_group
			order_headers
		end

	add_precompile
			-- Add a new precompile.
		local
			p: like precompile
		do
			p := precompile
			if not attached p then
				create p.make (target, configuration_window)
				internal_precompile := p
				extend (p)
			end
			p.add_group
			order_headers
		end

	set_clusters (a_groups: STRING_TABLE [CONF_CLUSTER])
			-- Set groups.
		local
			c: like clusters
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create c.make (target, configuration_window)
				internal_clusters := c
				c.set_groups (a_groups)
				order_headers
			end
		end

	set_overrides (a_groups: STRING_TABLE [CONF_OVERRIDE])
			-- Set overrides.
		local
			o: like overrides
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create o.make (target, configuration_window)
				internal_overrides := o
				o.set_groups (a_groups)
				order_headers
			end
		end

	set_assemblies (a_groups: STRING_TABLE [CONF_ASSEMBLY])
			-- Set assemblies.
		local
			a: like assemblies
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create a.make (target, configuration_window)
				internal_assemblies := a
				a.set_groups (a_groups)
				order_headers
			end
		end

	set_libraries (a_groups: STRING_TABLE [CONF_LIBRARY])
			-- Set libraries.
		local
			l: like libraries
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create l.make (target, configuration_window)
				internal_libraries := l
				l.set_groups (a_groups)
				order_headers
			end
		end

	set_precompile (a_group: detachable CONF_PRECOMPILE)
			-- Set precompile.
		local
			l_ht: STRING_TABLE [CONF_PRECOMPILE]
			p: like precompile
		do
			if a_group /= Void then
				create p.make (target, configuration_window)
				internal_precompile := p
				create l_ht.make (1)
				l_ht.force (a_group, a_group.name)
				p.set_groups (l_ht)
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

	internal_clusters: detachable TARGET_CLUSTERS_SECTION
			-- Clusters (Could still be present even if it removed from Current)

	internal_overrides: detachable TARGET_OVERRIDES_SECTION
			-- Overrides (Could still be present even if it removed from Current)

	internal_assemblies: detachable TARGET_ASSEMBLIES_SECTION
			-- Assemblies (Could still be present even if it removed from Current)

	internal_libraries: detachable TARGET_LIBRARIES_SECTION
			-- Libraries (Could still be present even if it removed from Current)

	internal_precompile: detachable TARGET_PRECOMPILES_SECTION
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
			if attached internal_clusters as c then
				l_cl := c.is_expanded
			end
			if attached internal_overrides as o then
				l_ov := o.is_expanded
			end
			if attached internal_assemblies as a then
				l_as := a.is_expanded
			end
			if attached internal_libraries as l then
				l_lib := l.is_expanded
			end
			if attached internal_precompile as p then
				l_pre := p.is_expanded
			end

			wipe_out

			if attached internal_clusters as c and then not c.is_empty then
				extend (c)
				if l_cl then
					c.expand
				end
			end
			if attached internal_overrides as o and then not o.is_empty then
				extend (o)
				if l_ov then
					o.expand
				end
			end
			if attached internal_assemblies as a and then not a.is_empty then
				extend (a)
				if l_as then
					a.expand
				end
			end
			if attached internal_libraries as l and then not l.is_empty then
				extend (l)
				if l_lib then
					l.expand
				end
			end
			if attached internal_precompile as p and then not p.is_empty then
				extend (p)
				if l_pre then
					p.expand
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
