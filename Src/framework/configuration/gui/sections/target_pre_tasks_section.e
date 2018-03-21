note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_PRE_TASKS_SECTION

inherit
	TARGET_SECTION
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
			copy,
			is_equal
		end

create
	make

feature -- Access

	name: READABLE_STRING_32
			-- Name of the section.
		once
			Result := conf_interface_names.task_pre_tree
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.project_settings_tasks_icon
		end

feature -- Element update

	add_task
			-- Add a new compilation task.
		local
			l_task: CONF_ACTION
			l_task_sec: TASK_SECTION
		do
				-- create configuration
			l_task := configuration_window.conf_factory.new_action ("new", False, Void)
			target.add_pre_compile (l_task)

				-- create and select section
			create l_task_sec.make (l_task, conf_interface_names.task_pre, target, configuration_window)
			extend (l_task_sec)
			expand
			l_task_sec.enable_select
		end

feature {NONE} -- Implementation

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (1)

			create l_item.make_with_text_and_action (conf_interface_names.task_add_pre, agent add_task)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_pre_compilation_task_icon)
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_empty_section (conf_interface_names.selection_tree_select_node))
		end

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.add_pre_task_button.select_actions.wipe_out
			toolbar.add_pre_task_button.select_actions.extend (agent add_task)
			toolbar.add_pre_task_button.enable_sensitive
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
