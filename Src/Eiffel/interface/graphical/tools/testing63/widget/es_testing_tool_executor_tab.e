indexing
	description: "[
		Widget showing status and control buttons for an {EIFFEL_TEST_EXECUTOR_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_EXECUTOR_TAB

inherit
	ES_WINDOW_WIDGET [EV_VERTICAL_BOX]
		rename
			make_widget as make_es_widget,
			make as make_widget
		end

create
	make

feature {NONE} -- Initialization

	make (a_executor: like executor; a_window: like develop_window)
			-- Initialize `Current'.
			--
			-- `a_executor': Executor to be shown.
		require
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			executor := a_executor
			make_widget (a_window)
		ensure
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
			executor_set: executor = a_executor
		end

	build_widget_interface (a_widget: like widget)
			-- <Precursor>
		do
			create grid.make (develop_window)
			grid.set_layout (create {ES_EIFFEL_TEST_GRID_LAYOUT_LIGHT}.make (test_suite))
			grid.connect (executor)
			a_widget.extend (grid.widget)
		end

feature -- Access

	executor: !EIFFEL_TEST_EXECUTOR_I

	title: !STRING_32
			-- Caption for tab
		do
			create Result.make (25)
			Result.append (local_formatter.translation (t_title))
			Result.append (" (")
			if {l_debugger: EIFFEL_TEST_DEBUGGER_I} executor then
				Result.append (local_formatter.translation (t_title_debugger))
			else
				Result.append (local_formatter.translation (t_title_background))
			end
			Result.append_character (')')
		end

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			if {l_debugger: EIFFEL_TEST_DEBUGGER_I} executor then
				Result := stock_pixmaps.debug_run_icon_buffer
			else
				Result := stock_pixmaps.debug_run_icon_buffer
			end
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			if {l_debugger: EIFFEL_TEST_DEBUGGER_I} executor then
				Result := stock_pixmaps.debug_run_icon
			else
				Result := stock_pixmaps.debug_run_icon
			end
		end

feature {NONE} -- Access: grid

	grid: !ES_TAGABLE_LIST_GRID [EIFFEL_TEST_I]

	frozen test_suite: !SERVICE_CONSUMER [!EIFFEL_TEST_SUITE_S]
			-- Access to a test suite service {EIFFEL_TEST_SUITE_S} consumer
		once
			create Result
		end

feature {NONE} -- Factory

	create_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Constants

	t_title: !STRING = "Execution"
	t_title_background: !STRING = "background"
	t_title_debugger: !STRING = "debugger"

end
