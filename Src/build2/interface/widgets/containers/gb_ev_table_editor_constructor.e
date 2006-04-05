indexing
	description: "Builds an attribute editor for modification of objects of type EV_TABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			tool_bar: EV_TOOL_BAR
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create rows_entry.make (Current, Result, rows_string, gb_ev_table_rows, gb_ev_table_rows_tooltip,
				agent set_rows (?), agent valid_row_value (?), components)
			create columns_entry.make (Current, Result, columns_string, gb_ev_table_columns, gb_ev_table_columns_tooltip,
				agent set_columns (?), agent valid_column_value (?), components)
			create row_spacing_entry.make (Current, Result, row_spacing_string, gb_ev_table_row_spacing, gb_ev_table_row_spacing_tooltip,
				agent set_row_spacing (?), agent valid_spacing (?), components)
			create column_spacing_entry.make (Current, Result, column_spacing_string, gb_ev_table_column_spacing, gb_ev_table_column_spacing_tooltip,
				agent set_column_spacing (?), agent valid_spacing (?), components)
			create border_width_entry.make (Current, Result, border_width_string, gb_ev_table_border_width, gb_ev_table_border_width_tooltip,
				agent set_border_width (?), agent valid_spacing (?), components)
			create homogeneous_button.make_with_text ("Is_homogeneous?")
			homogeneous_button.select_actions.extend (agent toggle_homogeneous)
			homogeneous_button.select_actions.extend (agent update_editors)
			Result.extend (homogeneous_button)
			create layout_button.make_with_text ("Position children...")
			create tool_bar
			tool_bar.extend (layout_button)
			create horizontal_box
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			if first.count = 0 then
				layout_button.parent.disable_sensitive
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
			execution_agents.put (agent set_rows (?), rows_string)
			validate_agents.put (agent valid_row_value (?), rows_string)
			execution_agents.put (agent set_columns (?), columns_string)
			validate_agents.put (agent valid_column_value (?), columns_string)
			execution_agents.put (agent set_row_spacing (?), row_spacing_string)
			validate_agents.put (agent valid_spacing (?), row_spacing_string)
			execution_agents.put (agent set_column_spacing (?), Column_spacing_string)
			validate_agents.put (agent valid_spacing (?), Column_spacing_string)
			execution_agents.put (agent set_border_width (?), Border_width_string)
			validate_agents.put (agent valid_spacing (?), Border_width_string)
		end

feature {GB_TABLE_POSITIONER} -- Implementation
		
	set_item_position_and_span (v: EV_WIDGET; a_column, a_row, columns, rows: INTEGER) is
			-- Move `v' to `a_column', `a_row' and resize to `columns', `rows'.
		require
			widget_not_void: v /= Void
			widget_contained: first.has (v)
			column_valid: a_column >= 1 and a_column <= first.columns
			row_valid: a_row >= 1 and a_row <= first.rows
			column_span_valid: a_column + columns - 1 <= first.columns
			row_span_valid: a_row + rows - 1 <= first.rows
		local
			index: INTEGER
		do
				-- Do nothing if position and span has not changed.
			if first.item_column_position (v) /= a_column or first.item_row_position (v) /= a_row or
			 first.item_column_span (v) /= columns or first.item_row_span (v) /= rows then
			 	index := first.index_of (v, 1)
			 	actual_set_item_position_and_span (object, index, a_column, a_row, columns, rows)
			 	for_all_instance_referers (object, agent actual_set_item_position_and_span (?, index, a_column, a_row, columns, rows))
					-- Update project.
				enable_project_modified		
			end
		end
		
	actual_set_item_position_and_span (an_object: GB_OBJECT; index, a_column, a_row, columns, rows: INTEGER) is
			-- Set `index' items within representations of `an_object' to new position.
		require
			object_not_void: an_object /= Void
			index_valid: an_object.children /= Void implies index >= 1 and index <= an_object.children.count
			column_valid: a_column >= 1 and a_column <= first.columns
			row_valid: a_row >= 1 and a_row <= first.rows
			column_span_valid: a_column + columns - 1 <= first.columns
			row_span_valid: a_row + rows - 1 <= first.rows
		local
			table: EV_TABLE
		do
			table ?= an_object.object
			check
				object_was_table: table /= Void
			end
			table.set_item_position_and_span (table.i_th (index), a_column, a_row, columns, rows)
			table ?= an_object.real_display_object
			if table /= Void then
				check
					object_was_table: table /= Void
				end
				table.set_item_position_and_span (table.i_th (index), a_column, a_row, columns, rows)
			end
		end

	show_layout_window is
			-- Display window allowing placement of widgets.
		do
			if layout_window = Void then
				create layout_window.make_with_editor (Current, components)
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
		
	layout_button: EV_TOOL_BAR_BUTTON
		-- Provides access to the layout window.
		
	Column_positions_string: STRING is "Column_positions"
	
	Row_positions_string: STRING is "Row_positions"
	
	Column_spans_string: STRING is "Column_spans"
	
	Row_spans_string: STRING is "Row_spans"
	
	rows_string: STRING is "Rows"
	
	columns_string: STRING is "Columns"
	
	row_spacing_string: STRING is "Row_spacing"
	
	column_spacing_string: STRING is "Column_spacing"
	
	border_width_string: STRING is "Border_width";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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


end -- class GB_EV_TABLE_EDITOR_CONSTRUCTOR
