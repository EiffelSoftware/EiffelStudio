indexing
	description: "[
		An event list service {EVENT_LIST_S} tool to show all errors and warning event items in a single list in the EiffelStudio UI
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_ERROR_LIST_TOOL_PANEL

inherit
	ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE
		redefine
			build_tool_interface,
			internal_recycle,
			create_right_tool_bar_items,
			is_appliable_event,
			surpress_synchronization,
			on_event_added,
			on_event_removed,
			update_content_applicable_widgets,
			show
		end

	ES_ERROR_LIST_COMMANDER_I
		export
			{ES_ERROR_LIST_COMMAND} all
		end

	SHARED_ERROR_TRACER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Iniitalization

	 build_tool_interface (a_widget: ES_GRID) is
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		local
			l_col: EV_GRID_COLUMN
			l_session: SESSION_I
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_widget)
			a_widget.set_column_count_to (position_column)

				-- Create columns
			l_col := a_widget.column (1)
			l_col.set_width (20)
			l_col := a_widget.column (category_column)
			l_col.set_width (20)

			l_col := a_widget.column (error_column)
			l_col.set_title (interface_names.l_description)
			l_col.set_width (100)

			l_col := a_widget.column (context_column)
			l_col.set_title (interface_names.l_location)
			l_col.set_width (200)

			l_col := a_widget.column (position_column)
			l_col.set_title (interface_names.l_position)
			l_col.set_width (80)

			a_widget.enable_tree
			a_widget.disable_row_height_fixed
			a_widget.enable_auto_size_best_fit_column (error_column)
			a_widget.enable_multiple_row_selection
			a_widget.item_deactivate_actions.extend (agent (a_row: EV_GRID_ITEM)
				do
						-- Updates UI based on selection and row count.
					update_content_applicable_widgets (grid_events.row_count > 0)
				end)
			a_widget.row_select_actions.extend (agent (a_row: EV_GRID_ROW)
				do
						-- Updates UI based on selection and row count.
					update_content_applicable_widgets (grid_events.row_count > 0)
				end)

				-- Enable sorting
			enable_sorting_on_columns (<<a_widget.column (category_column),
				a_widget.column (error_column),
				a_widget.column (context_column),
				a_widget.column (position_column)>>)

				-- Enable copying to clipboard
			enable_copy_to_clipboard

				-- Bind redirecting pick and drop actions
			stone_director.bind (a_widget)

				-- Set UI based on initial state
			update_content_applicable_navigation_buttons

				-- Hook up events for session data
			if session_manager.is_service_available then
				l_session := session_manager.service.retrieve (False)
				l_session.value_changed_event.subscribe (agent on_session_value_changed)
				if {l_expand: !BOOLEAN_REF} l_session.value_or_default (expand_errors_session_id, False) then
					expand_errors := l_expand.item
					if expand_errors then
						expand_errors_button.enable_select
					else
						expand_errors_button.disable_select
					end
				end
			end
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Recycle tool.
		do
			if is_initialized then
				stone_director.unbind (grid_events)

				filter_widget.filter_changed_actions.prune (agent on_warnings_filter_changed)
				errors_button.select_actions.prune (agent on_toogle_errors_button)
				warnings_button.select_actions.prune (agent on_toogle_warnings_button)

				if session_manager.is_service_available then
					session_manager.service.retrieve (False).value_changed_event.unsubscribe (agent on_session_value_changed)
				end

			end
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE}
		end

feature -- Access

	error_count: NATURAL
			-- Number of errors

	warning_count: NATURAL
			-- Number of warnings

feature -- Status report

	show_errors: BOOLEAN
			-- Indicates if errors should be shown
		do
			Result := not is_initialized or else errors_button.is_selected
		end

	show_warnings: BOOLEAN
			-- Indicates if errors should be shown
		do
			Result := not is_initialized or else warnings_button.is_selected
		end

	expand_errors: BOOLEAN
			-- Indicates if errors should be shown automatically

feature {NONE} -- Status report

	is_expanding_all_errors: BOOLEAN
			-- Indicates if the errors are being expanded, as a result of the expand errors button being pressed.

	frozen surpress_synchronization: BOOLEAN
			-- State to indicate if synchonization with the event list service should be suppressed
			-- when initializing.

feature {NONE} -- User interface items

	errors_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide error events

	warnings_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide warning events

	expand_errors_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to expanded error events automatically

	error_info_button: SD_TOOL_BAR_BUTTON
			-- Error information button

	filter_button: SD_TOOL_BAR_POPUP_BUTTON
			-- Filter button to filter information in list

	filter_widget: ES_WARNINGS_FILTER_WIDGET
			-- Filter widget

feature {NONE} -- Command items

	error_info_command: EB_ERROR_INFORMATION_CMD
			-- Error information command

	go_to_next_error_command: ES_NEXT_ERROR_COMMAND
			-- Go to next error command
		do
			Result := develop_window.commands.go_to_next_error_command
		ensure
			result_attached: Result /= Void
		end

	go_to_previous_error_command: ES_PREVIOUS_ERROR_COMMAND
			-- Go to previous error command
		do
			Result := develop_window.commands.go_to_previous_error_command
		ensure
			result_attached: Result /= Void
		end

	go_to_next_warning_command: ES_NEXT_WARNING_COMMAND
			-- Go to next warning command
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
			a_row_data_set: ({EVENT_LIST_ITEM_I}) #? a_row.data /= Void
		local
			l_event_item: EVENT_LIST_ITEM_I
			l_error: ERROR
			l_line: INTEGER
			l_classi_stone: CLASSI_STONE
			l_classc_stone: CLASSC_STONE
			l_line_stone: LINE_STONE
		do
			l_event_item ?= a_row.data
			if l_event_item /= Void then
				Result ?= a_row.item (context_column).data
				if Result /= Void then
					l_error ?= l_event_item.data
					if l_error /= Void then
						l_line := l_error.line
						if l_line > 0 then
							l_classc_stone ?= Result
							if l_classc_stone /= Void then
								create {COMPILED_LINE_STONE}Result.make_with_line (l_classc_stone.e_class, l_line, True)
							else
								l_classi_stone ?= Result
								create {UNCOMPILED_LINE_STONE}Result.make_with_line (l_classi_stone.class_i, l_line, True)
							end
							l_line_stone ?= Result
							if l_line_stone /= Void then
								l_line_stone.set_should_line_be_selected (True)
								if l_error.column > 0 then
									l_line_stone.set_column_number (l_error.column)
								end
							end
						end
					end
				end
			end
		end

	is_appliable_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' can be shown with the current event list tool
		do
			Result := is_error_event (a_event_item) or is_warning_event (a_event_item)
		end

	is_error_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' is an error event
		do
			if a_event_item.type = {EVENT_LIST_ITEM_TYPES}.error and then {l_error: !EVENT_LIST_ERROR_ITEM_I} a_event_item then
				Result := not l_error.is_warning
			end
		ensure
			not_is_warning_event: Result implies not is_warning_event (a_event_item)
		end

	is_warning_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' is an error event
		require
			a_event_item_attached: a_event_item /= Void
		do
			if a_event_item.type = {EVENT_LIST_ITEM_TYPES}.error and then {l_error: !EVENT_LIST_ERROR_ITEM_I} a_event_item then
				Result := l_error.is_warning
			end
		ensure
			not_is_error_event: Result implies not is_error_event (a_event_item)
		end

feature {ES_ERROR_LIST_TOOL} -- Navigation

	go_to_next_error (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if show_errors then
				if error_count > 0 then
					move_next (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_error_event (a_item) and then
								(event_context_stone (a_item) /= Void or
									-- C compiler errors have not context stone so we need to account for this.
								({C_COMPILER_ERROR}) #? a_item.data /= Void)
						end)
				end
			end
		end

	go_to_previous_error (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if show_errors then
				if error_count > 0 then
					move_previous (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_error_event (a_item) and then
								(event_context_stone (a_item) /= Void or
									-- C compiler errors have not context stone so we need to account for this.
								({C_COMPILER_ERROR}) #? a_item.data /= Void)
						end)
				end
			end
		end

	go_to_next_warning (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if show_warnings then
				if warning_count > 0 then
					move_next (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_warning_event (a_item) and then event_context_stone (a_item) /= Void
						end)
				end
			end
		end

	go_to_previous_warning (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if show_warnings then
				if warning_count > 0 then
					move_previous (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_warning_event (a_item) and then event_context_stone (a_item) /= Void
						end)
				end
			end
		end

feature {NONE} -- Basic operations

	do_default_action (a_row: EV_GRID_ROW)
			-- <Precursor>
		local
			l_event_item: EVENT_LIST_ITEM_I
			l_stone: STONE
			l_error: C_COMPILER_ERROR
			l_tool: ES_C_OUTPUT_TOOL_PANEL
		do
			l_event_item ?= a_row.data
			if l_event_item /= Void then
				l_error ?= l_event_item.data
				if l_error /= Void then
						-- Show the C/C++ compiler output
					l_tool ?= develop_window.shell_tools.tool ({ES_C_OUTPUT_TOOL}).panel
					if l_tool /= Void then
						l_tool.scroll_to_end
						l_tool.force_display
					end
				else
					l_stone := event_context_stone_from_row (a_row)
					if l_stone /= Void and then l_stone.is_valid then
						(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
					end
				end
			end
		end

feature {NONE} -- Events

	on_event_added (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_applicable: BOOLEAN
		do
			l_applicable := is_appliable_event (a_event_item)
			if l_applicable and not is_initialized then
					-- We have to perform initialization to set the icon and counter.
					-- Synchronization with the event list service is surpress to prevent duplication of event items being added.
				surpress_synchronization := True
				initialize
			end

			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_service, a_event_item)

			if l_applicable then
				if is_error_event (a_event_item) then
					set_error_count (error_count + 1)
				elseif is_warning_event (a_event_item) then
					set_warning_count (warning_count + 1)
				else
					check False end
				end
				update_content_applicable_navigation_buttons
			end
		ensure then
			is_initialized: is_appliable_event (a_event_item) implies is_initialized
		end

	on_event_removed (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I) is
			-- <Precursor>
		local
			l_applicable: BOOLEAN
		do
			l_applicable := is_appliable_event (a_event_item)
			if l_applicable and not is_initialized then
					-- We have to perform initialization to set the icon and counter
					-- Synchronization with the event list service is surpress to prevent duplication of event items being added.
				surpress_synchronization := True
				initialize
			end

			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_service, a_event_item)
			if l_applicable then
				if is_error_event (a_event_item) then
					set_error_count (error_count - 1)
				elseif is_warning_event (a_event_item) then
					set_warning_count (warning_count - 1)
				else
					check False end
				end
				update_content_applicable_navigation_buttons
			end
		ensure then
			is_initialized: is_appliable_event (a_event_item) implies is_initialized
		end

	on_toogle_errors_button is
			-- Called when `errors_button' is selected
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_row: EV_GRID_ROW
			l_event_item: EVENT_LIST_ITEM_I
			l_count, i: INTEGER
		do
			from
				i := 1
				l_count := grid_events.row_count
			until
				i > l_count
			loop
				l_row := grid_events.row (i)
				l_event_item ?= l_row.data
				if l_event_item /= Void then
					if is_error_event (l_event_item) then
						if show_errors then
							l_row.show
						else
							l_row.hide
						end
					end
				end
				i := i + 1
			end

			update_content_applicable_navigation_buttons
		end

	on_toogle_warnings_button is
			-- Called when `warnings_button' is selected
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_row: EV_GRID_ROW
			l_event_item: EVENT_LIST_ITEM_I
			l_warning: ERROR
			l_filter_widget: like filter_widget
			l_show: BOOLEAN
			l_count, i: INTEGER
		do
			l_filter_widget := filter_widget
			l_show := show_warnings
			from
				i := 1
				l_count := grid_events.row_count
			until
				i > l_count
			loop
				l_row := grid_events.row (i)
				l_event_item ?= l_row.data
				if l_event_item /= Void then
					if is_warning_event (l_event_item) then
						l_warning ?= l_event_item.data
						check l_warning_attached: l_warning /= Void end
						if l_warning /= Void and then l_show and l_filter_widget.is_unfiltered (l_warning) then
							l_row.show
						else
							l_row.hide
						end
					end
				end
				i := i + 1
			end

			update_content_applicable_navigation_buttons
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
			l_event_item: EVENT_LIST_ERROR_ITEM_I
			l_count, i: INTEGER
		do
			l_expand := expand_errors_button.is_selected
			if expand_errors /= l_expand then
				is_expanding_all_errors := l_expand
				expand_errors := l_expand
				if session_manager.is_service_available then
					session_manager.service.retrieve (False).set_value (l_expand, expand_errors_session_id)
				end

					-- Set applicable grid items and open/closed because on expanded status
				l_grid := grid_events
				from
					i := 1
					l_count := l_grid.row_count
				until
					i > l_count
				loop
					l_row := l_grid.row (i)
					if l_row.is_expandable then
						l_event_item ?= l_row.data
						if l_event_item /= Void and then is_error_event (l_event_item) then
							if l_expand then
								l_row.expand
							else
								l_row.collapse
							end
						end
					end
					i := i + 1
				end
				is_expanding_all_errors := False
			end
		ensure
			expand_errors_set: expand_errors = expand_errors_button.is_selected
			not_is_expanding_all_errors: not is_expanding_all_errors
		end

	on_expand_event_row (a_row: EV_GRID_ROW) is
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
			if not is_expanding_all_errors then
				grid_events.selected_rows.do_all (agent {EV_GRID_ROW}.disable_select)
				a_row.enable_select
				if a_row.subrow_count > 0 then
						-- Ensure the row is visible.
					a_row.subrow (1).ensure_visible
				end
			end
		end

	on_error_info
			-- Call when the error information button is clicked.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_event: EVENT_LIST_ITEM_I
			l_error: ERROR
		do
			if not grid_events.selected_rows.is_empty then
					-- Retrieve event item set from {ES_EVENT_LIST_TOOL_PANEL_BASE}.on_event_added
				l_event ?= grid_events.selected_rows.first.data
				if l_event /= Void then
						-- Now retrieve error item
					l_error ?= l_event.data
					check
						l_error_attached: l_error /= Void
					end

				end
			end

			if l_error = Void then
					-- No error found. This can happen when the expanded information row is selected.
				error_info_command.execute
			else
				error_info_command.execute_with_stone (create {ERROR_STONE}.make (l_error))
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
			l_event: EVENT_LIST_ITEM_I
			l_warning: ERROR
			l_count, i: INTEGER
		do
			l_filter := filter_widget
			l_grid := grid_events
			from l_count := l_grid.row_count; i := 1 until i > l_count loop
				l_row := l_grid.row (i)
				if a_exclude /= not l_row.is_show_requested then
					l_event ?= l_row.data
					if l_event /= Void and then is_warning_event (l_event) then
						l_warning ?= l_event.data
						if l_warning /= Void then
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

	on_session_value_changed (a_session: SESSION; a_id: STRING_8) is
			-- Called when the session changes
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_session_attached: a_session /= Void
			a_session_is_interface_usable: a_session.is_interface_usable
		do
			if a_id.is_equal (expand_errors_session_id) then
					-- Retrieve global session
				if {l_expand: !BOOLEAN_REF} a_session.value_or_default (expand_errors_session_id, False) then
					if expand_errors /= l_expand.item then
						expand_errors := l_expand.item
						if expand_errors then
							expand_errors_button.enable_select
						else
							expand_errors_button.disable_select
						end
						on_toggle_expand_errors_button
					end
				end
			end
		end

feature {NONE} -- Factory

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Available tool bar items
		do
			create errors_button.make
			errors_button.set_text (("0 ").as_string_32 + interface_names.b_errors.as_string_32)
			errors_button.set_pixmap (stock_pixmaps.tool_error_icon)
			errors_button.set_pixel_buffer (stock_pixmaps.tool_error_icon_buffer)
			errors_button.enable_select
			errors_button.select_actions.extend (agent on_toogle_errors_button)
			errors_button.select_actions.compare_objects

			create warnings_button.make
			warnings_button.set_text (("0 ").as_string_32 + interface_names.b_warnings.as_string_32)
			warnings_button.set_pixmap (stock_pixmaps.tool_warning_icon)
			warnings_button.set_pixel_buffer (stock_pixmaps.tool_warning_icon_buffer)
			warnings_button.enable_select
			warnings_button.select_actions.extend (agent on_toogle_warnings_button)
			warnings_button.select_actions.compare_objects

			create Result.make (3)
			Result.put_last (errors_button)
			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)
			Result.put_last (warnings_button)
		ensure then
			errors_button_attached: errors_button /= Void
			warnings_button_attached: warnings_button /= Void
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Available tool bar items
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (8)

				-- Navigation buttons
			l_button := go_to_next_error_command.new_sd_toolbar_item (False)
			Result.put_last (l_button)

			l_button := go_to_previous_error_command.new_sd_toolbar_item (False)
			Result.put_last (l_button)

			l_button := go_to_next_warning_command.new_sd_toolbar_item (False)
			Result.put_last (l_button)

			l_button := go_to_previous_warning_command.new_sd_toolbar_item (False)
			Result.put_last (l_button)

				-- Separator
			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Automatic expand error button
			create expand_errors_button.make
			expand_errors_button.set_pixmap (stock_pixmaps.errors_and_warnings_expand_errors_icon)
			expand_errors_button.set_pixel_buffer (stock_pixmaps.errors_and_warnings_expand_errors_icon_buffer)
			expand_errors_button.set_tooltip (interface_names.f_toogle_expand_errors)
			expand_errors_button.select_actions.extend (agent on_toggle_expand_errors_button)
			expand_errors_button.select_actions.compare_objects
			Result.put_last (expand_errors_button)

			create error_info_command.make
			error_info_button := error_info_command.new_sd_toolbar_item (False)
				-- We need to do something else, like handle grid selection
			error_info_button.select_actions.wipe_out
			error_info_button.select_actions.extend (agent on_error_info)
			Result.put_last (error_info_button)

				-- Filter pop up widget
			create filter_widget.make
			filter_widget.filter_changed_actions.extend (agent on_warnings_filter_changed)

				-- Filter button
			create filter_button.make
			filter_button.set_pixmap (stock_pixmaps.metric_filter_icon)
			filter_button.set_pixel_buffer (stock_pixmaps.metric_filter_icon_buffer)
			filter_button.set_tooltip (interface_names.f_filter_warnings)
			filter_button.set_popup_widget (filter_widget)

			Result.put_last (filter_button)
		ensure then
			filter_button_attached: filter_button /= Void
		end

feature {NONE} -- User interface manipulation

	show is
			-- Redefine
		local
			l_width: INTEGER
			l_platform: PLATFORM
			l_grid: ES_GRID
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE}

			create l_platform
			if l_platform.is_unix then
				-- This is hack for bug#13604
				l_grid := grid_events
				if l_grid /= Void and then not l_grid.is_destroyed then
					l_width := l_grid.width
				end
			end
		end

	set_error_count (a_count: like error_count)
			-- Sets `error_count' to `a_count'
		local
			l_text: STRING_32
		do
			error_count := a_count
			create l_text.make (20)
			l_text.append_natural_32 (a_count)
			l_text.append_character (' ')
			if a_count = 1 then
				l_text.append_string (interface_names.b_error)
			else
				l_text.append_string (interface_names.b_errors)
			end
			errors_button.set_text (l_text)
			update_tool_title_and_pixmap

		ensure
			error_count_set: error_count = a_count
		end

	set_warning_count (a_count: like warning_count)
			-- Sets `warning_count' to `a_count'
		local
			l_text: STRING_32
		do
			warning_count := a_count
			create l_text.make (20)
			l_text.append_natural_32 (a_count)
			l_text.append_character (' ')
			if a_count = 1 then
				l_text.append_string (interface_names.b_warning)
			else
				l_text.append_string (interface_names.b_warnings)
			end
			warnings_button.set_text (l_text)
			update_tool_title_and_pixmap
		ensure
			warning_count_set: warning_count = a_count
		end

	update_tool_title_and_pixmap is
			-- Sets the tool's title an pixmap based on the number of items existing in the list
		local
			l_title: STRING_32
			l_buffer: EV_PIXEL_BUFFER
		do
			l_title := interface_names.t_errors_and_warnings_tool.twin
			if item_count > 0 then
				l_title := l_title + " (" + error_count.out + "|" + warning_count.out + ")"
				if error_count > 0 and warning_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_errors_and_warnings_icon_buffer
				elseif error_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_errors_icon_buffer
				elseif warning_count > 0 then
					l_buffer := stock_pixmaps.tool_errors_list_with_warnings_icon_buffer
				else
					check False end
				end
			end

			if l_title /= Void and then not l_title.is_empty then
				set_title (l_title)
			end
			if l_buffer /= Void then
				set_icon (l_buffer)
			else
				set_icon (stock_pixmaps.tool_errors_list_with_errors_icon_buffer)
			end
		end

	update_content_applicable_widgets (a_enable: BOOLEAN)
			-- Updates widgets on tool that require content to exist
			--
			-- `a_enable': True to indicate there is content available, False otherwise
		do
			if a_enable and grid_events.selected_rows.count = 1 then
				error_info_command.enable_sensitive
			else
				error_info_command.disable_sensitive
			end
		end

	update_content_applicable_navigation_buttons
			-- Updates content applicable navigation buttons
		do
			if error_count > 0 and errors_button.is_selected then
				go_to_next_error_command.enable_sensitive
				go_to_previous_error_command.enable_sensitive
			else
				go_to_next_error_command.disable_sensitive
				go_to_previous_error_command.disable_sensitive
			end

			if warning_count > 0  and warnings_button.is_selected then
				go_to_next_warning_command.enable_sensitive
				go_to_previous_warning_command.enable_sensitive
			else
				go_to_next_warning_command.disable_sensitive
				go_to_previous_warning_command.disable_sensitive
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
			l_item: EV_GRID_LABEL_ITEM
			l_error: ERROR
			l_tip: EB_EDITOR_TOKEN_TOOLTIP
			l_lines: LIST [EIFFEL_EDITOR_LINE]
			l_content: LIST [EDITOR_TOKEN]
			l_pixmap: EV_PIXMAP
			l_row: EV_GRID_ROW
			l_pos_token: EDITOR_TOKEN_NUMBER
			l_line: EIFFEL_EDITOR_LINE
			l_context_stone: STONE
			l_expanded: BOOLEAN
		do
			create l_item
			a_row.set_item (1, l_item)

				-- Set expand actions
			a_row.expand_actions.extend (agent on_expand_event_row (a_row))

				-- Set category pixmap item
			create l_item
			l_pixmap := category_icon_from_event_item (a_event_item)
			if l_pixmap /= Void then
				l_item.set_pixmap (l_pixmap)

					-- Set string data for pixmap index, so it can be sorted.
				l_item.set_data (a_event_item.category.out)
				l_item.disable_full_select
			end
			a_row.set_item (category_column, l_item)

				-- Set error information
			l_error ?= a_event_item.data
			if l_error /= Void then
				create l_gen.make
				tracer.trace (l_gen, l_error, {ERROR_TRACER}.single_line)

				if l_gen.last_line /= Void and then l_gen.last_line.count > 0 then
					l_editor_item := create_clickable_grid_item (l_gen.last_line)
				else
					create l_editor_item.make_with_text ("No error message found!")
				end
				l_editor_item.disable_full_select
				if is_error_event (a_event_item) then
					l_editor_item.set_pixmap (stock_pixmaps.tool_error_icon)
				elseif is_warning_event (a_event_item) then
					l_editor_item.set_pixmap (stock_pixmaps.tool_warning_icon)
				else
					check False end
				end
				l_editor_item.set_spacing ({ES_UI_CONSTANTS}.grid_editor_item_spacing)
				a_row.set_item (error_column, l_editor_item)

					-- Set row hieght
				a_row.set_height (l_editor_item.label_font_height.max ({ES_UI_CONSTANTS}.grid_row_height))

					-- Build full error text
				create l_gen.make
				l_gen.enable_multiline
				tracer.trace (l_gen, l_error, {ERROR_TRACER}.normal)
				l_lines := l_gen.lines
				if not l_lines.is_empty then
					l_tip := create_clickable_tooltip (l_lines, l_editor_item, a_row)
					a_row.select_actions.extend (agent l_tip.restart_tooltip_timer)

						-- Sub row full error
					a_row.insert_subrow (1)
					l_row := a_row.subrow (1)
					create l_item
					l_item.disable_full_select
					l_row.set_item (category_column, l_item)

					l_editor_item := create_multiline_clickable_grid_item (l_lines, False)
					l_row.set_height (l_tip.required_tooltip_height)
					l_row.set_item (error_column, l_editor_item)
				end

					-- Context
				tracer.trace (l_gen, l_error, {ERROR_TRACER}.context)
				if l_gen.last_line /= Void then
					l_editor_item := create_clickable_grid_item (l_gen.last_line)
					a_row.set_item (context_column, l_editor_item)
					l_content := l_gen.last_line.content
					if not l_content.is_empty then
							-- Set context pebble by iterating through the context content to find a feature
							-- or class token.
						from l_content.finish until l_content.before or l_context_stone /= Void loop
							if {l_ft: !EDITOR_TOKEN_FEATURE} l_content.item_for_iteration then
								l_context_stone ?= l_ft.pebble
							elseif {l_ct: !EDITOR_TOKEN_CLASS} l_content.item_for_iteration then
								l_context_stone ?= l_ct.pebble
							end
							l_content.back
						end
						if l_context_stone /= Void then
							l_editor_item.set_data (l_context_stone)
						end
					end
				end

					-- Line and column number
				l_editor_item := Void
				if l_error.line > 0 and then l_context_stone /= Void then
						-- Created position token
					create l_pos_token.make (l_error.line.out + ", " + l_error.column.max (1).out)
					l_pos_token.set_is_clickable (True)
						-- Note: We call `event_context_stone_from_row' instead of using `l_context_stone' because
						--       it uses line position information, unlike `l_context_stone'
					l_pos_token.set_pebble (event_context_stone_from_row (a_row))

						-- Create editor item					
					create l_line.make_empty_line
					l_line.append_token (l_pos_token)
					l_editor_item := create_clickable_grid_item (l_line)
				end
				a_row.set_item (position_column, l_editor_item)
			end

				-- Fill empty items
			if l_row /= Void then
				grid_events.grid_row_fill_empty_cells (l_row)
				l_row.set_height (l_row.height + 2)
			end
			grid_events.grid_row_fill_empty_cells (a_row)
			a_row.set_height (a_row.height + 2)

				-- Set visibility
			if is_error_event (a_event_item) then
				if not show_errors then
					a_row.hide
				end
			elseif is_warning_event (a_event_item) then
				if not show_warnings or else filter_widget /= Void and then not filter_widget.is_unfiltered (l_error) then
					a_row.hide
				end
			else
				check False end
			end

				-- Set expanded status
			if a_row.is_expandable and then is_error_event (a_event_item) then
				if expand_errors then
					l_expanded := is_expanding_all_errors
					is_expanding_all_errors := True
					a_row.expand
					is_expanding_all_errors := l_expanded
				elseif a_row.is_expanded then
					a_row.collapse
				end
			end
		ensure then
			is_expanding_all_errors_unchanged: is_expanding_all_errors = old is_expanding_all_errors
		end

feature {NONE} -- Constants

	category_column: INTEGER = 2
	error_column: INTEGER = 3
	context_column: INTEGER = 4
	position_column: INTEGER = 5

	expand_errors_session_id: STRING_8 = "com.eiffel.error_list.expand_errors"

invariant
	errors_button_attached: is_initialized implies errors_button /= Void
	warnings_button_attached: is_initialized implies warnings_button /= Void
	filter_button_attached: is_initialized implies filter_button /= Void
	expand_errors_button_attached: is_initialized implies expand_errors_button /= Void
	item_count_matches_error_and_warning_count: error_count + warning_count = item_count

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
