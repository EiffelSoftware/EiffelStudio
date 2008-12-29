note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_TASKS_SECTION

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

	name: STRING_GENERAL
			-- Name of the section.
		once
			Result := conf_interface_names.section_tasks
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.project_settings_tasks_icon
		end

	pre_tasks: TARGET_PRE_TASKS_SECTION
			-- Header for pre compilation tasks.
		do
			if internal_pre_tasks /= Void and then has (internal_pre_tasks) then
				Result := internal_pre_tasks
			end
		end

	post_tasks: TARGET_POST_TASKS_SECTION
			-- Header for post compilation tasks.
		do
			if internal_post_tasks /= Void and then has (internal_post_tasks) then
				Result := internal_post_tasks
			end
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (2)

			create l_item.make_with_text_and_action (conf_interface_names.task_add_pre, agent add_pre_compilation)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_pre_compilation_task_icon)

			create l_item.make_with_text_and_action (conf_interface_names.task_add_post, agent add_post_compilation)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_post_compilation_task_icon)
		end

feature -- Simple operations

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.add_pre_task_button.select_actions.wipe_out
			toolbar.add_pre_task_button.select_actions.extend (agent add_pre_compilation)
			toolbar.add_pre_task_button.enable_sensitive

			toolbar.add_post_task_button.select_actions.wipe_out
			toolbar.add_post_task_button.select_actions.extend (agent add_post_compilation)
			toolbar.add_post_task_button.enable_sensitive
		end

feature -- Element update

	add_pre_compilation
			-- Add a new pre compilation task.
		do
			if pre_tasks = Void then
				create internal_pre_tasks.make (target, configuration_window)
				put_front (internal_pre_tasks)
			end
			internal_pre_tasks.add_task
		end

	add_post_compilation
			-- Add a new post compilation task.
		do
			if post_tasks = Void then
				create internal_post_tasks.make (target, configuration_window)
				extend (internal_post_tasks)
			end
			internal_post_tasks.add_task
		end

	set_pre_compilation (a_tasks: ARRAYED_LIST [CONF_ACTION])
			-- Set pre compilation tasks to `a_tasks'.
		local
			l_task: TASK_SECTION
		do
			if a_tasks /= Void and then not a_tasks.is_empty then
				create internal_pre_tasks.make (target, configuration_window)
				put_front (internal_pre_tasks)
				from
					a_tasks.start
				until
					a_tasks.after
				loop
					create l_task.make (a_tasks.item, conf_interface_names.task_pre, target, configuration_window)
					internal_pre_tasks.extend (l_task)
					a_tasks.forth
				end
			end
		end

	set_post_compilation (a_tasks: ARRAYED_LIST [CONF_ACTION])
			-- Set post compilation tasks to `a_tasks'.
		local
			l_task: TASK_SECTION
		do
			if a_tasks /= Void and then not a_tasks.is_empty then
				create internal_post_tasks.make (target, configuration_window)
				extend (internal_post_tasks)
				from
					a_tasks.start
				until
					a_tasks.after
				loop
					create l_task.make (a_tasks.item, conf_interface_names.task_post, target, configuration_window)
					internal_post_tasks.extend (l_task)
					a_tasks.forth
				end
			end
		end

feature {NONE} -- Implementation

	internal_pre_tasks: TARGET_PRE_TASKS_SECTION
			-- Header for pre compilation tasks. (Could still be present even if it removed from Current)

	internal_post_tasks: TARGET_POST_TASKS_SECTION
			-- Header for post compilation tasks. (Could still be present even if it removed from Current)

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_empty_section (conf_interface_names.selection_tree_select_node))
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
