indexing
	description: "[
		Graphical panel for EiffelStudio's testing tool.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_PANEL_63

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			on_before_initialize,
			on_after_initialized,
			create_right_tool_bar_items
		end

	ES_SHARED_EIFFEL_TEST_SERVICE
		export
			{NONE} all
		end

	EIFFEL_TEST_SUITE_OBSERVER
		redefine
			on_test_added,
			on_test_changed,
			on_test_removed,
			on_processor_launched,
			on_processor_stopped,
			on_processor_error
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	TAG_UTILITIES
		export
			{NONE} all
		end

create {ES_TESTING_TOOL_63}
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		local
			l_et: KL_EQUALITY_TESTER [!STRING]
		do
			Precursor
			l_et ?= create {KL_STRING_EQUALITY_TESTER}
			create view_templates.make (5)
			view_templates.set_equality_tester (l_et)
			create view_template_descriptions.make (5)
			view_template_descriptions.set_equality_tester (l_et)
			create view_history.make
			view_history.set_equality_tester (l_et)

			create filter.make
		end

feature {NONE} -- Initialization: widgets

	build_tool_interface (a_widget: like create_widget) is
			-- <Precursor>
		do
			build_view_bar (a_widget)
			create split_area
			build_tree_view
			build_notebook
			a_widget.extend (split_area)
		end

	build_view_bar (a_widget: like create_widget) is
			-- Build tool bar containing view and filter box
		local
			l_tool_bar: SD_TOOL_BAR
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			create l_hbox
			l_hbox.set_padding (10)
			l_hbox.set_border_width (5)

				-- Create and add `view_box' with label
			create l_label.make_with_text (local_formatter.translation (l_view))
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create view_box
			l_hbox.extend (view_box)
			register_action (view_box.select_actions, agent on_select_view)
			register_action (view_box.return_actions, agent on_return_view)

				-- Create and add `filter_box' with label
			create l_label.make_with_text (local_formatter.translation (l_filter))
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create filter_box
			register_action (filter_box.return_actions, agent on_return_filter)
			l_hbox.extend (filter_box)

			create clear_filter_button.make
			clear_filter_button.set_pixel_buffer (stock_pixmaps.general_reset_icon_buffer)
			clear_filter_button.set_pixmap (stock_pixmaps.general_reset_icon)
			clear_filter_button.set_tooltip (local_formatter.translation (tt_clear_filter))
			register_action (clear_filter_button.select_actions, agent on_clear_filter)
			create l_tool_bar.make
			l_tool_bar.extend (clear_filter_button)
			l_tool_bar.compute_minimum_size
			l_hbox.extend (l_tool_bar)
			l_hbox.disable_item_expand (l_tool_bar)

			a_widget.extend (l_hbox)
			a_widget.disable_item_expand (l_hbox)
		end

	build_tree_view is
			-- Create `tree_view' and add it to `split_area'.
		do
			create tree_view.make (develop_window)
			split_area.set_first (tree_view.widget)
			register_action (tree_view.item_selected_actions, agent on_selection_change (?, True))
			register_action (tree_view.item_deselected_actions, agent on_selection_change (?, False))
			register_action (tree_view.item_pointer_double_press_actions, agent on_item_double_press)
		end

	build_notebook
			-- Create `notebook' and add permament tabs.
		do
			create notebook
			create outcome_tab.make (develop_window)
			notebook.extend (outcome_tab.widget)
			notebook.set_item_text (outcome_tab.widget, outcome_tab.title)
			notebook.item_tab (outcome_tab.widget).set_pixmap (outcome_tab.icon_pixmap)
			split_area.set_second (notebook)
		end

feature {NONE} -- Initialization: widget status

	on_after_initialized
			-- <Precursor>
		local
			l_service: EIFFEL_TEST_SUITE_S
		do
			Precursor
			if test_suite.is_service_available then
				l_service := test_suite.service
				l_service.connect_events (Current)
			end
			tree_view.set_layout (create {ES_EIFFEL_TEST_GRID_LAYOUT})
			propagate_drop_actions (Void)

			initialize_tool_bar
			initialize_view_bar
			update_run_labels
		end

	initialize_tool_bar
			-- Initialize tool bar buttons
		do
			--register_action (a_sequence: ACTION_SEQUENCE [TUPLE], a_action: PROCEDURE [ANY, TUPLE])
		end

	initialize_view_bar
			-- Initialize view bar combo boxes
		do
			view_templates.force_last ("")
			view_template_descriptions.force_last ("")
			view_templates.force_last ("class")
			view_template_descriptions.force_last ("Tests")
			view_templates.force_last ("outcome")
			view_template_descriptions.force_last ("Outcomes")
			view_templates.force_last ("covers")
			view_template_descriptions.force_last ("Classes under test")
			view_templates.force_last ("type")
			view_template_descriptions.force_last ("Types")

			update_view_box
			view_box.i_th (2).enable_select
		end

feature -- Access: help

	help_context_id: !STRING_GENERAL
			-- <Precursor>
		once
			Result := "702E5BFA-6EB6-48AA-B7DE-C7CB3E9D0471"
		end

feature {NONE} -- Access

	tree_view: !ES_TAGABLE_TREE_GRID [!EIFFEL_TEST_I]
			-- Tree view displaying tests

	filter: !TAG_BASED_FILTERED_COLLECTION [!EIFFEL_TEST_I]
			-- Collection used for filter

	outcome_tab: !ES_TESTING_TOOL_OUTCOME_WIDGET
			-- Tab showing details of a selected test

feature {NONE} -- Access: widgets

	view_box: !EV_COMBO_BOX
			-- Combo box which defines prefix for `tree_view'

	filter_box: !EV_COMBO_BOX
			-- Combo box containing pattern for filtering tests

	split_area: !EV_VERTICAL_SPLIT_AREA
			-- Splitting area for grid and notebook

	notebook: !EV_NOTEBOOK
			-- Notebook for detailed information

	runs_label: !EV_LABEL
			-- Label showing number of tests which have been executed

	errors_label: !EV_LABEL
			-- Label showing number of tests currently failing

	errors_pixmap: !EV_PIXMAP

feature {NONE} -- Access: view

	view_templates: !DS_ARRAYED_LIST [!STRING]
			-- List of predefined tags to be used in `tree_view'

	view_template_descriptions: !DS_ARRAYED_LIST [!STRING]
			-- List of readable descriptions for each tag in `view_templates'

	view_history: !DS_LINKED_LIST [!STRING]
			-- List of tags user has entered recently

feature {NONE} -- Access: buttons

	wizard_button: !SD_TOOL_BAR_BUTTON
			-- Button for launching test wizard

	run_button: !SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button for launching the test executor

	debug_button: !SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button for debugging tests

	stop_button: !SD_TOOL_BAR_BUTTON
			-- Button for stopping any current test execution

	clear_filter_button: !SD_TOOL_BAR_BUTTON
			-- Button for clearing any filter

feature {NONE} -- Access: menus

	run_all_menu,
	run_failing_menu,
	run_selected_menu,
	run_filtered_menu: !EV_MENU_ITEM
			-- Menu items for running tests in background

	debug_all_menu,
	debug_failing_menu,
	debug_selected_menu,
	debug_filtered_menu: !EV_MENU_ITEM
			-- Menu items for debugging tests

feature {NONE} -- Status setting: view

	on_return_view is
			-- Called when the user enters a new view definition
		local
			l_orig_tag, l_tag: !STRING
		do
			l_orig_tag ?= view_box.text.to_string_8
			l_tag := l_orig_tag
			if not l_tag.is_empty then
				if l_tag.starts_with (split_char.out) then
					l_tag := l_tag.substring (2, l_tag.count)
				end
				if l_tag.ends_with (split_char.out) then
					l_tag := l_tag.substring (1, l_tag.count - 1)
				end
			end
			if is_valid_tag (l_tag) then
				if not l_tag.is_empty then
					if not view_templates.has (l_tag) then
						view_history.start
						view_history.search_forth (l_tag)
						if not view_history.after then
							view_history.remove_at
						end
						view_history.put_first (l_tag)
						if view_history.count > 3 then
							view_history.remove_last
						end
						update_view_box
					end
				end
				view_box.set_text (l_tag)
				execute_with_busy_cursor (agent update_view)
			else
				-- TODO: report bad view definition
			end
		end

	on_select_view is
			-- Called when a view new view is selected
		local
			l_tag: STRING
		do
			l_tag ?= view_box.selected_item.data
			check
				tag_attached: l_tag /= Void
			end
			view_box.set_text (l_tag)
			execute_with_busy_cursor (agent update_view)
		end

	on_return_filter
			-- Called when user presses enter in `filter_box'.
		do
			execute_with_busy_cursor (agent update_view)
		end

	on_clear_filter
			-- Called when `clear_filter_button' is pressed.
		do
			filter_box.set_text ("")
			execute_with_busy_cursor (agent update_view)
		end

	update_view_box is
			-- Update proposal list for `view_box'
		local
			l_cursor: !DS_LINEAR_CURSOR [!STRING]
			i: INTEGER
			l_item: EV_LIST_ITEM
		do
			view_box.wipe_out
			from
				l_cursor ?= view_history.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				create l_item.make_with_text (l_cursor.item)
				l_item.set_data (l_cursor.item)
				view_box.extend (l_item)
				l_cursor.forth
			end
			from
				i := 1
			until
				i > view_templates.count
			loop
				create l_item.make_with_text (view_template_descriptions.item (i))
				l_item.set_data (view_templates.item (i))
				view_box.extend (l_item)
				i := i + 1
			end
		end

	update_view is
			-- Refresh `tree_view' according to current view definition.
		local
			l_tag: !STRING
		do
			develop_window.lock_update
			if test_suite.is_service_available then
				l_tag ?= view_box.text.to_string_8
				if tree_view.is_connected then
					if not tree_view.tag_prefix.is_equal (l_tag) then
						tree_view.disconnect
					end
				end
				if not filter.is_connected then
					filter.connect (test_suite.service)
				end
				if {l_expr: !STRING} filter_box.text.to_string_8 and then not l_expr.is_empty then
					if not (filter.has_expression and then filter.expression.is_equal (l_expr)) then
						filter.set_expression (l_expr)
					end
				elseif filter.has_expression then
					filter.remove_expression
				end
				if not tree_view.is_connected then
					tree_view.connect (filter, l_tag)
				end
			else
				if tree_view.is_connected then
					tree_view.disconnect
				end
				if filter.is_connected then
					filter.disconnect
				end
			end
			develop_window.unlock_update
		end

feature {NONE} -- Status setting: stones

	on_stone_changed (a_old_stone: ?like stone)
			-- <Precursor>
		local
			l_name: STRING
		do
			if not is_in_stone_synchronization then
				if {l_class_stone: !CLASSI_STONE} stone and then {l_class: !EIFFEL_CLASS_I} l_class_stone.class_i then
					l_name := l_class_stone.class_name
					if test_suite.is_service_available then
						test_suite.service.synchronize_with_class (l_class)
						if test_suite.service.is_test_class (l_class) then
							view_box.set_text ("class")
						else
							view_box.set_text ("covers")
						end
					else
						view_box.set_text ("covers")
					end
					filter_box.set_text (l_name)
					update_view
				end
			end
		end

feature {NONE} -- Status settings: widgets

	update_run_labels
			-- Update text in `runs_label' and `errors_label'.
		local
			l_text: STRING_32
			l_ts: EIFFEL_TEST_SUITE_S
		do
			if test_suite.is_service_available then
				l_ts := test_suite.service
				create l_text.make (10)
				l_text.append ("Run: ")
				l_text.append_natural_32 (l_ts.count_executed)
				l_text.append_character ('/')
				if l_ts.is_project_initialized then
					l_text.append_integer (l_ts.tests.count)
				else
					l_text.append_integer (0)
				end
				runs_label.set_text (l_text)

				create l_text.make (10)
				l_text.append ("Failing: ")
				l_text.append_natural_32 (l_ts.count_failing)
				errors_label.set_text (l_text)

				if l_ts.count_failing > 0 then
					errors_pixmap.enable_sensitive
					errors_label.enable_sensitive
				else
					errors_pixmap.disable_sensitive
					errors_label.disable_sensitive
				end

				if {l_tb: like right_tool_bar_widget} right_tool_bar_widget then
					l_tb.compute_minimum_size
				end
			end
		end

feature {NONE} -- Events: test execution

	on_run_current (a_type: !TYPE [EIFFEL_TEST_EXECUTOR_I]) is
			-- Called when user presses `run_button' or `debug_button' directly.
		do
			if test_suite.is_service_available then
				if not tree_view.selected_items.is_empty then
					on_run_selected (a_type)
				else
					on_run_filtered (a_type)
				end
			end
		end

	on_run_all (a_type: !TYPE [EIFFEL_TEST_EXECUTOR_I]) is
			-- Called when user selects "run all" item of `run_button'.
		do
			if test_suite.is_service_available then
				execute_list (test_suite.service.tests, a_type)
			end
		end

	on_run_failing (a_type: !TYPE [EIFFEL_TEST_EXECUTOR_I]) is
			-- Called when user selectes "run failing" item of `run_button'.
		local
			l_item: !EIFFEL_TEST_I
			l_list: !DS_ARRAYED_LIST [!EIFFEL_TEST_I]
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
		do
			if test_suite.is_service_available then
				create l_list.make (test_suite.service.tests.count)
				l_cursor := test_suite.service.tests.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					l_item := l_cursor.item
					if l_item.is_outcome_available then
						if l_item.last_outcome.is_fail then
							l_list.force_last (l_item)
						end
					end
					l_cursor.forth
				end
				execute_list (l_list, a_type)
			end
		end

	on_run_filtered (a_type: !TYPE [EIFFEL_TEST_EXECUTOR_I]) is
			-- Called when user selects "run filteres" item of `run_button'.
		do
			if test_suite.is_service_available then
				execute_list (filter.items, a_type)
			end
		end

	on_run_selected (a_type: !TYPE [EIFFEL_TEST_EXECUTOR_I]) is
			-- Called when user selects "run selected" item of `run_button'.
		do
			if test_suite.is_service_available then
				execute_list (tree_view.selected_items, a_type)
			end
		end

	execute_list (a_list: !DS_LINEAR [!EIFFEL_TEST_I]; a_type: !TYPE [EIFFEL_TEST_EXECUTOR_I])
			-- Try to run all tests in a given list through the background executor. If of some reason
			-- the tests can not be executed, show an error message.
		require
			test_suite_available: test_suite.is_service_available
		local
			l_executor: EIFFEL_TEST_EXECUTOR_I
			l_test_suite: EIFFEL_TEST_SUITE_S
		do
			l_test_suite := test_suite.service
			if l_test_suite.processor_registrar.is_registered (a_type) then
				l_executor := l_test_suite.executor (a_type)
				if l_executor.is_ready (l_test_suite) then
					if l_executor.is_valid_test_list (a_list, l_test_suite) then
						l_test_suite.run_list (l_executor, a_list, False)
					else
						-- TODO: message saying choosen tests can not be executed...
					end
				else
					-- TODO: message saying executor is currently running tests
				end
			else
				-- TODO: message saying executor is not available
			end
		end

	on_stop
			-- Stop any running test processor
		local
			l_cursor: DS_LINEAR_CURSOR [EIFFEL_TEST_PROCESSOR_I]
		do
			if test_suite.is_service_available then
				from
					l_cursor := test_suite.service.processor_registrar.processors.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					if l_cursor.item.is_interface_usable and l_cursor.item.is_running then
						l_cursor.item.request_stop
					end
					l_cursor.forth
				end
			end
		end

feature {NONE} -- Events: labels

	on_run_label_select
			-- Called when user clicks on `runs_label'.
		do
			view_box.set_text (l_outcome_view)
			filter_box.set_text ("")
			update_view
		end

	on_error_label_select
			-- Called when user clicks on `errors_label'.
		do
			view_box.set_text (l_outcome_view)
			filter_box.set_text (l_filter_not_passing)
			update_view
		end

feature {EIFFEL_TEST_SUITE_S} -- Events: test suite

	on_test_added (a_collection: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]; a_item: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			update_run_labels
		end

	on_test_changed (a_test_suite: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]; a_test: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			if outcome_tab.is_active and then outcome_tab.test = a_test then
				outcome_tab.show_test (a_test)
			end
			update_run_labels
		end

	on_test_removed (a_collection: !ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]; a_item: !EIFFEL_TEST_I)
			-- <Precursor>
		do
			if outcome_tab.is_active and then outcome_tab.test = a_item then
				outcome_tab.remove_test
			end
			update_run_labels
		end

	on_processor_launched (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		local
			l_new_tab: ES_TESTING_TOOL_PROCESSOR_WIDGET
			l_found: BOOLEAN
		do
			from
				notebook.start
			until
				notebook.after or l_found
			loop
				if {l_tab: ES_TESTING_TOOL_PROCESSOR_WIDGET} notebook.item_for_iteration.data then
					if l_tab.processor = a_processor then
						l_found := True
						notebook.item_tab (l_tab.widget).enable_select
					end
				end
				notebook.forth
			end

			if not l_found then
				if {l_executor: !EIFFEL_TEST_EXECUTOR_I} a_processor then
					create {ES_TESTING_TOOL_EXECUTOR_WIDGET} l_new_tab.make (l_executor, develop_window.as_attached)
				elseif {l_generator: !EIFFEL_TEST_GENERATOR_I} a_processor then
					create {ES_TESTING_TOOL_GENERATOR_WIDGET} l_new_tab.make (l_generator, develop_window.as_attached)
				elseif {l_factory: !EIFFEL_TEST_FACTORY_I} a_processor then
					create {ES_TESTING_TOOL_FACTORY_WIDGET} l_new_tab.make (l_factory, develop_window.as_attached)
				end
				if l_new_tab /= Void then
					l_new_tab.widget.set_data (l_new_tab)
					register_action (l_new_tab.grid.item_pointer_double_press_actions, agent on_item_double_press)
					notebook.go_i_th (notebook.count)
					notebook.put_right (l_new_tab.widget)
					notebook.set_item_text (l_new_tab.widget, l_new_tab.title)
					notebook.item_tab (l_new_tab.widget).set_pixmap (l_new_tab.icon_pixmap)
					notebook.item_tab (l_new_tab.widget).enable_select
				end
			end

			if background_executor_type.attempt (a_processor) /= Void then
				run_button.disable_sensitive
			elseif debug_executor_type.attempt (a_processor) /= Void then
				debug_button.disable_sensitive
			end
		end

 	on_processor_stopped (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
 			-- <Precursor>
 		do
 			if background_executor_type.attempt (a_processor) /= Void then
				run_button.enable_sensitive
			elseif debug_executor_type.attempt (a_processor) /= Void then
				debug_button.enable_sensitive
			end
 		end

 	on_processor_error (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I; a_error: !STRING_8; a_token_values: !TUPLE)
 			-- <Precursor>
 		do
 			if window_manager.last_focused_window = develop_window then
 				prompts.show_error_prompt (local_formatter.formatted_translation (a_error, a_token_values), develop_window.window, Void)
 			end
 		end

feature {ES_TAGABLE_TREE_GRID} -- Events: tree view

	on_item_double_press (a_item: !EIFFEL_TEST_I)
			-- Called when user double presses on item in of the grids
		do
			if not outcome_tab.is_active or else outcome_tab.test /= a_item then
				outcome_tab.show_test (a_item)
			end
			notebook.item_tab (outcome_tab.widget).enable_select
		end

	on_selection_change (a_test: !EIFFEL_TEST_I; a_is_selected: BOOLEAN)
			-- Called when item is selected or deselected.
		do
			if tree_view.selected_items.is_empty then
				run_selected_menu.disable_sensitive
				debug_selected_menu.disable_sensitive
			else
				run_selected_menu.enable_sensitive
				debug_selected_menu.enable_sensitive
			end
		end

feature {NONE} -- Factory

	create_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_menu: EV_MENU
		do
			create Result.make (5)

			create wizard_button.make
			wizard_button.set_text ("New test")
			register_action (wizard_button.select_actions, agent
				local
					l_wizard: ES_EIFFEL_TEST_WIZARD_MANAGER
				do
					create l_wizard.make (develop_window)
				end)
			Result.force_last (wizard_button)

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Create run button
			create run_button.make
			run_button.set_tooltip (local_formatter.translation (f_run_button))
			run_button.set_pixel_buffer (stock_pixmaps.debug_run_icon_buffer)
			run_button.set_pixmap (stock_pixmaps.debug_run_icon)
			register_action (run_button.select_actions, agent on_run_current (background_executor_type))

			create l_menu
			create run_all_menu.make_with_text (local_formatter.translation (m_run_all))
			register_action (run_all_menu.select_actions, agent on_run_all (background_executor_type))
			l_menu.extend (run_all_menu)
			create run_failing_menu.make_with_text (local_formatter.translation (m_run_failing))
			register_action (run_failing_menu.select_actions, agent on_run_failing (background_executor_type))
			l_menu.extend (run_failing_menu)
			create run_filtered_menu.make_with_text (local_formatter.translation (m_run_filtered))
			register_action (run_filtered_menu.select_actions, agent on_run_filtered (background_executor_type))
			l_menu.extend (run_filtered_menu)
			create run_selected_menu.make_with_text (local_formatter.translation (m_run_selected))
			register_action (run_selected_menu.select_actions, agent on_run_selected (background_executor_type))
			l_menu.extend (run_selected_menu)
			run_button.set_menu (l_menu)

			Result.force_last (run_button)

				-- Create debug button
			create debug_button.make
			debug_button.set_tooltip (local_formatter.translation (f_debug_button))
			debug_button.set_pixel_buffer (stock_pixmaps.debugger_environment_force_debug_mode_icon_buffer)
			debug_button.set_pixmap (stock_pixmaps.debugger_environment_force_debug_mode_icon)
			register_action (debug_button.select_actions, agent on_run_current (debug_executor_type))

			create l_menu
			create debug_all_menu.make_with_text (local_formatter.translation (m_debug_all))
			register_action (debug_all_menu.select_actions, agent on_run_all (debug_executor_type))
			l_menu.extend (debug_all_menu)
			create debug_failing_menu.make_with_text (local_formatter.translation (m_debug_failing))
			register_action (debug_failing_menu.select_actions, agent on_run_failing (debug_executor_type))
			l_menu.extend (debug_failing_menu)
			create debug_filtered_menu.make_with_text (local_formatter.translation (m_debug_filtered))
			register_action (debug_filtered_menu.select_actions, agent on_run_filtered (debug_executor_type))
			l_menu.extend (debug_filtered_menu)
			create debug_selected_menu.make_with_text (local_formatter.translation (m_debug_selected))
			register_action (debug_selected_menu.select_actions, agent on_run_selected (debug_executor_type))
			l_menu.extend (debug_selected_menu)
			debug_button.set_menu (l_menu)

			Result.force_last (debug_button)

				-- Create stop button
			create stop_button.make
			stop_button.set_tooltip (local_formatter.translation (f_stop_button))
			stop_button.set_pixel_buffer (stock_pixmaps.debug_stop_icon_buffer)
			stop_button.set_pixmap (stock_pixmaps.debug_stop_icon)
			register_action (stop_button.select_actions, agent on_stop)
			Result.force_last (stop_button)
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_vbox: EV_VERTICAL_BOX
			l_box: EV_HORIZONTAL_BOX
			l_pixmap: EV_PIXMAP
		do
			create Result.make (4)

				-- Runs
			create l_vbox
			l_vbox.extend (create {EV_CELL})

			create l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.notebook_border)
			l_box.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)

			l_pixmap := stock_pixmaps.run_animation_5_icon.twin
			register_action (l_pixmap.pointer_double_press_actions, agent on_run_label_select)

			l_pixmap.set_minimum_size (l_pixmap.width, l_pixmap.height)
			l_box.extend (l_pixmap)

			create runs_label
			runs_label.align_text_left
			register_action (runs_label.pointer_double_press_actions, agent on_run_label_select)
			l_box.extend (runs_label)

			l_vbox.extend (l_box)
			l_vbox.disable_item_expand (l_box)
			l_vbox.extend (create {EV_CELL})
			Result.force_last (create {SD_TOOL_BAR_WIDGET_ITEM}.make (l_vbox))

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Errors
			create l_vbox
			l_vbox.extend (create {EV_CELL})

			create l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.notebook_border)
			l_box.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)

			create errors_pixmap.make_with_pixel_buffer (stock_pixmaps.general_error_icon_buffer)
			errors_pixmap.set_minimum_size (errors_pixmap.width, errors_pixmap.height)
			register_action (errors_pixmap.pointer_double_press_actions, agent on_error_label_select)
			l_box.extend (errors_pixmap)

			create errors_label
			errors_label.align_text_left
			register_action (errors_label.pointer_double_press_actions, agent on_error_label_select)
			l_box.extend (errors_label)

			l_vbox.extend (l_box)
			l_vbox.disable_item_expand (l_box)
			l_vbox.extend (create {EV_CELL})
			Result.force_last (create {SD_TOOL_BAR_WIDGET_ITEM}.make (l_vbox))
		end

feature {NONE} -- Internationalization

	f_run_button: STRING = "Run all tests in background"
	f_debug_button: STRING = "Debug all tests in EiffelStudio"
	f_stop_button: STRING = "Stop all execution"
	tt_clear_filter: STRING = "Clear filter"

	m_run_all: STRING = "Run all"
	m_run_failing: STRING = "Run failing"
	m_run_filtered: STRING = "Run filtered"
	m_run_selected: STRING = "Run selected"
	m_debug_all: STRING = "Debug all"
	m_debug_failing: STRING = "Debug failing"
	m_debug_filtered: STRING = "Debug filtered"
	m_debug_selected: STRING = "Debug selected"

	l_view: STRING = "View"
	l_filter: STRING = "Filter"
	l_outcome_view: STRING = "outcome"
	l_filter_not_passing: STRING = "-outcome/passes"

invariant
	predefined_view_count_correct: view_template_descriptions.count = view_templates.count
	details_tab_valid: notebook.has (outcome_tab.widget)

end
