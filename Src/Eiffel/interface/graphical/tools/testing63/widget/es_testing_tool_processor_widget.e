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

feature {NONE} -- Initialization

	make (a_processor: like processor; a_window: like development_window)
			-- Initialize `Current'.
			--
			-- `a_processor': Processor to be shown.
			-- `a_window': Window in which `Current' is shown
		require
			a_window_attached: a_window /= Void
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
			create grid.make (development_window)
			grid.set_layout (create {ES_EIFFEL_TEST_GRID_LAYOUT_LIGHT})
			grid.connect (processor)
			register_action (grid.item_selected_actions, agent on_selection_change)
			register_action (grid.item_deselected_actions, agent on_selection_change)
			a_widget.extend (grid.widget)
		end

feature -- Access

	processor: !EIFFEL_TEST_PROCESSOR_I
			-- Executor being visualized by `Current'

	grid: !ES_TAGABLE_LIST_GRID [!EIFFEL_TEST_I]
			-- Grid displaying list of tests

feature {NONE} -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Window in which `Current' is shown

feature {NONE} -- Events: test suite

	on_processor_launched (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = processor then
				on_processor_changed
			end
		end

	on_processor_finished (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = processor then
				on_processor_changed
			end
		end

	on_processor_stopped (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- <Precursor>
		do
			if a_processor = processor then
				on_processor_changed
			end
		end

feature {NONE} -- Events: widgets

	on_selection_change (a_test: !EIFFEL_TEST_I)
			-- Called when selection in `grid' changes
		deferred
		end

feature {NONE} -- Events: processor

	on_processor_changed
			-- Called when `processor' changes its status
		deferred
		end

end
