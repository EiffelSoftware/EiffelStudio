indexing
	description: "[
		An event list service {EVENT_LIST_SERVICE_I} tool to show all errors and warning event items in a single list in the EiffelStudio UI
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_ERRORS_AND_WARNINGS_TOOL

inherit
	ES_CLICKABLE_EVENT_LIST_TOOL_BASE
		redefine
			build_tool_interface,
			create_right_tool_bar_items,
			is_appliable_event,
			maximum_item_count,
			on_event_added,
			on_event_removed,
			update_content_applicable_widgets
		end

	ES_ERRORS_AND_WARNINGS_COMMANDER_I
		export
			{ES_ERRORS_AND_WARNINGS_COMMAND} all
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
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_BASE} (a_widget)
			a_widget.set_column_count_to (column_column)

			l_col := a_widget.column (1)
			l_col.set_width (20)
			l_col := a_widget.column (category_column)
			l_col.set_width (20)

			l_col := a_widget.column (error_column)
			l_col.set_title ("Description")
			l_col.set_width (500)

			l_col := a_widget.column (context_column)
			l_col.set_title ("Context")
			l_col.set_width (200)

			l_col := a_widget.column (lines_column)
			l_col.set_title ("Line")
			l_col.set_width (40)

			l_col := a_widget.column (column_column)
			l_col.set_title ("Column")
			l_col.set_width (50)

			grid_events.enable_tree
			grid_events.disable_row_height_fixed

				-- Bind redirecting pick and drop actions
			stone_director.bind (grid_events)
		end

feature -- Access

	error_count: NATURAL_8
			-- Number of errors

	warning_count: NATURAL_8
			-- Number of warnings

feature {NONE} -- Access

	tool_title: like title
			-- The tool's original title.
		do
			Result := "Error List"
		end

	tool_icon_buffer: like icon
			-- The tool's original icon as a pixel buffer.
		do
			Result := stock_pixmaps.tool_errors_list_with_errors_icon_buffer
		end

	maximum_item_count: NATURAL
			-- Maximum number of items displayable by the list.
			-- Note: Use 0 to indicate no maximum.
		do
			Result := 100
		end

feature {NONE} -- User interface items

	errors_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide error events

	warnings_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toogle to show/hide warning events

	error_info_button: SD_TOOL_BAR_BUTTON
			-- Error information button

	filter_button: SD_TOOL_BAR_POPUP_BUTTON
			-- Filter button to filter information in list

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
			l_error: ERROR
			l_line: INTEGER
			l_classi_stone: CLASSI_STONE
			l_classC_stone: CLASSC_STONE
		do
			l_row := find_event_row (a_event_item)
			if l_row /= Void then
				Result ?= l_row.item (context_column).data
				if Result /= Void then
					l_error ?= a_event_item.data
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
			Result := not is_warning_event (a_event_item) and then (({ERROR}) #? a_event_item.data) /= Void
		ensure
			not_is_warning_event: Result implies not is_warning_event (a_event_item)
		end

	is_warning_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' is an error event
		require
			a_event_item_attached: a_event_item /= Void
		do
			Result := (({WARNING}) #? a_event_item.data) /= Void
		ensure
			not_is_error_event: Result implies not is_error_event (a_event_item)
		end

	is_event_context_available (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' has a context available
		require
			a_event_item_attached: a_event_item /= Void
		do

		ensure
			not_is_error_event: Result implies not is_error_event (a_event_item)
		end

feature -- Status report

	show_errors: BOOLEAN
			-- Indicates if errors should be shown
		do
			Result := errors_button.is_selected
		end

	show_warnings: BOOLEAN
			-- Indicates if errors should be shown
		do
			Result := warnings_button.is_selected
		end

feature {ES_ERRORS_AND_WARNINGS_COMMAND} -- Navigation

	go_to_next_error (a_cycle: BOOLEAN)
			-- Goes to next error in the list.
			--
			-- `a_cycle': Specify true to jump back to the beginning of the list when reaching the end, False to perform
			--            not action when the end has been reached.
		do
			if show_errors then
				if error_count > 0 then
					move_next (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_error_event (a_item) and then event_context_stone (a_item) /= Void
						end)
				end
			end
		end

	go_to_previous_error (a_cycle: BOOLEAN)
			-- Goes to previous error in the list.
			--
			-- `a_cycle': Specify true to jump to the end of the list when reaching the start, False to perform
			--            not action when the start has been reached.
		do
			if show_errors then
				if error_count > 0 then
					move_previous (agent (a_item: EVENT_LIST_ITEM_I): BOOLEAN
						require
							a_item_attached: a_item /= Void
						do
							Result := is_error_event (a_item) and then event_context_stone (a_item) /= Void
						end)
				end
			end
		end

	go_to_next_warning (a_cycle: BOOLEAN)
			-- Goes to next warning in the list.
			--
			-- `a_cycle': Specify true to jump back to the beginning of the list when reaching the end, False to perform
			--            not action when the end has been reached.
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
			-- Goes to previous warning in the list.
			--
			-- `a_cycle': Specify true to jump to the end of the list when reaching the start, False to perform
			--            not action when the start has been reached.
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

	do_default_action (a_row: EV_GRID_ROW) is
			-- Performs a default actions for a given row.
			--
			-- `a_row': The row the user requested an action to be performed on.
		local
			l_event_item: EVENT_LIST_ITEM_I
			l_stone: STONE
		do
			l_event_item ?= a_row.data
			if l_event_item /= Void then
				l_stone := event_context_stone (l_event_item)
				if l_stone /= Void and then l_stone.is_valid then
					(create {EB_CONTROL_PICK_HANDLER}).launch_stone (l_stone)
				end
			end
		end

feature {NONE} -- Events

	on_event_added (a_service: EVENT_LIST_SERVICE_I; a_event_item: EVENT_LIST_ITEM_I)
			-- Called when a event item is added to the event service.
			--
			-- `a_service': Event service where event was added.
			-- `a_event_item': The event item added to the service.
		do
			if not is_initialized then
				initialize
			end
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_BASE} (a_service, a_event_item)
			if is_appliable_event (a_event_item) then
				if is_error_event (a_event_item) then
					set_error_count (error_count + 1)
				elseif is_warning_event (a_event_item) then
					set_warning_count (warning_count + 1)
				else
					check False end
				end
				update_content_applicable_navigation_buttons
			end
		end

	on_event_removed (a_service: EVENT_LIST_SERVICE_I; a_event_item: EVENT_LIST_ITEM_I) is
			-- Called after a event item has been removed from the service `a_service'
			--
			-- `a_service': Event service where the event was removed.
			-- `a_event_item': The event item removed from the service.
		do
			if not is_initialized then
				initialize
			end
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_BASE} (a_service, a_event_item)
			if is_appliable_event (a_event_item) then
				if is_error_event (a_event_item) then
					set_error_count (error_count - 1)
				elseif is_warning_event (a_event_item) then
					set_warning_count (warning_count - 1)
				else
					check False end
				end
				update_content_applicable_navigation_buttons
			end
		end

feature {NONE} -- Events

	on_toogle_errors_button is
			-- Called when `errors_button' is selected
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
		end

	on_toogle_warnings_button is
			-- Called when `warnings_button' is selected
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
					if is_warning_event (l_event_item) then
						if show_warnings then
							l_row.show
						else
							l_row.hide
						end
					end
				end
				i := i + 1
			end
		end

	on_error_info
			-- Call when the error information button is clicked
		local
			l_event: EVENT_LIST_ITEM_I
			l_error: ERROR
		do
			if grid_events.selected_rows.is_empty then
				error_info_command.execute
			else
					-- Retrieve event item set from {ES_EVENT_LIST_TOOL_BASE}.on_event_added
				l_event ?= grid_events.selected_rows.first.data
				check
					l_event_attached: l_event /= Void
				end
					-- Now retrieve error item
				l_error ?= l_event.data
				check
					l_error_attached: l_error /= Void
				end
				error_info_command.execute_with_stone (create {ERROR_STONE}.make (l_error))
			end
		end

feature {NONE} -- Factory

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Available tool bar items
		do
			create errors_button.make
			errors_button.set_text ("0 Errors")
			errors_button.set_pixmap (stock_pixmaps.tool_error_icon)
			errors_button.set_pixel_buffer (stock_pixmaps.tool_error_icon_buffer)
			errors_button.enable_select
			errors_button.select_actions.extend (agent on_toogle_errors_button)

			create warnings_button.make
			warnings_button.set_text ("0 Warnings")
			warnings_button.set_pixmap (stock_pixmaps.tool_warning_icon)
			warnings_button.set_pixel_buffer (stock_pixmaps.tool_warning_icon_buffer)
			warnings_button.enable_select
			warnings_button.select_actions.extend (agent on_toogle_warnings_button)

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
			create Result.make (7)

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

			create error_info_command.make
			error_info_button := error_info_command.new_sd_toolbar_item (False)
				-- We need to do something else, like handle grid selection
			error_info_button.select_actions.wipe_out
			error_info_button.select_actions.extend (agent on_error_info)
			Result.put_last (error_info_button)

			create filter_button.make
			filter_button.set_pixmap (stock_pixmaps.metric_filter_icon)
			filter_button.set_pixel_buffer (stock_pixmaps.metric_filter_icon_buffer)
			filter_button.set_tooltip (interface_names.f_filter_warnings)
			Result.put_last (filter_button)
		ensure then
			filter_button_attached: filter_button /= Void
		end

feature {NONE} -- User interface manipulation

	set_error_count (a_count: NATURAL_8)
			-- Sets `error_count' to `a_count'
		require
			a_count_small_enough: a_count + error_count + warning_count <= maximum_item_count
		local
			l_text: STRING_32
		do
			error_count := a_count
			create l_text.make (20)
			l_text.append_natural_8 (a_count)
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

	set_warning_count (a_count: NATURAL_8)
			-- Sets `warning_count' to `a_count'
		require
			a_count_small_enough: a_count + error_count + warning_count <= maximum_item_count
		local
			l_text: STRING_32
		do
			warning_count := a_count
			create l_text.make (20)
			l_text.append_natural_8 (a_count)
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
				-- No filter actions yet so we disable it.
			filter_button.disable_sensitive
			if a_enable then
				error_info_command.enable_sensitive
			else
				error_info_command.disable_sensitive
			end
		end

	update_content_applicable_navigation_buttons
			-- Updates content applicable navigation buttons
		do
			if error_count > 0 then
				go_to_next_error_command.enable_sensitive
				go_to_previous_error_command.enable_sensitive
			else
				go_to_next_error_command.disable_sensitive
				go_to_previous_error_command.disable_sensitive
			end

			if warning_count > 0 then
				go_to_next_warning_command.enable_sensitive
				go_to_previous_warning_command.enable_sensitive
			else
				go_to_next_warning_command.disable_sensitive
				go_to_previous_warning_command.disable_sensitive
			end
		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW) is
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
		do
			create l_item
			a_row.set_item (1, l_item)

				-- Set category pixmap item
			create l_item
			l_pixmap := category_pixmap_from_task (a_event_item)
			if l_pixmap /= Void then
				l_item.set_pixmap (l_pixmap)
			end
			a_row.set_item (category_column, l_item)

				-- Set error information
			l_error ?= a_event_item.data
			if l_error /= Void then
				create l_gen.make
				l_error.trace_single_line (l_gen)

				if l_gen.last_line /= Void and then l_gen.last_line.count > 0 then
					l_editor_item := create_clickable_grid_item (l_gen.last_line)
				else
					create l_editor_item.make_with_text ("No error message found!")
				end
				if is_error_event (a_event_item) then
					l_editor_item.set_pixmap (stock_pixmaps.tool_error_icon)
				elseif is_warning_event (a_event_item) then
					l_editor_item.set_pixmap (stock_pixmaps.tool_warning_icon)
				else
					check False end
				end
				l_editor_item.set_spacing (8)
				a_row.set_item (error_column, l_editor_item)

					-- Set row hieght
				a_row.set_height (l_editor_item.label_font_height.max (15))

					-- Build full error text
				create l_gen.make
				l_gen.enable_multiline
				l_error.trace (l_gen)
				l_lines := l_gen.lines
				if not l_lines.is_empty then
					l_tip := create_clickable_tooltip (l_lines, l_editor_item, a_row)
					a_row.select_actions.extend (agent l_tip.restart_tooltip_timer)

						-- Sub row full error
					a_row.insert_subrow (1)
					l_row := a_row.subrow (1)
					l_editor_item := create_multiline_clickable_grid_item (l_lines)
					l_row.set_height (l_tip.required_tooltip_height)
					l_row.set_item (error_column, l_editor_item)
				end

					-- Context
				l_error.trace_primary_context (l_gen)
				if l_gen.last_line /= Void then
					l_editor_item := create_clickable_grid_item (l_gen.last_line)
					a_row.set_item (context_column, l_editor_item)
					l_content := l_gen.last_line.content
					if not l_content.is_empty then
							-- Set context pebble
						l_editor_item.set_data (l_gen.last_line.content.last.pebble)
					end
				end

					-- Line number
				create l_item
				if l_error.line > 0 then
					l_item.set_text (l_error.line.out)
				end
				a_row.set_item (lines_column, l_item)

					-- Column number
				create l_item
				if l_error.line > 0 and then l_error.column > 0 then
					l_item.set_text (l_error.column.out)
				end
				a_row.set_item (column_column, l_item)
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
				if not show_warnings then
					a_row.hide
				end
			else
				check False end
			end
		end

feature {NONE} -- Constants

	category_column: INTEGER = 2
	error_column: INTEGER = 3
	context_column: INTEGER = 4
	lines_column: INTEGER = 5
	column_column: INTEGER = 6

invariant
	errors_button_attached: is_initialized implies errors_button /= Void
	warnings_button_attached: is_initialized implies warnings_button /= Void
	filter_button_attached: is_initialized implies filter_button /= Void
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
