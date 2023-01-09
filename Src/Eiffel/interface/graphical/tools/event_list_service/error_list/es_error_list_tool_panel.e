note
	description: "[
		An event list service {EVENT_LIST_S} tool to show all errors and warning event items in a single list in the EiffelStudio UI
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ERROR_LIST_TOOL_PANEL

inherit
	ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE
		redefine
			build_tool_interface,
			create_clickable_tooltip,
			create_mini_tool_bar_items,
			create_right_tool_bar_items,
			internal_recycle,
			is_appliable_event,
			is_event_list_synchronized_on_initialized,
			on_after_initialized,
			on_before_initialize,
			on_event_item_added,
			on_event_item_clean_up,
			on_event_item_removed,
			on_handle_key,
			on_unlocked,
			show,
			show_context_menu,
			update_content_applicable_widgets
		end

	ES_ERROR_LIST_COMMANDER_I
		export
			{ES_ERROR_LIST_COMMANDER_I} all
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_SHARED_OUTPUTS
		export
			{NONE} all
		end

	SESSION_EVENT_OBSERVER
		export
			{NONE} all
		redefine
			on_session_value_changed
		end

	CODE_ANALYZER_OBSERVER [STONE, CA_RULE_VIOLATION]
		export
			{NONE} all
		redefine
			on_put
		end

	SHARED_ERROR_TRACER
		export
			{NONE} all
		end

	CA_SHARED_NAMES
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization: User interface

	 build_tool_interface (a_widget: ES_GRID)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		local
			l_col: EV_GRID_COLUMN
		do
			Precursor (a_widget)
			a_widget.set_column_count_to (last_column)

				-- Create columns
			l_col := a_widget.column (category_column)
			l_col.set_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (40))

			l_col := a_widget.column (rule_column)
			l_col.set_title (interface_names.l_rule_code)
			l_col.set_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (50))

			l_col := a_widget.column (description_column)
			l_col.set_title (interface_names.l_description)
			l_col.set_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (100))

			l_col := a_widget.column (context_column)
			l_col.set_title (interface_names.l_location)
			l_col.set_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (200))

			l_col := a_widget.column (position_column)
			l_col.set_title (interface_names.l_position)
			l_col.set_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (80))

			l_col := a_widget.column (severity_column)
			l_col.set_title (interface_names.l_severity)
			l_col.set_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (50))
			l_col.hide

			a_widget.enable_tree
			a_widget.hide_tree_node_connectors
			a_widget.disable_row_height_fixed
			a_widget.enable_auto_size_best_fit_column (description_column)
			a_widget.enable_multiple_row_selection
			register_action (a_widget.row_deselect_actions, agent (a_row: EV_GRID_ROW)
				do
						-- Updates UI based on selection and row count.
					update_content_applicable_widgets (grid_events.row_count > 0)
				end)
			register_action (a_widget.row_select_actions, agent (a_row: EV_GRID_ROW)
				do
						-- Updates UI based on selection and row count.
					update_content_applicable_widgets (grid_events.row_count > 0)
				end)

				-- Enable sorting.
			enable_sorting_on_columns (<<
				a_widget.column (category_column),
				a_widget.column (severity_column),
				a_widget.column (rule_column),
				a_widget.column (description_column),
				a_widget.column (context_column),
				a_widget.column (position_column)>>)

				-- Support correct sorting on position.
			grid_wrapper.column_sort_info [position_column].set_comparator
				(agent (r1, r2: EV_GRID_ROW; o: like {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order): BOOLEAN
					local
						l1, l2: INTEGER
						c1, c2: INTEGER
					do
						if attached {EVENT_LIST_ITEM_I} r1.data as i then
							if attached {ERROR} i.data as e then
								l1 := e.line
								c1 := e.column
							elseif
								attached {CA_RULE_VIOLATION_EVENT} i as v and then
								attached v.location as l
							then
								l1 := l.line
								c1 := l.position
							end
						end
						if attached {EVENT_LIST_ITEM_I} r2.data as i then
							if attached {ERROR} i.data as e then
								l2 := e.line
								c2 := e.column
							elseif
								attached {CA_RULE_VIOLATION_EVENT} i as v and then
								attached v.location as l
							then
								l2 := l.line
								c2 := l.position
							end
						end
						Result :=
							(l1 < l2 or else l1 = l2 and then c1 < c2) =
							(o = {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order)
					end)
		end

	on_before_initialize
			-- <Precursor>
		do
			Precursor

				-- Connect the observer to the code analyzer service.
			if attached code_analyzer.service as s then
				s.code_analyzer_connection.connect_events (Current)
			end

				-- We want the tool to synchronize with the event list, when first initialized.
			is_event_list_synchronized_on_initialized := True

			create syntax_errors.make_default
			syntax_errors.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [EVENT_LIST_ERROR_ITEM_I]}.make (
				agent (ia_item: EVENT_LIST_ERROR_ITEM_I; ia_other: EVENT_LIST_ERROR_ITEM_I): BOOLEAN
						-- Equality tester to ensure two like syntax errors are considered the same.
					do
						Result := ia_item ~ ia_other or else (
								ia_item /= Void and then
								ia_other /= Void and then
								attached {SYNTAX_ERROR} ia_item.data as l_item_error and then
								attached {SYNTAX_ERROR} ia_other.data as l_other_error and then
								l_item_error.line = l_other_error.line and then
								l_item_error.column = l_other_error.column and then
								l_item_error.file_name ~ l_other_error.file_name)
					end))

				-- Register observer on preference 'expand_n_errors'.			
			preferences.error_list_tool_data.expand_n_errors_preferences.change_actions.extend (agent on_preference_expand_n_errors)
		end

	on_after_initialized
			-- <Precursor>
		local
			p: like on_editor_preference_change_agent
		do

				-- Enable copying to clipboard.
			enable_copy_to_clipboard

				-- Bind redirecting pick and drop actions.
			stone_director.bind (grid_events, Current)

				-- Configure expand errors based con preferece
				-- 'tools.error_list.expand_n_errors'.
			on_preference_expand_n_errors

				-- Set UI based on initial state.
			update_content_applicable_navigation_buttons

				-- Set message counters to their defaults.
			update_message_counters

			Precursor

			p := agent on_editor_preference_change
			on_editor_preference_change_agent := p
			preferences.editor_data.post_update_actions.extend (p)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if
				is_initialized and then
				attached session_manager.service and then
				session_data.session_connection.is_connected (Current)
			then
				session_data.session_connection.disconnect_events (Current)
			end
			if
				attached code_analyzer.service as s and then
				s.code_analyzer_connection.is_connected (Current)
			then
				s.code_analyzer_connection.disconnect_events (Current)
			end
			if attached on_editor_preference_change_agent as p then
				preferences.editor_data.post_update_actions.prune_all (p)
			end
			Precursor
		end

feature {NONE} -- Access

	error_count: NATURAL
			-- Number of errors.

	warning_count: NATURAL
			-- Number of warnings.

	hint_count: NATURAL
			-- Number of hints.

	syntax_errors: DS_ARRAYED_LIST [EVENT_LIST_ERROR_ITEM_I]
			-- List of managed syntax errors, used to perform error adoption.
			-- Note: Adoption takes place when a compiler reports an error and then the editor it opened.

	last_tooltip_item: detachable EV_GRID_ITEM
			-- Last item that brings up tooltip

	expand_n_errors: BOOLEAN
			-- 	Expand the first N errors.
			--| with N=1.

	show_n_errors: INTEGER
			-- First N errors to expand.

feature {NONE} -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "62F36EFA-1D3A-9E48-3A6A-7DA40B7E2046"
		end

feature {NONE} -- Access: User interface

	error_button: detachable SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide error events.

	warning_button: detachable SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide warning events.

	hint_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide hint events.

	expand_errors_button: detachable SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to expanded error events automatically

	delete_button: detachable SD_TOOL_BAR_BUTTON
			-- Delete selected items button

	error_info_button: detachable SD_TOOL_BAR_BUTTON
			-- Error information button

	filter_button: detachable SD_TOOL_BAR_POPUP_BUTTON
			-- Filter button to filter information in list

	filter_widget: detachable ES_WARNINGS_FILTER_WIDGET
			-- Filter widget

	text_filter: EV_TEXT_FIELD
			-- Text field to enter filter

feature {NONE} -- Element change

	set_error_count (a_count: like error_count)
			-- Sets `error_count' to `a_count'.
		do
			error_count := a_count
		ensure
			error_count_set: error_count = a_count
		end

	set_warning_count (a_count: like warning_count)
			-- Sets `warning_count' to `a_count'.
		do
			warning_count := a_count
		ensure
			warning_count_set: warning_count = a_count
		end

	set_hint_count (c: like hint_count)
			-- Sets `hint_count' to `c'.
		do
			hint_count := c
		ensure
			hint_count_set: hint_count = c
		end

feature {NONE} -- Status report

	is_error_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to an error?
		do
			if a_event_item.type = {EVENT_LIST_ITEM_TYPES}.error then
				Result :=
					attached {EVENT_LIST_ERROR_ITEM_I} a_event_item as e and then not e.is_warning or else
					attached {CA_RULE_VIOLATION_EVENT} a_event_item as e and then e.is_error_event or else
					attached {CA_EXCEPTION_EVENT} a_event_item
			end
		ensure
			not_is_other_event: Result implies not
				(is_warning_event (a_event_item) or
				is_hint_event (a_event_item) or
				is_ok_event (a_event_item))
		end

	is_warning_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to a warning?
		require
			a_event_item_attached: a_event_item /= Void
		do
			if a_event_item.type = {EVENT_LIST_ITEM_TYPES}.error then
				Result :=
					attached {EVENT_LIST_ERROR_ITEM_I} a_event_item as e and then e.is_warning or else
					attached {CA_RULE_VIOLATION_EVENT} a_event_item as e and then e.is_warning_event
			end
		ensure
			not_is_other_event: Result implies not
				(is_error_event (a_event_item) or
				is_hint_event (a_event_item) or
				is_ok_event (a_event_item))
		end

	is_hint_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to a hint?
		do
			if a_event_item.type = {EVENT_LIST_ITEM_TYPES}.error then
				Result := attached {CA_RULE_VIOLATION_EVENT} a_event_item as e and then e.is_hint_event
			end
		ensure
			not_is_other_event: Result implies not
				(is_error_event (a_event_item) or
				is_warning_event (a_event_item) or
				is_ok_event (a_event_item))
		end

	is_ok_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to a "no issue" event?
		do
			Result := attached {CA_NO_ISSUES_EVENT} a_event_item
		ensure
			not_is_other_event: Result implies not
				(is_error_event (a_event_item) or
				is_warning_event (a_event_item) or
				is_hint_event (a_event_item))
		end

	is_appliable_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- <Precursor>
		do
			Result :=
				is_error_event (a_event_item) or
				is_warning_event (a_event_item) or
				is_hint_event (a_event_item) or
				is_ok_event (a_event_item)
		ensure then
			definition: Result implies
				(is_error_event (a_event_item) or
				is_warning_event (a_event_item) or
				is_hint_event (a_event_item) or
				is_ok_event (a_event_item))
		end

	is_displaying_error: BOOLEAN
			-- Indicates if error messages should be shown.
		do
			Result := not is_initialized or else error_button.is_selected
		end

	is_displaying_warning: BOOLEAN
			-- Indicates if warning messages should be shown.
		do
			Result := not is_initialized or else warning_button.is_selected
		end

	is_displaying_hint: BOOLEAN
			-- Indicates if hint messages should be shown.
		do
			Result := not is_initialized or else hint_button.is_selected
		end

	is_row_visible (s: READABLE_STRING_32; r: EV_GRID_ROW): BOOLEAN
			-- Is row `r` visible with text filter `s`?
		require
			s_is_lower: s.same_string (s.as_lower)
		do
			Result := True
			if attached {EVENT_LIST_ITEM_I} r.data as e then
					-- Test if the corresponding event type is shown.
				if is_error_event (e) then
					Result := is_displaying_error
				elseif is_warning_event (e) then
					Result := is_displaying_warning
				elseif is_hint_event (e) then
					Result := is_displaying_hint
				end
				if Result then
						-- Test if the event matches text filter.
					Result :=
						s.is_empty or else
						has_text (s, r, rule_column) or else
						has_text (s, r, description_column) or else
						has_text (s, r, context_column)
				end
			end
		end

	has_text (s: READABLE_STRING_32; r: EV_GRID_ROW; c: like category_column): BOOLEAN
			-- Does item in column `c` of row `r` have a text `s`?
		require
			s_is_lower: s.same_string (s.as_lower)
		do
			if attached r.item (c) as i then
				Result :=
					attached i.tooltip as t and then t.as_lower.has_substring (s) or else
					attached {EV_GRID_LABEL_ITEM} i as l and then attached l.text as t and then t.as_lower.has_substring (s) or else
					attached {EB_GRID_EDITOR_TOKEN_ITEM} i as e and then attached e.text as t and then t.as_lower.has_substring (s)
			else
				Result := True
			end
		end

	is_expanding_errors: BOOLEAN
			-- Indicates if errors should be shown automatically.

	is_expanding_all_errors: BOOLEAN
			-- Indicates if the errors are being expanded, as a result of the expand errors button being pressed

	is_event_list_synchronized_on_initialized: BOOLEAN
			-- <Precursor>

feature {NONE} -- Command items

	go_to_next_error_command: ES_NEXT_ERROR_COMMAND
			-- Go to next error command.
		do
			Result := develop_window.commands.go_to_next_error_command
		ensure
			result_attached: Result /= Void
		end

	go_to_previous_error_command: ES_PREVIOUS_ERROR_COMMAND
			-- Go to previous error command.
		do
			Result := develop_window.commands.go_to_previous_error_command
		ensure
			result_attached: Result /= Void
		end

	go_to_next_warning_command: ES_NEXT_WARNING_COMMAND
			-- Go to next warning command.
		do
			Result := develop_window.commands.go_to_next_warning_command
		ensure
			result_attached: Result /= Void
		end

	go_to_previous_warning_command: ES_PREVIOUS_WARNING_COMMAND
			-- Go to previous warning command
		do
			Result := develop_window.commands.go_to_previous_warning_command
		ensure
			result_attached: Result /= Void
		end

	apply_fix_command: ES_FIX_COMMAND
			-- "Apply fix" command.
		do
			Result := develop_window.commands.apply_fix_command
		ensure
			result_attached: Result /= Void
		end

	error_info_command: EB_ERROR_INFORMATION_CMD
			-- Error information command.

feature {NONE} -- Query

	event_context_stone (a_event_item: EVENT_LIST_ITEM_I): STONE
			-- Retrieve an event item's context stone, if one is available
			--
			-- `a_event_item': An event item to retrieve a strone from.
			-- `Result': A context stone, if any.
		require
			a_event_item_attached: a_event_item /= Void
			is_appliable_event: is_appliable_event (a_event_item)
		local
			l_row: EV_GRID_ROW
		do
			l_row := find_event_row (a_event_item)
			if l_row /= Void then
				Result := event_context_stone_from_row (l_row)
			end
		end

	event_context_stone_from_row (a_row: EV_GRID_ROW): STONE
			-- Retrieve an event item's context stone, if one is available
			--
			-- `EV_GRID_ROW': A row to retrieve an event context from.
			-- `Result': A context stone, if any.
		require
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_data_set: attached {EVENT_LIST_ITEM_I} a_row.data
		local
			l_line: INTEGER
		do
			if
				attached {EVENT_LIST_ITEM_I} a_row.data as l_event_item and then
				attached {STONE} a_row.item (context_column).data as s
			then
				Result := s
				if attached {ERROR} l_event_item.data as l_error then
					l_line := l_error.line
					if l_line > 0 then
						if attached {FEATURE_ERROR} l_error as feature_error and then attached feature_error.written_class as w then
							create {COMPILED_LINE_STONE} Result.make_with_line (w, l_line, True)
						elseif attached {CLASSC_STONE} Result as l_classc_stone then
							create {COMPILED_LINE_STONE} Result.make_with_line (l_classc_stone.e_class, l_line, True)
						elseif attached {CLASSI_STONE} Result as l_classi_stone then
							create {UNCOMPILED_LINE_STONE} Result.make_with_line (l_classi_stone.class_i, l_line, True)
						end
						if attached {LINE_STONE} Result as l_line_stone then
							l_line_stone.set_should_line_be_selected (True)
							if l_error.column > 0 then
								l_line_stone.set_column_number (l_error.column)
							end
						end
					end
				end
			elseif attached {CA_EXCEPTION_EVENT} a_row.parent_row_root.data as l_exception then
				raise_default_exception_dialog (create {EV_DIALOG}, l_exception.data.ex)
			elseif attached {CA_RULE_VIOLATION_EVENT} a_row.parent_row_root.data as l_event_item then
				if attached l_event_item.location as l_loc then
					create {COMPILED_LINE_STONE} Result.make_with_line_and_column (l_event_item.affected_class, l_loc.line, l_loc.column)
				else
					create {CLASSC_STONE} Result.make (l_event_item.affected_class)
				end
			end
		end

	should_tooltip_be_displayed: BOOLEAN
			-- Check preference to see if tooltip should be displayed?
		do
			Result := (create {EB_SHARED_PREFERENCES}).preferences.error_list_tool_data.show_tooltip
		end

feature {ES_TOOL} -- Basic operation

	show
			-- <Precursor>
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE}

				-- This is hack for bug#13604.
			if
				{PLATFORM}.is_unix and then
				attached grid_events as l_grid and then
				not l_grid.is_destroyed
			then
				l_grid.width.do_nothing
			end
		end

feature {NONE} -- Basic operations

	do_default_action (a_row: EV_GRID_ROW)
			-- <Precursor>
		local
			s: STONE
		do
			if attached {EVENT_LIST_ITEM_I} a_row.data as l_event_item then
				if attached {C_COMPILER_ERROR} l_event_item.data as l_error then
					if attached l_error.associated_feature as l_feature then
							-- Open the corresponding feature.
						create {FEATURE_STONE} s.make (l_feature)
					elseif attached c_compiler_output as l_output then
							-- Show the C/C++ compiler output
						l_output.activate (True)
						if attached develop_window.shell_tools.tool ({ES_OUTPUTS_TOOL}) as l_tool then
							l_tool.show (True)
						end
					end
				else
					s := event_context_stone_from_row (a_row)
				end
			end
			if attached s and then s.is_valid then
				(create {EB_CONTROL_PICK_HANDLER}).launch_stone (s)
			end
		end

	show_context_menu (a_item: EV_GRID_ITEM; a_x: INTEGER; a_y: INTEGER)
			-- <Precursor>
		local
			l_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
			s: ARRAYED_LIST [EV_GRID_ROW]
			fix_count: INTEGER
			fix_action: ES_FIX
		do
			if attached {EVENT_LIST_ITEM_I} a_item.row.data as l_item then
				create l_menu

				s := grid_events.selected_rows
				across
					s as r
				loop
					if
						attached {EVENT_LIST_ITEM_I} r.item.data and then
						attached {EB_GRID_EDITOR_TOKEN_ITEM} r.item.item (description_column) as e and then
						e.component_count > 0 and then
						attached {ES_FIX} e.component (e.component_count) as action
					then
						fix_count := fix_count + 1
						fix_action := action
					end
				end

				if fix_count > 1 then
						-- There are several selected fixes.
					create l_menu_item.make_with_text (locale.formatted_string
						(locale.plural_translation ("Apply $1 fix", "Apply $1 fixes", fix_count), fix_count))
					l_menu_item.select_actions.extend (agent apply_fix)
				elseif attached fix_action then
						-- This is just one selected fix.
					l_menu_item := fix_action.menu_item
					l_menu_item.select_actions.extend (agent apply_single_fix (a_item.row))
				end
					-- Add an entry to apply a fix or fixes.
				if attached l_menu_item then
					l_menu_item.set_pixmap (stock_pixmaps.errors_and_warnings_fix_apply_icon)
					l_menu.extend (l_menu_item)
					l_menu.extend (create {EV_MENU_SEPARATOR})
				end

					-- Remove, singular.
				create l_menu_item.make_with_text (interface_names.m_remove)
				l_menu_item.set_pixmap (stock_pixmaps.general_delete_icon)
				l_menu_item.select_actions.extend (agent (r: EV_GRID_ROW)
					do
						remove_event_list_row (r)
						update_message_counters
						update_content_applicable_navigation_buttons
					end (a_item.row))
				l_menu.extend (l_menu_item)

				if grid_events.has_selected_row then
						-- Remove, multiple.
					create l_menu_item.make_with_text (interface_names.m_remove_all)
					l_menu_item.set_pixmap (stock_pixmaps.general_delete_icon)
					l_menu_item.select_actions.extend (agent on_select_delete_button)
					l_menu.extend (l_menu_item)
				end
				l_menu.show_at (a_item.row.parent, a_x, a_y)
			else
					-- This occurs when the user requests a context menu on an error list subrow, which
					-- do not have context menus.
				check
					row_parented: a_item.row.parent_row /= Void
				end
			end
		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW)
			-- Populates a grid row's item on a given row using the event `a_event_item'.
			--
			-- `a_event_item': A event to base the creation of a grid row on.
			-- `a_row': The row to create items on.
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_gen: EB_EDITOR_TOKEN_GENERATOR
			l_tip: EB_EDITOR_TOKEN_TOOLTIP
			l_content: LIST [EDITOR_TOKEN]
			l_pos_token: EDITOR_TOKEN_NUMBER
			l_line: EIFFEL_EDITOR_LINE
			l_context_stone: STONE
			l_expanded: BOOLEAN
			l_is_updating: BOOLEAN
			l_label: EV_GRID_LABEL_ITEM
			has_details: BOOLEAN
			category_label: EV_GRID_LABEL_ITEM
		do
			a_row.set_data (a_event_item)

				-- Set expand actions
			a_row.expand_actions.extend (agent on_row_expanded (a_row))

				-- Set error information.
			if is_appliable_event (a_event_item) then
					-- Category column.
				create category_label
				category_label.disable_full_select
				if is_error_event (a_event_item) then
					a_row.set_background_color (error_background_color)
					category_label.set_pixmap (stock_pixmaps.tool_error_icon)
					category_label.set_data (once "1")
				elseif is_warning_event (a_event_item) then
					a_row.set_background_color (warning_background_color)
					category_label.set_pixmap (stock_pixmaps.tool_warning_icon)
					category_label.set_data (once "2")
				elseif is_hint_event (a_event_item) then
					a_row.set_background_color (hint_background_color)
					category_label.set_pixmap (stock_pixmaps.general_information_icon)
					category_label.set_data (once "3")
				elseif is_ok_event (a_event_item) then
					a_row.set_background_color (success_background_color)
					category_label.set_pixmap (stock_pixmaps.general_tick_icon)
					category_label.set_data (once "4")
				else
						-- Unknown issue is most significat.
					category_label.set_data (once "0")
				end
				a_row.set_item (category_column, category_label)

				create l_gen.make
					-- Description column.
				if attached {ERROR} a_event_item.data as l_error then
						-- Mark that the message has a details subrow.
					has_details := True
						-- Compute error code.
					tracer.trace_error_code (l_gen, l_error)
						-- Add a tooltip to the category.
					category_label.set_tooltip (l_gen.last_line.wide_image)
						-- Rule column.
					l_editor_item := create_clickable_grid_item (l_gen.last_line, False)
						-- TODO: Add tooltip.
					a_row.set_item (rule_column, l_editor_item)
						-- Context column.
					l_gen.wipe_out_lines
					tracer.trace_context (l_gen, l_error)
					if l_gen.last_line /= Void then
						l_editor_item := create_clickable_grid_item (l_gen.last_line, False)
							-- No extra initialization needed so update `l_editor_item' to reflect settings.
						l_editor_item.try_call_setting_change_actions
						a_row.set_item (context_column, l_editor_item)
						l_content := l_gen.last_line.content
						if not l_content.is_empty then
								-- Set context pebble by iterating through the context content to find a feature
								-- or class token.
							from l_content.finish until l_content.before or l_context_stone /= Void loop
								if attached {EDITOR_TOKEN_FEATURE} l_content.item_for_iteration as l_ft then
									if attached {STONE} l_ft.pebble as s then
										l_context_stone := s
									end
								elseif attached {EDITOR_TOKEN_CLASS} l_content.item_for_iteration as l_ct then
									if attached {STONE} l_ct.pebble as s then
										l_context_stone := s
									end
								end
								l_content.back
							end
							if l_context_stone /= Void then
								l_editor_item.set_data (l_context_stone)
							end
						end
					end
						-- Retrieve location if available.
					if l_error.line > 0 then
							-- Create position token.
						create l_pos_token.make (l_error.line.out + ", " + l_error.column.max (1).out)
					end
						-- Set description.
					l_gen.wipe_out_lines
					tracer.trace_tersely (l_gen, l_error)
					if attached l_gen.last_line as l and then l.count > 0 then
						l_editor_item := create_clickable_grid_item (l, False)
					else
						l_editor_item := Void
					end
				elseif attached {CA_NO_ISSUES_EVENT} a_event_item then
					create l_editor_item.make_with_text (ca_messages.no_issues)
				elseif attached {CA_EXCEPTION_EVENT} a_event_item as e then
						-- Context column.
					e.data.cl.append_name (l_gen)
					l_editor_item := create_clickable_grid_item (l_gen.last_line, True)
					a_row.set_item (context_column, l_editor_item)
						-- Set description.
					create l_editor_item.make_with_text (ca_messages.error)
				elseif attached {CA_RULE_VIOLATION_EVENT} a_event_item as v then
						-- Mark that the message has a details subrow.
					has_details := True
						-- Add a tooltip to the category.
					category_label.set_tooltip (v.rule_id)
						-- Rule column.
					create l_label.make_with_text (v.rule_id)
					l_label.set_tooltip (v.rule_title)
					a_row.set_item (rule_column, l_label)
						-- Severity column.
					a_row.set_item (severity_column,
						create {EV_GRID_LABEL_ITEM}.make_with_text (v.severity_score.out))
						-- Context column.
					v.affected_class.append_name (l_gen)
					l_editor_item := create_clickable_grid_item (l_gen.last_line, True)
					a_row.set_item (context_column, l_editor_item)
					create {CLASSC_STONE} l_context_stone.make (v.affected_class)
						-- Retrieve location if available.
					if attached v.location as l then
							-- Create position token.
						create l_pos_token.make (l.line.out + ", " + l.column.out)
						l_pos_token.set_is_clickable (True)
						l_pos_token.set_pebble (create {COMPILED_LINE_STONE}.make_with_line_and_column (v.affected_class, l.line, l.column))
					end
						-- Set description.
					l_gen.wipe_out_lines
					v.add_title (l_gen)
					if attached l_gen.last_line as l and then l.count > 0 then
						l_editor_item := create_clickable_grid_item (l, False)
					else
						l_editor_item := Void
					end
				end
				if not attached l_editor_item then
					create l_editor_item.make_with_text ("No error message found!")
				end

					-- Lock update of editor item until everything has been set.
				l_editor_item.lock_update
				l_editor_item.disable_full_select

				l_editor_item.set_spacing ({ES_UI_CONSTANTS}.grid_item_spacing)
					-- Add optional fix component.
				add_fix_component (a_event_item, l_editor_item)

					-- Unlock editor item and call setting changed actions to signify that settings have changed.
				l_editor_item.unlock_update
				l_editor_item.try_call_setting_change_actions

				a_row.set_item (description_column, l_editor_item)

					-- Set row height
				a_row.set_height (l_editor_item.label_font_height.max
					(l_editor_item.required_height_for_text_and_component).max
					({ES_UI_CONSTANTS}.grid_row_height))

					-- Build full error text row.
				if a_row.subrow_count > 0 then
						-- Only update the row if there was already a subrow.
					populate_error_subrow (a_row)
						-- The row is being updated, so preserve any original state.
					l_is_updating := True
				elseif has_details then
						-- Defer the actual building to expansion action.
					a_row.insert_subrow (1)
				end

				l_tip := create_clickable_tooltip (agent generate_lines_for_tooltip (a_event_item), l_editor_item, a_row)
				a_row.select_actions.extend (agent l_tip.restart_tooltip_timer)

					-- Line and column number.
				l_editor_item := Void
				if attached l_pos_token then
					if l_context_stone /= Void then
						l_pos_token.set_is_clickable (True)
							-- Note: We call `event_context_stone_from_row' instead of using `l_context_stone' because
							--       it uses line position information, unlike `l_context_stone'
						l_pos_token.set_pebble (event_context_stone_from_row (a_row))
					end
						-- Create editor item.
					create l_line.make_unix_style
					l_line.append_token (l_pos_token)
					l_editor_item := create_clickable_grid_item (l_line, False)
						-- No extra initialization needed so update `l_editor_item' to reflect settings.
					l_editor_item.try_call_setting_change_actions
				end
				a_row.set_item (position_column, l_editor_item)
			end

				-- Fill empty items
			grid_events.grid_row_fill_empty_cells (a_row)
			a_row.set_height (a_row.height + 2)

				-- Set visibility.
			if not is_row_visible (text_filter.text.as_lower, a_row) then
				a_row.hide
			end

				-- Set expanded status
			if not l_is_updating and then a_row.is_expandable and then is_error_event (a_event_item) then
				if is_expanding_errors then
					l_expanded := is_expanding_all_errors
					is_expanding_all_errors := True
					a_row.expand
					is_expanding_all_errors := l_expanded
				elseif expand_n_errors and then show_n_errors > 0 then
					l_expanded := expand_n_errors
					a_row.expand
					show_n_errors := show_n_errors - 1
					expand_n_errors :=  l_expanded
				elseif a_row.is_expanded then
					a_row.collapse
				end
			end
		ensure then
			is_expanding_all_errors_unchanged: is_expanding_all_errors = old is_expanding_all_errors
		end

	update_tool_title_and_pixmap
			-- Sets the tool's title an pixmap based on the number of items existing in the list
		local
			l_title: STRING_32
			l_buffer: EV_PIXEL_BUFFER
		do
			l_title := interface_names.t_errors_and_warnings_tool.twin
			if item_count > 0 then
				l_title.append_character (' ')
				l_title.append_character ('(')
				l_title.append_natural_32 (error_count)
				l_title.append_character ('|')
				l_title.append_natural_32 (warning_count)
				l_title.append_character ('|')
				l_title.append_natural_32 (hint_count)
				l_title.append_character (')')
				if error_count > 0 and warning_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_errors_and_warnings_icon_buffer
				elseif error_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_errors_icon_buffer
				elseif warning_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_warnings_icon_buffer
				elseif hint_count > 0 then
					l_buffer := stock_pixmaps.general_information_icon_buffer
				end
			end
			if not attached l_buffer then
				l_buffer := stock_pixmaps.tool_errors_list_with_errors_icon_buffer
			end
			set_title (l_title)
			set_icon (l_buffer)
		end

	update_content_applicable_widgets (a_enable: BOOLEAN)
			-- <Precursor>
		do
			if a_enable then
					-- There are some errors.
					-- Error codes can be dropped to the error info button.
				error_info_command.enable_sensitive
					-- Check if some errors can be deleted.
				if grid_events.has_selected_row then
						-- Selected errors can be deleted.
					delete_button.enable_sensitive
				else
					delete_button.disable_sensitive
				end
					-- Check if there are fixable elements.
				if
					across
						grid_events.selected_rows as r
					some
						attached {EB_GRID_EDITOR_TOKEN_ITEM} r.item.item (description_column) as c and then c.component_count > 0
					end
				then
						-- Some items can be fixed.
					apply_fix_command.enable_sensitive
				else
						-- No items can be fixed.
					apply_fix_command.disable_sensitive
				end
			else
					-- Everything is disabled.
				error_info_command.disable_sensitive
				apply_fix_command.disable_sensitive
				delete_button.disable_sensitive
			end
		end

	update_content_applicable_navigation_buttons
			-- Updates content applicable navigation buttons
		do
			if error_count > 0 and error_button.is_selected then
				go_to_next_error_command.enable_sensitive
				go_to_previous_error_command.enable_sensitive
			else
				go_to_next_error_command.disable_sensitive
				go_to_previous_error_command.disable_sensitive
			end

			if warning_count > 0  and warning_button.is_selected then
				go_to_next_warning_command.enable_sensitive
				go_to_previous_warning_command.enable_sensitive
			else
				go_to_next_warning_command.disable_sensitive
				go_to_previous_warning_command.disable_sensitive
			end
		end

	update_message_counters
			-- Updates message counters on the user interface.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			error_button.set_text (interface_names.b_error_toggle_error (error_count))
			error_button.set_tooltip (interface_names.f_error_toggle_error (error_count))
			warning_button.set_text (interface_names.b_error_toggle_warning (warning_count))
			warning_button.set_tooltip (interface_names.f_error_toggle_warning (warning_count))
			hint_button.set_text (interface_names.b_error_toggle_hint (hint_count))
			hint_button.set_tooltip (interface_names.f_error_toggle_hint (hint_count))
			update_tool_title_and_pixmap
		end

	populate_error_subrow (a_parent_row: EV_GRID_ROW)
			-- Populate/update subrow of `a_parent_row'.
		require
			a_parent_row_not_void: a_parent_row /= Void
			a_parent_row_has_data: attached {EVENT_LIST_ITEM_I} a_parent_row.data
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_lines: LIST [EIFFEL_EDITOR_LINE]
			l_row: EV_GRID_ROW
		do
			if attached {EVENT_LIST_ITEM_I} a_parent_row.data as l_event then
				l_lines := generate_lines_for_tooltip (l_event)
				if not l_lines.is_empty then
						-- Sub row full error
					if a_parent_row.subrow_count = 0 then
							-- No subrow, add one.
							-- Note: A sub row will exist if the information is being updated
						a_parent_row.insert_subrow (1)
					end

					l_row := a_parent_row.subrow (1)
					l_row.set_data (l_event)
					l_row.set_background_color (a_parent_row.background_color)

					l_editor_item := create_multiline_clickable_grid_item (l_lines, True, False)
					if attached {CA_RULE_VIOLATION_EVENT} l_event as v then
						l_editor_item.set_tooltip (v.data.rule.description)
					end
						-- No extra initialization needed so update `l_editor_item' to reflect settings.
					l_editor_item.try_call_setting_change_actions
					l_row.set_height (l_editor_item.required_height_for_text_and_component)
					l_row.set_item (description_column, l_editor_item)
					l_row.set_height (l_row.height + 2)
					grid_events.grid_row_fill_empty_cells (l_row)
				end
			end
		end

	generate_lines_for_tooltip (e: EVENT_LIST_ITEM_I): LIST [EIFFEL_EDITOR_LINE]
			-- Generate lines for tooltip of `e'.
		require
			event_item_attached: e /= Void
		local
			l_gen: EB_EDITOR_TOKEN_GENERATOR
		do
			create l_gen.make
			l_gen.enable_multiline
			if attached {EVENT_LIST_ERROR_ITEM} e as i and then attached {ERROR} i.data as r then
				tracer.trace (l_gen, r)
			elseif attached {CA_RULE_VIOLATION_EVENT} e as v then
				v.format_description (l_gen)
			end
			if l_gen.last_line.count > 0 then
					-- Last line is not terminated with a new line.
					-- Add it anyway.
				l_gen.add_new_line
			end
			Result := l_gen.lines
		ensure
			Result_set: Result /= Void
		end

feature {ES_ERROR_LIST_COMMANDER_I} -- Basic operations: Navigation

	go_to_next_error (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if
				is_displaying_error and then
				error_count > 0
			then
				move_next (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
					require
						a_item_attached: a_item /= Void
					do
						Result := is_error_event (a_item) and then
							(event_context_stone (a_item) /= Void or
								-- C compiler errors have not context stone so we need to account for this.
							attached {C_COMPILER_ERROR} a_item.data)
					end)
			end
		end

	go_to_previous_error (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if
				is_displaying_error and then
				error_count > 0
			then
				move_previous (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
					require
						a_item_attached: a_item /= Void
					do
						Result := is_error_event (a_item) and then
							(event_context_stone (a_item) /= Void or
								-- C compiler errors have not context stone so we need to account for this.
							attached {C_COMPILER_ERROR} a_item.data)
					end)
			end
		end

	go_to_next_warning (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if
				is_displaying_warning and then warning_count > 0 or else
				is_displaying_hint and then hint_count > 0
			then
				move_next (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
					require
						a_item_attached: a_item /= Void
					do
						Result :=
							(is_warning_event (a_item) or else is_hint_event (a_item)) and then
							attached event_context_stone (a_item)
					end)
			end
		end

	go_to_previous_warning (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if
				is_displaying_warning and then warning_count > 0 or else
				is_displaying_hint and then hint_count > 0
			then
				move_previous (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
					require
						a_item_attached: a_item /= Void
					do
						Result :=
							(is_warning_event (a_item) or else is_hint_event (a_item)) and then
							attached event_context_stone (a_item)
					end)
			end
		end

	apply_fix
			-- <Precursor>
		do
			fix_undo_promt (agent apply_fix_without_undo_prompt)
		end

feature {NONE} -- Fixing

	add_fix_component (e: EVENT_LIST_ITEM_I; i: EB_GRID_EDITOR_TOKEN_ITEM)
			-- Add a fix option of `e' to the item `i'.
		local
			fix_component: ES_FIX
			f: ITERABLE [FIX [TEXT_FORMATTER]]
		do
			if attached {COMPILER_ERROR} e.data as ce then
				f := fix_factory.fix_option (ce)
			elseif attached {CA_RULE_VIOLATION_EVENT} e as v then
				f := v.data.fixes
			end
			if attached f then
					-- TODO: Handle multiple fix options instead of just the first one.
				across
					f as o
				until
					attached fix_component
				loop
						-- Associate fix option with the grid item.
					fix_component := {ES_FIX_FACTORY}.create_component (o.item)
					if attached fix_component then
							-- Augment `i'  with a notification that a fix is available.
						i.append_component (fix_component)
							-- Make sure a notification is always visible.
						i.ensure_component_display
					end
				end
			end
		end

	apply_single_fix (r: EV_GRID_ROW)
			-- Attempt to apply a fix chosen for row `r'.
		do
			fix_undo_promt (agent apply_single_fix_without_undo_prompt (r))
		end

	apply_single_fix_without_undo_prompt (r: EV_GRID_ROW)
			-- Attempt to apply a fix chosen for row `r' without notification about "undo" behaviour.
			-- Open an editor for the affected class if `is_editor_requested`.
		local
			i: INTEGER
		do
			if attached {EB_GRID_EDITOR_TOKEN_ITEM} r.item (description_column) as e then
				from
					i := e.component_count
				until
					i <= 0
				loop
					if attached {ES_FIX} e.component (i) as f then
							-- Prevent further applications of the fix and
							-- remove a notification that a fix is available.
						e.remove_component (i)
							-- Apply the fix.
						apply_fixes (create {ARRAYED_LIST [ES_FIX]}.make_from_array (<<f>>), f.compiled_class)
					end
					i := i - 1
				end
			end
		end

	apply_fix_without_undo_prompt
			-- Apply fixes to selected items without notification about "undo" behaviour.
		local
			selected_fixes: HASH_TABLE [ARRAYED_LIST [ES_FIX], like {CLASS_C}.class_id]
			class_fixes: ARRAYED_LIST [ES_FIX]
			i: INTEGER
		do
			create selected_fixes.make (1)
			across
				grid_events.selected_rows as r
			loop
				if attached {EB_GRID_EDITOR_TOKEN_ITEM} r.item.item (description_column) as e then
					from
						i := e.component_count
					until
						i <= 0
					loop
						if attached {ES_FIX} e.component (i) as f then
							e.remove_component (i)
							class_fixes := selected_fixes [f.compiled_class.class_id]
							if not attached class_fixes then
								create class_fixes.make (1)
								selected_fixes [f.compiled_class.class_id] := class_fixes
							end
							class_fixes.extend (f)
						end
						i := i - 1
					end
				end
			end
			across
				selected_fixes as selected_class_fixes
			loop
				if attached system.class_of_id (selected_class_fixes.key) as c then
					apply_fixes (selected_class_fixes.item, c)
				end
			end
		end

	apply_fixes (f: ARRAYED_LIST [ES_FIX]; c: CLASS_C)
			-- Apply fixes `f` to class `c` opening a new editor if `is_editor_requested`.
		local
			m: ES_CLASS_TEXT_AST_MODIFIER
		do
			create m.make (c.lace_class)
			if
				attached window_manager.active_editor_for_class (c.lace_class) as class_editor and then
				class_editor.changed or else
				c.lace_class.date /= c.lace_class.file_date
			then
				prompts.show_error_prompt (locale.formatted_string
					(locale.translation_in_context ("Class $1 has been changed and should be recompiled before applying fixes.", once "tool.error"), c.name) , develop_window.window, Void)
			elseif m.is_modifiable then
				if preferences.dialog_data.open_class_on_fix_preference.value then
						-- Make sure there are editors with the class.
					develop_window.commands.new_tab_cmd.execute_with_stone (create {CLASSC_STONE}.make (c))
						-- Make sure all editors associated with the class finish loading of the text.
					across
						develop_window.editors_manager.editor_editing (c.lace_class) as e
					loop
						e.item.flush
					end
				end
				m.execute_batch_modifications (agent (modifier: ES_CLASS_TEXT_AST_MODIFIER; fixes: ARRAYED_LIST [ES_FIX])
					local
						a: CLASS_AS
						s: TUPLE [start_position: INTEGER_32; end_position: INTEGER_32]
						r: ERT_TOKEN_REGION
					do
						a := modifier.ast
						s := modifier.ast_position (a)
						r := a.token_region (modifier.ast_match_list)
						across
							fixes as fix
						loop
							fix.item.apply_to (modifier)
						end
						if modifier.ast_match_list.is_text_modified (r) then
							modifier.replace_code (s.start_position, s.end_position, modifier.ast_match_list.text_32 (r))
						end
					end (m, f), True, True)
				;(create {ES_CLASS_LICENSER}).relicense (c.lace_class)
			else
				prompts.show_error_prompt (interface_names.l_class_is_not_writable (c.name), develop_window.window, Void)
			end
		end

	fix_undo_promt (action: PROCEDURE)
			-- Raise a discardable prompt about performing fixes by `action` with the description of "undo" behaviour
			-- and call the action with the flag indicating whether a new editor for every class should be open.
		local
			p: ES_DISCARDABLE_QUESTION_WARNING_PROMPT
			a: PROCEDURE
		do
			create p.make_standard_persistent
				(warning_messages.w_fix_undo_warning,
				interface_names.l_discard_fix_undo_warning,
				create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.confirm_fix_without_undo_preference, False),
				create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.open_class_on_fix_preference, True))
			a := agent apply_fixes_and_update_toolbar (action)
			p.set_button_action ({ES_DIALOG_BUTTONS}.yes_button, a)
			p.set_button_action ({ES_DIALOG_BUTTONS}.no_button, a)
			p.show_on_active_window
		end

	apply_fixes_and_update_toolbar (action: PROCEDURE)
			-- Apply fixes by calling `action` and update toolbar.
		do
				-- Perform original action.
			action.call
				-- Update toolbar buttons state that may be changed by the previous instruction.
			update_content_applicable_widgets (grid_events.row_count > 0)
		end

	fix_factory: FIX_FACTORY
			-- A factory to compuile fixes for errors.
		do
			create Result.make
		end

feature {NONE} -- Event handlers: event list

	on_unlocked (a_sender: attached LOCKABLE_I)
			-- <Precursor>
		do
			if is_interface_usable and is_initialized then
				update_content_applicable_navigation_buttons
				update_message_counters
			end
			Precursor (a_sender)
		end

	on_event_item_added (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_applicable: BOOLEAN
		do
			l_applicable := is_appliable_event (a_event_item)
			if l_applicable and not is_initialized then
					-- We have to perform initialization to set the icon and counter.
					-- Synchronization with the event list service is surpress to prevent duplication of event items being added.
				is_event_list_synchronized_on_initialized := False
				initialize
			end

			Precursor (a_service, a_event_item)

			if l_applicable then
				if is_error_event (a_event_item) then
					set_error_count (error_count + 1)
				elseif is_warning_event (a_event_item) then
					set_warning_count (warning_count + 1)
				elseif is_hint_event (a_event_item) then
					set_hint_count (hint_count + 1)
				elseif not is_ok_event (a_event_item) then
					check from_is_appliable_event_postcondition: False end
				end
			end
		ensure then
			is_initialized: is_appliable_event (a_event_item) implies is_initialized
		end

	on_event_item_removed (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_applicable: BOOLEAN
		do
			l_applicable := is_appliable_event (a_event_item)
			if l_applicable and not is_initialized then
					-- We have to perform initialization to set the icon and counter
					-- Synchronization with the event list service is surpress to prevent duplication of event items being added.
				is_event_list_synchronized_on_initialized := False
				initialize
			end
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_service, a_event_item)
			if l_applicable then
				if is_error_event (a_event_item) then
					set_error_count (error_count - 1)
				elseif is_warning_event (a_event_item) then
					set_warning_count (warning_count - 1)
				elseif is_hint_event (a_event_item) then
					set_hint_count (hint_count - 1)
				elseif not is_ok_event (a_event_item) then
					check from_is_appliable_event_postcondition: False end
				end
			end
		ensure then
			is_initialized: is_appliable_event (a_event_item) implies is_initialized
		end

	on_event_item_clean_up (a_service: EVENT_LIST_S)
			-- <Precursor>
		do
			if not is_initialized then
					-- We have to perform initialization to set the icon and counter
					-- Synchronization with the event list service is surpress to prevent duplication of event items being added.
				is_event_list_synchronized_on_initialized := False
				initialize
			end
				-- Hide the tooltip if possible
			if attached last_tooltip_item as l_item and then not l_item.is_destroyed then
				l_item.pointer_leave_actions.call (Void)
			end
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_service)
			set_error_count (0)
			set_warning_count (0)
			set_hint_count (0)
			update_content_applicable_navigation_buttons
			update_message_counters
		ensure then
			is_initialized: is_initialized
		end

	on_session_value_changed (a_session: SESSION; a_id: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			if
				a_id.same_string (expand_errors_session_id) and then
					-- Retrieve global session
				attached {BOOLEAN_REF} a_session.value_or_default (expand_errors_session_id, False) as l_expand and then
				is_expanding_errors /= l_expand.item
			then
				is_expanding_errors := l_expand.item
				if is_expanding_errors then
					expand_errors_button.enable_select
				else
					expand_errors_button.disable_select
				end
				on_toggle_expand_errors_button
			end
		end

feature {NONE} -- Event handlers: code analyzer

	on_put (s: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]; e: STONE)
			-- <Precursor>
		do
			if attached {TARGET_STONE} e then
				scope_label.set_tooltip (ca_messages.system_scope_tooltip)
				scope_label.set_foreground_color (preferences.editor_data.target_text_color)
			elseif attached {CLASSC_STONE} e then
				scope_label.set_tooltip (ca_messages.class_scope_tooltip)
				scope_label.set_foreground_color (preferences.editor_data.class_text_color)
			elseif attached {CLUSTER_STONE} e then
				scope_label.set_tooltip (ca_messages.cluster_scope_tooltip)
				scope_label.set_foreground_color (preferences.editor_data.cluster_text_color)
			elseif attached {DATA_STONE} e then
				scope_label.set_tooltip (ca_messages.conf_group_tooltip)
				scope_label.set_foreground_color (preferences.editor_data.cluster_text_color)
			else
				scope_label.remove_tooltip
			end
			scope_label.set_text (e.stone_name)
			scope_label.set_pebble (e)
			scope_label.set_pick_and_drop_mode
		end

feature {NONE} -- Action handlers

	on_row_expanded (a_row: EV_GRID_ROW)
			-- Called when the expand error button is selected.
			--
			-- `a_row': The row that was expanded.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_has_grid_events_as_parent: a_row.parent = grid_events
			a_row_is_expanded: a_row.is_expanded
		do
				-- We don't rebuild the subrow when it is already there built on the same event.
			if attached {EVENT_LIST_ITEM_I} a_row.data as l_event and then (a_row.subrow_count = 0 or else a_row.subrow (1).data /= l_event) then
				populate_error_subrow (a_row)
			end
			if not is_expanding_all_errors then
				grid_events.selected_rows.do_all (agent {EV_GRID_ROW}.disable_select)
				a_row.enable_select
				if a_row.subrow_count > 0 and then a_row.subrow (1).is_displayed then
						-- Ensure the row is visible.
					a_row.subrow (1).ensure_visible
				end
			end
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			if
				a_released and then
				not a_alt and then
				not a_ctrl and then
				not a_shift and then
				a_key.code = {EV_KEY_CONSTANTS}.key_delete
			then
				remove_all_selected_event_list_rows
				update_message_counters
				update_content_applicable_navigation_buttons
				Result := True
			else
				Result := Precursor (a_key, a_alt, a_ctrl, a_shift, a_released)
			end
		end

	on_toogle_message_button (is_enabled: PREDICATE; is_controlled: PREDICATE [EVENT_LIST_ITEM_I]; is_seeable: PREDICATE [EVENT_LIST_ITEM_I])
			-- Called when one of the buttons selecting message kinds is toggled.
			-- `is_enabled` tells if the message kind is currently enabled.
			-- `is_controlled` tells if the message is controlled by the associated button.
			-- `is_seeable` tells if the message is visible according to current filters.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_row: EV_GRID_ROW
			l_show: BOOLEAN
			l_count, i: INTEGER
		do
			l_show := is_enabled.item
			from
				i := 1
				l_count := grid_events.row_count
			until
				i > l_count
			loop
				l_row := grid_events.row (i)
				if
					attached {EVENT_LIST_ITEM_I} l_row.data as e and then
					is_controlled (e)
				then
					if l_show and then is_seeable (e) then
						l_row.show
					else
						l_row.hide
					end
				end
				i := i + 1
			end
			update_content_applicable_navigation_buttons
		end

	on_update_visiblity
			-- Show or hide rows according to the current settings.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_row: EV_GRID_ROW
			l_count, i: INTEGER
			s: STRING_32
		do
			s := text_filter.text
			if not s.is_empty then
				 s := s.as_lower
			end
			from
				i := 1
				l_count := grid_events.row_count
			until
				i > l_count
			loop
				l_row := grid_events.row (i)
				if is_row_visible (s, l_row) then
					l_row.show
				else
					l_row.hide
				end
				i := i + 1
			end
		end

	on_toggle_expand_errors_button
			-- Called when the expand error button is selected
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_expanding_all_errors: not is_expanding_all_errors
		local
			l_expand: BOOLEAN
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_count, i: INTEGER
		do
			l_expand := expand_errors_button.is_selected
			if is_expanding_errors /= l_expand then
				is_expanding_all_errors := l_expand
				is_expanding_errors := l_expand

					-- Set applicable grid items and open/closed because on expanded status
				l_grid := grid_events
				from
					i := 1
					l_count := l_grid.row_count
				until
					i > l_count
				loop
					l_row := l_grid.row (i)
					if
						l_row.is_expandable and then
						attached {EVENT_LIST_ERROR_ITEM_I} l_row.data as l_event_item and then
						is_error_event (l_event_item)
					then
						if l_expand then
							l_row.expand
						else
							l_row.collapse
						end
					end
					i := i + 1
				end
				is_expanding_all_errors := False
			end
		ensure
			is_expanding_errors_set: is_expanding_errors = expand_errors_button.is_selected
			not_is_expanding_all_errors: not is_expanding_all_errors
		end

	on_select_delete_button
			-- Caled when the `delete_button' is selected.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			remove_all_selected_event_list_rows
			update_message_counters
			update_content_applicable_navigation_buttons
		end

	on_select_error_info
			-- Call when the error information button is clicked.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if
				grid_events.has_selected_row and then
					-- Retrieve event item set from {ES_EVENT_LIST_TOOL_PANEL_BASE}.on_event_added
				attached {EVENT_LIST_ITEM_I} grid_events.selected_rows.first.data as l_event and then
				attached {ERROR} l_event.data as e
			then
					-- Retrieve error item.
				error_info_command.execute_with_stone (create {ERROR_STONE}.make (e))
			else
					-- No error found. This can happen when the expanded information row is selected.
				error_info_command.execute
			end
		end

	on_warnings_filter_changed (a_type: TYPE [ANY]; a_exact_only: BOOLEAN; a_exclude: BOOLEAN)
			-- Called when the filter has been changed
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_filter: ES_WARNINGS_FILTER_WIDGET
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			l_count, i: INTEGER
		do
			l_filter := filter_widget
			l_grid := grid_events
			from l_count := l_grid.row_count; i := 1 until i > l_count loop
				l_row := l_grid.row (i)
				if
					a_exclude = l_row.is_show_requested and then
					attached {EVENT_LIST_ITEM_I} l_row.data as l_event and then
					is_warning_event (l_event) and then
					attached {ERROR} l_event.data as l_warning
				then
					if not l_filter.is_unfiltered (l_warning) then
						if a_exclude then
							l_row.hide
						end
					else
						if not a_exclude then
							l_row.show
						end
					end
				end

				if l_row.subrow_count_recursive > 1 then
					i := i + l_row.subrow_count_recursive
				else
					i := i + 1
				end
			end

			if l_filter.filtered.is_empty then
				filter_button.set_pixel_buffer (stock_pixmaps.errors_and_warnings_filter_icon_buffer)
				filter_button.set_pixmap (stock_pixmaps.errors_and_warnings_filter_icon)
			else
				filter_button.set_pixel_buffer (stock_pixmaps.errors_and_warnings_filter_active_icon_buffer)
				filter_button.set_pixmap (stock_pixmaps.errors_and_warnings_filter_active_icon)
			end
		end

feature {NONE} -- Factory

	create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			create error_button.make
			error_button.set_pixmap (stock_pixmaps.tool_error_icon)
			error_button.set_pixel_buffer (stock_pixmaps.tool_error_icon_buffer)
			error_button.enable_select
			error_button.select_actions.extend (agent on_toogle_message_button
				(agent is_displaying_error,
				agent is_error_event,
				agent (e: EVENT_LIST_ITEM_I): BOOLEAN do Result := True end))

			create warning_button.make
			warning_button.set_pixmap (stock_pixmaps.tool_warning_icon)
			warning_button.set_pixel_buffer (stock_pixmaps.tool_warning_icon_buffer)
			warning_button.enable_select
			warning_button.select_actions.extend (agent on_toogle_message_button
				(agent is_displaying_warning,
				agent is_warning_event,
				agent (e: EVENT_LIST_ITEM_I): BOOLEAN do
					Result := attached {ERROR} e.data as w implies filter_widget.is_unfiltered (w)
				end))

			create hint_button.make
			hint_button.set_pixmap (stock_pixmaps.general_information_icon)
			hint_button.set_pixel_buffer (stock_pixmaps.general_information_icon_buffer)
			hint_button.enable_select
			hint_button.select_actions.extend (agent on_toogle_message_button
				(agent is_displaying_hint,
				agent is_hint_event,
				agent (e: EVENT_LIST_ITEM_I): BOOLEAN do Result := True end))

			create Result.make (4)
			Result.extend (error_button)
			Result.extend (create {SD_TOOL_BAR_WIDGET_ITEM}.make (create {EV_LABEL}))
			Result.extend (warning_button)
			Result.extend (create {SD_TOOL_BAR_WIDGET_ITEM}.make (create {EV_LABEL}))
			Result.extend (hint_button)
		ensure then
			error_button_attached: error_button /= Void
			warning_button_attached: warning_button /= Void
		end

	create_mini_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		local
			h: EV_HORIZONTAL_BOX
		do
			create h
			h.set_padding (3)
			h.disable_homogeneous
			h.extend (create {EV_LABEL}.make_with_text (ca_names.last_analyzed))
				-- Scope label.
			create scope_label.make_with_text (ca_names.analysis_not_run)
			scope_label.set_foreground_color (colors.disabled_foreground_color)
			scope_label.align_text_left
			scope_label.set_minimum_width (200)
			h.extend (scope_label)
			create Result.make_from_array (<<create {SD_TOOL_BAR_WIDGET_ITEM}.make (h)>>)
		end

	create_right_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (17)

				-- Fix buttons.
			l_button := apply_fix_command.new_sd_toolbar_item (True)
			Result.extend (l_button)

				-- Separator
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Navigation buttons
			l_button := go_to_next_error_command.new_sd_toolbar_item (False)
			Result.extend (l_button)

			l_button := go_to_previous_error_command.new_sd_toolbar_item (False)
			Result.extend (l_button)

			l_button := go_to_next_warning_command.new_sd_toolbar_item (False)
			Result.extend (l_button)

			l_button := go_to_previous_warning_command.new_sd_toolbar_item (False)
			Result.extend (l_button)

			create delete_button.make
			delete_button.set_pixel_buffer (stock_pixmaps.general_delete_icon_buffer)
			delete_button.set_pixmap (stock_pixmaps.general_delete_icon)
			delete_button.set_tooltip (locale_formatter.translation (tt_delete_items))
			register_action (delete_button.select_actions, agent on_select_delete_button)
			Result.extend (delete_button)

				-- Separator
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Automatic expand error button
			create expand_errors_button.make
			expand_errors_button.set_pixmap (stock_pixmaps.errors_and_warnings_expand_errors_icon)
			expand_errors_button.set_pixel_buffer (stock_pixmaps.errors_and_warnings_expand_errors_icon_buffer)
			expand_errors_button.set_tooltip (interface_names.f_toogle_expand_errors)
			register_action (expand_errors_button.select_actions, agent on_toggle_expand_errors_button)
			Result.extend (expand_errors_button)

			create error_info_command.make
			error_info_button := error_info_command.new_sd_toolbar_item (False)
				-- We need to do something else, like handle grid selection
			error_info_button.select_actions.wipe_out
			register_action (error_info_button.select_actions, agent on_select_error_info)
			Result.extend (error_info_button)

				-- Filter pop up widget
			create filter_widget.make
			register_action (filter_widget.filter_changed_actions, agent on_warnings_filter_changed)

				-- Filter section.

			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Filter button.
			create filter_button.make
			filter_button.set_pixmap (stock_pixmaps.metric_filter_icon)
			filter_button.set_pixel_buffer (stock_pixmaps.metric_filter_icon_buffer)
			filter_button.set_tooltip (interface_names.f_filter_warnings)
			filter_button.set_popup_widget (filter_widget)
			Result.extend (filter_button)

				-- Text filter.
			create text_filter
			text_filter.key_release_actions.extend (agent (k: EV_KEY) do on_update_visiblity end)
			text_filter.set_minimum_width_in_characters (10)
			text_filter.set_tooltip (interface_names.f_error_text_filter)
			Result.extend (create {SD_TOOL_BAR_WIDGET_ITEM}.make (text_filter))

				-- Text filter clear button.
			create l_button.make
			l_button.set_pixmap (stock_mini_pixmaps.general_delete_icon)
			l_button.pointer_button_press_actions.extend (
				agent (x, y, b: INTEGER_32; xt, yt, p: REAL_64; xs, ys: INTEGER_32)
					do
						text_filter.set_text ("")
						on_update_visiblity
					end
				)
			l_button.set_tooltip (interface_names.f_error_clear_text_filter)
			Result.extend (l_button)
		ensure then
			filter_button_attached: filter_button /= Void
		end

	create_clickable_tooltip (a_lines: FUNCTION [LIST [EIFFEL_EDITOR_LINE]]; a_item: EV_GRID_ITEM; a_row: EV_GRID_ROW): EB_EDITOR_TOKEN_TOOLTIP
			-- <Precursor>
		local
			l_just_created: BOOLEAN
		do
			if not attached a_item.data then
				l_just_created := True
			end
			Result := Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE}(a_lines, a_item, a_row)
			if l_just_created then
				Result.veto_tooltip_display_functions.extend (agent: BOOLEAN
					do
						Result := should_tooltip_be_displayed
					end)
				Result.before_display_actions.extend (agent (a_it: EV_GRID_ITEM)
					do
						last_tooltip_item := a_it
					end (a_item)
					)
			end
		end

feature {ES_CODE_ANALYSIS_COMMAND} -- UI Items

	scope_label: EV_LABEL
			-- Label showing the scope of the last analysis.

feature {NONE} -- Services

	frozen code_analyzer: SERVICE_CONSUMER [CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]]
			-- Access to an code analyzer service {CODE_ANALYZER_S} consumer.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Preference Handler

	on_preference_expand_n_errors
			-- Update the state that controls if errors in the Error List tool should be expanded automatically.
			-- The behavior is controlled by `preferences.error_list_tool_data.expand_n_errors`:
			-- • < 0: auto expand all,
			-- • = 0: do not expand,
			-- • > 0: expand first N errors.
		local
			n: like {ES_ERROR_LIST_DATA}.expand_n_errors
		do
			n := preferences.error_list_tool_data.expand_n_errors
			if n < 0 then
					-- Expand all.
				is_expanding_errors := True
				expand_n_errors := False
				expand_errors_button.enable_select
			elseif n > 0  then
					-- Expand the N first errors.
				is_expanding_errors := False
				expand_n_errors := True
				show_n_errors :=  n
				expand_errors_button.disable_select
			else
					-- Expand disabled.
				is_expanding_errors :=False
				expand_n_errors := False
				show_n_errors := 0
				expand_errors_button.disable_select
			end
		end

	on_editor_preference_change_agent: detachable PROCEDURE
			-- Saved editor preference agent to be recycled.
			-- See `on_editor_preference_change`.

	on_editor_preference_change
			-- Update rows to reflect changes in editor preferences (such as new font size).
		local
			row_index: like {ES_GRID}.row_count
			row: like {ES_GRID}.row
			row_height: like {EV_GRID_ROW}.height
		do
				-- Update height of all rows.
			from
				row_index := grid_events.row_count
			until
				row_index <= 0
			loop
				row := grid_events.row (row_index)
				if attached {EB_GRID_EDITOR_TOKEN_ITEM} row.item (description_column) as e then
					e.set_overriden_fonts (e.label_font_table, e.label_font_height)
					row_height :=
						e.label_font_height.max
						(e.required_height_for_text_and_component).max
						({ES_UI_CONSTANTS}.grid_row_height) + 2
					if row_height /= row.height then
						row.set_height (row_height)
					end
				end
				row_index := row_index - 1
			variant
				row_index
			end
		end

feature {NONE} -- Exception handling

	raise_default_exception_dialog (a_empty_dialog: EV_DIALOG; an_exception: EXCEPTION)
			-- Raises the exception dialog `a_empty_dialog' for `an_exception'.
		require
			a_empty_dialog_valid: a_empty_dialog /= Void and then not a_empty_dialog.is_destroyed
		local
			l_exception_string: detachable STRING_32
			l_label: EV_TEXT
			l_label_box: EV_HORIZONTAL_BOX
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_font: EV_FONT
			l_ignore: EV_BUTTON
			l_frame: EV_FRAME
			l_error_box: EV_HORIZONTAL_BOX
			l_error_label: EV_LABEL
			l_exception_message: READABLE_STRING_32
		do
			l_exception_string := an_exception.trace
			if l_exception_string /= Void then
				l_exception_string := l_exception_string.twin
				l_exception_string.prune_all ('%R')
			end
			create l_label
			l_label.disable_word_wrapping
			l_label.disable_edit
			create l_font
			l_font.set_family ({EV_FONT_CONSTANTS}.Family_typewriter)
			l_label.set_font (l_font)
			if l_exception_string /= Void then
				l_label.set_text (l_exception_string)
			else
				l_label.set_text (ca_messages.no_trace)
			end
			create l_vbox
			create l_error_box
			l_error_box.set_border_width (5)
			l_error_box.set_padding (5)
			l_error_box.extend ((create {EV_STOCK_PIXMAPS}).error_pixmap.twin)
			l_error_box.disable_item_expand (l_error_box.first)
			l_error_box.first.set_minimum_size (32, 32)
			create l_error_label
			l_error_label.align_text_left
			l_error_label.set_text (ca_messages.the_following_exception)
			l_error_box.extend (l_error_label)
			l_vbox.extend (l_error_box)
			l_vbox.disable_item_expand (l_error_box)

			create l_frame
			create l_label_box
			l_frame.extend (l_label_box)
			l_label_box.set_padding (5)
			l_label_box.set_border_width (5)
			l_label_box.extend (l_label)
			l_frame.set_text (ca_messages.exception_trace)
			l_vbox.extend (l_frame)
			a_empty_dialog.extend (l_vbox)
			create l_hbox
			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)
			create l_ignore.make_with_text (ca_messages.close)
			l_ignore.select_actions.extend (agent a_empty_dialog.destroy)
			l_hbox.extend (create {EV_CELL})
			l_hbox.extend (l_ignore)
			l_hbox.disable_item_expand (l_ignore)
			l_hbox.set_border_width (5)
			l_hbox.set_padding (5)
			l_exception_message :=
				if attached an_exception.description as l_message then
					l_message
				else
					{STRING_32} ""
				end
			a_empty_dialog.set_title (ca_messages.inspector_eiffel_exception + l_exception_message)
			a_empty_dialog.set_minimum_height (350)
			a_empty_dialog.set_size (500, 300)
			a_empty_dialog.raise
				--| FIXME Behavior would be better if dialog has full application modality.

				-- Set "Ignore" as the default
			l_ignore.set_focus
		end

feature {NONE} -- Colors

	error_background_color: EV_COLOR
			-- Background color for errors.
		do
			Result := preferences.error_list_tool_data.error_background
		ensure
			valid_result: Result /= Void
		end

	warning_background_color: EV_COLOR
			-- Background color for warning.
		do
			Result := preferences.error_list_tool_data.warning_background
		ensure
			valid_result: Result /= Void
		end

	hint_background_color: EV_COLOR
			-- Background color for hint.
		do
			Result := preferences.error_list_tool_data.hint_background
		ensure
			valid_result: Result /= Void
		end

	success_background_color: EV_COLOR
			-- Background color for success.
		do
			Result := preferences.error_list_tool_data.success_background
		ensure
			valid_result: Result /= Void
		end

feature {NONE} -- Constants

	category_column: INTEGER = 1
	rule_column: INTEGER = 2
	description_column: INTEGER = 3
	context_column: INTEGER = 4
	position_column: INTEGER = 5
	severity_column: INTEGER = 6
	last_column: INTEGER = 6

	expand_errors_session_id: STRING = "com.eiffel.error_list.expand_errors"

feature {NONE} -- Internationalization

	tt_delete_items: STRING = "Delete all the selected [completed] items"

invariant
	error_button_attached: (is_initialized and is_interface_usable) implies attached error_button
	warning_button_attached: (is_initialized and is_interface_usable) implies attached warning_button
	deletebutton_attached: (is_initialized and is_interface_usable) implies attached delete_button
	expand_errors_button_attached: (is_initialized and is_interface_usable) implies attached expand_errors_button
	error_info_button_attached: (is_initialized and is_interface_usable) implies attached error_info_button
	filter_button_attached: (is_initialized and is_interface_usable) implies attached filter_button
	item_count_matches_error_and_warning_count: error_count + warning_count + hint_count = item_count

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
