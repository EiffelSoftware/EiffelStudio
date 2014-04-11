note
	description:
		"Graphical panel for Code Analysis tool"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_ANALYSIS_TOOL_PANEL

inherit
	ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE
		redefine
			build_tool_interface,
			on_before_initialize,
			on_after_initialized,
			internal_recycle,
			create_mini_tool_bar_items,
			create_right_tool_bar_items,
			is_event_list_synchronized_on_initialized,
			is_event_list_scrolled_automatically,
			is_appliable_event,
			on_event_item_added,
			on_event_item_removed,
			find_event_row
		end

	SESSION_EVENT_OBSERVER
		export {NONE} all end

	SHARED_ERROR_TRACER
		export {NONE} all end

	CA_SHARED_NAMES

create {ES_CODE_ANALYSIS_TOOL}
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		do
			Precursor

				-- We want the tool to synchronize with the event list, when first initialized.
			is_event_list_synchronized_on_initialized := True
		end

	on_after_initialized
			-- <Precursor>
		do
				-- Bind redirecting pick and drop actions.
			stone_director.bind (grid_events, Current)

				-- Hook up events for session data.
			if session_manager.is_service_available then
				session_data.session_connection.connect_events (Current)
			end

			is_event_list_scrolled_automatically := False

			Precursor
		end

    create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- <Precursor>
        local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
		do
			create l_helper

				-- "Toggle errors" button.
			create errors_button.make
			errors_button.set_pixmap (stock_pixmaps.general_error_icon)
			errors_button.set_pixel_buffer (stock_pixmaps.general_error_icon_buffer)
			errors_button.enable_select
			errors_button.select_actions.extend (agent on_update_visiblity)

				-- "Toggle warnings" button.
			create warnings_button.make
			warnings_button.set_pixmap (stock_pixmaps.general_warning_icon)
			warnings_button.set_pixel_buffer (stock_pixmaps.general_warning_icon_buffer)
			warnings_button.enable_select
			warnings_button.select_actions.extend (agent on_update_visiblity)

				-- "Toggle suggestions" button.
			create suggestions_button.make
			suggestions_button.set_pixmap (stock_pixmaps.view_editor_icon)
			suggestions_button.set_pixel_buffer (stock_pixmaps.view_editor_icon_buffer)
			suggestions_button.enable_select
			suggestions_button.select_actions.extend (agent on_update_visiblity)

				-- "Toggle hints" button.
			create hints_button.make
			hints_button.set_pixmap (stock_pixmaps.general_information_icon)
			hints_button.set_pixel_buffer (stock_pixmaps.general_information_icon_buffer)
			hints_button.enable_select
			hints_button.select_actions.extend (agent on_update_visiblity)

			update_button_titles

				-- Scope label.
			create scope_label.make_with_text (ca_names.analysis_not_run)
			scope_label.set_foreground_color (dark_gray)

			create Result.make (5)
				-- Button to analyze whole system.
			whole_system_button := l_helper.ca_command.new_whole_system_toolbar_item (True)
			Result.extend (whole_system_button)
				-- Button to analyze current item or dropped stone.
			current_item_button := l_helper.ca_command.new_sd_toolbar_item (True)
			Result.extend (current_item_button)
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
				-- Label to display last analyzed scope.
			Result.extend (errors_button)
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
			Result.extend (warnings_button)
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
			Result.extend (suggestions_button)
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
			Result.extend (hints_button)
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
		end

	create_mini_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			create Result.make_from_array (<<create {SD_TOOL_BAR_WIDGET_ITEM}.make (scope_label)>>)
		end

	create_right_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_prev_button, l_next_button, l_clear_filter: SD_TOOL_BAR_BUTTON
			l_box: EV_HORIZONTAL_BOX
		do
				-- "Move to previous error" button.
			create l_prev_button.make
			l_prev_button.set_pixmap (stock_pixmaps.view_previous_icon)
			l_prev_button.set_tooltip (ca_names.go_to_previous_tooltip)
			l_prev_button.select_actions.extend (agent go_to_previous_violation)

				-- "Move to next error" button.
			create l_next_button.make
			l_next_button.set_pixmap (stock_pixmaps.view_next_icon)
			l_next_button.set_tooltip (ca_names.go_to_next_tooltip)
			l_next_button.select_actions.extend (agent go_to_next_violation)

				-- Preferences button.

			show_preferences_button := (create {ES_CA_SHOW_PREFERENCES_COMMAND}.make).new_sd_toolbar_item (True)

				-- Text field and button for filter.

			create l_box
			l_box.extend (create {EV_LABEL}.make_with_text (ca_names.tool_text_filter))
			l_box.disable_item_expand (l_box.last)
			create text_filter
			text_filter.key_release_actions.force_extend (agent on_update_visiblity)
			text_filter.set_minimum_width_in_characters (10)
			l_box.extend (text_filter)
			l_box.disable_item_expand (text_filter)
			create l_clear_filter.make
			l_clear_filter.set_pixmap (stock_mini_pixmaps.general_delete_icon)
			l_clear_filter.pointer_button_press_actions.force_extend (
				agent
					do
						text_filter.set_text ("")
						on_update_visiblity
					end
				)

				-- Adding the controls to the tool bar.
			create Result.make (7)
			Result.extend (create {SD_TOOL_BAR_RESIZABLE_ITEM}.make (l_box))
			Result.extend (l_clear_filter)
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
			Result.extend (l_prev_button)
			Result.extend (l_next_button)
			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
			Result.extend (show_preferences_button)
		end

	build_tool_interface (a_widget: ES_GRID)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		local
			l_col: EV_GRID_COLUMN
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_widget)

				-- Enable scrollbars.
			a_widget.show_horizontal_scroll_bar
			a_widget.show_vertical_scroll_bar

				-- Create columns.
			a_widget.set_column_count_to (last_column)

			l_col := a_widget.column (category_column)
			l_col.set_width (40)

			l_col := a_widget.column (description_column)
			l_col.set_title (ca_names.description_column)
			l_col.set_width (500)

			l_col := a_widget.column (class_column)
			l_col.set_title (ca_names.class_column)
			l_col.set_width (120)

			l_col := a_widget.column (location_column)
			l_col.set_title (ca_names.location_column)
			l_col.set_width (80)

			l_col := a_widget.column (rule_id_column)
			l_col.set_title (ca_names.rule_id_column)
			l_col.set_width (120)

			l_col := a_widget.column (severity_score_column)
			l_col.set_title (ca_names.severity_score_column)
			l_col.set_width (50)

			a_widget.enable_tree
			a_widget.disable_row_height_fixed
			a_widget.enable_auto_size_best_fit_column (description_column)

				-- Enable sorting.
			enable_sorting_on_columns (
				<<
					a_widget.column (category_column),
					a_widget.column (severity_score_column),
					a_widget.column (class_column),
					a_widget.column (location_column),
					a_widget.column (description_column),
					a_widget.column (rule_id_column)
				>>)
		end

feature -- Access

	whole_system_button, current_item_button: EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Button to execute Code Analysis.

	show_preferences_button: EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Button to display preferences dialog.

	error_count: INTEGER
			-- Number of error events

	warning_count: INTEGER
			-- Number of warning events

	suggestion_count: INTEGER
			-- Number of suggestion events

	hint_count: INTEGER
			-- Number of hint events

feature -- Status report

	show_errors: BOOLEAN
			-- Should errors be shown?
		do
			Result := not is_initialized or else errors_button.is_selected
		end

	show_warnings: BOOLEAN
			-- Should warnings be shown?
		do
			Result := not is_initialized or else warnings_button.is_selected
		end

	show_suggestions: BOOLEAN
			-- Should suggestions be shown?
		do
			Result := not is_initialized or else suggestions_button.is_selected
		end

	show_hints: BOOLEAN
			-- Should hints be shown?
		do
			Result := not is_initialized or else hints_button.is_selected
		end

	is_item_visible (a_item: EV_GRID_ROW): BOOLEAN
			-- Is `a_item' visible?
		local
			l_text: STRING_32
		do
			Result := True
			if attached {CA_EXCEPTION_EVENT} a_item.data as l_exception then
				if not show_errors then Result := False end
			elseif attached {CA_RULE_VIOLATION_EVENT} a_item.data as l_viol then
				if is_error_event (l_viol) and not show_errors then
					Result := False
				elseif is_warning_event (l_viol) and not show_warnings then
					Result := False
				elseif is_suggestion_event (l_viol) and not show_suggestions then
					Result := False
				elseif is_hint_event (l_viol) and not show_hints then
					Result := False
				else
					l_text := text_filter.text.as_lower
					if
						not l_text.is_empty and then
						not l_viol.title.as_lower.has_substring (l_text) and then
						not l_viol.rule_id.as_lower.has_substring (l_text) and then
						not l_viol.affected_class.name.as_lower.has_substring (l_text) and then
						not l_viol.violation_description.as_lower.has_substring (l_text)
					then
						Result := False
					end
				end
			end
		end

	frozen is_event_list_synchronized_on_initialized: BOOLEAN
			-- <Precursor>

	frozen is_event_list_scrolled_automatically: BOOLEAN
			-- <Precursor>

feature {NONE} -- User interface items

	errors_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide errors.

	warnings_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide warnings.

	suggestions_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide suggestions.

	hints_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide hints.

	text_filter: EV_TEXT_FIELD
			-- Text field to enter filter

feature {ES_CODE_ANALYSIS_COMMAND} -- UI Items

	scope_label: EV_LABEL
			-- Label showing the scope of the last analysis.

feature {NONE} -- Events

	on_event_item_added (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_applicable: BOOLEAN
		do
			l_applicable := is_appliable_event (a_event_item)
			if l_applicable and not is_initialized then
					-- We have to perform initialization to set the icon and counter.
					-- Synchronization with the event list service is surpress to prevent duplication of event items being added.
				is_event_list_synchronized_on_initialized := True
				initialize
			end
			if l_applicable then
				if is_error_event (a_event_item) or attached {CA_EXCEPTION_EVENT} a_event_item then
					error_count := error_count + 1
				elseif is_warning_event (a_event_item) then
					warning_count := warning_count + 1
				elseif is_suggestion_event (a_event_item) then
					suggestion_count := suggestion_count + 1
				elseif is_hint_event (a_event_item) then
					hint_count := hint_count + 1
				else
					check is_ok_event (a_event_item) end
				end

				update_button_titles

				Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_service, a_event_item)
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
				is_event_list_synchronized_on_initialized := True
				initialize
			end
			if l_applicable then
				if is_error_event (a_event_item) or attached {CA_EXCEPTION_EVENT} a_event_item then
					error_count := error_count - 1
				elseif is_warning_event (a_event_item) then
					warning_count := warning_count - 1
				elseif is_suggestion_event (a_event_item) then
					suggestion_count := suggestion_count - 1
				elseif is_hint_event (a_event_item) then
					hint_count := hint_count - 1
				else
					check is_ok_event (a_event_item) end
				end

				update_button_titles

				Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_service, a_event_item)
			end
		ensure then
			is_initialized: is_appliable_event (a_event_item) implies is_initialized
		end

	on_update_visiblity
			-- Called when visibility settings change
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_row: EV_GRID_ROW
			l_count, i: INTEGER
		do
			from
				i := 1
				l_count := grid_events.row_count
			until
				i > l_count
			loop
				l_row := grid_events.row (i)
				if is_item_visible (l_row) then
					l_row.show
				else
					l_row.hide
				end
				i := i + 1
			end
		end

feature {NONE} -- Query

	is_appliable_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' can be shown with the current event list tool
		do
			Result := attached {CA_RULE_VIOLATION_EVENT} a_event_item
						or attached {CA_NO_ISSUES_EVENT} a_event_item
						or attached {CA_EXCEPTION_EVENT} a_event_item
		end

	is_error_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to an error?
		do
			Result :=
				attached {CA_RULE_VIOLATION_EVENT} a_event_item as l_ev
				and then l_ev.is_error_event
		end

	is_warning_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to a warning?
		do
			Result :=
				attached {CA_RULE_VIOLATION_EVENT} a_event_item as l_ev
				and then l_ev.is_warning_event
		end

	is_suggestion_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to a suggestion?
		do
			Result := attached {CA_RULE_VIOLATION_EVENT} a_event_item as l_ev
			and then l_ev.is_suggestion_event
		end

	is_hint_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to a hint?
		do
			Result := attached {CA_RULE_VIOLATION_EVENT} a_event_item as l_ev
			and then l_ev.is_hint_event
		end

	is_ok_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Does event `a_event_item' correspond to a "no issue" event?
		do
			Result := attached {CA_NO_ISSUES_EVENT} a_event_item
		end

feature {NONE} -- Basic operations

	do_default_action (a_row: EV_GRID_ROW)
			-- <Precursor>
		local
			l_stone: STONE
		do
			if attached {CA_EXCEPTION_EVENT} a_row.parent_row_root.data as l_exception then
				raise_default_exception_dialog (create {EV_DIALOG}, l_exception.data.ex)
			elseif attached {CA_RULE_VIOLATION_EVENT} a_row.parent_row_root.data as l_event_item then
				if attached l_event_item.location as l_loc then
					create {COMPILED_LINE_STONE} l_stone.make_with_line (l_event_item.affected_class, l_loc.line, True)
				else
					create {CLASSC_STONE} l_stone.make (l_event_item.affected_class)
				end
			end
			if l_stone /= Void and then l_stone.is_valid then
				(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
			end
		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW)
			-- Populates a grid row's item on a given row using the event `a_event_item'.
			--
			-- `a_event_item': A event to base the creation of a grid row on.
			-- `a_row': The row to create items on.
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_gen, l_message_gen: EB_EDITOR_TOKEN_GENERATOR
			l_label: EV_GRID_LABEL_ITEM
			l_pos_token: EDITOR_TOKEN_NUMBER
			l_line: EIFFEL_EDITOR_LINE
		do
			a_row.set_data (a_event_item)

			if attached {CA_NO_ISSUES_EVENT} a_event_item as l_noissues then
				create l_label
				l_label.disable_full_select
				l_label.set_pixmap (stock_pixmaps.general_tick_icon)
				a_row.set_item (category_column, l_label)

				create l_label.make_with_text (ca_messages.no_issues)
				a_row.set_item (description_column, l_label)

			elseif attached {CA_EXCEPTION_EVENT} a_event_item as l_exception then

					-- Severity is error:
				create l_label
				l_label.disable_full_select
				l_label.set_pixmap (stock_pixmaps.general_error_icon)
				l_label.set_data ("Error")
				a_row.set_background_color (error_bg_color)
				a_row.set_item (category_column, l_label)

					-- Set affected class:
				create l_gen.make
				l_exception.data.cl.append_name (l_gen)
				l_editor_item := create_clickable_grid_item (l_gen.last_line, True)
				a_row.set_item (class_column, l_editor_item)

					-- Generic description:
				create l_label.make_with_text (ca_messages.error)
				a_row.set_item (description_column, l_label)

			elseif attached {CA_RULE_VIOLATION_EVENT} a_event_item as l_viol then

					-- Severity category
				create l_label
				l_label.disable_full_select
				if is_error_event (l_viol) then
					l_label.set_pixmap (stock_pixmaps.general_error_icon)
					l_label.set_data ("Error")
					a_row.set_background_color (error_bg_color)
				elseif is_warning_event (l_viol) then
					l_label.set_pixmap (stock_pixmaps.general_warning_icon)
					l_label.set_data ("Warning")
					a_row.set_background_color (warning_bg_color)
				elseif is_suggestion_event (l_viol) then
					l_label.set_pixmap (stock_pixmaps.view_editor_icon)
					l_label.set_data ("Suggestion")
					a_row.set_background_color (suggestion_bg_color)
				elseif is_hint_event (l_viol) then
					l_label.set_pixmap (stock_pixmaps.general_information_icon)
					l_label.set_data ("Hint")
					a_row.set_background_color (hint_bg_color)
				end

				a_row.set_item (category_column, l_label)

					-- Info
				create l_message_gen.make
				l_message_gen.add (l_viol.title)
				l_editor_item := create_clickable_grid_item (l_message_gen.last_line, True)
				l_editor_item.pointer_button_release_actions.extend (agent show_fixes_context_menu (l_viol.data.fixes, a_row, ?, ?, ?, ?, ?, ?, ?, ?))
				a_row.set_height (l_editor_item.required_height_for_text_and_component)
				a_row.set_item (description_column, l_editor_item)

				create l_label.make_with_text (l_viol.rule_id)
				a_row.set_item (rule_id_column, l_label)

				create l_label.make_with_text (l_viol.severity_score.out)
				a_row.set_item (severity_score_column, l_label)

					-- Class
				create l_gen.make
				l_viol.affected_class.append_name (l_gen)
				l_editor_item := create_clickable_grid_item (l_gen.last_line, True)
				a_row.set_item (class_column, l_editor_item)

					-- Location
				if attached l_viol.location as l_loc then
					create l_pos_token.make (l_viol.location.line.out + ", " + l_viol.location.column.max (1).out)
					l_pos_token.set_is_clickable (True)
					l_pos_token.set_pebble (create {COMPILED_LINE_STONE}.make_with_line (l_viol.affected_class, l_viol.location.line, True))
				else -- No location attached.
					create l_pos_token.make ("")
				end
--					-- Create editor item.
				create l_line.make_unix_style
				l_line.append_token (l_pos_token)
				l_editor_item := create_clickable_grid_item (l_line, False)
					-- No extra initialization needed so update `l_editor_item' to reflect settings.
				l_editor_item.try_call_setting_change_actions
				a_row.set_item (location_column, l_editor_item)

				insert_subrow (a_row, l_viol)
			else
				check False end
			end

			if not is_item_visible (a_row) then
				a_row.hide
			end
		end

	show_fixes_context_menu (a_fixes: attached LINKED_LIST [CA_FIX]; a_row: EV_GRID_ROW; x: INTEGER; y: INTEGER; button: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER)
			-- Show a context menu for data row `a_row' where the user can choose from fixes in `a_fixes'.
			-- If `button' is not set to `3' (right mouse button) then no context menu will be shown. All
			-- the other arguments are required by the mouse button event and are ignored.
		local
			l_menu: EV_MENU
			l_item: EV_MENU_ITEM
			l_fix_executor: ES_CA_FIX_EXECUTOR
		do
				-- Only process right clicks (`button = 3').
			if button = 3 and then not a_fixes.is_empty then
				create l_menu

				across a_fixes as l_fixes loop
						-- Only make fixes available that have not been applied already.
					if not l_fixes.item.applied then
						create l_fix_executor.make_with_fix (l_fixes.item, a_row)
						create l_item.make_with_text_and_action (ca_messages.fix + l_fixes.item.caption,
						                                         agent l_fix_executor.apply_fix)
						l_menu.extend (l_item)
					end
				end

				l_menu.show
			end
		end

	insert_subrow (a_parent: EV_GRID_ROW; a_viol: CA_RULE_VIOLATION_EVENT)
			-- Insert a new subrow into `a_parent' for `a_viol'.
		local
			l_index: INTEGER
			l_row: EV_GRID_ROW
			l_text_gen: EB_EDITOR_TOKEN_GENERATOR
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_index := a_parent.subrow_count + 1

			a_parent.insert_subrow (l_index)
			l_row := a_parent.subrow (l_index)

			l_row.set_item (class_column, create {EV_GRID_LABEL_ITEM})
			l_row.set_item (location_column, create {EV_GRID_LABEL_ITEM})

			create l_text_gen.make
			l_text_gen.enable_multiline
			a_viol.format_description (l_text_gen)
			l_text_gen.add_new_line
			l_editor_item := create_multiline_clickable_grid_item (l_text_gen.lines, True, False)
			l_editor_item.set_tooltip (a_viol.data.rule.description)
			l_row.set_height (l_editor_item.required_height_for_text_and_component)
			l_row.set_item (description_column, l_editor_item)
			l_row.set_height (l_row.height + 2)
			grid_events.grid_row_fill_empty_cells (l_row)
		end

	update_button_titles
			-- Update button titles with number of events.
		do
			errors_button.set_text (ca_names.tool_errors (error_count))
			warnings_button.set_text (ca_names.tool_warnings (warning_count))
			suggestions_button.set_text (ca_names.tool_suggestions (suggestion_count))
			hints_button.set_text (ca_names.tool_hints (hint_count))
		end

	find_event_row (a_event_item: EVENT_LIST_ITEM_I): detachable EV_GRID_ROW
			-- <Precursor>
		local
			l_grid: like grid_events
			l_row: EV_GRID_ROW
			i: INTEGER
		do
			l_grid := grid_events
			from
					-- Count backwards as it is more optimal for use in item insertion/removal.
				i := l_grid.row_count
			until
				i = 0
			loop
				l_row := l_grid.row (i)
				if l_row.data = a_event_item then
					Result := l_row
					i := 0
				else
					i := i - 1
				end
			end
		end

	go_to_next_violation
			-- Navigates to the next rule violation.
		do
			move_next (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						do
							Result := True
						end)
		end

	go_to_previous_violation
			-- Navigates to the previous rule violation.
		do
			move_previous (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
							do
								Result := True
							end)
		end

feature {NONE} -- Exception Info



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
			l_exception_message: READABLE_STRING_GENERAL
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
			if attached an_exception.description as l_message then
				l_exception_message := l_message
			else
				l_exception_message := ""
			end
			a_empty_dialog.set_title (ca_messages.inspector_eiffel_exception + l_exception_message)
			a_empty_dialog.set_minimum_height (350)
			a_empty_dialog.set_size (500, 300)
			a_empty_dialog.raise
				--| FIXME Behavior would be better if dialog has full application modality.

				-- Set "Ignore" as the default
			l_ignore.set_focus
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if
				is_initialized
				and then session_manager.is_service_available
				and then session_data.session_connection.is_connected (Current)
			then
				session_data.session_connection.disconnect_events (Current)
			end

			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE}
		end

feature {NONE} -- Colors

	error_bg_color: EV_COLOR
			-- Background color for errors.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
		do
			create l_helper
			Result := l_helper.ca_command.error_bgcolor.value
		ensure
			valid_result: Result /= Void
		end

	warning_bg_color: EV_COLOR
			-- Background color for errors.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
		do
			create l_helper
			Result := l_helper.ca_command.warning_bgcolor.value
		ensure
			valid_result: Result /= Void
		end

	suggestion_bg_color: EV_COLOR
			-- Background color for errors.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
		do
			create l_helper
			Result := l_helper.ca_command.suggestion_bgcolor.value
		ensure
			valid_result: Result /= Void
		end

	hint_bg_color: EV_COLOR
			-- Background color for errors.
		local
			l_helper: ES_CODE_ANALYSIS_BENCH_HELPER
		do
			create l_helper
			Result := l_helper.ca_command.hint_bgcolor.value
		ensure
			valid_result: Result /= Void
		end

	dark_gray: EV_COLOR
			-- Dark gray color (e. g. for font foreground).
		do
			create Result.make_with_8_bit_rgb (100, 100, 100)
		ensure
			valid_result: Result /= Void
		end

feature {NONE} -- Constants

	category_column: INTEGER = 1
	class_column: INTEGER = 2
	location_column: INTEGER = 3
	description_column: INTEGER = 4
	rule_id_column: INTEGER = 5
	severity_score_column: INTEGER = 6
	last_column: INTEGER = 6

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
