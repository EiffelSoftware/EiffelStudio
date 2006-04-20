indexing
	description: "Objects that handle commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_HANDLER

create
	make_with_components

feature -- Access

	make_with_components (components: GB_INTERNAL_COMPONENTS) is
			-- Initialize current with `components'.
		require
			components_not_void: components /= Void
		do
			create save_command.make_with_components (components)
			create new_project_command.make_with_components (components)
			create project_settings_command.make_with_components (components)
			create open_project_command.make_with_components (components)
			create import_project_command.make_with_components (components)
			create close_project_command.make_with_components (components)
			create show_hide_history_command.make_with_components (components)
			create delete_object_command.make_with_components (components)
			create object_editor_command.make_with_components (components)
			create show_hide_builder_window_command.make_with_components (components)
			show_hide_builder_window_command.enable_sensitive
			create show_hide_display_window_command.make_with_components (components)
			show_hide_display_window_command.enable_sensitive
			create show_hide_component_viewer_command.make_with_components (components)
			create show_hide_constants_dialog_command.make_with_components (components)
			create set_root_window_command.make_with_components (components)
			create redo_command.make_with_components (components)
			create undo_command.make_with_components (components)
			create generation_command.make_with_components (components)
			create expand_layout_tree_command.make_with_components (components)
			create collapse_layout_tree_command.make_with_components (components)
			create tools_always_on_top_command.make_with_components (components)
			create cut_object_command.make_with_components (components)
			create copy_object_command.make_with_components (components)
			create paste_object_command.make_with_components (components)
			create clipboard_command.make_with_components (components)

			create all_standard_commands.make (0)
			all_standard_commands.extend (save_command)
			all_standard_commands.extend (new_project_command)
			all_standard_commands.extend (project_settings_command)
			all_standard_commands.extend (open_project_command)
			all_standard_commands.extend (close_project_command)
			all_standard_commands.extend (delete_object_command)
			all_standard_commands.extend (object_editor_command)
			all_standard_commands.extend (undo_command)
			all_standard_commands.extend (redo_command)
			all_standard_commands.extend (generation_command)
			all_standard_commands.extend (set_root_window_command)
			all_standard_commands.extend (import_project_command)
			all_standard_commands.extend (cut_object_command)
			all_standard_commands.extend (copy_object_command)
			all_standard_commands.extend (paste_object_command)
			all_standard_commands.extend (clipboard_command)

			create all_two_state_commands.make (0)
			all_two_state_commands.extend (Show_hide_builder_window_command)
			all_two_state_commands.extend (Show_hide_display_window_command)
			all_two_state_commands.extend (Show_hide_history_command)
			all_two_state_commands.extend (Show_hide_constants_dialog_command)
			all_two_state_commands.extend (Show_hide_component_viewer_command)
		end

	save_command: GB_FILE_SAVE_COMMAND
			-- Command representing `Save'.
			-- Not sensitive by default.

	new_project_command: GB_NEW_PROJECT_COMMAND
			-- Command representing a new project.

	project_settings_command: GB_SHOW_PROJECT_SETTINGS_COMMAND
			-- Command representing `project settings'.

	open_project_command: GB_FILE_OPEN_COMMAND
			-- Command representing open project.

	import_project_command: GB_FILE_IMPORT_COMMAND
			-- Command representing import project.

	close_project_command: GB_CLOSE_PROJECT_COMMAND
			-- Command representing close project.

	show_hide_history_command: GB_SHOW_HIDE_HISTORY_COMMAND
			-- Command representing display history.

	delete_object_command: GB_DELETE_OBJECT_COMMAND
			-- Command representing delete.

	object_editor_command: GB_OBJECT_EDITOR_COMMAND
			-- Command representing a new object editor request.

	show_hide_builder_window_command: GB_SHOW_HIDE_BUILDER_WINDOW_COMMAND
			-- Command representing a show/hide builder window request.

	show_hide_display_window_command: GB_SHOW_HIDE_DISPLAY_WINDOW_COMMAND
			-- Command representing a show/hide display window request.

	show_hide_component_viewer_command: GB_SHOW_HIDE_COMPONENT_VIEWER_COMMAND
			-- Command representing a show/hide component viewer request.

	show_hide_constants_dialog_command: GB_SHOW_HIDE_CONSTANTS_DIALOG_COMMAND
			-- Command representing display of constants dialog.

	set_root_window_command: GB_SET_ROOT_WINDOW_COMMAND
			-- Command representing setting of root window.

	redo_command: GB_REDO_COMMAND
			-- Command representing a redo.

	undo_command: GB_UNDO_COMMAND
			-- Command representing undo.

	generation_command: GB_GENERATION_COMMAND
			-- Command representing code generation.

	expand_layout_tree_command: GB_EXPAND_LAYOUT_TREE_COMMAND
			-- Command representing expansion of the layout constructor.

	collapse_layout_tree_command: GB_COLLAPSE_LAYOUT_TREE_COMMAND
			-- Command representing collapse of the layout constructor.

	tools_always_on_top_command: GB_TOOLS_ALWAYS_ON_TOP_COMMAND
			-- Command representing whether windows should be modeless or independent.
			-- Modeless by default.

	cut_object_command: GB_CUT_OBJECT_COMMAND
			-- Command representing cutting of selected object from layout selector.

	copy_object_command: GB_COPY_OBJECT_COMMAND
			-- Command representing copying of selected object from layout selector.

	paste_object_command: GB_PASTE_OBJECT_COMMAND
			-- Command representing pasting of copied object from clipboard.

	clipboard_command: GB_CLIPBOARD_COMMAND
			-- Command representing clipboard functionality.

feature -- Basic operation

	update is
			-- For every command in `all_standard_commands',
			--  and `all_two_state_commands', update their state.
		local
			current_command: GB_STANDARD_CMD
			two_state_command: GB_TWO_STATE_COMMAND
		do
			from
				all_standard_commands.start
			until
				all_standard_commands.off
			loop
				current_command := all_standard_commands.item
				if current_command.executable then
					current_command.enable_sensitive
				else
					current_command.disable_sensitive
				end
				all_standard_commands.forth
			end
			from
				all_two_state_commands.start
			until
				all_two_state_commands.off
			loop
				two_state_command := all_two_state_commands.item
				if two_state_command.executable then
					two_state_command.enable_sensitive
				else
					two_state_command.disable_sensitive
				end
				all_two_state_commands.forth
			end
		end

feature {GB_MAIN_WINDOW} -- Implementation

	all_standard_commands: ARRAYED_LIST [GB_STANDARD_CMD]
			-- All the standard commands accessible through `Current'.
			-- This assumes that the commands are static and no new
			-- commands are created during the programs execution.

	all_two_state_commands: ARRAYED_LIST [GB_TWO_STATE_COMMAND];

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


end -- class GB_COMMAND_HANDLER
