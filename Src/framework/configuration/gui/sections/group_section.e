note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GROUP_SECTION

inherit
	TARGET_SECTION
		rename
			make as make_target_section
		redefine
			name,
			icon,
			context_menu,
			create_select_actions,
			update_toolbar_sensitivity
		end

	CONF_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	make (a_group: like group; a_target: like target; a_window: like configuration_window)
			-- Create.
		require
			a_group_not_void: a_group /= Void
			a_target_not_void: a_target /= Void
			a_window_not_void: a_window /= Void and then not a_window.is_destroyed
		do
			group := a_group
			target := a_target
			make_target_section (a_target, a_window)
		ensure
			group_set: group = a_group
			target_set: target = a_target
		end

feature -- Access

	group: CONF_GROUP
			-- Group for which information are displayed.

	name: STRING_GENERAL
			-- Name of the section.
		do
			Result := group.name
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		do
			Result := conf_pixmaps.pixmap_from_group (group)
		end

feature -- Element update

	ask_remove_group
			-- Ask for confirmation and remove `Current'.
		local
			l_msg: STRING_32
		do
			if group.is_library then
				l_msg := conf_interface_names.target_remove_library (name)
			else
				l_msg := conf_interface_names.target_remove_group (name)
			end

			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (
				l_msg, configuration_window, agent remove_group, Void)
		end

	update_pixmap
			-- Update the pixmap if necessary.
		do
			if icon /= pixmap then
				set_pixmap (icon)
			end
		end

feature {NONE} -- Implementation

	remove_group
			-- Remove `Current' from the tree where it is displayed.
			-- Also remove the parent node if it is empty.
		local
			l_parent_head: TARGET_GROUPS_BASE_SECTION
			l_parent, l_grand_parent: EV_TREE_NODE_LIST
			l_par_node, l_grand_par_node: EV_TREE_NODE
			i: INTEGER
		do
			l_parent := parent
			l_parent.start
			i := l_parent.index_of (Current, 1)
			l_parent.prune (Current)
			l_par_node ?= l_parent
			check
				correct_parent: l_par_node /= Void
			end
			l_parent_head ?= l_parent
			if l_parent_head /= Void and then l_parent_head.is_empty then
				l_grand_parent := l_parent_head.parent
				l_grand_parent.start
				l_grand_parent.prune (l_par_node)
				l_grand_par_node ?= l_grand_parent
				check
					correct_grand_parent: l_grand_par_node /= Void
				end
				l_grand_par_node.enable_select
			elseif l_par_node.count >= i then
				l_par_node.i_th (i).enable_select
			elseif i-1 > 0 then
				l_par_node.i_th (i-1).enable_select
			else
				l_par_node.enable_select
			end
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (2)

			create l_item.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_group)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.general_delete_icon)

			create l_item.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.tool_properties_icon)
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_properties_target_groups (target, group))
		end

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_group)
			toolbar.remove_button.enable_sensitive
		end

invariant
	group_not_void: group /= Void

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
