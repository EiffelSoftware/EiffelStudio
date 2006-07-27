indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TASK_SECTION

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

create
	make

feature {NONE} -- Initialization

	make (a_task: like task; a_type: STRING; a_target: like target; a_window: like configuration_window) is
			-- Create.
		require
			a_task_not_void: a_task /= Void
			a_type_ok: a_type.is_equal (conf_interface_names.task_pre) or a_type.is_equal (conf_interface_names.task_post)
			a_target_not_void: a_target /= Void
			a_window_not_void: a_window /= Void and then not a_window.is_destroyed
		do
			task := a_task
			type := a_type
			target := a_target
			make_target_section (a_target, a_window)
		ensure
			task_set: task = a_task
			type_set: type = a_type
			target_set: target = a_target
		end

feature -- Access

	task: CONF_ACTION
			-- Task for which information are displayed.

	type: STRING
			-- Type of the task.

	name: STRING is
			-- Name of the section.
		do
			Result := task.command
		end

	icon: EV_PIXMAP is
			-- Icon of the section.
		once
			Result := pixmaps.icon_pixmaps.project_settings_task_icon
		end

feature -- Element update

	ask_remove_task is
			-- Ask for confirmation and remove `Current'.
		local
			l_cd: EV_CONFIRMATION_DIALOG
		do
			create l_cd.make_with_text_and_actions (conf_interface_names.target_remove_task (name), <<agent remove_task>>)
			l_cd.show_modal_to_window (configuration_window)
		end

feature {NONE} -- Implementation

	remove_task is
			-- Remove `Current' from the configuration and from the tree where it is displayed.
			-- Also remove the parent node if it is empty.
		local
			l_parent, l_grand_parent: EV_TREE_NODE_LIST
			l_par_node, l_grand_par_node: EV_TREE_NODE
		do
			target.remove_action (task)

			l_parent := parent
			l_parent.start
			l_parent.prune (Current)
			l_par_node ?= l_parent
			check
				correct_parent: l_par_node /= Void
			end
			if l_parent.is_empty then
				l_grand_parent := l_par_node.parent
				l_grand_parent.start
				l_grand_parent.prune (l_par_node)
				l_grand_par_node ?= l_grand_parent
				check
					correct_grand_parent: l_grand_par_node /= Void
				end
				l_grand_par_node.enable_select
			else
				l_par_node.enable_select
			end
		end

	context_menu: EV_MENU is
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result

			create l_item.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_task)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)

			create l_item.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.tool_properties_icon)
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_properties_target_tasks (target, task, type))
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_task)
			toolbar.remove_button.enable_sensitive
		end

invariant
	task_not_void: task /= Void
	target_not_void: target /= Void
	type_ok: type.is_equal (conf_interface_names.task_pre) or type.is_equal (conf_interface_names.task_post)

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
