indexing
	description: "Objects that represent a target section."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_SECTION

inherit
	CONFIGURATION_SECTION
		rename
			make as make_section
		end

	CONF_ACCESS
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target; a_window: like configuration_window) is
			-- Create.
		require
			a_target_not_void: a_target /= Void
			a_window_not_void: a_window /= Void and then not a_window.is_destroyed
		do
			target := a_target
			make_section (a_window)
		ensure
			target_set: target = a_target
		end

feature -- Access

	target: CONF_TARGET
			-- Target for which information are displayed.

	name: STRING is
			-- Name of the section.
		do
			Result := conf_interface_names.section_target (target.name)
		end

	icon: EV_PIXMAP is
			-- Icon of the section.
		once
			Result := pixmaps.icon_pixmaps.top_level_folder_targets_icon
		end

feature -- Element update

	add_target is
			-- Add a new target that inherits from this one.
		local
			l_target: CONF_TARGET
			l_system: CONF_SYSTEM
		do
			l_system := configuration_window.conf_system
			if not l_system.targets.has ("new") then
					-- add it to the configuration
				l_target := configuration_window.conf_factory.new_target ("new", l_system)
				l_target.set_parent (target)
				l_system.add_target (l_target)

					-- add and display the section
				configuration_window.add_target_sections (l_target, Current)
				expand
				last.enable_select
			end
		end

	ask_remove_target is
			-- Ask for confirmation and remove Current.
		local
			l_cd: EV_CONFIRMATION_DIALOG
			l_wd: EV_WARNING_DIALOG
			l_targets: ARRAYED_LIST [CONF_TARGET]
		do
			if target.system.targets.count = 1 then
				create l_wd.make_with_text (conf_interface_names.target_remove_last)
			elseif target.system.library_target = target then
				create l_wd.make_with_text (conf_interface_names.target_remove_library_target)
			else
				from
					l_targets := target.system.target_order
					l_targets.start
					l_targets.search (target)
					check
						found: not l_targets.exhausted
					end
				until
					l_wd /= Void or l_targets.after
				loop
					if l_targets.item.extends = target then
						create l_wd.make_with_text (conf_interface_names.target_remove_extends (l_targets.item.name))
					end
					l_targets.forth
				end
			end

			if l_wd /= Void then
				l_wd.show_modal_to_window (configuration_window)
			else
				create l_cd.make_with_text_and_actions (conf_interface_names.remove_target (name), <<agent remove_target>>)
				l_cd.show_modal_to_window (configuration_window)
			end
		end

feature {NONE} -- Implementation

	groups_section: TARGET_GROUPS_SECTION is
			-- Groups sub section.
		do
			from
				start
			until
				Result /= Void
			loop
				check
					not_after: not after
				end
				Result ?= item
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	advanced_section: TARGET_ADVANCED_SECTION is
			-- Advanced sub section.
		do
			from
				start
			until
				Result /= Void
			loop
				check
					not_after: not after
				end
				Result ?= item
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	externals_section: TARGET_EXTERNALS_SECTION is
			-- Externals sub section.
		local
			l_advanced: TARGET_ADVANCED_SECTION
		do
			l_advanced := advanced_section
			check
				found_advanced: l_advanced /= Void
			end
			from
				l_advanced.start
			until
				Result /= Void
			loop
				check
					not_after: not l_advanced.after
				end
				Result ?= l_advanced.item
				l_advanced.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	tasks_section: TARGET_TASKS_SECTION is
			-- Tasks sub section.
		local
			l_advanced: TARGET_ADVANCED_SECTION
		do
			l_advanced := advanced_section
			check
				found_advanced: l_advanced /= Void
			end
			from
				l_advanced.start
			until
				Result /= Void
			loop
				check
					not_after: not l_advanced.after
				end
				Result ?= l_advanced.item
				l_advanced.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	remove_target is
			-- Remove `Current' from the configuration and from the tree where it is displayed.
		local
			l_parent_tree: EV_TREE
			l_parent: EV_TREE_NODE_LIST
			l_par_node: EV_TREE_NODE
		do
			configuration_window.conf_system.remove_target (target.name)

			l_parent := parent
			l_parent_tree := parent_tree
			l_parent.start
			l_parent.prune (Current)
			l_par_node ?= l_parent
			if l_par_node /= Void then
				l_par_node.enable_select
			else
				l_parent_tree.first.enable_select
			end
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM] is
			-- Context menu with available actions for `Current'.
		local
			l_groups: TARGET_GROUPS_SECTION
			l_externals: TARGET_EXTERNALS_SECTION
			l_tasks: TARGET_TASKS_SECTION
			l_item: EV_MENU_ITEM
		do
			create Result.make (10)

			create l_item.make_with_text_and_action (conf_interface_names.add_target, agent add_target)
			Result.extend (l_item)
			l_item.set_pixmap (pixmaps.icon_pixmaps.new_target_icon)

			l_groups := groups_section
			Result.append (l_groups.context_menu)
			l_externals := externals_section
			Result.append (l_externals.context_menu)
			l_tasks := tasks_section
			Result.append (l_tasks.context_menu)

			create l_item.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_target)
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
			Result.extend (agent configuration_window.show_properties_target_general (target))
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toolbar'.
		local
			l_groups: TARGET_GROUPS_SECTION
			l_externals: TARGET_EXTERNALS_SECTION
			l_tasks: TARGET_TASKS_SECTION
		do
			l_groups := groups_section
			l_groups.update_toolbar_sensitivity
			l_externals := externals_section
			l_externals.update_toolbar_sensitivity
			l_tasks := tasks_section
			l_tasks.update_toolbar_sensitivity

			toolbar.add_target_button.select_actions.wipe_out
			toolbar.add_target_button.select_actions.extend (agent add_target)
			toolbar.add_target_button.enable_sensitive

			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_target)
			toolbar.remove_button.enable_sensitive
		end

invariant
	target_not_void: target /= Void

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
