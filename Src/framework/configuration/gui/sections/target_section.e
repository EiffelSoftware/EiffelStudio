note
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

	make (a_target: like target; a_window: like configuration_window)
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

	name: READABLE_STRING_32
			-- Name of the section.
		do
			Result := conf_interface_names.section_target (target.name)
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.top_level_folder_targets_icon
		end

feature -- Element update

	add_target
			-- Add a new target that inherits from this one.
		local
			l_target: CONF_TARGET
			l_system: CONF_SYSTEM
			l_name: STRING
			i: INTEGER
		do
			l_system := configuration_window.conf_system
				-- find an unused target name (new_XXX)
			from
				l_name := "new_1"
				i := 1
			until
				not l_system.targets.has (l_name)
			loop
				l_name := "new_"+i.out
				i := i + 1
			end
				-- add it to the configuration
			l_target := configuration_window.conf_factory.new_target (l_name, l_system)
			l_target.set_parent (target)
			l_system.add_target (l_target)

				-- add and display the section
			configuration_window.add_target_sections (l_target, Current)
			expand
			last.enable_select
		end

	add_remote_target
			-- Add a new remote target.
		local
			dlg: ADD_REMOTE_TARGET_DIALOG
			par_loc, loc: PATH
			s: STRING_32
		do
			create dlg.make (configuration_window.current_target, configuration_window.conf_factory)
			dlg.show_modal_to_window (configuration_window)
			if
				dlg.is_ok and then
				attached dlg.last_target as tgt and then
				attached parent as p
			then
				par_loc := target.system.file_path.absolute_path.canonical_path.parent
				loc := tgt.system.file_path.absolute_path.canonical_path
				if loc.name.starts_with (loc.name) then
					create s.make_from_string (loc.name)
					s.remove_head (par_loc.name.count)
					if not s.is_empty and s[1] = loc.directory_separator then
						s.remove_head (1)
						create loc.make_from_string (s)
					end
				end
				target.reference_parent (create {CONF_REMOTE_TARGET_REFERENCE}.make (tgt.name, loc.name))
				target.set_remote_parent (tgt)
				if attached configuration_window.remote_target_section_from (tgt, p) as l_section then
					p.start
					p.prune (l_section)
				end
				p.start
				p.prune (Current)
				configuration_window.add_target_sections (tgt, p)
				p.last.enable_select
			end
		end

	ask_remove_target
			-- Ask for confirmation and remove Current.
		local
			l_prompts: ES_PROMPT_PROVIDER
			l_targets: ARRAYED_LIST [CONF_TARGET]
			l_shown: BOOLEAN
		do
			l_prompts := (create {ES_SHARED_PROMPT_PROVIDER}).prompts
			if target.system.targets.count = 1 then
				l_prompts.show_warning_prompt (conf_interface_names.target_remove_last, configuration_window, Void)
				l_shown := True
			elseif target.system.library_target = target then
				l_prompts.show_warning_prompt (conf_interface_names.target_remove_library_target, configuration_window, Void)
				l_shown := True
			else
				from
					l_targets := target.system.target_order
					l_targets.start
					l_targets.search (target)
					check
						found: not l_targets.exhausted
					end
				until
					l_shown or l_targets.after
				loop
					if l_targets.item.extends = target then
						l_prompts.show_warning_prompt (conf_interface_names.target_remove_extends (l_targets.item.name), configuration_window, Void)
						l_shown := True
					end
					l_targets.forth
				end
			end

			if not l_shown then
				l_prompts.show_question_prompt (conf_interface_names.remove_target (name), configuration_window, agent remove_target, Void)
			end
		end

feature {NONE} -- Implementation

	groups_section: TARGET_GROUPS_SECTION
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
				Result := {TARGET_GROUPS_SECTION} / item
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	advanced_section: TARGET_ADVANCED_SECTION
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
				Result := {TARGET_ADVANCED_SECTION} / item
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	externals_section: TARGET_EXTERNALS_SECTION
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
				Result := {TARGET_EXTERNALS_SECTION} / l_advanced.item
				l_advanced.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	tasks_section: TARGET_TASKS_SECTION
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
				Result := {TARGET_TASKS_SECTION} / l_advanced.item
				l_advanced.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	remove_target
			-- Remove `Current' from the configuration and from the tree where it is displayed.
		local
			l_parent_tree: EV_TREE
			l_parent: EV_TREE_NODE_LIST
		do
			configuration_window.conf_system.remove_target (target.name)
			l_parent := parent
			l_parent_tree := parent_tree
			if l_parent /= Void then
				l_parent.start
				l_parent.prune (Current)
			end
			if attached {EV_TREE_NODE} l_parent as n then
				n.enable_select
			elseif l_parent_tree /= Void and then attached l_parent_tree.first as n then
				n.enable_select
			else
				check has_parent: False end
			end
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (10)

			create l_item.make_with_text_and_action (conf_interface_names.add_target, agent add_target)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_target_icon)

			create l_item.make_with_text_and_action (conf_interface_names.add_remote_target, agent add_remote_target)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_remote_target_icon)
			if target.extends /= Void or target.parent_reference /= Void then
				l_item.disable_sensitive
			end

			Result.append (groups_section.context_menu)
			Result.append (externals_section.context_menu)
			Result.append (tasks_section.context_menu)

			create l_item.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_target)
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
			Result.extend (agent configuration_window.show_properties_target_general (target))
		end

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toolbar'.
		do
			groups_section.update_toolbar_sensitivity
			externals_section.update_toolbar_sensitivity
			tasks_section.update_toolbar_sensitivity

			toolbar.add_target_button.select_actions.wipe_out
			toolbar.add_target_button.select_actions.extend (agent add_target)
			toolbar.add_target_button.enable_sensitive

			if target.extends = Void and target.parent_reference = Void then
				toolbar.add_remote_target_button.select_actions.wipe_out
				toolbar.add_remote_target_button.select_actions.extend (agent add_remote_target)
				toolbar.add_remote_target_button.enable_sensitive
			end

			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_target)
			toolbar.remove_button.enable_sensitive
		end

invariant
	target_not_void: target /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
