note
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
			remove_group,
			update_toolbar_sensitivity
		end

create
	make

feature -- Access

	group: CONF_CLUSTER
		-- Group for which information are displayed.

feature -- Element update

	remove_group
			-- Remove `Current' and all children from the configuration and from the tree where it is displayed.
			-- Also remove the parent node if it is empty and is not a cluster.
		local
			l_parent: like group
			l_cs: like Current
		do
				-- remove children
			from
				start
			until
				after
			loop
				l_cs ?= item
				check cluster_section: l_cs /= Void end
				l_cs.remove_group
				forth
			end

				-- remove current
			target.remove_cluster (group.name)
			l_parent := group.parent
			if l_parent /= Void then
				l_parent.remove_child (group)
			end
			Precursor
		end

	set_children (a_children: ARRAYED_LIST [like group])
			-- Set child clusters.
		local
			l_cluster: like group
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

	add_subcluster
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

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (3)

			create l_item.make_with_text_and_action (conf_interface_names.group_add_subcluster, agent add_subcluster)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_cluster_icon)

			create l_item.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_group)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.general_delete_icon)

			create l_item.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.tool_properties_icon)
		end

	update_toolbar_sensitivity
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

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
