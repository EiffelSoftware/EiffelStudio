indexing
	description: "Shortcuts preferences other than editor shortcuts and external commands shortcuts."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_MISC_SHORTCUT_DATA

inherit
	EB_SHORTCUTS_DATA

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

	SHARED_BENCH_NAMES
		export
			{NONE} all
		end

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end

feature -- Access

	shortcuts: HASH_TABLE [SHORTCUT_PREFERENCE, STRING] is
			-- Shortcuts
		once
			create Result.make (default_shortcut_actions.count)
		end

feature -- Fixed shortcuts

	focus_editor_shortcut: EB_FIXED_SHORTCUT is
			-- Fixed shortcut for focusing current editor.
		once
			create Result.make (names.fs_focus_on_editor, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_escape), False, False, False)
		end

	close_window_shortcut: EB_FIXED_SHORTCUT is
			-- Fixed shortcut for closing window.
		once
			create Result.make (names.fs_close_window, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_f4), True, False, False)
		end

	undo_shortcut: EB_FIXED_SHORTCUT is
			-- Fixed shortcut for all undo command.
		once
			create Result.make (names.fs_undo_command, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_z), False, True, False)
		end

	redo_shortcut: EB_FIXED_SHORTCUT is
			-- Fixed shortcut for all redo command.
		once
			create Result.make (names.fs_redo_command, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_y), False, True, False)
		end

	debug_menu_shortcut: EB_FIXED_SHORTCUT is
			-- Shortcut for debug menu
		once
			create Result.make (names.fs_debug_menu, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_d), True, True, False)
		end

feature {NONE} -- Initializing fixed shortcuts

	initialize_fixed_shortcuts is
			-- Initialize fixed shortcuts in relative shortcuts.
			-- Fixed shortcuts can not be overridden by normal shortcuts.
		do
			focus_editor_shortcut.set_group (main_window_group)
			undo_shortcut.set_group (main_window_group)
			redo_shortcut.set_group (main_window_group)
			close_window_shortcut.set_group (main_window_group)
			debug_menu_shortcut.set_group (main_window_group)
		end

feature {NONE} -- Preference Strings

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			initialize_fixed_shortcuts

				-- General
			create l_manager.make (preferences, "shortcuts.general")
			default_shortcut_actions := general_shortcuts
			initialize_shortcuts_prefs (l_manager)

				-- File
			create l_manager.make (preferences, "shortcuts.file")
			default_shortcut_actions := file_shortcuts
			initialize_shortcuts_prefs (l_manager)

				-- View -> Tools
			create l_manager.make (preferences, "shortcuts.view.tools")
			default_shortcut_actions := show_tool_shortcuts
			initialize_shortcuts_prefs (l_manager)

				-- View
			create l_manager.make (preferences, "shortcuts.view")
			default_shortcut_actions := views_shortcuts
			initialize_shortcuts_prefs (l_manager)

				-- Project
			create l_manager.make (preferences, "shortcuts.project")
			default_shortcut_actions := project_shortcuts
			initialize_shortcuts_prefs (l_manager)

				-- debug
			create l_manager.make (preferences, "shortcuts.debug")
			default_shortcut_actions := debug_shortcuts
			initialize_shortcuts_prefs (l_manager)
		end

	preferences: PREFERENCES
			-- Preferences

	default_shortcut_actions: ARRAYED_LIST [TUPLE [actions: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]; group: MANAGED_SHORTCUT_GROUP]]
			-- Array of shortcut defaults (Alt/Ctrl/Shift/KeyString) & shortcut group

feature {NONE} -- Modifiable shortcuts

	general_shortcuts: like default_shortcut_actions is
			-- General shortcuts. (Alt/Ctrl/Shift/KeyString)
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
		do
			create Result.make (1)
			create l_hash.make (2)
			l_hash.put ([False, False, False, key_strings.item (Key_f6).twin.as_string_8], "focus_on_class_address")
			l_hash.put ([False, True, False, key_strings.item (Key_f4).twin.as_string_8], "close_focusing_docking_tool_or_editor")
			Result.extend ([l_hash, main_window_group])
		end

	file_shortcuts: like default_shortcut_actions is
			-- File shortcuts. (Alt/Ctrl/Shift/KeyString)
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
		do
			create Result.make (1)
			create l_hash.make (4)
			l_hash.put ([False, True, False, key_strings.item (key_t).twin.as_string_8], "new_tab")
			l_hash.put ([False, True, False, key_strings.item (Key_n).twin.as_string_8], "new_window")
			l_hash.put ([False, True, False, key_strings.item (Key_s).twin.as_string_8], "save")
			l_hash.put ([False, True, True, key_strings.item (Key_s).twin.as_string_8], "save_all")
			Result.extend ([l_hash, main_window_group])
		end

	show_tool_shortcuts: like default_shortcut_actions is
			-- Show tool shortcuts. (Alt/Ctrl/Shift/KeyString)
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
		do
			create Result.make (1)
			create l_hash.make (22)
			l_hash.put ([True, True, False, key_strings.item (Key_f).twin.as_string_8], "show_search_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_r).twin.as_string_8], "show_search_report_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_o).twin.as_string_8], "show_output_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_0).twin.as_string_8], "show_c_output_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_x).twin.as_string_8], "show_external_output_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_e).twin.as_string_8], "show_errors_and_warnings_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_l).twin.as_string_8], "show_logger_tool")
			l_hash.put ([False, False, False, key_strings.item (Key_f4).twin.as_string_8], "show_properties_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_t).twin.as_string_8], "show_features_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_u).twin.as_string_8], "show_clusters_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_m).twin.as_string_8], "show_metric_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_y).twin.as_string_8], "show_dependency_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_i).twin.as_string_8], "show_diagram_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_c).twin.as_string_8], "show_class_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_v).twin.as_string_8], "show_feature_relation_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_g).twin.as_string_8], "show_contract_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_a).twin.as_string_8], "show_favorites_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_n).twin.as_string_8], "show_windows_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_b).twin.as_string_8], "show_breakpoints_tool")
			Result.extend ([l_hash, main_window_group])
		end

	views_shortcuts: like default_shortcut_actions is
			-- Basic/Clickable/Flat/Contract/interface etc. view shortcuts. (Alt/Ctrl/Shift/KeyString)
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
		do
			create Result.make (1)
			create l_hash.make (8)
			l_hash.put ([True, False, False, key_strings.item (key_down).twin.as_string_8], "send_to_context")
			l_hash.put ([False, True, True, key_strings.item (Key_t).twin.as_string_8], "basic_text_view")
			l_hash.put ([False, True, True, key_strings.item (Key_c).twin.as_string_8], "clickable_text_view")
			l_hash.put ([False, True, True, key_strings.item (Key_f).twin.as_string_8], "flat_view")
			l_hash.put ([False, True, True, key_strings.item (Key_o).twin.as_string_8], "contract_view")
			l_hash.put ([False, True, True, key_strings.item (Key_i).twin.as_string_8], "interface_view")
			l_hash.put ([True, False, False, key_strings.item (key_left).twin.as_string_8], "go_back")
			l_hash.put ([True, False, False, key_strings.item (key_right).twin.as_string_8], "go_forth")
			Result.extend ([l_hash, main_window_group])
		end

	project_shortcuts: like default_shortcut_actions is
			-- Project shortcuts. (Alt/Ctrl/Shift/KeyString)
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
		do
			create Result.make (1)
			create l_hash.make (6)
			l_hash.put ([False, False, False, key_strings.item (key_f7).twin.as_string_8], "compile")
			l_hash.put ([True, False, False, key_strings.item (key_f8).twin.as_string_8], "search_new_class_and_compile")
			l_hash.put ([False, False, True, key_strings.item (key_f8).twin.as_string_8], "check_overrides_and_compile")
			l_hash.put ([False, True, False, key_strings.item (key_f7).twin.as_string_8], "freeze")
			l_hash.put ([False, True, True, key_strings.item (key_f7).twin.as_string_8], "finalize")
			l_hash.put ([False, True, False, key_strings.item (key_pause).twin.as_string_8], "cancel")
			l_hash.put ([False, True, False, key_strings.item (key_f8).twin.as_string_8], "go_to_next_error")
			l_hash.put ([False, True, True, key_strings.item (key_f8).twin.as_string_8], "go_to_previous_error")
			l_hash.put ([True, True, False, key_strings.item (key_f8).twin.as_string_8], "go_to_next_warning")
			l_hash.put ([True, True, True, key_strings.item (key_f8).twin.as_string_8], "go_to_previous_warning")
			Result.extend ([l_hash, main_window_group])
		end

	debug_shortcuts: like default_shortcut_actions is
			-- Debug shortcuts. (Alt/Ctrl/Shift/KeyString)
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
		do
			create Result.make (1)
			create l_hash.make (12)
			l_hash.put ([False, False, False, key_strings.item (key_f10).twin.as_string_8], "step_by_step")
			l_hash.put ([False, False, False, key_strings.item (key_f11).twin.as_string_8], "step_into")
			l_hash.put ([False, False, True, key_strings.item (key_f11).twin.as_string_8], "step_out_of_routine")
			l_hash.put ([False, False, False, key_strings.item (key_f5).twin.as_string_8], "run")
			l_hash.put ([False, True, False, key_strings.item (key_f5).twin.as_string_8], "run_ignore_breakpoints")
			l_hash.put ([False, True, True, key_strings.item (key_f5).twin.as_string_8], "pause_application")
			l_hash.put ([False, False, True, key_strings.item (key_f5).twin.as_string_8], "stop_application")

			l_hash.put ([True, True, False, key_strings.item (Key_s).twin.as_string_8], "show_call_stack_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_p).twin.as_string_8], "show_threads_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_j).twin.as_string_8], "show_objects_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_l).twin.as_string_8], "show_object_viewer_tool")
			l_hash.put ([True, True, False, key_strings.item (Key_h).twin.as_string_8], "show_watch_tool")
			Result.extend ([l_hash, main_window_group])
		end

invariant
	preferences_not_void: preferences /= Void

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
