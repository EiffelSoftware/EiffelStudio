note
	description: "[
			Multi-column lists that allow in-place editing of list row items. 
			By default ALLcolumns are editable.
			Only one single column item is editable at any time and 
			the widget typewhich can be edited must conform to EV_TEXTABLE.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_EDITABLE_LIST

inherit
	EV_MULTI_COLUMN_LIST
		redefine
			extend
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: EV_WINDOW)
			-- Create list with all columns editable and with relative 'a_window'.
		require
			window_not_void: a_window /= Void
		do
			create change_widgets.make (0)
			create editable_columns.make (0)
			create editable_rows.make (0)
			create end_edit_actions.default_create
			relative_window := a_window
			default_create

			resize_actions.extend (agent resized)
			column_resized_actions.extend (agent resized (?, 0, 0, 0))
			pointer_double_press_actions.extend (agent edit_row (?, ?, ?, ?, ?, ?, ?, ?))
			end_edit_actions.extend (agent on_change_widget_deselected)
			set_non_empty_column_values (True)
			set_all_rows_editable
		end

feature -- Status report

	all_columns_editable: BOOLEAN
			-- Are all columns in the list editable?

	all_rows_editable: BOOLEAN
			-- Are all rows in the list editable?

	column_editable (i: INTEGER): BOOLEAN
			-- Is column at index 'i' allowed to be edited?
		do
			Result := editable_columns.has (i)
		end

	row_editable (i: INTEGER): BOOLEAN
			-- Is row at index 'i' allowed to be edited?
		do
			Result := editable_rows.has (i)
		end

feature -- Element Change

	extend (v: like item)
			-- Add 'v' to Current.
		do
			Precursor {EV_MULTI_COLUMN_LIST} (v)
			set_row_editable (True, count)
		end

feature -- Status setting

	set_field
			-- Set field at row index 'widget_row' and column index 'widget_column' with
			-- value of `saved text' after an edit has been unsuccessful
		obsolete
			"use `set_with_previous_text' instead [2017-05-31]"
		do
			set_with_previous_text
		end

	set_with_previous_text
			-- Set field at row index 'widget_row' and column index 'widget_column' with
			-- value of `saved text' after an edit has been unsuccessful
		do
			go_i_th (widget_row)
			if attached saved_text as t then
				item.put_i_th (t, widget_column)
			end
		end

	set_unique_column_values (a_flag: BOOLEAN)
			-- Set column value uniqueness to 'a_flag'.
		do
			unique_column_values := a_flag
		end

	set_non_empty_column_values (a_flag: BOOLEAN)
			-- Set so edited column values are not allowed to be empty.
		do
			empty_column_values := a_flag
		end

	set_column_editable (a_flag: BOOLEAN; i: INTEGER)
			-- Make column at index 'i' editable according to 'a_flag'.
		do
			if a_flag then
				if not editable_columns.has (i) then
					editable_columns.extend (i)
				end
			else
				from
					editable_columns.start
				until
					editable_columns.after
				loop
					if editable_columns.item = i then
						editable_columns.remove
					else
						editable_columns.forth
					end
				end
			end

		end

	set_all_columns_editable
			-- Make every column editable.
		require
			has_columns: column_count > 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i = column_count + 1
			loop
				editable_columns.extend (i)
				i := i + 1
			end
			all_columns_editable := True
		end

	set_row_editable (a_flag: BOOLEAN; i: INTEGER)
			-- Make row at index 'i' editable according to 'a_flag'.
		local
			done: BOOLEAN
		do
			if a_flag then
					-- Do nothing for already editable.
				if not editable_rows.has (i) then
					editable_rows.extend (i)
				end
			else
				from
					editable_rows.start
				until
					editable_rows.after or done
				loop
					if editable_rows.item = i then
						editable_rows.remove
						done := True
					else
						editable_rows.forth
					end
				end
			end
		end

	set_all_rows_editable
			-- Make every row editable.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i = count + 1
			loop
				editable_rows.extend (i)
				i := i + 1
			end
			all_rows_editable := True
		end

	change_widget_type (i: INTEGER; a_widget: EV_TEXTABLE)
			-- Set widget type to be displayed at column index 'i'
		require
			editable_column: column_editable (i)
		do
			if change_widgets.has (i) then
				change_widgets.replace (a_widget, i)
			else
				change_widgets.put (a_widget, i)
			end
			if attached {EV_COMBO_BOX} a_widget as combo_box then
				combo_box.select_actions.extend (agent combo_item_selected (combo_box))
			end
		end

feature -- Removal

	remove_selected_item
			-- Remove the currently selected item from the list.
		local
			list_item: detachable EV_MULTI_COLUMN_LIST_ROW
		do
			list_item := selected_item
			if list_item /= Void then
				prune (list_item)
			end
		end

feature -- Selection

	select_item (a_string: READABLE_STRING_GENERAL; i: INTEGER)
			-- Select in list the first item with text 'a_string' at index 'i'.
		local
			done: BOOLEAN
		do
			from
				start
			until
				after or done
			loop
				if item.i_th (i).same_string_general (a_string) then
					item.enable_select
					done := True
				end
				forth
			end
		end

feature -- Editing

	edit_row (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- User has double clicked list row so set up dialogs for in-place editing.
		do
			if attached selected_item as l_selected_item then
				widget_column := column_index (x, y)
				widget_row := index_of (l_selected_item, 1)
				saved_text := l_selected_item [widget_column]
				calculate_offsets (x, y)
				generate_edit_dialog
			end
		end

feature {NONE} -- Status report

	unique_column_values: BOOLEAN
			-- Should column values be unique for each row?	No by default.

	empty_column_values: BOOLEAN
			-- Are edited column values allowed to empty?  No by default.

	column_index (x, y: INTEGER): INTEGER
			-- The index of the column which was clicked by the user.  Store
			-- result in `widget_column'
		local
			i, low_x_bound, high_x_bound: INTEGER
		do
			from
				i := 1
			until
				i = column_count + 1
			loop
				low_x_bound := high_x_bound
				high_x_bound := high_x_bound + column_width (i)
				if x > low_x_bound and x < high_x_bound then
					Result := i
				end
				i := i + 1
			end
		end

feature -- Actions

	end_edit_actions: EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- List of actions to perform when list row has just been edited.

feature {NONE} -- Actions

	on_edit_end
			-- Action to be performed when row editing has been finished
		do
			end_edit_actions.call (Void)
		end

	on_change_widget_deselected
			-- Clear any in-place editing dialogs and set row data to reflect newly entered text.
		do
			create hide_timer.make_with_interval (25)
			hide_timer.actions.extend (agent hide_window_on_timer)
				--internal_dialog.hide
		end

	hide_window_on_timer
			--
		do
			check hide_timer /= Void then end
			hide_timer.destroy
			if attached internal_dialog as l_internal_dialog then
				l_internal_dialog.hide
			end
		end

	hide_timer: detachable EV_TIMEOUT note option: stable attribute end

	on_key_release (key: EV_KEY; a_dialog: EV_UNTITLED_DIALOG)
			-- Actions to check if user has press the return key on 'a_dialog'.
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter or
				key.code = {EV_KEY_CONSTANTS}.key_tab then
				update_actions
			end
		end

	update_actions
			-- Actions to be performed when change widget is updated, redefine for custom
			-- behaviour.
		local
			l_saved_text: like saved_text
			l_error_dialog: like error_dialog
		do
			if attached widget as w then
				if attached selected_item as l_selected_item then
					if unique_column_values then
						if is_valid_text (w.text, widget_column, index_of (l_selected_item, 1)) then
							l_selected_item.put_i_th (w.text, widget_column)
						else
							l_saved_text := saved_text
							check l_saved_text /= Void then end
							w.set_text (l_saved_text)
							create l_error_dialog.make_with_text
								("This column identifier is in use by another row.%N Please choose another.")
							error_dialog := l_error_dialog
							l_error_dialog.show_modal_to_window (relative_window)
						end
					else
						l_selected_item.put_i_th (w.text, widget_column)
					end
				end
				w.focus_out_actions.wipe_out
				w.key_release_actions.wipe_out
				on_edit_end
			end
		end

	update_agents (a_container_arg: EV_CONTAINER; adding: BOOLEAN)
			-- Add an agent to every widget in container so that when clicked
			-- it hides the editable dialog.  If not `adding' then remove the
			-- appropriate agent.
		local
			button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
		do
			across
				a_container_arg.linear_representation as ic
			loop
				button_press_actions := ic.pointer_button_press_actions
				if adding then
					button_press_actions.extend (agent hide_window)
				else
					button_press_actions.go_i_th (button_press_actions.count)
					button_press_actions.remove
				end
				if attached {EV_CONTAINER} ic as con then
					update_agents (con, adding)
				end
			end
		end

feature {NONE} -- Commands

	generate_edit_dialog
			-- Generate new edit dialog for row editing in column at index 'i'.
		local
			l_internal_dialog: like internal_dialog
			l_saved_text: like saved_text
			w: like widget
		do
			if column_editable (widget_column) and row_editable (widget_row) then

					-- Destroy previous editing dialog
				l_internal_dialog := internal_dialog
				if l_internal_dialog /= Void then
					l_internal_dialog.destroy
					internal_dialog := Void
				end

				if change_widgets.has (widget_column) then
					w := {like widget} / change_widgets.item (widget_column)
				else
						-- Use text field as default widget type.
					create {EV_TEXT_FIELD} w
					change_widgets.put (w, widget_column)
				end
				widget := w
					-- Create the parent dialog.
				if attached w then
					create l_internal_dialog
					internal_dialog := l_internal_dialog
					l_internal_dialog.extend (w)
					l_internal_dialog.disable_user_resize
					l_internal_dialog.set_size (dialog_width, dialog_height)
					l_internal_dialog.show_relative_to_window (relative_window)
					l_internal_dialog.set_position (x_offset, y_offset)
					initialize_observers

						-- Setup the editable widget
					w.key_release_actions.extend (agent on_key_release (?, l_internal_dialog))

					l_saved_text := saved_text
					check l_saved_text /= Void then end
					w.set_text (l_saved_text)
					w.focus_out_actions.extend (agent focus_lost)
				end
			end
		end

	focus_lost
			-- Focus lost on editable widget
		do
			if screen.widget_at_position (screen.pointer_position.x, screen.pointer_position.y) /= widget then
				update_actions
			end
		end

	screen: EV_SCREEN
			-- Screen
		once
			create Result
		end

	redraw_dialog
			-- Redraw edit dialog in response to interface changes
		require
			has_internal_dialog: internal_dialog /= Void
		local
			l_internal_dialog: like internal_dialog
		do
			l_internal_dialog := internal_dialog
			check l_internal_dialog /= Void then end
			l_internal_dialog.set_size (dialog_width, dialog_height)
			l_internal_dialog.show_relative_to_window (relative_window)
			calculate_x_offset (0)
			l_internal_dialog.set_position (x_offset, y_offset)
		end

	hide_window (a_x, a_y: INTEGER; a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Hide
		do
			update_actions
				--	update_agents (relative_window, False)
		end

feature {NONE} -- Widget

	widget: detachable EV_TEXT_COMPONENT
			-- The widget with the Current keyboard focus.

	x_offset, y_offset: INTEGER
			-- Where 'widget' should be positioned on the x-axis or y-axis.

	widget_column, widget_row: INTEGER
			-- The column/row index that 'widget' belongs to.

	saved_text: detachable STRING_32
			-- Saved text of 'widget'.  Used to reset text in case non-unique
			-- value entered and 'unique_column_values' in true.

	calculate_offsets (x, y: INTEGER)
			-- Determine the appropriate x and y values for 'widget'.
		do
			calculate_y_offset (y)
			calculate_x_offset (x)
		end

	calculate_y_offset (y: INTEGER)
			-- Calculate the y axis value required to correctly position edit dialog in
			-- list.  WORK AROUND SINCE VISION DOES NOT MAKE AVAILABLE COLUMN TITLE HEIGHT.
		do
			y_offset := screen_y + (y - ((y - 19) \\ row_height).abs) + 13 - row_height
		end

	calculate_x_offset (x: INTEGER)
			-- Calculate the x axis value required to correctly position edit dialog in list.
		local
			i: INTEGER
		do
			from
				i := 1
				x_offset := screen_x
			until
				i = widget_column
			loop
				x_offset := x_offset + column_width (i)
				i := i + 1
			end
		end

	dialog_width: INTEGER
			-- The width that editable dialog should be at any given moment based on
			-- current display status
		do
			Result := column_width (widget_column)
		end

	dialog_height: INTEGER
			-- The height that editable dialog should be at any given moment based on
			-- current display status
		do
			Result := row_height - 5
		end

feature {NONE} -- Access

	relative_window: EV_WINDOW
			-- Window to which editable dialogs are to be shown relative to.

	editable_columns: ARRAYED_LIST [INTEGER]
			-- Indices of all editable columns in row.

	editable_rows: ARRAYED_LIST [INTEGER]
			-- Indices of all editable rows in list.

	change_widgets: HASH_TABLE [EV_TEXTABLE, INTEGER]
			-- List of textable widgets associated by column.  Used to determine
			-- widget type for each column.

feature {NONE} -- Implementation

	initialize_observers
			--
		do
				--update_agents (relative_window, True)
		end

	is_valid_text (a_string: READABLE_STRING_GENERAL; c, r: INTEGER): BOOLEAN
			-- Is the string 'a_string' at row 'r' and column 'c' unique to column 'c'?.
		do
			from
				Result := True
				start
			until
				after or not Result
			loop
				if not empty_column_values or not a_string.is_empty then
					if a_string.same_string (item [c]) and index /= r then
						Result := False
					elseif not empty_column_values and a_string.is_empty then
						Result := False
					end
				end
				forth
			end
		end

	resized (a_x, a_y, a_width, a_height: INTEGER)
			-- Current was resized.
			-- None of the arguments are used since we just want a notification.
		local
			cnt,
			l_total: INTEGER
		do
				-- Resize last column of list to fit exactly
			if not is_empty then
				from
					cnt := 1
					l_total := width
				until
					cnt = column_count
				loop
					l_total := l_total - column_width (cnt)
					cnt := cnt + 1
				end
				if l_total > 0 then
					resize_actions.block
					column_resized_actions.block
					set_column_width (l_total, cnt)
					resize_actions.resume
					column_resized_actions.resume
				end

					-- Redraw internal dialog if required
				if attached internal_dialog as l_internal_dialog and then l_internal_dialog.is_displayed then
					redraw_dialog
				end
			end
		end

	error_dialog: detachable EV_INFORMATION_DIALOG
			-- Error dialog indicating name clash.

	internal_dialog: detachable EV_UNTITLED_DIALOG
			-- Internal dialog for holding editable widget

	combo_item_selected (combo_box: EV_COMBO_BOX)
			--
		local
			l_selected_item: detachable EV_LIST_ITEM
		do
			l_selected_item := combo_box.selected_item
			check l_selected_item /= Void then end
			i_th (widget_row).put_i_th (l_selected_item.text, widget_column)
		end

invariant
	has_relative_window: relative_window /= Void
	change_widgets_not_void: change_widgets /= Void
	editable_columns_not_void: editable_columns /= Void

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
