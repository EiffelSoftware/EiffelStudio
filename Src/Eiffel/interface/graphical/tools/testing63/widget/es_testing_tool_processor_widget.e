indexing
	description: "[
		Widget displaying tests of any {EIFFEL_TEST_PROCESSOR_I} in a grid, also providing basic test
		    suite eventing for its implementors.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TESTING_TOOL_PROCESSOR_WIDGET

inherit
	ES_NOTEBOOK_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_widget
		redefine
			on_after_initialized,
			create_right_tool_bar_items,
			internal_recycle
		end

	EIFFEL_TEST_SUITE_OBSERVER
		rename
			on_processor_launched as on_processor_launched_frozen,
			on_processor_finished as on_processor_finished_frozen,
			on_processor_stopped as on_processor_stopped_frozen,
			on_processor_proceeded as on_processor_proceeded_frozen
		redefine
			on_processor_launched_frozen,
			on_processor_finished_frozen,
			on_processor_stopped_frozen,
			on_processor_proceeded_frozen
		end

	ES_SHARED_EIFFEL_TEST_SERVICE
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_processor: like processor; a_window: like development_window)
			-- Initialize `Current'.
			--
			-- `a_processor': Processor to be shown.
			-- `a_window': Window in which `Current' is shown
		require
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			if test_suite.is_service_available then
				test_suite.service.connect_events (Current)
			end
			processor := a_processor
			development_window := a_window
			make_widget
		ensure
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
			processor_set: processor = a_processor
		end

	build_notebook_widget_interface (a_widget: like widget)
			-- <Precursor>
		do
			build_progress_bar (a_widget)
			build_grid (a_widget)
		end

	build_progress_bar (a_widget: like widget)
			-- Create `progress_bar' widget.
		local
			l_toolbar: SD_WIDGET_TOOL_BAR
			l_box: EV_HORIZONTAL_BOX
		do

			create progress_widget

			create l_box
			l_box.set_border_width ({ES_UI_CONSTANTS}.horizontal_padding)
			create progress_bar
			l_box.extend (progress_bar)
			progress_widget.extend (l_box)

			create l_toolbar.make (create {SD_TOOL_BAR}.make)
			create_progress_bar_items.do_all (agent l_toolbar.extend)
			l_toolbar.compute_minimum_size
			progress_widget.extend (l_toolbar)
			progress_widget.disable_item_expand (l_toolbar)

			a_widget.extend (progress_widget)
			a_widget.disable_item_expand (progress_widget)
		end

	build_grid (a_widget: like widget)
			-- Create `grid'.
		do
			create grid.make (development_window)
			grid.set_layout (create {ES_EIFFEL_TEST_LIST_GRID_LAYOUT})
			grid.connect (processor)
			a_widget.extend (grid.widget)
		end

	on_after_initialized
			-- <Precursor>
		do
			if not processor.is_running then
				progress_widget.hide
			end
			on_processor_changed_frozen
		end

feature -- Access

	processor: !EIFFEL_TEST_PROCESSOR_I
			-- Executor being visualized by `Current'

	grid: !ES_TAGABLE_LIST_GRID [!EIFFEL_TEST_I]
			-- Grid displaying list of tests

	title: !STRING_32
			-- Caption for tab
		deferred
		end

	icon: !EV_PIXEL_BUFFER
			-- Pixel buffer for widget
		deferred
		end

	icon_pixmap: !EV_PIXMAP
			-- Icon for widget
		deferred
		end

feature -- Access: widgets

	close_button: !SD_TOOL_BAR_BUTTON
			-- Button for closing/removing `Current' from widget

feature {NONE} -- Access

	development_window: !EB_DEVELOPMENT_WINDOW
			-- Window in which `Current' is shown

	stop_button: !SD_TOOL_BAR_BUTTON
			-- Button for stopping test execution

	progress_bar: !EV_HORIZONTAL_PROGRESS_BAR
			-- Bar showing `processor' progress

	progress_widget: !EV_HORIZONTAL_BOX
			-- Widget containing `progress_bar'

feature {NONE} -- Events: test suite

	frozen on_processor_launched_frozen (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = processor then
				on_processor_launched
				on_processor_changed_frozen
			end
		end

	frozen on_processor_finished_frozen (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = processor then
				on_processor_finished
				on_processor_changed_frozen
			end
		end

	frozen on_processor_stopped_frozen (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = processor then
				on_processor_stopped
				on_processor_changed_frozen
			end
		end

	frozen on_processor_proceeded_frozen (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = processor then
				on_processor_proceeded
				on_processor_changed_frozen
			end
		end

feature {NONE} -- Events: widgets

	on_stop
			-- Called when `stop_button' is selected
		do
			if processor.is_interface_usable and then processor.is_running then
				processor.request_stop
			end
		end

feature {NONE} -- Events: processor

	frozen on_processor_changed_frozen
			-- Called when `processor' changes its status or after widgets of `Current' have just been initialized.
		do
			on_processor_changed
			if processor.is_interface_usable and then
			   processor.is_running and then
			   not processor.is_finished
			then
				stop_button.enable_sensitive
				progress_bar.set_proportion (processor.progress)
			else
				stop_button.disable_sensitive
			end
		end

	on_processor_changed
			-- Called when `processor' changes its status or after widgets of `Current' have just been initialized.
		do
		end

	on_processor_launched
			-- Called when `processor' is launched.
		do
			progress_widget.show
		end

	on_processor_proceeded
			-- Called when `processor' proceeds.
		do
		end

	on_processor_finished
			-- Called when `processor' is finished.
		do
		end

	on_processor_stopped
			-- Called when `processor' is stopped.
		do
			progress_widget.hide
		end

feature {NONE} -- Implementation

	internal_recycle
			-- <Precursor>
		do
			Precursor
			if test_suite.is_service_available then
				test_suite.service.disconnect_events (Current)
			end
		end

feature {NONE} -- Factory

	create_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do

		end

	create_right_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			create Result.make (1)

			create close_button.make
			close_button.set_text (local_formatter.translation (b_close))
			close_button.set_tooltip (local_formatter.translation (tt_close))

			Result.force_last (close_button)
		end

	create_progress_bar_items: !DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Create items shown to the right of `progress_bar'
		do
			create Result.make (1)

			create stop_button.make
			stop_button.set_pixel_buffer (stock_pixmaps.debug_stop_icon_buffer)
			stop_button.set_pixmap (stock_pixmaps.debug_stop_icon)
			stop_button.set_tooltip (tt_stop)
			register_action (stop_button.select_actions, agent on_stop)
			Result.force_last (stop_button)
		end

	create_notebook_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Constants

	b_close: !STRING = "Close"

	tt_stop: !STRING = "Stop current execution"
	tt_close: !STRING = "Close tab"

end
