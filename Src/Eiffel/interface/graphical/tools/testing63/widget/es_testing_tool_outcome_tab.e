indexing
	description: "[
		Widget showing detailed information about testing outcomes for a given test.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_OUTCOME_TAB

inherit
	ES_WINDOW_WIDGET [EV_VERTICAL_BOX]

	ES_EIFFEL_TEST_COMMANDER_I

create
	make

feature {NONE} -- Initialization

	build_widget_interface (a_widget: like widget)
			-- <Precursor>
		do
			create grid
			grid.enable_tree
			grid.enable_multiple_row_selection
			grid.hide_tree_node_connectors
			a_widget.extend (grid)
		end

feature -- Access

	test: !EIFFEL_TEST_I
			-- Test being displayed by `Current'
		do
			Result ?= internal_test
		end

	title: !STRING_32
			-- Caption for tab
		do
			Result := local_formatter.translation (t_title)
		end

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.feature_routine_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.feature_routine_icon
		end

feature {NONE} -- Access

	grid: !ES_GRID
			-- Grid for listing test results

	internal_test: ?like test
			-- Internal storage for `test'

feature -- Status report

	is_active: BOOLEAN
			-- <Precursor>
		do
			Result := internal_test /= Void
		end

feature {NONE} -- Status report

	outcome_count: INTEGER
			-- Current number of outcomes shown in grid

feature -- Status setting

	show_test (a_test: !EIFFEL_TEST_I)
			-- <Precursor>
		local
			i: INTEGER
			l_cursor: DS_BILINEAR_CURSOR [!TEST_OUTCOME]
		do
			if is_active and a_test /= test then
				remove_test
			end
			if not is_active then
				internal_test := a_test
				grid.set_column_count_to (2)
				grid.column (1).set_width (250)
				grid.enable_auto_size_best_fit_column (2)
			end
			from
				l_cursor := test.outcomes.new_cursor
				l_cursor.start
				i := 1
			until
				l_cursor.after
			loop
				if i > outcome_count then
					add_outcome (l_cursor.item, l_cursor.is_last)
				end
				l_cursor.forth
				i := i + 1
			end
			outcome_count := i - 1
		end

	remove_test
			-- <Precursor>
		do
			outcome_count := 0
			internal_test := Void
			grid.wipe_out
		end

feature {NONE} -- Implementation

	add_outcome (a_outcome: !TEST_OUTCOME; a_expanded: BOOLEAN) is
			-- Add outcome to grid
			--
			-- `a_outcome': Outcome for which information should be added.
			-- `a_expanded': If True, grid rows will be shown expanded.
		local
			l_label: EV_GRID_LABEL_ITEM
			l_row: EV_GRID_ROW
			l_pos: INTEGER
		do
			l_pos := 1
			grid.insert_new_row (l_pos)
			create l_label.make_with_text (a_outcome.date.out)
			if a_outcome.is_pass then
				l_label.set_pixmap (stock_pixmaps.general_tick_icon)
			elseif a_outcome.is_fail then
				l_label.set_pixmap (stock_pixmaps.general_error_icon)
			else
				--l_label.set_pixmap (stock_pixmaps.general_error_icon)
			end
			l_row := grid.row (l_pos)
			l_row.set_item (1, l_label)

			if a_outcome.has_response then
				add_invocation (l_row, a_outcome.setup_response, "set up", a_expanded)
				if a_outcome.is_setup_clean then
					add_invocation (l_row, a_outcome.test_response, "test", a_expanded)
					add_invocation (l_row, a_outcome.teardown_response, "tear down", a_expanded)
				end
			else
				l_label.set_text ("no response")
			end
			if a_expanded and l_row.is_expandable then
				l_row.expand
			end
		end

	add_invocation (a_parent: EV_GRID_ROW; a_invocation: TEST_INVOCATION_RESPONSE; a_name: !STRING; a_expanded: BOOLEAN) is
			-- Add invocation information to grid
			--
			-- `a_parent': Parent row for new rows.
			-- `a_invocation': Invocation response for which information should be shown.
			-- `a_name': Name for invocation
			-- `a_expanded': If True, grid rows will be shown expanded.
		local
			l_pos: INTEGER
			l_label: EV_GRID_LABEL_ITEM
			l_text: STRING
			l_row: EV_GRID_ROW
		do
			l_pos := a_parent.index + a_parent.subrow_count_recursive + 1
			grid.insert_new_row_parented (l_pos, a_parent)
			create l_label
			l_row := grid.row (l_pos)
			l_row.set_item (1, l_label)
			create l_text.make (30)
			l_text.append (a_name)
			l_text.append (": ")
			if a_invocation.is_exceptional then
				l_text.append ("exceptional")
				add_exception_details (l_row, a_invocation.exception)
				add_text (l_row, "trace", a_invocation.exception.trace)
				if a_expanded and l_row.is_expandable then
					l_row.expand
				end
			else
				l_text.append ("normal")
			end
			l_label.set_text (l_text)
			if not a_invocation.output.is_empty then
				add_text (l_row, "output", a_invocation.output)
			end
		end

	add_text (a_parent: EV_GRID_ROW; a_name, a_text: !STRING)
			-- Add plain text to grid
			--
			-- `a_parent': Parent row for all new rows.
			-- `a_name': Name describing text.
			-- `a_text': Actual text to be added.
		local
			l_pos: INTEGER
			l_label: EV_GRID_LABEL_ITEM
			l_row: EV_GRID_ROW
		do
			l_pos := a_parent.index + a_parent.subrow_count_recursive + 1
			grid.insert_new_row_parented (l_pos, a_parent)
			l_row := grid.row (l_pos)
			create l_label.make_with_text (a_name)
			l_row.set_item (1, l_label)
			create l_label.make_with_text ("(double click to see)")
			l_label.pointer_double_press_actions.extend (agent show_text (a_text, ?, ?, ?, ?, ?, ?, ?, ?))
			l_row.set_item (2, l_label)
		end

	add_exception_details (a_parent: EV_GRID_ROW; a_exception: TEST_INVOCATION_EXCEPTION) is
			-- Add rows with exception details
			--
			-- `a_parent': Parent row for all new rows.
			-- `a_exception': Exception containing details to be added.
		local
			l_pos: INTEGER
			l_label: EV_GRID_LABEL_ITEM
		do
			l_pos := a_parent.index + 1
			grid.insert_new_rows_parented (3, l_pos, a_parent)
				-- Code
			create l_label.make_with_text ("code")
			grid.row (l_pos).set_item (1, l_label)
			create l_label.make_with_text (a_exception.code.out)
			grid.row (l_pos).set_item (2, l_label)
				-- Class
			create l_label.make_with_text ("recipient")
			grid.row (l_pos + 1).set_item (1, l_label)
			create l_label.make_with_text (a_exception.class_name + a_exception.recipient_name)
			grid.row (l_pos + 1).set_item (2, l_label)
				-- tag
			create l_label.make_with_text ("tag")
			grid.row (l_pos + 2).set_item (1, l_label)
			create l_label.make_with_text (a_exception.tag_name)
			grid.row (l_pos + 2).set_item (2, l_label)
		end

	show_text (a_text: !STRING; i1, i2, i3: INTEGER; r1, r2, r3: REAL_64; i4, i5: INTEGER)
			-- Display text in a separate window.
		local
			l_dialog: ES_INFORMATION_PROMPT
		do
			create l_dialog.make_standard (a_text)
			l_dialog.show (develop_window.window)
		end

feature {NONE} -- Factory

	create_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
			Result.set_data (Current)
		ensure then
			data_set: Result.data = Current
		end

feature {NONE} -- Constants

	t_title: !STRING = "Outcomes"

end
