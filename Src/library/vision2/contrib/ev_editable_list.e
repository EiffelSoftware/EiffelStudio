indexing
	description: "[Multi-column lists that allow in-place editing of list row items.  By default ALL%
		%columns are editable.  Only one single column item is editable at any time and the widget type%
		%which can be edited must conform to EV_TEXTABLE."
	author: ""
	date: "6/17/02"
	revision: "1.0"

class
	EV_EDITABLE_LIST
	
inherit
	EV_MULTI_COLUMN_LIST
		redefine
			extend
		end

create
	make

feature -- Initialization

	make (a_window: EV_WINDOW) is
			-- Create list with all columns editable and with relative 'a_window'.
		require
			window_not_void: a_window /= Void
		do
			default_create
			relative_window := a_window
			create edit_dialogs.make (0)
			create change_widgets.make (0)
			create editable_columns.make (0)
			create editable_rows.make (0)
			create end_edit_actions.default_create
			pointer_double_press_actions.extend (agent edit_row (?, ?, ?, ?, ?, ?, ?, ?) )
			end_edit_actions.extend (agent on_change_widget_deselected)
			set_non_empty_column_values (True)
			set_all_rows_editable
		end

feature -- Status report
		
	all_columns_editable: BOOLEAN
			-- Are all columns in the list editable?
		
	all_rows_editable: BOOLEAN
			-- Are all rows in the list editable?
			
	column_editable (i: INTEGER): BOOLEAN is
			-- Is column at index 'i' allowed to be edited?
		do
			Result := editable_columns.has (i)
		end
		
	row_editable (i: INTEGER): BOOLEAN is
			-- Is row at index 'i' allowed to be edited?
		do
			Result := editable_rows.has (i)
		end

feature -- Element Change

	extend (v: like item) is
			-- Add 'v' to Current.
		do
			{EV_MULTI_COLUMN_LIST} Precursor (v)
			set_row_editable (True, count)
		end

feature -- Status setting		

	set_field is
			-- Set field at row index 'widget_row' and column index 'widget_column'..
		do
			go_i_th (widget_row)
			item.put_i_th (saved_text, widget_column)
		end

	set_unique_column_values (a_flag: BOOLEAN) is
			-- Set column value uniqueness to 'a_flag'.
		require
			valid_flag: a_flag /= Void
		do
			unique_column_values := a_flag
		end
		
	set_non_empty_column_values (a_flag: BOOLEAN) is
			-- Set so edited column values are not allowed to be empty.
		require
			valid_flag: a_flag /= Void
		do
			empty_column_values := a_flag
		end
		
	set_column_editable (a_flag: BOOLEAN; i: INTEGER) is
			-- Make column at index 'i' editable according to 'a_flag'. 
		do
			if a_flag then
				if editable_columns.has (i) then
					-- Already editbale, do nothing.
				else
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
					end
					editable_columns.forth
				end
			end
			
		end

	set_all_columns_editable is
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
		
	set_row_editable (a_flag: BOOLEAN; i: INTEGER) is
			-- Make row at index 'i' editable according to 'a_flag'.
		local
			done: BOOLEAN
		do
			if a_flag then
				if editable_rows.has (i) then
					-- Already editbale, do nothing.
				else
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

	set_all_rows_editable is
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
		
	change_widget_type (i: INTEGER; a_widget: EV_TEXTABLE) is
			-- Set widget to be displayed at column index 'i' with index 'i' to a_widget.
		require
			editable_column: column_editable (i)
		do
			if change_widgets.has (i) then
				change_widgets.replace (a_widget, i)
			else
				change_widgets.put (a_widget, i)
			end
			
		end

feature -- Removal

	remove_selected_item is
			-- Remove the currently selected item from the list.
		local
			list_item: EV_MULTI_COLUMN_LIST_ROW
		do
			list_item := selected_item
			if list_item /= Void  then
				prune (list_item)
			end
		end
		
feature -- Selection

	select_item (a_string: STRING; i: INTEGER) is
			-- Select in list the first item with text 'a_string' at index 'i'.
		local
			done: BOOLEAN
		do
			from
				start
			until
				after or done
			loop
				if item.i_th (i).is_equal (a_string) then
					item.enable_select
					done := True
				end
				forth
			end
		end

feature -- Basic operations

	edit_row (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- User has double clicked list row so set up dialogs for in-place editing.
		do
			if selected_item /= Void then
				calculate_offsets (x, y)
				generate_edit_dialog (column_index (x, y), index_of (selected_item, 1))
			end	
		end

feature {NONE} -- Status report

	unique_column_values: BOOLEAN
			-- Should column values be unique for each row?	No by default.	
			
	empty_column_values: BOOLEAN
			-- Are edited column values allowed to empty?  No by default.
			
	is_hideable: BOOLEAN is
			-- Is current editable row able to be hidden (i.e. no change dialogs have
			-- the keyboard focus).
		do
			from
				Result := True
				edit_dialogs.start
			until
				edit_dialogs.after
			loop
				if edit_dialogs.item.has_focus then
					Result := False
				end
				edit_dialogs.forth
			end
		end
		
	column_index (x, y: INTEGER): INTEGER is
			-- The index of the column which was clicked by the user.
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
			widget_column := Result
		end

feature {NONE} -- Actions

	on_edit_end is
			-- Action to be performed when row editing has been finished
		do
			end_edit_actions.call ([])
		end

	on_change_widget_deselected is
			-- Clear any in-place editing dialogs since row has lost focus and also
			-- set row data to reflect newly entered text.
		do
			if not edit_dialogs.is_empty then
				
			
				from 
					edit_dialogs.start
				until
					edit_dialogs.after
				loop
					edit_dialogs.item.hide
					edit_dialogs.item.destroy
					edit_dialogs.forth
				end
				edit_dialogs.wipe_out
			end
		end
	
	on_key_release (key: EV_KEY; a_dialog: EV_UNTITLED_DIALOG) is
			-- Actions to check if user has press the return key on 'a_dialog'.
		do
			if key.code = feature {EV_KEY_CONSTANTS}.key_enter then				
--				on_change_widget_deselected
			end
		end
	
	update_actions is
			-- Actions to be performed when change widget is updated, redefine for custom 
			-- behaviour.
		do
			if selected_item /= Void then
				if unique_column_values then
					if is_valid_text (widget.text, widget_column, index_of (selected_item, 1)) then
						selected_item.put_i_th (widget.text, widget_column)
					else
						widget.set_text (saved_text)
							create error_dialog.make_with_text
								("This column identifier is in use by another row.%N Please choose another.")
							error_dialog.show_modal_to_window (relative_window)
					end
				else
					selected_item.put_i_th (widget.text, widget_column)
--					generate_edit_dialog (widget_column)
				end
			end
			on_edit_end
		end

feature -- Actions
				
	end_edit_actions: ACTION_SEQUENCE [TUPLE[]]
			-- List of actions to perform when list row has just been edited.

feature {NONE} -- Widget Editing

	widget: EV_TEXTABLE
			-- The widget with the Current keyboard focus.
			
	widget_column: INTEGER
			-- The column index that 'widget' belongs to.
			
	widget_row: INTEGER
			-- The row index that 'widget' belongs to.
			
	saved_text: STRING
			-- Saved text of 'widget'.  Used to reset text in case non-unique 
			-- value entered and 'unique_column_values' in true.
	
	calculate_offsets (x, y: INTEGER) is
			-- Determine the appropriate x and y values for 'widget'.
		do
			calculate_y_offset (y)
		end		
		
	calculate_y_offset (y: INTEGER) is
			-- Calculate the y axis value required to correctly position edit dialog in
			-- list.  WORK AROUND SINCE VISION DOES NOT MAKE AVAILABLE COLUMN TITLE HEIGHT.
		local
		 	actual_index: INTEGER
		do
			actual_index := y - ((y - 19) \\ row_height).abs
			y_offset := screen_y + actual_index + 13 - row_height
		end

	y_offset: INTEGER
			-- Where 'widget' should be positioned on the y-axis
			
	calculate_x_offset (x: INTEGER) is
			-- Calculate the y axis value required to correctly position edit dialog in
			-- list.
		do
			-- N.B. TO DO ONCE VISION PROVIDES SUPPORT FOR DETERMINING SCROLL OFFSETS.
		end

	x_offset: INTEGER
			-- Where 'widget' should be positioned on the x-axis.

feature {NONE} -- Implementation

	relative_window: EV_WINDOW
			-- Window to which editable dialogs are to be shown relative to.
			
	editable_columns: ARRAYED_LIST [INTEGER]
			-- Indices of all editable columns in row.
			
	editable_rows: ARRAYED_LIST [INTEGER]
			-- Indices of all editable rows in list.
			
	edit_dialogs: ARRAYED_LIST [EV_UNTITLED_DIALOG]
			-- List of dialogs used for editing Current row.
			
	change_widgets: HASH_TABLE [EV_TEXTABLE, INTEGER]
			-- List of textable widgets associated by column.  Used to determine
			-- widget type for each column.

	generate_edit_dialog (a_col_index, a_row_index: INTEGER) is
			-- Generate new edit dialog for row editing in column at index 'i', a text 
			-- field dialog unless otherwise previously specified by 'change_widget_type'.
		local
			change_dialog: EV_UNTITLED_DIALOG
			change_widget: EV_WIDGET
			text_change_widget: EV_TEXT_FIELD
			i, a_column_width: INTEGER
			x_pos: INTEGER
		do
			if column_editable (a_col_index) and row_editable (a_row_index) then
				
				from
					i := 1
					x_pos := screen_x
					edit_dialogs.wipe_out
					saved_text := selected_item @ (a_col_index)
					widget_row := index_of (selected_item, 1)
				until
					i = a_col_index + 1
				loop
					x_pos := x_pos + a_column_width
					a_column_width := column_width (i)
					i := i + 1
				end			
				
				create change_dialog
				edit_dialogs.extend (change_dialog)
				change_dialog.set_size (a_column_width, row_height - 5)		
				change_dialog.disable_user_resize
				
				if change_widgets.has (a_col_index) then
					change_widget ?= change_widgets.item (a_col_index)
					change_widget.key_release_actions.extend (agent on_key_release (?, change_dialog))
					change_widget.focus_out_actions.extend (agent update_actions)
					change_dialog.extend (change_widget)
				else
					create {EV_TEXT_FIELD} text_change_widget
					change_widgets.put (text_change_widget, a_col_index)
					text_change_widget.key_release_actions.extend (agent  on_key_release (?, change_dialog))
					text_change_widget.focus_out_actions.extend (agent update_actions)
					change_dialog.extend (text_change_widget)
				end

				widget := change_widgets.item (a_col_index)
				change_widgets.item (a_col_index).set_text (saved_text)
				change_dialog.show_relative_to_window (relative_window)
				change_dialog.set_position (x_pos, y_offset)
			end
		end

	is_valid_text (a_string: STRING; c, r: INTEGER): BOOLEAN is
			-- Is the string 'a_string' at row 'r' and column 'c' unique to column 'c'?.
		do
			from
				Result := True
				start
			until
				after or (Result = False)
			loop
				if empty_column_values and a_string.is_empty then
				else
					if (a_string.is_equal (item @ c) and not (index = r)) then
						Result := False
					elseif (not empty_column_values) and (a_string.is_empty) then
						Result := False
					end
				end
				forth
			end
		end
		
	error_dialog: EV_INFORMATION_DIALOG
			-- Error dialog indicating name clash.
	
invariant
	has_relative_window: relative_window /= Void
	edit_dialogs_not_void: edit_dialogs /= Void
	change_widgets_not_void: change_widgets /= Void
	editable_columns_not_void: editable_columns /= Void

end -- class EV_EDITABLE_LIST
