note
	description: "Graphical panel for EiffelStudio's testing tool."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			on_after_initialized
		end

	ES_TOOL_ICONS_PROVIDER_I [ES_TESTING_TOOL_ICONS]
		rename
			tool as tool_descriptor
		export
			{NONE} all
		end

	ES_SHARED_TEST_SERVICE
		export
			{NONE} all
		end

	TEST_SUITE_OBSERVER
		redefine
			on_session_launched,
			on_session_finished
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	CONF_ACCESS
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create {ES_TESTING_TOOL}
	make

feature {NONE} -- Initialization: widgets

	build_tool_interface (a_widget: like create_widget)
			-- <Precursor>
		do
			create split_area
			build_test_tree
			build_execution_widget
			a_widget.extend (split_area)
		end

	build_test_tree
			-- Initialize `test_tree' and show it in `Current'.
		local
			l_tag_tree: ES_TAG_TREE_GRID [TEST_I]
		do
			create test_tree.make (develop_window, Current)
			l_tag_tree := test_tree.tag_tree
			register_action (l_tag_tree.node_selected_actions, agent on_selection_change (?, True))
			register_action (l_tag_tree.node_deselected_actions, agent on_selection_change (?, False))
			split_area.set_first (test_tree.widget)
		end

	build_execution_widget
			-- Create `notebook' and add permament tabs.
		local
			l_box: EV_VERTICAL_BOX
			l_statistics: ES_TEST_STATISTICS_WIDGET
			l_execution: ES_TEST_RECORDS_TAB
		do
			create l_box

			create l_statistics.make (Current)
			l_box.extend (l_statistics.widget)
			l_box.disable_item_expand (l_statistics.widget)

			create l_execution.make (Current)
			l_box.extend (l_execution.widget)

			split_area.set_second (l_box)
			auto_recycle (l_execution)
		end

feature {NONE} -- Initialization: widget status

	on_after_initialized
			-- <Precursor>
		local
			l_app: EV_APPLICATION
			l_service_consumer: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			l_key: UUID
			l_output: ES_EDITOR_OUTPUT_PANE
		do
			Precursor
			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					do
						a_test_suite.test_suite_connection.connect_events (Current)
						register_factories (a_test_suite)
					end)
			propagate_drop_actions (Void)

				-- Initialize testing output
			create l_service_consumer
			if attached l_service_consumer.service as l_service then
				l_key := (create {OUTPUT_MANAGER_KINDS}).testing
				if
					l_service.is_interface_usable and then
					l_service.is_valid_registration_key (l_key) and then
					not l_service.is_output_available (l_key)
				then
					create l_output.make (locale.translation (t_testing_output))
					l_service.register (l_output, l_key)
				end
			end

			update_selection_state
			update_running_state

			l_app := (create {EV_SHARED_APPLICATION}).ev_application
			l_app.add_idle_action_kamikaze (agent split_area.set_proportion ({REAL_32} 0.5))
		end

	register_factories (a_test_suite: TEST_SUITE_S)
			-- Register {ETEST_*} factories in test suite service.
		once
			a_test_suite.register_factory (create {ETEST_DEFAULT_SESSION_FACTORY [ETEST_MANUAL_CREATION]})
			a_test_suite.register_factory (create {ETEST_DEFAULT_SESSION_FACTORY [TEST_GENERATOR]})
			a_test_suite.register_factory (create {ETEST_DEFAULT_SESSION_FACTORY [ETEST_EXTRACTION]})
		end

feature -- Access: help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "1d8cc843-238e-feaa-cfa6-629f080ffba7"
		end

feature {NONE} -- Access

	test_creation_pixmap: EV_PIXMAP
			-- Pixmap for test creation
		do
			Result := stock_pixmaps.icon_with_overlay (icons.general_test_icon, stock_pixmaps.overlay_new_icon_buffer, 0, 0)
		end

	test_creation_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer for test creation
		do
			Result := stock_pixmaps.icon_buffer_with_overlay (icons.general_test_icon_buffer, stock_pixmaps.overlay_new_icon_buffer, 0, 0)
		end

feature {NONE} -- Access: widgets

	test_tree: ES_TEST_TREE
			-- Tree showing tag tree for tests

	split_area: EV_VERTICAL_SPLIT_AREA
			-- Splitting area for grid and notebook

	notebook: EV_NOTEBOOK
			-- Notebook for detailed information

feature {NONE} -- Access: buttons

	creation_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button for launching test wizard

	run_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button for launching the test executor

	debug_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button for debugging tests

	stop_button: SD_TOOL_BAR_BUTTON
			-- Button for stopping any current test execution

feature {NONE} -- Access: menus

	run_all_menu,
	run_failing_menu,
	run_selected_menu,
	run_filtered_menu,
	run_preferences_menu: EV_MENU_ITEM
			-- Menu items for running tests in background

	debug_all_menu,
	debug_failing_menu,
	debug_selected_menu,
	debug_filtered_menu: EV_MENU_ITEM
			-- Menu items for debugging tests

feature {NONE} -- Access: test creation

	test_creation_menu: EV_MENU
			-- Menu for `creation_button'.
		local
			l_item: EV_MENU_ITEM
			l_launch_wizard: BOOLEAN
			l_suffix: STRING_32
			l_system_available: BOOLEAN
			l_system_valid: BOOLEAN
		do
			create Result

			l_launch_wizard := True
			if
				attached session_manager.service and then
				attached {BOOLEAN} session_data.value ({TEST_SESSION_CONSTANTS}.launch_wizard) as l_bool
			then
				l_launch_wizard := l_bool
			end
			if l_launch_wizard then
				l_suffix := "..."
			else
				l_suffix := ""
			end

			l_system_available := workbench.is_in_stable_state and then not workbench.is_compiling
			l_system_valid := l_system_available and then workbench.system.successful

			create l_item.make_with_text_and_action (locale.translation (create_manual_text) + l_suffix,
				agent on_create_manual_test (l_launch_wizard))
			Result.extend (l_item)
			if not l_system_available then
					-- Manual tests can only be launched if there is a system available and the compiler is not already compiling.
				l_item.disable_sensitive
			end

			Result.extend (create {EV_MENU_SEPARATOR})

			create l_item.make_with_text_and_action (locale.translation (generate_all_text) + l_suffix,
				agent on_generate_test (l_launch_wizard))
			Result.extend (l_item)
			if not l_system_valid or else open_classes.is_empty then
					-- Can only be used if we have a valid system.
				l_item.disable_sensitive
			end

			create l_item.make_with_text_and_action (locale.translation (generate_custom_text) + l_suffix,
				agent on_generate_custom_test (l_launch_wizard))
			Result.extend (l_item)
			if not l_system_valid then
					-- Can only be used if we have a valid system.
				l_item.disable_sensitive
			end

			Result.extend (create {EV_MENU_SEPARATOR})

			if debugger_manager.application_is_executing and then debugger_manager.application_is_stopped then
				create l_item.make_with_text_and_action (locale.translation (extract_text) + l_suffix,
					agent on_extract_test (l_launch_wizard, debugger_manager.application_status))
			else
				create l_item.make_with_text (locale.translation (extract_text) + l_suffix)
				l_item.disable_sensitive
			end
			Result.extend (l_item)

			Result.extend (create {EV_MENU_SEPARATOR})

			create l_item.make_with_text_and_action (locale.translation (preferences_text) + "...",
				agent on_launch_creation_preferences)
			if not l_system_valid then
					-- Can only be used if we have a valid system.
				l_item.disable_sensitive
			end
			Result.extend (l_item)
		end

feature {NONE} -- Status setting: stones

	on_stone_changed (a_old_stone: detachable like stone)
			-- <Precursor>
		local
			l_filter_text: detachable STRING_32
		do
			if not is_in_stone_synchronization then
				if attached {CLASSI_STONE} stone as l_class_stone and then attached {EIFFEL_CLASS_I} l_class_stone.class_i as l_class then
					create l_filter_text.make (40)
					l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.class_prefix)
					l_filter_text.append_string_general (l_class_stone.class_name)
					if attached {FEATURE_STONE} stone as l_feature_stone then
						l_filter_text.append_string_general ("/.*")
						l_filter_text.append (l_feature_stone.feature_name)
					end
				elseif attached {CLUSTER_STONE} stone as l_cluster then
					create l_filter_text.make (40)
					if l_cluster.group.is_cluster then
						l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.cluster_prefix)
					elseif l_cluster.group.is_library then
						l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.library_prefix)
					elseif l_cluster.group.is_override then
						l_filter_text.append ({EC_TAG_TREE_CONSTANTS}.override_prefix)
					end
					l_filter_text.append (l_cluster.group.name)
				end
				if l_filter_text /= Void then
					test_tree.set_filter (l_filter_text)
				end
			end
		end

feature {NONE} -- Query

    open_classes: STRING
    		-- Classes currently open in editor pane
    	do
    		create Result.make (200)
			if attached window_manager.windows as l_windows then
				if attached {EB_DEVELOPMENT_WINDOW} l_windows.item as l_window and then l_window.is_interface_usable then
					if attached l_window.editors_manager.editors as l_editors then
						from l_editors.start until l_editors.after loop
							if
								attached l_editors.item as l_editor and then
								l_editor.is_interface_usable and then
								attached {CLASSI_STONE} l_editor.stone as l_class
							then
									-- We have the class stone
								if attached l_class.class_i as l_class_i then
									if l_class_i.is_compiled then
										if not Result.is_empty then
											Result.append_character (',')
										end
										Result.append (l_class_i.name)
									end
								end
							end
							l_editors.forth
						end
					end
				end
			end
    	end

feature -- Basic operations

	set_test_tree_filter (a_filter: STRING_GENERAL)
			-- Set filter in `test_tree'.
			--
			-- `a_filter': New filter expression.
		require
			a_filter_attached: a_filter /= Void
		do
			test_tree.set_filter (a_filter)
		end

feature {NONE} -- Events: test creation

	on_create_manual_test (a_launch_wizard: BOOLEAN)
			-- Launch manual test creation.
			--
			-- `a_launch_wizard': True if wizard should be launched in advance, False otherwise.
		local
			l_system_available: BOOLEAN
			l_composition: ES_TEST_WIZARD_COMPOSITION
			l_wizard: ES_TEST_LAUNCH_WIZARD
			l_launch: BOOLEAN
		do
			l_system_available := Workbench.is_in_stable_state and then not Workbench.is_compiling
			if l_system_available then
				if a_launch_wizard then
					create l_composition.make (locale.translation ("Create manual test"), {ARRAY [ES_TEST_WIZARD_PAGE]} <<
						create {ES_TEST_MANUAL_WIZARD_PAGE},
						create {ES_TEST_TAGS_WIZARD_PAGE},
						create {ES_TEST_GENERAL_WIZARD_PAGE} >>)
					create l_wizard.make (l_composition, develop_window.window)
					l_launch := l_wizard.is_launch_requested
				else
					l_launch := True
				end
				if l_launch and attached session_manager.service as l_service then
					launch_session_type ({ETEST_MANUAL_CREATION}, agent launch_manual_test_creation (?, l_service))
				end
			end
		end

	on_generate_test (a_launch_wizard: BOOLEAN)
			-- Launch test generation for open classes.
			--
			-- `a_launch_wizard': True if wizard should be launched in advance, False otherwise.
		local
			l_composition: ES_TEST_WIZARD_COMPOSITION
			l_wizard: ES_TEST_LAUNCH_WIZARD
			l_launch: BOOLEAN
			l_types: STRING
		do
			l_types := open_classes
			if not l_types.is_empty and attached session_manager.service as l_session_service then
				l_session_service.retrieve (True).set_value (l_types, {TEST_SESSION_CONSTANTS}.temporary_types)
				if a_launch_wizard then
					create l_composition.make (locale.translation (generate_test_text), {ARRAY [ES_TEST_WIZARD_PAGE]} <<
						create {ES_TEST_GENERATION_WIZARD_PAGE}.make_using_temporary_types,
						create {ES_TEST_TAGS_WIZARD_PAGE},
						create {ES_TEST_GENERAL_WIZARD_PAGE} >>)
					create l_wizard.make (l_composition, develop_window.window)
					l_launch := l_wizard.is_launch_requested
				else
					l_launch := True
				end
				if l_launch then
					launch_session_type ({TEST_GENERATOR}, agent launch_test_generation (?, l_session_service, True))
				end
			end
		end

	on_generate_custom_test (a_launch_wizard: BOOLEAN)
			-- Launch test generation for custom type list.
			--
			-- `a_launch_wizard': True if wizard should be launched in advance, False otherwise.
		local
			l_composition: ES_TEST_WIZARD_COMPOSITION
			l_wizard: ES_TEST_LAUNCH_WIZARD
			l_launch: BOOLEAN
		do
			if a_launch_wizard then
				create l_composition.make (locale.translation (generate_test_text), {ARRAY [ES_TEST_WIZARD_PAGE]} <<
					create {ES_TEST_GENERATION_WIZARD_PAGE},
					create {ES_TEST_TAGS_WIZARD_PAGE},
					create {ES_TEST_GENERAL_WIZARD_PAGE} >>)
				create l_wizard.make (l_composition, develop_window.window)
				l_launch := l_wizard.is_launch_requested
			else
				l_launch := True
			end
			if l_launch and attached session_manager.service as l_session_service then
				launch_session_type ({TEST_GENERATOR}, agent launch_test_generation (?, l_session_service, False))
			end
		end

	on_extract_test (a_launch_wizard: BOOLEAN; an_app_status: APPLICATION_STATUS)
			-- Launch test extraction.
			--
			-- `a_launch_wizard': True if wizard should be launched in advance, False otherwise.
		local
			l_page: ES_TEST_CALL_STACK_WIZARD_PAGE
			l_composition: ES_TEST_WIZARD_COMPOSITION
			l_wizard: ES_TEST_LAUNCH_WIZARD
			l_session_service: detachable SESSION_MANAGER_S
		do
			l_session_service := session_manager.service
			if a_launch_wizard then
				create l_page.make (an_app_status)
				create l_composition.make (locale.translation (extract_test_text), {ARRAY [ES_TEST_WIZARD_PAGE]} <<
					l_page,
					create {ES_TEST_TAGS_WIZARD_PAGE},
					create {ES_TEST_GENERAL_WIZARD_PAGE} >>)
				create l_wizard.make (l_composition, develop_window.window)
				if l_wizard.is_launch_requested and l_session_service /= Void then
					launch_session_type ({ETEST_EXTRACTION}, agent launch_test_extraction (?, l_session_service, l_page.call_stack_elements))
				end
			elseif l_session_service /= Void then
				launch_session_type ({ETEST_EXTRACTION}, agent launch_default_test_extraction (?, l_session_service, Void))
			end
		end

	on_launch_creation_preferences
			-- Launch creation preferences wizard.
		local
			l_composition: ES_TEST_WIZARD_COMPOSITION
			l_wizard: ES_TEST_PREFERENCE_WIZARD
		do
			create l_composition.make (locale.translation (t_creation_preferences), {ARRAY [ES_TEST_WIZARD_PAGE]} <<
				create {ES_TEST_GENERAL_WIZARD_PAGE},
				create {ES_TEST_TAGS_WIZARD_PAGE},
				create {ES_TEST_MANUAL_WIZARD_PAGE},
				create {ES_TEST_GENERATION_WIZARD_PAGE},
				create {ES_TEST_EXTRACTION_WIZARD_PAGE} >>)
			create l_wizard.make (l_composition, develop_window.window)
		end

feature {NONE} -- Events: test execution

	on_run_current (a_debug: BOOLEAN)
			-- Called when user presses `run_button' or `debug_button' directly.
			--
			-- `a_debug': True if `debug_button' was pressed, False otherwise.
		do
			if test_tree.tag_tree.selected_nodes.is_empty then
				on_run_filtered (a_debug)
			else
				on_run_selected (a_debug)
			end
		end

	on_run_all (a_debug: BOOLEAN)
			-- Called when user selects "run all" item of `run_button'.
			--
			-- `a_debug': True if `debug_button' was pressed, False otherwise.
		local
			l_executor: TEST_EXECUTION
		do
			if attached test_suite.service as l_test_suite then
				create l_executor.make (l_test_suite, is_gui)
				l_test_suite.tests.do_all (agent l_executor.queue_test)
				l_test_suite.launch_session (l_executor)
				--launch_executor (Void, a_type)
			end
		end

	on_run_failing (a_debug: BOOLEAN)
			-- Called when user selectes "run failing" item of `run_button'.
			--
			-- `a_debug': True if `debug_button' was pressed, False otherwise.
		local
			l_item: TEST_I
			l_list: ARRAYED_LIST [TEST_I]
			l_tests: SEQUENCE [TEST_I]
		do
			if attached test_suite.service as l_test_suite then
				l_tests := l_test_suite.tests
				create l_list.make (l_tests.count)
				from
					l_tests.start
				until
					l_tests.after
				loop
					l_item := l_tests.item_for_iteration
					-- FIXME: only execute failing once statistics are implemented
					--if l_item.is_outcome_available then
					--	if l_item.last_outcome.is_fail then
							l_list.force (l_item)
					--	end
					--end
					l_tests.forth
				end
				launch_executor (l_list, a_debug)
			end
		end

	on_run_filtered (a_debug: BOOLEAN)
			-- Called when user selects "run filteres" item of `run_button'.
			--
			-- `a_debug': True if `debug_button' was pressed, False otherwise.
		local
			l_tests: ARRAYED_LIST [TEST_I]
		do
			l_tests := test_tree.tag_tree.items.linear_representation
			launch_executor (l_tests, a_debug)
		end

	on_run_selected (a_debug: BOOLEAN)
			-- Called when user selects "run selected" item of `run_button'.
			--
			-- `a_debug': True if `debug_button' was pressed, False otherwise.
		local
			l_items: SEARCH_TABLE [TEST_I]
			l_nodes: SEARCH_TABLE [TAG_TREE_NODE [TEST_I]]
		do
			create l_items.make (10)
			from
				l_nodes := test_tree.tag_tree.selected_nodes
				l_nodes.start
			until
				l_nodes.after
			loop
				l_nodes.item_for_iteration.append_items_recursive (l_items)
				l_nodes.forth
			end
			launch_executor (l_items.linear_representation, a_debug)
		end

	on_stop
			-- Stop any running test processor
		do
			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					local
						l_sessions: ARRAYED_LIST [TEST_SESSION_I]
						l_session: TEST_SESSION_I
					do
						l_sessions := a_test_suite.running_sessions
						from
							l_sessions.start
						until
							l_sessions.after
						loop
							l_session := l_sessions.item_for_iteration
							if l_session.has_next_step then
								l_session.cancel
							end
							l_sessions.forth
						end
					end)
		end

feature {TEST_SUITE_S} -- Events: test suite

	on_session_launched (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- <Precursor>
		do
			update_running_state
		end

	on_session_finished (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- <Precursor>
		do
			update_running_state
		end

	update_running_state
			-- Update buttons according to currently running test session in test suite.
		do
			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					do
						if a_test_suite.running_sessions.count > 0 then
							if not stop_button.is_sensitive then
								stop_button.enable_sensitive
							end
						else
							if stop_button.is_sensitive then
								stop_button.disable_sensitive
							end
						end
					end)
		end

feature {NONE} -- Events: tree view

	on_selection_change (a_node: TAG_TREE_NODE [TEST_I]; a_is_selected: BOOLEAN)
			-- Called when item is selected or deselected.
		do
			update_selection_state
		end

	update_selection_state
			-- Update buttons and menus according to selection state in `test_tree'
		do
			if test_tree.tag_tree.selected_nodes.is_empty then
				run_selected_menu.disable_sensitive
				debug_selected_menu.disable_sensitive
				run_button.set_tooltip (locale_formatter.translation (tt_run_filtered))
				debug_button.set_tooltip (locale_formatter.translation (tt_debug_filtered))
			else
				run_selected_menu.enable_sensitive
				debug_selected_menu.enable_sensitive
				run_button.set_tooltip (locale_formatter.translation (tt_run_selected))
				debug_button.set_tooltip (locale_formatter.translation (tt_debug_selected))
			end
		end

feature {NONE} -- Factory

	create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_menu: EV_MENU
		do
			create Result.make (7)

			create creation_button.make
			creation_button.set_tooltip (locale_formatter.translation (create_test_text))
			creation_button.set_pixmap (test_creation_pixmap)
			creation_button.set_pixel_buffer (test_creation_pixel_buffer)
			creation_button.set_menu_function (agent test_creation_menu)
			register_action (creation_button.select_actions, agent on_create_manual_test (True))
			Result.extend (creation_button)

				-- Test generation button	
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Create run button
			create run_button.make
			run_button.set_tooltip (locale_formatter.translation (f_run_button))
			run_button.set_pixel_buffer (stock_pixmaps.debug_run_icon_buffer)
			run_button.set_pixmap (stock_pixmaps.debug_run_icon)
			register_action (run_button.select_actions, agent on_run_current (False))

			create l_menu
			create run_all_menu.make_with_text (locale_formatter.translation (m_run_all))
			register_action (run_all_menu.select_actions, agent on_run_all (False))
			l_menu.extend (run_all_menu)
			create run_failing_menu.make_with_text (locale_formatter.translation (m_run_failing))
			register_action (run_failing_menu.select_actions, agent on_run_failing (False))
			l_menu.extend (run_failing_menu)
			create run_filtered_menu.make_with_text (locale_formatter.translation (m_run_filtered))
			register_action (run_filtered_menu.select_actions, agent on_run_filtered (False))
			l_menu.extend (run_filtered_menu)
			create run_selected_menu.make_with_text (locale_formatter.translation (m_run_selected))
			register_action (run_selected_menu.select_actions, agent on_run_selected (False))
			l_menu.extend (run_selected_menu)

			l_menu.extend (create {EV_MENU_SEPARATOR})

			l_menu.extend (create {EV_MENU_ITEM}.make_with_text_and_action (locale.translation (preferences_text) + "...", agent
				local
					l_comp: ES_TEST_WIZARD_COMPOSITION
					l_wizard: ES_TEST_PREFERENCE_WIZARD
				do
					create l_comp.make (locale.translation (t_execution_preferences), <<
						create {ES_TEST_EXECUTION_WIZARD_PAGE}>>)
					create l_wizard.make (l_comp, develop_window.window)
				end))

			run_button.set_menu (l_menu)

			Result.extend (run_button)

				-- Create debug button
			create debug_button.make
			debug_button.set_tooltip (locale_formatter.translation (f_debug_button))
			debug_button.set_pixel_buffer (stock_pixmaps.debugger_environment_force_execution_mode_icon_buffer)
			debug_button.set_pixmap (stock_pixmaps.debugger_environment_force_execution_mode_icon)
			register_action (debug_button.select_actions, agent on_run_current (True))

			create l_menu
			create debug_all_menu.make_with_text (locale_formatter.translation (m_debug_all))
			register_action (debug_all_menu.select_actions, agent on_run_all (True))
			l_menu.extend (debug_all_menu)
			create debug_failing_menu.make_with_text (locale_formatter.translation (m_debug_failing))
			register_action (debug_failing_menu.select_actions, agent on_run_failing (True))
			l_menu.extend (debug_failing_menu)
			create debug_filtered_menu.make_with_text (locale_formatter.translation (m_debug_filtered))
			register_action (debug_filtered_menu.select_actions, agent on_run_filtered (True))
			l_menu.extend (debug_filtered_menu)
			create debug_selected_menu.make_with_text (locale_formatter.translation (m_debug_selected))
			register_action (debug_selected_menu.select_actions, agent on_run_selected (True))
			l_menu.extend (debug_selected_menu)

			debug_button.set_menu (l_menu)

			Result.extend (debug_button)

				-- Create stop button
			create stop_button.make
			stop_button.set_tooltip (locale_formatter.translation (f_stop_button))
			stop_button.set_pixel_buffer (stock_pixmaps.debug_stop_icon_buffer)
			stop_button.set_pixmap (stock_pixmaps.debug_stop_icon)
			register_action (stop_button.select_actions, agent on_stop)
			Result.extend (stop_button)
		end

feature {NONE} -- Internationalization

	t_testing_output: STRING = "Testing"
	t_execution: STRING = "Execution"
	t_creation: STRING = "Creation"

	t_execution_preferences: STRING = "Execution Settings"
	t_creation_preferences: STRING = "Test Creation Settings"

	create_test_text: STRING = "Create new test"
	create_manual_text: STRING = "Create Manual Test"
	generate_test_text: STRING = "Generate Tests"
	extract_test_text: STRING = "Extract Tests"

	generate_all_text: STRING = "Generate tests for open classes"
	generate_custom_text: STRING = "Generate tests for custom types"
	extract_text: STRING = "Extract tests from debugger"
	preferences_text: STRING = "Preferences"

	f_run_button: STRING = "Run all tests in background"
	f_debug_button: STRING = "Debug all tests in EiffelStudio"
	f_stop_button: STRING = "Stop all test related tasks"

	m_run_all: STRING = "Run all"
	m_run_failing: STRING = "Run failing"
	m_run_filtered: STRING = "Run filtered"
	m_run_selected: STRING = "Run selected"
	tt_run_filtered: STRING = "Run filtered tests"
	tt_run_selected: STRING = "Run selected tests"
	m_debug_all: STRING = "Debug all"
	m_debug_failing: STRING = "Debug failing"
	m_debug_filtered: STRING = "Debug filtered"
	m_debug_selected: STRING = "Debug selected"
	tt_debug_filtered: STRING = "Debug filtered tests"
	tt_debug_selected: STRING = "Run selected tests"

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
