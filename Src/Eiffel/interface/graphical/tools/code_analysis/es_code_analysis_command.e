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
			is_tooltext_important,
			new_mini_sd_toolbar_item,
			new_sd_toolbar_item,
			tooltext
		end

	CA_SHARED_NAMES

	SHARED_EIFFEL_PROJECT

	SHARED_ERROR_HANDLER

	COMPILER_EXPORTER

	EB_SHARED_WINDOW_MANAGER
	EB_SHARED_GRAPHICAL_COMMANDS

	CODE_ANALYZER_OBSERVER [STONE, CA_RULE_VIOLATION]
		redefine
			on_finish,
			on_start
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method.
		do
			enable_sensitive
			set_up_menu_items

				-- Connect the observer to the code analyzer service.
			if attached code_analyzer_s.service as s then
				s.code_analyzer_connection.connect_events (Current)
			end
		end

feature -- Status report

	is_tooltext_important: BOOLEAN = True
			-- <Precursor>

feature -- Execution

	execute
			-- Execute when no stone is provided. The whole system will be analyzed.
		local
			l_save_confirm: ES_DISCARDABLE_COMPILE_SAVE_FILES_PROMPT
			l_classes: DS_ARRAYED_LIST [CLASS_I]
		do
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
		local
			l_save_confirm: ES_DISCARDABLE_COMPILE_SAVE_FILES_PROMPT
			l_classes: DS_ARRAYED_LIST [CLASS_I]
		do
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
		do
			if attached target_stone as stone then
				compile_and_analyze (stone)
			end
		end

	save_compile_and_analyze (a_stone: STONE)
			-- Save modified windows, compile project and perform analysis of stone `a_stone'.
		do
			window_manager.save_all_before_compiling
			compile_and_analyze (a_stone)
		end

	compile_and_analyze (a_stone: STONE)
			-- Compile project and perform analysis of stone `a_stone'.
		do
			if droppable (a_stone) then
					-- Compile the project and only analyze if the compilation was successful.
				if eiffel_project.able_to_compile then
						-- Avoid recompiling a precompiled library.
					eiffel_project.quick_melt (True, True, True)
				end
				if eiffel_project.successful then
					if
						attached code_analyzer_s.service as service and then
						service.is_interface_usable and then
						service.is_stopped and then
						service.is_value_valid (a_stone)
					then
						service.put (a_stone)
						service.start
					else
						;(create {ES_INFORMATION_PROMPT}.make_standard (ca_messages.already_running_long)).show_on_active_window
					end
				end
			end
		end

	analysis_completed (a_exceptions: detachable ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]])
			-- Is called when the analysis is completed. `a_exceptions' is a list
			-- of exceptions that occurred during analysis.
		local
			l_violation_exists: BOOLEAN
		do
			if attached event_list_s.service as s then
					-- Avoid redrawing all items one by one.
				s.lock

					-- First off, remove all event items.
				s.prune_event_items (event_context_cookie)

					-- Report exceptions (if any).
				if a_exceptions /= Void then
					across a_exceptions as ic loop
						s.put_event_item (event_context_cookie, create {CA_EXCEPTION_EVENT}.make (ic.item))
						l_violation_exists := True
					end
				end

					-- Add an event item for each rule violation.
				if attached code_analyzer_s.service as code_analyzer then
					across
						code_analyzer.violations as v
					from
						if not v.after then
							l_violation_exists := True
						end
					loop
						s.put_event_item (event_context_cookie, create {CA_RULE_VIOLATION_EVENT}.make (v.item))
					end
				end

					-- If there are no violations at all then add a pseudo item indicating this very fact.
				if not l_violation_exists then
					s.put_event_item (event_context_cookie, create {CA_NO_ISSUES_EVENT}.make)
				end

					-- Enable redrawing of items.
				s.unlock
			end

				-- Update status bar.
			window_manager.display_message (ca_messages.status_bar_terminated)
				-- Raise error tool panel.
			error_handler.force_display
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

feature -- Items

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- <Precursor>
		local
			popup_button: EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON
		do
			create popup_button.make (Current)
			popup_button.set_menu_function (agent updated_drop_down_menu)

			Result := popup_button
			initialize_sd_toolbar_item (Result, display_text)
			if display_text then
				Result.set_text (ca_names.analyze_item)
			end
			Result.set_tooltip (ca_names.analyze_item_tooltip)
			Result.select_actions.extend (agent analyze_again)

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

	droppable (a: ANY): BOOLEAN
			-- Can user drop `a` on `Current`?
		do
			Result :=
				attached code_analyzer_s.service as s and then
				attached {STONE} a as x and then
				s.is_value_valid (x)
		end

feature {CODE_ANALYZER_S} -- Event handlers

	on_start (service: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION])
			-- <Precursor>
		do
			disable_sensitive
			window_manager.display_message (ca_messages.status_bar_running)
		end

	on_finish (service: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]; exceptions: ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]])
			-- <Precursor>
		do
			enable_sensitive
			analysis_completed (exceptions)
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.analyzer_analyze_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.analyzer_analyze_icon_buffer
		end

	analyze_again
			-- Analyze last analyzed item.
		do
			if attached code_analyzer_s.service as s then
				if attached last_stone as stone then
					execute_with_stone (stone)
				else
					updated_drop_down_menu.show
				end
			end
		end

	analyze_editor
			-- Analyze current editor item.
		do
			if attached editor_stone as stone then
				execute_with_stone (editor_stone)
			end
		end

	analyze_parent_cluster
			-- Analyze parent cluster of current stone (if any).
		do
			if attached parent_stone as stone then
				execute_with_stone (stone)
			end
		end

feature {NONE} -- Stone information

	last_stone: detachable STONE
			-- Most recently analyzed stone if any.
		do
			if
				attached code_analyzer_s.service as s and then
				attached s.item as stone and then
				droppable (stone)
			then
				Result := stone
			end
		ensure
			is_droppable: attached Result implies droppable (Result)
		end

	editor_stone: detachable STONE
			-- Currently selected editor stone if any.
		do
			if
				attached window_manager.last_focused_development_window as w and then
				attached w.stone as stone and then
				droppable (stone)
			then
				Result := stone
			end
		ensure
			is_droppable: attached Result implies droppable (Result)
		end

	parent_stone: detachable STONE
			-- Parent stone of currently selected item if any.
		do
			Result := last_stone
			if attached {CLASSC_STONE} Result as class_stone then
				Result := create {CLUSTER_STONE}.make (class_stone.group)
			elseif
				attached {CLUSTER_STONE} Result as cluster_stone and then
				attached {CLUSTER_I} cluster_stone.group as cluster and then
				attached cluster.parent_cluster as parent_cluster
			then
				Result := create {CLUSTER_STONE}.make (parent_cluster)
			else
					-- There is no parent.
				Result := Void
			end
			if not droppable (Result) then
				Result := Void
			end
		ensure
			is_droppable: attached Result implies droppable (Result)
		end

	target_stone: detachable STONE
			-- Target stone of currently selected item if any.
		do
			if attached eiffel_universe.target as target then
				create {TARGET_STONE} Result.make (target)
				if not droppable (Result) then
					Result := Void
				end
			end
		ensure
			is_droppable: attached Result implies droppable (Result)
		end

feature -- Access

	name: STRING_GENERAL
			-- <Precursor>
		do
			Result := command_name
		end

	command_name: STRING = "Analyze"
			-- Value for `name` used in this class.

feature {NONE} -- Implementation

	set_up_menu_items
			-- Set up menu items of proof button.
		do
			create analyze_again_menu_item.make_with_text_and_action (ca_messages.analyze_last_menu (Void), agent analyze_again)
			analyze_again_menu_item.set_pixmap (pixmaps.icon_pixmaps.analyzer_analyze_refresh_icon)
			create analyze_editor_menu_item.make_with_text_and_action (ca_messages.analyze_editor_menu (Void), agent analyze_editor)
			analyze_editor_menu_item.set_pixmap (pixmaps.icon_pixmaps.analyzer_analyze_editor_icon)
			create analyze_parent_menu_item.make_with_text_and_action (ca_messages.analyze_parent_menu (Void), agent analyze_parent_cluster)
			analyze_parent_menu_item.set_pixmap (pixmaps.icon_pixmaps.analyzer_analyze_cluster_icon)
				-- Use `execute` instead of `analyze_all` to ensure compilation is done first.
			create analyze_target_menu_item.make_with_text_and_action (ca_messages.analyze_target_menu (Void), agent execute)
			analyze_target_menu_item.set_pixmap (pixmaps.icon_pixmaps.analyzer_analyze_target_icon)
		end

	updated_drop_down_menu: EV_MENU
			-- Same as `drop_down_menu`, but with all entries updated to reflect current scope.
		do
			if attached last_stone as stone then
				analyze_again_menu_item.set_text (ca_messages.analyze_last_menu (stone.stone_name))
				analyze_again_menu_item.enable_sensitive
			else
				analyze_again_menu_item.set_text (ca_messages.analyze_last_menu (Void))
				analyze_again_menu_item.disable_sensitive
			end
			if attached editor_stone as stone then
				analyze_editor_menu_item.set_text (ca_messages.analyze_editor_menu (stone.stone_name))
				analyze_editor_menu_item.enable_sensitive
			else
				analyze_editor_menu_item.set_text (ca_messages.analyze_editor_menu (Void))
				analyze_editor_menu_item.disable_sensitive
			end
			if attached parent_stone as stone then
				analyze_parent_menu_item.set_text (ca_messages.analyze_parent_menu (stone.stone_name))
				analyze_parent_menu_item.enable_sensitive
			else
				analyze_parent_menu_item.set_text (ca_messages.analyze_parent_menu (Void))
				analyze_parent_menu_item.disable_sensitive
			end
			if attached target_stone as stone then
				analyze_target_menu_item.set_text (ca_messages.analyze_target_menu (stone.stone_name))
				analyze_target_menu_item.enable_sensitive
			else
				analyze_target_menu_item.set_text (ca_messages.analyze_target_menu (Void))
				analyze_target_menu_item.disable_sensitive
			end
			Result := drop_down_menu
		end

	drop_down_menu: EV_MENU
			-- Drop down menu for `new_sd_toolbar_item'.
		once
			create Result
			Result.extend (analyze_again_menu_item)
			Result.extend (analyze_editor_menu_item)
			Result.extend (analyze_parent_menu_item)
			Result.extend (analyze_target_menu_item)
			Result.extend (create {EV_MENU_SEPARATOR})
			Result.extend (analyzer_preferences_cmd.new_menu_item)
		ensure
			not_void: Result /= Void
		end

	analyze_again_menu_item: EV_MENU_ITEM
			-- Menu item to analyze editor.

	analyze_editor_menu_item: EV_MENU_ITEM
			-- Menu item to analyze editor.

	analyze_parent_menu_item: EV_MENU_ITEM
			-- Menu item to analyze parent.

	analyze_target_menu_item: EV_MENU_ITEM
			-- Menu item to analyze target.

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := ca_messages.analyze_last_menu (Void)
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := ca_names.analyze_item_tooltip
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := ca_names.analyze_item
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := ca_messages.analyze_again_description
		end

feature {CODE_ANALYZER} -- Services

	code_analyzer_s: SERVICE_CONSUMER [CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]]
			-- Access to code analyzer service.
		once
			create Result
		end

	event_list_s: SERVICE_CONSUMER [EVENT_LIST_S]
			-- Access to an event list service {EVENT_LIST_S} consumer.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
