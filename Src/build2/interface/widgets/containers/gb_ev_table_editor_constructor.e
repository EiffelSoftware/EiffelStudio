indexing
	description: "Builds an attribute editor for modification of objects of type EV_TABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		export
			{GB_TABLE_POSITIONER} first, named_list_item_from_widget, update_editors
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is
			-- String representation of object_type modifyable by `Current'.
		once
			Result := Ev_table_string
		end
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
		do
			create Result
			initialize_attribute_editor (Result)
			create rows_entry.make (Current, Result, rows_string, gb_ev_table_rows, gb_ev_table_rows_tooltip,
				agent set_rows (?), agent valid_row_value (?))
			create columns_entry.make (Current, Result, columns_string, gb_ev_table_columns, gb_ev_table_columns_tooltip,
				agent set_columns (?), agent valid_column_value (?))
			create row_spacing_entry.make (Current, Result, row_spacing_string, gb_ev_table_row_spacing, gb_ev_table_row_spacing_tooltip,
				agent set_row_spacing (?), agent valid_spacing (?))
			create column_spacing_entry.make (Current, Result, column_spacing_string, gb_ev_table_column_spacing, gb_ev_table_column_spacing_tooltip,
				agent set_column_spacing (?), agent valid_spacing (?))
			create border_width_entry.make (Current, Result, border_width_string, gb_ev_table_border_width, gb_ev_table_border_width_tooltip,
				agent set_border_width (?), agent valid_spacing (?))
			create homogeneous_button.make_with_text ("Is_homogeneous?")
			homogeneous_button.select_actions.extend (agent toggle_homogeneous)
			homogeneous_button.select_actions.extend (agent update_editors)
			Result.extend (homogeneous_button)
			create layout_button.make_with_text ("Position children...")
			create horizontal_box
			horizontal_box.extend (layout_button)
			horizontal_box.disable_item_expand (layout_button)
			if first.count = 0 then
				layout_button.disable_sensitive
			end
			layout_button.select_actions.extend (agent show_layout_window)
			Result.extend (horizontal_box)
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			homogeneous_button.select_actions.block
			rows_entry.update_constant_display (first.rows.out)
			columns_entry.update_constant_display (first.columns.out)
			border_width_entry.update_constant_display (first.border_width.out)
			column_spacing_entry.update_constant_display (first.column_spacing.out)
			row_spacing_entry.update_constant_display (first.row_spacing.out)
			if first.is_homogeneous then
				homogeneous_button.enable_select
				homogeneous_button.set_text ("Disable homogeneous")
			else
				homogeneous_button.disable_select
				homogeneous_button.set_text ("Enable homogeneous")
			end
			if layout_window /= Void and then layout_window.is_show_requested then
				layout_window.update
			end
			homogeneous_button.select_actions.resume
		end
		
	table_items (table: EV_TABLE): ARRAYED_LIST [EV_WIDGET] is
			-- `Result' is all items in `table'. Ordered from
			-- top left, going down, before moving right to the
			-- next column.
		local
			counter: INTEGER
			item: EV_WIDGET
		do
			create Result.make (table.count)
			from
				counter := 0
			until
				Result.count = table.count
			loop
				item := table.item_at_position ((counter // table.columns) + 1, (counter \\ table.rows) + 1)
				if item /= Void then
					Result.extend (item)	
				end
				counter := counter + 1	
			end
		ensure
			count_correct: Result.count = table.count
		end
		
		layout_window: GB_TABLE_POSITIONER

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.extend (agent set_rows (?), rows_string)
			validate_agents.extend (agent valid_row_value (?), rows_string)
			execution_agents.extend (agent set_columns (?), columns_string)
			validate_agents.extend (agent valid_column_value (?), columns_string)
			execution_agents.extend (agent set_row_spacing (?), row_spacing_string)
			validate_agents.extend (agent valid_spacing (?), row_spacing_string)
			execution_agents.extend (agent set_column_spacing (?), Column_spacing_string)
			validate_agents.extend (agent valid_spacing (?), Column_spacing_string)
			execution_agents.extend (agent set_border_width (?), Border_width_string)
			validate_agents.extend (agent valid_spacing (?), Border_width_string)
		end

feature {GB_TABLE_POSITIONER} -- Implementation

	set_item_span (v: EV_WIDGET; columns, rows: INTEGER) is
			-- Adjust `v' so that it spans `columns', `rows' within
			-- objects.
		local
			second_widget: EV_WIDGET
		do
				-- Do nothing if span has not changed.
			if first.item_column_span (v) /= columns or first.item_row_span (v) /= rows then
				first.set_item_span (v, columns, rows)
					-- Now we need to get the widget represented in objects at the
					-- second place.
				
				if objects @ 2 /= Void then
					second_widget := (objects @ 2).item_at_position (first.item_column_position (v), first.item_row_position (v))
					(objects @ 2).set_item_span (second_widget, columns, rows)
				end
					-- Update project.
				enable_project_modified
			end
		end
		
	set_item_position_and_span (v: EV_WIDGET; a_column, a_row, columns, rows: INTEGER) is
			-- Move `v' to `a_column', `a_row' and resize to `columns', `rows'.
		local
			second_widget: EV_WIDGET
		do
				-- Do nothing it position and span has not changed.
			if first.item_column_position (v) /= a_column or first.item_row_position (v) /= a_row or
			 first.item_column_span (v) /= columns or first.item_row_span (v) /= rows then
					-- Now we need to get the widget represented in objects at the
					-- second place. We must do this before we move the first widget.
				if objects @ 2 /= Void then
					second_widget := (objects @ 2).item_at_position (first.item_column_position (v), first.item_row_position (v))
				end
	
				first.set_item_position_and_span (v, a_column, a_row, columns, rows)
				if objects @ 2 /= Void then
					(objects @ 2).set_item_position_and_span (second_widget, a_column, a_row, columns, rows)
				end
					-- Update project.
				enable_project_modified		
			end
		end

	show_layout_window is
			-- Display window allowing placement of widgets.
		do
			if layout_window = Void then
				create layout_window.make_with_editor (Current)
			end
			layout_window.show_modal_to_window (parent_window (parent_editor))
		end

	set_rows (row_value: INTEGER) is
			-- Resize table to accomodate `row_value' rows.
		do
			for_all_objects (agent {EV_TABLE}.resize (first.columns, row_value))
			update_editors
		end
		
	set_columns (column_value: INTEGER) is
			-- Resize table to accomodate `column_value' columns.
		do
			for_all_objects (agent {EV_TABLE}.resize (column_value, first.rows))
			update_editors
		end

	set_border_width (border_width: INTEGER) is
			-- Assign `border_width' to border width of table.
		do
			for_all_objects (agent {EV_TABLE}.set_border_width (border_width))
			update_editors
		end
		
	set_row_spacing (row_spacing: INTEGER) is
			-- Assign `row_spacing' to row spacing of table.
		do
			for_all_objects (agent {EV_TABLE}.set_row_spacing (row_spacing))
			update_editors
		end
		
	set_column_spacing (column_spacing: INTEGER) is
			-- Assign `column_spacing' to column spacing of table.
		do
			for_all_objects (agent {EV_TABLE}.set_column_spacing (column_spacing))
			update_editors
		end
		
		
	valid_row_value (new_value: INTEGER): BOOLEAN is
			-- Is `new_value' a valid row size for table.
		do
			Result := first.rows_resizable_to (new_value)
		end
		
	valid_column_value (new_value: INTEGER): BOOLEAN is
			-- Is `new_value' a valid column size for table.
		do
			Result := first.columns_resizable_to (new_value)
		end
		
	valid_spacing (new_value: INTEGER): BOOLEAN is
			-- Is `new_value' a valid spacing value?
		do
			Result := new_value > 0
		end
		
	toggle_homogeneous is
			-- NOT `is_homogeneous' state.
		do
			if first.is_homogeneous then
				for_all_objects (agent {EV_TABLE}.disable_homogeneous)
				homogeneous_button.set_text ("Enable homogeneous")
			else
				for_all_objects (agent {EV_TABLE}.enable_homogeneous)
				homogeneous_button.set_text ("Disable homogeneous")
			end
		end

	rows_entry, columns_entry, row_spacing_entry, column_spacing_entry, border_width_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets used.
		
	homogeneous_button: EV_CHECK_BUTTON
		-- Toggles `is_homogeneous' for table.
		
	layout_button: EV_BUTTON
		-- Provides access to the layout window.
		
	Column_positions_string: STRING is "Column_positions"
	
	Row_positions_string: STRING is "Row_positions"
	
	Column_spans_string: STRING is "Column_spans"
	
	Row_spans_string: STRING is "Row_spans"
	
	rows_string: STRING is "Rows"
	
	columns_string: STRING is "Columns"
	
	row_spacing_string: STRING is "Row_spacing"
	
	column_spacing_string: STRING is "Column_spacing"
	
	border_width_string: STRING is "Border_width"



end -- class GB_EV_TABLE_EDITOR_CONSTRUCTOR
