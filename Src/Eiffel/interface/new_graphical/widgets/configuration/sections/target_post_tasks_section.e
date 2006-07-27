indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_POST_TASKS_SECTION

inherit
	TARGET_SECTION
		redefine
			name,
			icon,
			create_context_menu,
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

feature -- Access

	name: STRING is
			-- Name of the section.
		once
			Result := conf_interface_names.task_post_tree
		end

	icon: EV_PIXMAP is
			-- Icon of the section.
		once
			Result := pixmaps.icon_pixmaps.project_settings_tasks_icon
		end

feature -- Element update

	add_task is
			-- Add a new compilation task.
		local
			l_task: CONF_ACTION
			l_task_sec: TASK_SECTION
		do
				-- create configuration
			l_task := configuration_window.conf_factory.new_action ("new", False, Void)
			target.add_post_compile (l_task)

				-- create and select section
			create l_task_sec.make (l_task, conf_interface_names.task_post, target, configuration_window)
			extend (l_task_sec)
			expand
			l_task_sec.enable_select
		end

feature {NONE} -- Implementation

	create_context_menu: EV_MENU is
			-- Context menu with available actions for `Current'.
		do
			create Result
			Result.extend (create {EV_MENU_ITEM}.make_with_text_and_action (conf_interface_names.general_add, agent add_task))
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_empty_section (conf_interface_names.selection_tree_select_node))
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.reset_sensitive

			toolbar.add_post_task_button.select_actions.wipe_out
			toolbar.add_post_task_button.select_actions.extend (agent add_task)
			toolbar.add_post_task_button.enable_sensitive
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
