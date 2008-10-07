indexing
	description: "[
		Widget showing status and control buttons for an {EIFFEL_TEST_EXECUTOR_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_EXECUTOR_WIDGET

inherit
	ES_NOTEBOOK_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_widget
		redefine
			on_after_initialized
		end

	EIFFEL_TEST_SUITE_OBSERVER
		redefine
			on_processor_launched,
			on_processor_finished,
			on_processor_stopped
		end

	ES_SHARED_EIFFEL_TEST_SERVICE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_executor: like executor; a_window: like development_window)
			-- Initialize `Current'.
			--
			-- `a_executor': Executor to be shown.
		require
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			if test_suite.is_service_available then
				test_suite.service.connect_events (Current)
			end
			executor := a_executor
			development_window := a_window
			make_widget
		ensure
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
			executor_set: executor = a_executor
		end

	build_notebook_widget_interface (a_widget: like widget)
			-- <Precursor>
		do
			create grid.make (development_window)
			grid.set_layout (create {ES_EIFFEL_TEST_GRID_LAYOUT_LIGHT})
			grid.connect (executor)
			register_action (grid.item_selected_actions, agent on_selection_change)
			register_action (grid.item_deselected_actions, agent on_selection_change)
			a_widget.extend (grid.widget)
		end

	on_after_initialized
			-- <Precursor>
		do
			adapt_executor_status
		end

feature -- Access

	executor: !EIFFEL_TEST_EXECUTOR_I

	title: !STRING_32
			-- Caption for tab
		do
			create Result.make (25)
			Result.append (local_formatter.translation (t_title))
			Result.append (" (")
			if debug_executor_type.attempt (executor) /= Void then
				Result.append (local_formatter.translation (t_title_debugger))
			else
				Result.append (local_formatter.translation (t_title_background))
			end
			Result.append_character (')')
		end

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			if debug_executor_type.attempt (executor) /= Void then
				Result := stock_pixmaps.debug_run_icon_buffer
			else
				Result := stock_pixmaps.debug_run_icon_buffer
			end
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			if debug_executor_type.attempt (executor) /= Void then
				Result := stock_pixmaps.debug_run_icon
			else
				Result := stock_pixmaps.debug_run_icon
			end
		end

feature {NONE} -- Access: grid

	development_window: EB_DEVELOPMENT_WINDOW
			-- Window in which `Current' is shown

	grid: !ES_TAGABLE_LIST_GRID [!EIFFEL_TEST_I]
			-- Grid displaying list of tests

feature {NONE} -- Access: buttons

	run_button: !SD_TOOL_BAR_BUTTON
			-- Button for relaunching past execution

	stop_button: !SD_TOOL_BAR_BUTTON
			-- Button for stopping test execution

	skip_button: !SD_TOOL_BAR_BUTTON
			-- Button for skipping tests during execution

feature {NONE} -- Status setting

	adapt_executor_status
			-- Adapt widgets according to state of `executor'
		local
			l_run, l_stop, l_skip: BOOLEAN
		do
			if executor.is_interface_usable then
				if executor.is_running then
					if not executor.is_finished then
						l_stop := True
						if not grid.selected_items.is_empty then
							l_skip := True
						end
					end
				elseif executor.is_test_suite_valid then
					if not executor.active_tests.is_empty then
						l_run := True
					end
				end
			end
			if l_run then
				run_button.enable_sensitive
			else
				run_button.disable_sensitive
			end
			if l_stop then
				stop_button.enable_sensitive
			else
				stop_button.disable_sensitive
			end
			if l_skip then
				skip_button.enable_sensitive
			else
				skip_button.disable_sensitive
			end
		end

feature {NONE} -- Events: executor

	on_processor_launched (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = executor then
				adapt_executor_status
			end
		end

	on_processor_finished (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = executor then
				adapt_executor_status
			end
		end

	on_processor_stopped (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = executor then
				adapt_executor_status
			end
		end

feature {NONE} -- Events: widgets

	on_run
			-- Called when `run_button' is selected
		local
			l_test_suite: !EIFFEL_TEST_SUITE_S
			l_list: !DS_ARRAYED_LIST [!EIFFEL_TEST_I]

		do
			if executor.is_interface_usable and test_suite.is_service_available then
				l_test_suite := test_suite.service
				if executor.is_test_suite_valid and l_test_suite.is_interface_usable then
					if not grid.selected_items.is_empty then
						create l_list.make_from_linear (grid.selected_items)
					else
						create l_list.make_from_linear (executor.active_tests)
					end
					if executor.is_ready (l_test_suite) and executor.is_valid_test_list (l_list, l_test_suite) then
						l_test_suite.run_list (executor, l_list, False)
					end
				end
			end
		end

	on_stop
			-- Called when `stop_button' is selected
		do
			if executor.is_interface_usable and then executor.is_running then
				executor.request_stop
			end
		end

	on_skip
			-- Called when `skip_button' is selected
		local
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
		do
			if executor.is_interface_usable and then executor.is_running then
				l_cursor := grid.selected_items.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					if executor.active_tests.has (l_cursor.item) then
						executor.skip_test (l_cursor.item)
					end
					l_cursor.forth
				end
			end
		end

	on_selection_change (a_test: !EIFFEL_TEST_I)
			-- Called when selection in `grid' changes
		do
			adapt_executor_status
		end

feature {NONE} -- Factory

	create_tool_bar_items: !DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			create Result.make (4)

			create run_button.make
			run_button.set_pixel_buffer (stock_pixmaps.debug_run_icon_buffer)
			run_button.set_pixmap (stock_pixmaps.debug_run_icon)
			run_button.set_tooltip (tt_run)
			register_action (run_button.select_actions, agent on_run)
			Result.force_last (run_button)

			create stop_button.make
			stop_button.set_pixel_buffer (stock_pixmaps.debug_stop_icon_buffer)
			stop_button.set_pixmap (stock_pixmaps.debug_stop_icon)
			stop_button.set_tooltip (tt_stop)
			register_action (stop_button.select_actions, agent on_stop)
			Result.force_last (stop_button)

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

			create skip_button.make
			skip_button.set_text (b_skip)
			register_action (skip_button.select_actions, agent on_skip)
			Result.force_last (skip_button)
		end

	create_notebook_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Constants

	t_title: !STRING = "Execution"
	t_title_background: !STRING = "background"
	t_title_debugger: !STRING = "debugger"

	tt_run: STRING = "Relaunch previous execution"
	tt_stop: STRING = "Stop current execution"
	b_skip: STRING = "Skip"

end
