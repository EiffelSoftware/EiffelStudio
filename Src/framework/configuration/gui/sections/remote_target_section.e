note
	description: "Objects that represent a remote target section."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	REMOTE_TARGET_SECTION

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

	SHARED_CONFIG_WINDOWS
		undefine
			copy,
			default_create,
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target; a_location: detachable READABLE_STRING_32; a_window: like configuration_window)
			-- Create.
		require
			a_target_not_void: a_target /= Void
			a_window_not_void: a_window /= Void and then not a_window.is_destroyed
		do
			target := a_target
			if a_location /= Void then
				location := a_location
			else
				location := a_target.system.file_name
			end
			make_section (a_window)
		ensure
			target_set: target = a_target
		end

feature -- Access

	target: CONF_TARGET
			-- Target for which information are displayed.

	location: READABLE_STRING_32

	name: READABLE_STRING_32
			-- Name of the section.
		do
			Result := conf_interface_names.section_target (target.name)
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		once
			Result := conf_pixmaps.top_level_folder_remote_targets_icon
		end

feature -- Basic operations

	edit_configuration
			-- Open a new dialog to edit the remote target configuration.
		local
			l_config: READABLE_STRING_32
			l_load: CONF_LOAD
			l_conf_window: CONFIGURATION_WINDOW
			t: detachable CONF_TARGET
		do
			l_config := resolver.resolved_location_path (location)

				-- see if we already have a window for this configuration and reuse it
			config_windows.search (l_config)
			if attached config_windows.found_item as win and then win.is_show_requested then
				l_conf_window := win
				l_conf_window.raise
			else
				create l_load.make (configuration_window.conf_factory)
				l_load.retrieve_and_check_configuration (l_config)
				if l_load.is_error or else not attached l_load.last_system as l_last_system then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (if attached l_load.last_error as err then err.text else {STRING_32} "Error ..." end, configuration_window, Void)
				else
					t := l_last_system.target (target.name)
					if t = Void then
						t := l_last_system.library_target
					end
					if t = Void then
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt ((create {CONF_ERROR_NOLIB}.make (name)).text, configuration_window, Void)
					else
						if
							l_load.is_warning and then
							attached l_load.last_warning_messages as l_last_warning_messages
						then
								-- add warnings
							(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt (l_last_warning_messages, configuration_window, Void)
						end

						create l_conf_window.make_for_target (l_last_system, t.name, configuration_window.conf_factory, create {ARRAYED_LIST [STRING]}.make (0), conf_pixmaps, configuration_window.external_editor_command)

						l_conf_window.set_size (configuration_window.width, configuration_window.height)
						l_conf_window.set_position (configuration_window.x_position, configuration_window.y_position)
						l_conf_window.set_split_position (configuration_window.split_position)

						l_conf_window.show
					end
				end
			end
		end

feature {NONE} -- File name processing

	resolver: CONF_PARSER_CONTROLLER
			-- File name resolver.
		once
			create Result
		end

feature -- Element update

	add_target
			-- Add a new target that extends this one.
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
				l_name := "new_" + i.out
				i := i + 1
			end
				-- add it to the configuration
			l_target := configuration_window.conf_factory.new_target (l_name, l_system)
			l_target.reference_parent (create {CONF_REMOTE_TARGET_REFERENCE}.make (target.name, location))
			l_target.set_remote_parent (target)
			l_system.add_target (l_target)

				-- add and display the section
			configuration_window.add_target_sections (l_target, Current)
			expand
			last.enable_select
		end

	ask_remove_target
			-- Ask for confirmation and remove Current.
		local
			l_prompts: ES_PROMPT_PROVIDER
			l_shown: BOOLEAN
		do
			l_prompts := (create {ES_SHARED_PROMPT_PROVIDER}).prompts
			if not configuration_window.is_remote_target (target) then
				l_prompts.show_warning_prompt (conf_interface_names.target_remove_impossible, configuration_window, Void)
				l_shown := True
			end

			if not l_shown then
				l_prompts.show_question_prompt (conf_interface_names.remove_remote_target (name, location), configuration_window, agent remove_target, Void)
			end
		end

feature {NONE} -- Implementation

	remove_target
			-- Remove `Current' from the configuration and from the tree where it is displayed.
		local
			l_parent_tree: EV_TREE
			l_parent: EV_TREE_NODE_LIST
			l_targets: LIST [CONF_TARGET]
		do
			l_parent := parent
			if configuration_window.is_remote_target (target) then
				l_targets := configuration_window.child_targets_of (target)
				across
					l_targets as ic
				loop
					ic.remove_parent
				end
			end
			l_parent_tree := parent_tree
			if l_parent /= Void then
				l_parent.start
				l_parent.prune (Current)
				if l_targets /= Void and then not l_targets.is_empty then
					across
						l_targets as ic
					loop
						configuration_window.add_target_sections (ic, l_parent)
					end
				end
			end
			if attached {EV_TREE_NODE} l_parent as l_par_node then
				l_par_node.enable_select
			elseif l_parent_tree /= Void then
				l_parent_tree.first.enable_select
			end
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (2)

			create l_item.make_with_text_and_action (conf_interface_names.add_target, agent add_target)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.new_target_icon)

			create l_item.make_with_text_and_action (conf_interface_names.remove_remote_target (target.name, location), agent remove_target)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.general_remove_icon)
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_properties_remote_target_general (target))
		end

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toolbar'.
		do
			toolbar.add_target_button.select_actions.wipe_out
			toolbar.add_target_button.select_actions.extend (agent add_target)
			toolbar.add_target_button.enable_sensitive

			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_target)
			toolbar.remove_button.enable_sensitive

			toolbar.edit_library.select_actions.wipe_out
			toolbar.edit_library.select_actions.extend (agent edit_configuration)
			toolbar.edit_library.enable_sensitive
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
