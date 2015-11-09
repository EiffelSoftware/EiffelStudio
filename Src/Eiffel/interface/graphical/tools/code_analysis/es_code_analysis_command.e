note
	description: "[
		Command to launch Code Analyzer.
		
		Can be added to toolbars and menus.
		Can be executed using stones.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_ANALYSIS_COMMAND

inherit

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext,
			new_sd_toolbar_item,
			new_mini_sd_toolbar_item
		end

	CA_SHARED_NAMES

	SHARED_EIFFEL_PROJECT

	SHARED_ERROR_HANDLER

	COMPILER_EXPORTER

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method.
		do
			initialize_preferences

			enable_sensitive
			set_up_menu_items

			create analysis_timestamp.make (0)
		end

feature -- Execution

	execute
			-- Execute when no stone is provided. The whole system will be analyzed.
		local
			l_save_confirm: ES_DISCARDABLE_COMPILE_SAVE_FILES_PROMPT
			l_classes: DS_ARRAYED_LIST [CLASS_I]
		do
				-- Show the tool right from the start.
			show_ca_tool

			if not eiffel_project.is_compiling then
				if window_manager.has_modified_windows then
					create l_classes.make_default
					window_manager.all_modified_classes.do_all (agent l_classes.force_last)
					create l_save_confirm.make (l_classes)
					l_save_confirm.set_button_action (l_save_confirm.dialog_buttons.yes_button, agent save_compile_and_analyze_all)
					l_save_confirm.set_button_action (l_save_confirm.dialog_buttons.no_button, agent compile_and_analyze_all)
					l_save_confirm.show_on_active_window
				else
					compile_and_analyze_all
				end
			end
		end

	execute_with_stone (a_stone: STONE)
			-- Execute with `a_stone'.
		do
			execute_with_stone_content (a_stone, Void)
		end

	execute_with_stone_content (a_stone: STONE; a_content: SD_CONTENT)
			-- Execute with `a_stone'.
		local
			l_save_confirm: ES_DISCARDABLE_COMPILE_SAVE_FILES_PROMPT
			l_classes: DS_ARRAYED_LIST [CLASS_I]
		do
				-- Show the tool right from the start.
			show_ca_tool

			if not eiffel_project.is_compiling then
				if window_manager.has_modified_windows then
					create l_classes.make_default
					window_manager.all_modified_classes.do_all (agent l_classes.force_last)
					create l_save_confirm.make (l_classes)
					l_save_confirm.set_button_action (l_save_confirm.dialog_buttons.yes_button, agent save_compile_and_analyze (a_stone))
					l_save_confirm.set_button_action (l_save_confirm.dialog_buttons.no_button, agent compile_and_analyze (a_stone))
					l_save_confirm.show_on_active_window
				else
					compile_and_analyze (a_stone)
				end
			end
		end

feature {ES_CODE_ANALYSIS_BENCH_HELPER} -- Basic operations

	save_compile_and_analyze_all
			-- Saves and compiles the system. If successful then the whole
			-- system will be analyzed.
		do
			window_manager.save_all_before_compiling
			compile_and_analyze_all
		end

	compile_and_analyze_all
			-- Compiles the system; if successful then the whole system will
			-- be analyzed.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
			l_dialog: ES_INFORMATION_PROMPT
		do
				-- Compile the project and only analyze if the compilation was successful.
			if eiffel_project.able_to_compile then
					-- Avoid recompiling a precompiled library.
				eiffel_project.quick_melt (True, True, True)
			end
			if eiffel_project.successful then
				create l_helper
				if l_helper.code_analyzer.is_running then
					create l_dialog.make_standard (ca_messages.already_running_long)
					l_dialog.show_on_active_window
				else
						-- Detection of changes

						-- If we did a system analysis recently then only add modified classes.
					if last_was_analyze_all then
						analyze_changed_classes
					else
						analyze_all
					end
					last_was_analyze_all := True
				end
			end
		end

	last_was_analyze_all: BOOLEAN
			-- Was the last analysis performed on the whole system?

	analysis_timestamp: HASH_TABLE [INTEGER, CLASS_I]
			-- Stores the time of the last modification of the class at the point
			-- of the last analysis.

	save_compile_and_analyze (a_stone: STONE)
			-- Save modified windows, compile project and perform analysis of stone `a_stone'.
		do
			window_manager.save_all_before_compiling
			compile_and_analyze (a_stone)
		end

	compile_and_analyze (a_stone: STONE)
			-- Compile project and perform analysis of stone `a_stone'.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
			l_dialog: ES_INFORMATION_PROMPT
		do
				-- Compile the project and only analyze if the compilation was successful.
			if eiffel_project.able_to_compile then
					-- Avoid recompiling a precompiled library.
				eiffel_project.quick_melt (True, True, True)
			end
			if eiffel_project.successful then
				create l_helper
				if l_helper.code_analyzer.is_running then
					create l_dialog.make_standard (ca_messages.already_running_long)
					l_dialog.show_on_active_window
				else
					perform_analysis (a_stone)
				end
			end
		end

	analyze_all
			-- Analyzes the whole system.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
			l_scope_label: EV_LABEL
		do
			create l_helper
			code_analyzer := l_helper.code_analyzer
			code_analyzer.clear_classes_to_analyze
			code_analyzer.rule_violations.wipe_out
			code_analyzer.add_whole_system

				-- Store all found classes.
			across code_analyzer.class_list as l_classes loop
				analysis_timestamp.force (l_classes.item.original_class.date, l_classes.item.original_class)
			end

			disable_tool_button
			window_manager.display_message (ca_messages.status_bar_running)
			code_analyzer.add_completed_action (agent analysis_completed)
			code_analyzer.analyze
			l_scope_label := ca_tool.panel.scope_label
			l_scope_label.set_text (ca_messages.system_scope)
			l_scope_label.set_tooltip (ca_messages.system_scope_tooltip)
			l_scope_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (30, 30, 30))
		end

	analyze_changed_classes
			-- Only analyze the classes that have been modified since the last analysis.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
			l_scope_label: EV_LABEL
			l_analysis_timestamp, l_changed_timestamp: INTEGER
			l_class: CLASS_I
		do
			create l_helper
			code_analyzer := l_helper.code_analyzer
			code_analyzer.clear_classes_to_analyze

			from analysis_timestamp.start
			until analysis_timestamp.after
			loop
					-- Check if class has been modified since last analysis.
				l_analysis_timestamp := analysis_timestamp.item_for_iteration
				l_class := analysis_timestamp.key_for_iteration
				l_changed_timestamp := l_class.date
				if l_changed_timestamp /= l_analysis_timestamp then
					code_analyzer.rule_violations.remove (l_class.compiled_class)
					code_analyzer.add_class (l_class.config_class)
				end

				analysis_timestamp.forth
			end

				-- Update the analysis timestamp for all the classes that have been added.
			across code_analyzer.class_list as l_classes loop
				analysis_timestamp.force (l_classes.item.original_class.date, l_classes.item.original_class)
			end

			disable_tool_button
			window_manager.display_message (ca_messages.status_bar_running)
			code_analyzer.add_completed_action (agent analysis_completed)
			code_analyzer.analyze
			l_scope_label := ca_tool.panel.scope_label
			l_scope_label.set_text (ca_messages.system_scope)
			l_scope_label.set_tooltip (ca_messages.system_scope_tooltip)
			l_scope_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (30, 30, 30))
		end

	last_scope_label: EV_LABEL
			-- Shows the scope of the last analysis (system, single class, etc.). A stone
			-- will be attached, too, depending on the scope.

	perform_analysis (a_stone: STONE)
			-- Analyze `a_stone' only.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
			l_scope_label: EV_LABEL
		do
				-- For simplicity let us assume that `a_stone' does not
				-- correspond to the system or is equivalent to it.
			last_was_analyze_all := False

			create l_helper
			code_analyzer := l_helper.code_analyzer
			code_analyzer.clear_classes_to_analyze
			code_analyzer.rule_violations.wipe_out

			l_scope_label := ca_tool.panel.scope_label

			if attached {CLASSC_STONE} a_stone as s then
				code_analyzer.add_class (s.class_i.config_class)
				l_scope_label.set_text (s.class_name)
				l_scope_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (140, 140, 255))
				l_scope_label.set_pebble (s)
				l_scope_label.set_pick_and_drop_mode
				l_scope_label.set_tooltip (ca_messages.class_scope_tooltip)
			elseif attached {CLUSTER_STONE} a_stone as s then
				if s.is_cluster then
					code_analyzer.add_cluster (s.cluster_i)
				else
					code_analyzer.add_group (s.group)
				end
				l_scope_label.set_text (s.stone_name)
				l_scope_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 140, 140))
				l_scope_label.set_pebble (s)
				l_scope_label.set_pick_and_drop_mode
				l_scope_label.set_tooltip (ca_messages.cluster_scope_tooltip)
			elseif attached {DATA_STONE} a_stone as s then
				if attached {LIST [CONF_GROUP]} s.data as g then
					from
						g.start
					until
						g.after
					loop
						if attached {CLUSTER_I} g.item_for_iteration as c then
							code_analyzer.add_cluster (c)
						end
						g.forth
					end
					l_scope_label.set_text (s.stone_name)
					l_scope_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (140, 255, 140))
					l_scope_label.set_pebble (s)
					l_scope_label.set_pick_and_drop_mode
					l_scope_label.set_tooltip (ca_messages.conf_group_tooltip)
				end
			end

			disable_tool_button
			window_manager.display_message (ca_messages.status_bar_running)
			code_analyzer.add_completed_action (agent analysis_completed)
			code_analyzer.analyze
		end

	analysis_completed (a_exceptions: detachable ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]])
			-- Is called when the analysis is completed. `a_exceptions' is a list
			-- of exceptions that occurred during analysis.
		local
			l_violation_exists: BOOLEAN
		do
			if attached event_list as l then
					-- First off, remove all event items.
				l.prune_event_items (event_context_cookie)

				if a_exceptions /= Void then
					across a_exceptions as ic loop
						l.put_event_item (event_context_cookie, create {CA_EXCEPTION_EVENT}.make (ic.item))
						l_violation_exists := True
					end
				end

					-- Add an event item for each rule violation.
				across code_analyzer.rule_violations as l_viol_list loop
					across l_viol_list.item as l_viol loop
						l.put_event_item (event_context_cookie, create {CA_RULE_VIOLATION_EVENT}.make (l_viol.item))
						l_violation_exists := True
					end
				end

					-- If there are no violations at all then add a pseudo item indicating this very fact.
				if not l_violation_exists then
					l.put_event_item (event_context_cookie, create {CA_NO_ISSUES_EVENT}.make)
				end
			end

			show_ca_tool

			enable_tool_button
				-- Update status bar.
			window_manager.display_message (ca_messages.status_bar_terminated)
		end

	event_context_cookie: UUID
			-- Context cookie for Code Analysis events.
		local
			l_generator: UUID_GENERATOR
		once
			create l_generator
			Result := l_generator.generate_uuid
		ensure
			valid_result: Result /= Void
		end

	ca_tool: detachable ES_CODE_ANALYSIS_TOOL
			-- Analysis tool (if applicable).
		local
			l_tool: ES_TOOL [EB_TOOL]
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_window := window_manager.last_focused_development_window
			if not l_window.is_recycled and then l_window.is_visible and then l_window = window_manager.last_focused_development_window then
				l_tool := l_window.shell_tools.tool ({ES_CODE_ANALYSIS_TOOL})
				if attached {ES_CODE_ANALYSIS_TOOL} l_tool as l_ca_tool then
					Result := l_ca_tool
				else
					check False end
				end
			end
		end

	show_ca_tool
			-- Shows the analysis tool.
		local
			l_tool: ES_CODE_ANALYSIS_TOOL
		do
			l_tool := ca_tool
			if l_tool /= Void and then not l_tool.is_recycled then
				l_tool.show (True)
			end
		end

	disable_tool_button
			-- Disable analysis button on tool.
		local
			l_tool: ES_CODE_ANALYSIS_TOOL
		do
			l_tool := ca_tool
			if l_tool /= Void and then l_tool.is_tool_instantiated then
				ca_tool.panel.whole_system_button.disable_sensitive
				ca_tool.panel.current_item_button.disable_sensitive
			end
		end

	enable_tool_button
			-- Enable analysis button on tool.
		local
			l_tool: ES_CODE_ANALYSIS_TOOL
		do
			l_tool := ca_tool
			if l_tool /= Void and then l_tool.is_tool_instantiated then
				ca_tool.panel.whole_system_button.enable_sensitive
				ca_tool.panel.current_item_button.enable_sensitive
			end
		end

feature -- Items

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- <Precursor>
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.set_text (ca_names.analyze_item)
			Result.set_tooltip (ca_names.analyze_item_tooltip)
			Result.select_actions.extend (agent analyze_current_item)

			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.set_veto_pebble_function (agent droppable)
		ensure then
			valid_result: Result /= Void
		end

	new_whole_system_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.set_text (ca_names.analyze_system)
			Result.set_tooltip (ca_names.analyze_system_tooltip)
			Result.select_actions.extend (agent execute)
		ensure then
			valid_result: Result /= Void
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- <Precursor>
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.set_veto_pebble_function (agent droppable)
		ensure then
			valid_result: Result /= Void
		end

feature -- Status report

	droppable (a_pebble: ANY): BOOLEAN
			-- Can user drop `a_pebble' on `Current'?
		do
			Result :=
				(attached {CLASSC_STONE} a_pebble) or else
				(attached {CLUSTER_STONE} a_pebble) or else
				(attached {DATA_STONE} a_pebble as s and then attached {LIST [CONF_GROUP]} s.data)
		end

feature {NONE} -- Implementation

	code_analyzer: CA_CODE_ANALYZER
			-- Code Analyzer instance

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.view_flat_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.view_flat_icon_buffer
		end

	analyze_current_item
			-- Proof current item
		local
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_window := window_manager.last_focused_development_window
			if droppable (l_window.stone) then
				execute_with_stone (l_window.stone)
			end
		end

	analyze_parent_cluster
			-- Proof parent cluster of window item.
		local
			l_window: EB_DEVELOPMENT_WINDOW
			l_cluster_stone: CLUSTER_STONE
		do
			l_window := window_manager.last_focused_development_window
			if attached {CLASSC_STONE} l_window.stone as l_stone then
				create l_cluster_stone.make (l_stone.group)
				execute_with_stone (l_cluster_stone)
			elseif attached {CLUSTER_STONE} l_window.stone as l_stone then
				if l_stone.cluster_i.parent_cluster /= Void then
					create l_cluster_stone.make (l_stone.cluster_i.parent_cluster)
				end
				execute_with_stone (l_cluster_stone)
			end
		end

feature {NONE} -- Implementation

	frozen service_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
			-- Access to an event list service {EVENT_LIST_S} consumer.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen event_list: detachable EVENT_LIST_S
			-- Access to an event list service.
		do
			Result := service_consumer.service
		end

	set_up_menu_items
			-- Set up menu items of proof button
		do
			create analyze_system_item.make_with_text_and_action (ca_messages.analyze_whole_system, agent analyze_all)
			create analyze_current_item_item.make_with_text_and_action (ca_messages.analyze_current_item, agent analyze_current_item)
			create analyze_parent_item_item.make_with_text_and_action (ca_messages.analyze_parent_cluster, agent analyze_parent_cluster)
		end

	drop_down_menu: EV_MENU
			-- Drop down menu for `new_sd_toolbar_item'.
		once
			create Result
			Result.extend (analyze_system_item)
			Result.extend (analyze_current_item_item)
			Result.extend (analyze_parent_item_item)
		ensure
			not_void: Result /= Void
		end

	analyze_current_item_item: EV_MENU_ITEM
			-- Menu item to analyze current item

	analyze_parent_item_item: EV_MENU_ITEM
			-- Menu item to analyze parent item

	analyze_system_item: EV_MENU_ITEM
			-- Menu item to analyze system

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := ca_messages.run_code_analysis
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := ca_messages.analyze_whole_system
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := ca_messages.run_code_analysis
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := "Run Eiffel Inspector."
		end

	name: STRING_GENERAL
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			Result := "Eiffel Inspector"
		end

feature -- GUI preferences

	initialize_preferences
			-- Initializes the preferences related to the tool panel.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_helper
			code_analyzer := l_helper.code_analyzer
			create l_manager.make (code_analyzer.preferences, {CA_SETTINGS}.code_analysis_namespace)

			error_bgcolor := l_manager.new_color_preference_value (l_manager,
				preference_option_name_error_background, default_error_bgcolor)
			warning_bgcolor := l_manager.new_color_preference_value (l_manager,
				preference_option_name_warning_background, default_warning_bgcolor)
			suggestion_bgcolor := l_manager.new_color_preference_value (l_manager,
				preference_option_name_suggestion_background, default_suggestion_bgcolor)
			hint_bgcolor := l_manager.new_color_preference_value (l_manager,
				preference_option_name_hint_background, default_hint_bgcolor)
			fixed_violation_bgcolor := l_manager.new_color_preference_value (l_manager,
				preference_option_name_fixed_background, default_fixed_violation_bgcolor)
		end

	color_string (a_color: attached EV_COLOR): STRING
			-- String representation of `a_color' for use in preferences.
		do
			create Result.make_empty
			Result.append_integer (a_color.red_8_bit)
			Result.append_character (';')
			Result.append_integer (a_color.green_8_bit)
			Result.append_character (';')
			Result.append_integer (a_color.blue_8_bit)
		ensure
			valid_result: Result /= Void
		end

	error_bgcolor,
	warning_bgcolor,
	suggestion_bgcolor,
	hint_bgcolor,
	fixed_violation_bgcolor: COLOR_PREFERENCE
			-- Color preferences

	default_error_bgcolor: EV_COLOR
		do
			create Result.make_with_8_bit_rgb (255, 220, 220)
		ensure
			valid_result: Result /= Void
		end

	default_warning_bgcolor: EV_COLOR
		do
			create Result.make_with_8_bit_rgb (255, 255, 188)
		ensure
			valid_result: Result /= Void
		end

	default_suggestion_bgcolor: EV_COLOR
		do
			create Result.make_with_8_bit_rgb (239, 228, 176)
		ensure
			valid_result: Result /= Void
		end

	default_hint_bgcolor: EV_COLOR
		do
			create Result.make_with_8_bit_rgb (188, 226, 193)
		ensure
			valid_result: Result /= Void
		end

	default_fixed_violation_bgcolor: EV_COLOR
		do
			create Result.make_with_8_bit_rgb (181, 230, 29)
		ensure
			valid_result: Result /= Void
		end

feature {NONE} -- Preferences

	preference_option_name_error_background: STRING
			-- A name of an error background option within the corresponding preference namespace.
		do
			Result := color_option_name ("error_background")
		end

	preference_option_name_warning_background: STRING
			-- A name of a warning background option within the corresponding preference namespace.
		do
			Result := color_option_name ("warning_background")
		end

	preference_option_name_suggestion_background: STRING
			-- A name of a suggestion background option within the corresponding preference namespace.
		do
			Result := color_option_name ("suggestion_background")
		end

	preference_option_name_hint_background: STRING
			-- A name of a hint background option within the corresponding preference namespace.
		do
			Result := color_option_name ("hint_background")
		end

	preference_option_name_fixed_background: STRING
			-- A name of a fixed violation background option within the corresponding preference namespace.
		do
			Result := color_option_name ("fixed_violation_background")
		end

	color_option_name (n: STRING): STRING
			-- A color option name in the corresponding color namespace.
		do
			Result := "color." + n
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
