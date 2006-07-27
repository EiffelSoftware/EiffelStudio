indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_SECTION

inherit
	GROUP_SECTION
		redefine
			context_menu,
			group,
			ask_remove_group,
			remove_group,
			update_toolbar_sensitivity
		end

create
	make

feature -- Access

	group: CONF_CLUSTER
		-- Group for which information are displayed.

feature -- Element update

	ask_remove_group is
			-- Ask for confirmation and remove `Current'.
		local
			l_wd: EV_WARNING_DIALOG
		do
			if group.children /= Void and then not group.children.is_empty then
				create l_wd.make_with_text (conf_interface_names.target_remove_group_children (group.name))
				l_wd.show_modal_to_window (configuration_window)
			else
				Precursor {GROUP_SECTION}
			end
		end

	remove_group is
			-- Remove `Current' from the configuration and from the tree where it is displayed.
			-- Also remove the parent node if it is empty and is not a cluster.
		local
			l_parent: like group
			l_tree_parent: EV_TREE_NODE_LIST
		do
			target.remove_cluster (group.name)
			l_parent := group.parent
			if l_parent /= Void then
				l_parent.remove_child (group)
				l_tree_parent := parent
				l_tree_parent.start
				l_tree_parent.prune (Current)
			else
				Precursor
			end
		end

	set_children (a_children: ARRAYED_LIST [like group]) is
			-- Set child clusters.
		local
			l_cluster: CONF_CLUSTER
			l_sec: like Current
		do
			if a_children /= Void then
				from
					a_children.start
				until
					a_children.after
				loop
					l_cluster := a_children.item
					create l_sec.make (l_cluster, target, configuration_window)
					extend (l_sec)
					l_sec.set_children (l_cluster.children)
					a_children.forth
				end
			end
		end

	add_subcluster is
			-- Add a subcluster.
		local
			l_dial: like add_dialog_type
			l_group: like group
			l_group_sec: like Current
		do
			create l_dial.make (target, configuration_window.conf_factory)
			l_dial.set_parent_cluster (group)
			l_dial.show_modal_to_window (configuration_window)
			if l_dial.is_ok then
				l_group := l_dial.last_group

					-- create and select the section
				create l_group_sec.make (l_group, target, configuration_window)
				extend (l_group_sec)
				expand
				l_group_sec.enable_select
			end
		end

feature {NONE} -- Implementation

	context_menu: EV_MENU is
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result

			create l_item.make_with_text_and_action (conf_interface_names.group_add_subcluster, agent add_subcluster)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.new_cluster_icon)

			create l_item.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_group)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)

			create l_item.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.tool_properties_icon)
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			Precursor

			toolbar.add_cluster_button.select_actions.wipe_out
			toolbar.add_cluster_button.select_actions.extend (agent add_subcluster)
			toolbar.add_cluster_button.enable_sensitive
		end

feature {NONE} -- Type anchors

	add_dialog_type: CREATE_CLUSTER_DIALOG;
			-- Type of the add dialog

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
