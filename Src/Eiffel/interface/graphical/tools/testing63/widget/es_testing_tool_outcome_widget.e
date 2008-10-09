indexing
	description: "[
		Widget showing detailed information about testing outcomes for a given test.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_OUTCOME_WIDGET

inherit
	ES_NOTEBOOK_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_widget
		end

	ES_SHARED_EIFFEL_TEST_SERVICE
		export
			{NONE} all
		end

	ES_EIFFEL_TEST_COMMANDER_I

	EXCEPTION_CODE_MEANING

create
	make

feature {NONE} -- Initialization

	make (a_window: like development_window)
			-- Initialize `Current'.
		require
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			development_window := a_window
			make_widget
		end

	build_notebook_widget_interface (a_widget: like widget)
			-- <Precursor>
		local
			l_support: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			create grid
			grid.enable_tree

			grid.enable_multiple_row_selection
			grid.hide_tree_node_connectors
			grid.set_column_count_to (2)
			grid.column (1).set_width (250)
			grid.enable_last_column_use_all_width

				-- pick and drop support
			create l_support.make_with_grid (grid)
			l_support.synchronize_color_or_font_change_with_editor
			l_support.enable_grid_item_pnd_support
			l_support.enable_ctrl_right_click_to_open_new_window
			l_support.set_context_menu_factory_function (agent (development_window.menus).context_menu_factory)

			a_widget.set_border_width (1)
			a_widget.set_background_color ((create {EV_STOCK_COLORS}).gray)
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

	development_window: EB_DEVELOPMENT_WINDOW
			-- Window in which `Current' is shown

	grid: !ES_GRID
			-- Grid for listing test results

	internal_test: ?like test
			-- Internal storage for `test'

	token_writer: EB_EDITOR_TOKEN_GENERATOR
			-- Token writer used to create clickable items
		once
			create Result.make
		end

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
			l_cursor: DS_BILINEAR_CURSOR [!EQA_TEST_OUTCOME]
		do
			if is_active and a_test /= test then
				remove_test
			end
			internal_test := a_test
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
			grid.remove_and_clear_all_rows
		end

feature {NONE} -- Implementation

	add_outcome (a_outcome: !EQA_TEST_OUTCOME; a_expanded: BOOLEAN) is
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
				l_label.set_pixmap (stock_pixmaps.general_warning_icon)
			end
			l_row := grid.row (l_pos)
			l_row.set_item (1, l_label)

			if a_outcome.has_response then
				add_invocation (l_row, a_outcome.setup_response, "setup", a_expanded)
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

	add_invocation (a_parent: EV_GRID_ROW; a_invocation: EQA_TEST_INVOCATION_RESPONSE; a_name: !STRING; a_expanded: BOOLEAN) is
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
			else
				l_text.append ("normal")
			end
			l_label.set_text (l_text)
			if not a_invocation.output.is_empty then
				add_text (l_row, "output", a_invocation.output)
			end
			if a_expanded and l_row.is_expandable then
				l_row.expand
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
			l_font: EV_FONT
		do
			l_pos := a_parent.index + a_parent.subrow_count_recursive + 1
			grid.insert_new_row_parented (l_pos, a_parent)
			l_row := grid.row (l_pos)
			create l_label.make_with_text (a_name)
			l_label.pointer_double_press_actions.extend (agent show_text (a_text, ?, ?, ?, ?, ?, ?, ?, ?))
			l_row.set_item (1, l_label)
			create l_label
			create l_font
			l_font.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
			l_label.set_font (l_font)
			l_label.set_text ("double click to view")
			l_label.pointer_double_press_actions.extend (agent show_text (a_text, ?, ?, ?, ?, ?, ?, ?, ?))
			l_row.set_item (2, l_label)
		end

	add_exception_details (a_parent: EV_GRID_ROW; a_exception: !EQA_TEST_INVOCATION_EXCEPTION) is
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
			grid.row (l_pos).set_item (2, code_item (a_exception.code))
				-- Class
			create l_label.make_with_text ("recipient")
			grid.row (l_pos + 1).set_item (1, l_label)
			grid.row (l_pos + 1).set_item (2, recipient_item (a_exception))
				-- tag
			create l_label.make_with_text ("tag")
			grid.row (l_pos + 2).set_item (1, l_label)
			create l_label.make_with_text (a_exception.tag_name)
			grid.row (l_pos + 2).set_item (2, l_label)
		end

	show_text (a_text: !STRING; i1, i2, i3: INTEGER; r1, r2, r3: REAL_64; i4, i5: INTEGER) is
			-- Display text in a separate window.
		local
			l_dialog: ES_BASIC_EDITOR_DIALOG
		do
			create l_dialog.make (stock_pixmaps.tool_output_icon_buffer, "Testing output")
			l_dialog.is_modal := False
			l_dialog.set_text ({!STRING_32} #? a_text.to_string_32)
			l_dialog.show (development_window.window)
		end

feature {NONE} -- Factory

	code_item (a_code: INTEGER): !EV_GRID_ITEM
			-- Item containing exception code and corresonding name
		local
			l_label: EV_GRID_LABEL_ITEM
			l_text: STRING
		do
			create l_text.make (25)
			l_text.append_integer (a_code)
			l_text.append (" (")
			l_text.append (description_from_code (a_code))
			l_text.append_character (')')
			create l_label.make_with_text (l_text)
			Result := l_label
		end

	recipient_item (a_exception: !EQA_TEST_INVOCATION_EXCEPTION): !EV_GRID_ITEM
			-- Item containing a clickable exception recipient if available
			--
			-- `a_exception': Exception containing recipient.
		local
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
			l_system: SYSTEM_I
			l_universe: UNIVERSE_I
			l_cluster: CONF_GROUP
			l_class: CLASS_I
			l_cclass: CLASS_C
			l_feat: E_FEATURE
		do
			if test_suite.is_service_available and then test_suite.service.is_project_initialized then
				l_universe := test_suite.service.eiffel_project.universe
				l_system := test_suite.service.eiffel_project.system.system
				if not l_system.root_creators.is_empty then
					l_cluster := l_system.root_creators.first.cluster
					l_universe := l_system.universe
					l_class := l_universe.safe_class_named (a_exception.class_name, l_cluster)
					if l_class /= Void then
						if l_class.is_compiled then
							l_cclass := l_class.compiled_class
							l_feat := l_cclass.feature_with_name (a_exception.recipient_name)
						end
					end
				end
			end
			token_writer.new_line
			token_writer.add_char ('{')
			if l_class /= Void then
				token_writer.add_class (l_class)
			else
				token_writer.add_string (a_exception.class_name)
			end
			token_writer.add_char ('}')
			token_writer.add_char ('.')
			if l_feat /= Void then
				token_writer.add_feature (l_feat, l_feat.name)
			else
				token_writer.add_string (a_exception.recipient_name)
			end
			create l_eitem
			l_eitem.set_text_with_tokens (token_writer.last_line.content)
			Result := l_eitem
		end

	create_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
		end

	create_notebook_widget: !EV_VERTICAL_BOX
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
