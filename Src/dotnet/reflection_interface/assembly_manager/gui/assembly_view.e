indexing
	description: "List the types of currently selected assembly."
	external_name: "ISE.AssemblyManager.AssemblyView"

class
	ASSEMBLY_VIEW

inherit
	DIALOG
		redefine
			dictionary
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly: like assembly) is
		indexing
			description: "[Set `assembly' with `an_assembly'.%
					%Set `assembly_descriptor' and build `type_list'.]"
			external_name: "Make"
		require
			non_void_assembly: an_assembly /= Void
		local
			return_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
		do
			make_form
			assembly := an_assembly
			assembly_descriptor := an_assembly.get_assembly_descriptor
			type_list := assembly.types
			sort_classes
			create types.make
			create children_table.make
			initialize_gui
			return_value := show_dialog
		ensure
			assembly_set: assembly = an_assembly
			assembly_descriptor_set: assembly_descriptor /= Void
			type_list_built: type_list /= Void
			non_void_types: types /= Void
		end

feature -- Access
	
	dictionary: ASSEMBLY_VIEW_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end
	
	assembly: ISE_REFLECTION_EIFFELASSEMBLY
		indexing
			description: "Assembly"
			external_name: "Assembly"
		end
		
	type_list: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "Assembly types"
			external_name: "TypeList"
		end

feature -- Basic Operations

	initialize_gui is
		indexing
			description: "Initialize GUI."
			external_name: "InitializeGUI"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			type: SYSTEM_TYPE
			on_close_delegate: SYSTEM_EVENTHANDLER
			on_resize_delegate: SYSTEM_EVENTHANDLER
			style: SYSTEM_DRAWING_FONTSTYLE
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			set_size (a_size)	
			set_icon (dictionary.Edit_icon)

				-- `Selected assembly: '
			create assembly_label.make_label
			assembly_label.set_text (assembly_descriptor.get_name)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			assembly_label.set_location (a_point)
			a_size.set_Height (dictionary.Label_height)
			assembly_label.set_size (a_size)
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, style.Bold) 
			assembly_label.set_font (label_font)
			get_controls.add (assembly_label)

			create_assembly_labels
			build_types_table
			display_types
			get_controls.add (data_grid)
			
			create on_resize_delegate.make_eventhandler (Current, $on_resize_action)
			add_resize (on_resize_delegate)
		end

feature -- Event handling

	on_resize_action (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Resize window and its content."
			external_name: "OnResizeAction"
		local
			a_size: SYSTEM_DRAWING_SIZE
		do
			a_size.set_width (get_width - dictionary.Margin // 2)
			a_size.set_height (get_height - 4 * dictionary.Row_height)
			data_grid.set_Size (a_size)			
			fill_data_grid
			refresh
		end
		
	on_cell (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Action performed when a cell of the data grid is selected"
			external_name: "OnCell"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_row: INTEGER
			selected_column: INTEGER
			rows: SYSTEM_DATA_DATAROWCOLLECTION
			a_row: SYSTEM_DATA_DATAROW
			eiffel_name: STRING
			eiffel_class: ISE_REFLECTION_EIFFELCLASS
			children: SYSTEM_COLLECTIONS_ARRAYLIST
			type_view: TYPE_VIEW
			cursors: SYSTEM_WINDOWS_FORMS_CURSORS
			wait_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
			normal_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
		do
			if data_grid.get_Current_Cell /= Void and then data_grid.get_current_cell.get_column_number /= Void then
				selected_column := data_grid.get_current_cell.get_column_number
				if selected_column = 0 then
					selected_row := data_grid.get_Current_Row_Index
					if selected_row /= -1 then
						rows := data_table.get_rows
						a_row := rows.get_item (selected_row)
						eiffel_name ?= a_row.get_item_int32 (selected_column)
						if eiffel_name /= Void then
							eiffel_class ?= types.get_item (eiffel_name)
							if eiffel_class /= Void then
								if not children_table.contains (eiffel_class) then
									children := children_factory.recursive_children (eiffel_class)
									children_table.add (eiffel_class, children)
								else
									children ?= children_table.get_item (eiffel_class)
								end
								wait_cursor := cursors.get_Wait_Cursor
								set_cursor (wait_cursor)
								create type_view.make (assembly_descriptor, eiffel_class, children, Current)
								normal_cursor := cursors.get_Arrow
								set_cursor (normal_cursor)
							end							
						end
					end
				end
			end
		end

feature -- Basic Operations

	update_gui is
		indexing
			description: "Update GUI."
			external_name: "UpdateGui"
		local
			columns: SYSTEM_DATA_DATACOLUMNCOLLECTION
		do
			create types.make
			type_list := assembly.types
			sort_classes
			get_controls.remove (data_grid)
			build_types_table
			display_types
			get_controls.add (data_grid)
			refresh		
		end
		
feature {TYPE_VIEW} -- Status Setting

	set_children (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; children_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Replace children of `an_eiffel_class' by `children_list' in `children_table'."
			external_name: "SetChildren"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_children_list: children_list /= Void	
		do
			if children_table.contains (an_eiffel_class) then
				children_table.remove (an_eiffel_class)
				children_table.add (an_eiffel_class, children_list)
			end		
		end
		
feature {NONE} -- Implementation

	eiffel_name_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOXCOLUMN
		indexing
			description: "Eiffel name column style"
			external_name: "EiffelNameColumnStyle"
		end
		
	external_name_column_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTEXTBOXCOLUMN
		indexing
			description: "External name column style"
			external_name: "ExternalNameColumnStyle"
		end
		
	eiffel_name_column: SYSTEM_DATA_DATACOLUMN
		indexing
			description: "Eiffel name column"
			external_name: "EiffelNameColumn"
		end

	external_name_column: SYSTEM_DATA_DATACOLUMN
		indexing
			description: "External name column"
			external_name: "ExternalNameColumn"
		end

	data_grid: SYSTEM_WINDOWS_FORMS_DATAGRID
		indexing
			description: "Data grid associated with `data_table'"
			external_name: "DataGrid"
		end
				
	data_table: SYSTEM_DATA_DATATABLE
		indexing
			description: "Data table"
			external_name: "DataTable"
		end

	data_grid_font: SYSTEM_DRAWING_FONT
		indexing
			description: "Data grid font"
			external_name: "DataGridFont"
		end
		
	type_factory: SYSTEM_TYPE
		indexing
			description: "Statics needed to create a type"
			external_name: "TypeFactory"
		end
	
	types: SYSTEM_COLLECTIONS_HASHTABLE
			-- | Key: Eiffel name
			-- | Value: Instance of `ISE_REFLECTION_EIFFELCLASS'
		indexing
			description: "Types"
			external_name: "Types"
		end
	
	children_factory: CHILDREN_FACTORY is
		indexing
			description: "Children factory"
			external_name: "ChildrenFactory"
		require
			non_void_type_list: type_list /= Void
		once
			create Result.make (type_list)
		ensure
			children_factory_created: Result /= Void
		end
	
	children_table: SYSTEM_COLLECTIONS_HASHTABLE
			-- | Key: instance of `ISE_REFLECTION_EIFFELCLASS'
			-- | Value: List of children (instance of `SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]')
		indexing
			description: "Children table"
			external_name: "ChildrenTable"
		end
		
	build_types_table is
		indexing
			description: "Build types table."
			external_name: "BuildTypesTable"
		do
			build_data_table
			build_data_grid
		end
		
	build_data_table is
		indexing
			description: "Build `data_table'."
			external_name: "BuildDataTable"
		local
			type: SYSTEM_TYPE
		do
			create data_table.make_datatable_1 (dictionary.Data_table_title)
			
				-- Create table columns
			type := type_factory.Get_Type_String (dictionary.System_string_type)
			create eiffel_name_column.make_datacolumn_2 (dictionary.Eiffel_name_column_title, type)
			create external_name_column.make_datacolumn_2 (dictionary.External_name_column_title, type)

				-- Add columns to data table
			data_table.get_Columns.Add_Data_Column (eiffel_name_column)
			data_table.get_Columns.Add_Data_Column (external_name_column)
		end

	build_data_grid is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGrid"
		local
			row: SYSTEM_DATA_DATAROW
			data_grid_table_style: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE		
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			added: INTEGER
			a_color: SYSTEM_DRAWING_COLOR
			on_cell_delegate: SYSTEM_EVENTHANDLER
			style: SYSTEM_DRAWING_FONTSTYLE
		do
				-- Build data grid	
			create data_grid.make_datagrid
			data_grid.Begin_Init
			data_grid.set_Visible (True)
			data_grid.set_caption_text (dictionary.Caption_text)
			create data_grid_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, style.Regular)
			data_grid.set_font (data_grid_font)
			
			a_point.set_x (0)
			a_point.set_y (dictionary.Margin + 4 * dictionary.Label_height)
			data_grid.set_location (a_point)
			a_size.set_width (dictionary.Window_width - dictionary.Margin // 2)
			a_size.set_height (dictionary.Window_height - 4 * dictionary.Margin - 4 * dictionary.Label_height)
			data_grid.set_size (a_size)
			data_grid.set_Data_Source (data_table)
			data_grid.set_Tab_Index (0)
			data_grid.End_Init 
			
				-- Table styles
			create eiffel_name_column_style.make_datagridtextboxcolumn
			create external_name_column_style.make_datagridtextboxcolumn
			
				-- Set `MappingName'.
			eiffel_name_column_style.set_mapping_name (dictionary.Eiffel_name_column_title)
			external_name_column_style.set_mapping_name (dictionary.External_name_column_title)

				-- Set `HeaderText'.
			eiffel_name_column_style.set_header_text (dictionary.Eiffel_name_column_title)
			external_name_column_style.set_header_text (dictionary.External_name_column_title)
			
				-- Set `width'.
			set_default_column_width
			set_read_only
			
				-- Set styles.
			create data_grid_table_style.make_datagridtablestyle_1 
			data_grid_table_style.set_back_color (a_color.get_White)
			data_grid_table_style.set_Preferred_Column_Width (dictionary.Window_width // 2)
			data_grid_table_style.set_preferred_row_height (dictionary.Row_height)
			data_grid_table_style.set_read_only (True)
			data_grid_table_style.set_row_headers_visible (False)
			data_grid_table_style.set_column_headers_visible (True)
			data_grid_table_style.set_mapping_name (dictionary.Data_table_title)
			data_grid_table_style.set_allow_sorting (False)
			
			added := data_grid_table_style.get_grid_column_styles.add (eiffel_name_column_style)
			added := data_grid_table_style.get_grid_column_styles.add (external_name_column_style)
			
			if not data_grid.get_Table_Styles.contains_data_grid_table_style (data_grid_table_style) then
				added := data_grid.get_Table_Styles.Add (data_grid_table_style)
			end	
			create on_cell_delegate.make_eventhandler (Current, $on_cell)
			data_grid.add_current_cell_changed (on_cell_delegate)	
			data_grid.add_click (on_cell_delegate)	
		end

	set_default_column_width is
		indexing
			description: "Set default column width according to the content."
			external_name: "SetDefaultColumnWidth"
		local
			resizing_support: RESIZING_SUPPORT
			eiffel_name_width: INTEGER
			external_name_width: INTEGER
		do
			create resizing_support.make (data_grid_font, dictionary.Window_width)
			eiffel_name_width := resizing_support.eiffel_name_column_width_from_classes (type_list)
			eiffel_name_column_style.set_width (eiffel_name_width)
			external_name_width := resizing_support.external_name_column_width_from_classes (type_list)
			if (get_width > dictionary.Window_width and external_name_width + eiffel_name_width < get_width) or (get_width <= dictionary.Window_width and external_name_width + eiffel_name_width < get_width - dictionary.Scrollbar_width) then
				external_name_column_style.set_width (get_width - eiffel_name_width - dictionary.Scrollbar_width)
			else
				external_name_column_style.set_width (external_name_width)
			end
		end

	set_read_only is
		indexing
			description: "Set read-only property to each column of the data grid."
			external_name: "SetReadOnly"
		do
			eiffel_name_column_style.set_read_only (True)
			external_name_column_style.set_read_only (True)	
		end
		
	display_types is
		indexing
			description: "Display types."
			external_name: "DisplayTypes"
		require
			non_void_type_list: type_list /= Void
		local
			row_count: INTEGER
			i: INTEGER
			a_class: ISE_REFLECTION_EIFFELCLASS
		do
			from
				row_count := 0
				i := 0
			until
				i = type_list.get_Count
			loop
				a_class ?= type_list.get_Item (i)
				if a_class /= Void then
					if not types.contains (a_class.get_eiffel_name) then
						types.add (a_class.get_eiffel_name, a_class)
					end
					build_row (a_class, row_count)
					row_count := row_count + 1
				end
				i := i + 1
			end
			fill_data_grid
		end

	build_row (a_class: ISE_REFLECTION_EIFFELCLASS; row_count: INTEGER) is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_class'."
			external_name: "BuildRow"
		require
			non_void_class: a_class /= Void
			positive_row_count: row_count >= 0
		local
			row: SYSTEM_DATA_DATAROW
		do
			row := data_table.New_Row
			data_table.get_rows.Add (row)
			row.get_Table.get_Default_View.set_Allow_Edit (False)
			row.get_Table.get_Default_View.set_Allow_New (False)
			row.get_Table.get_Default_View.set_Allow_Delete (False)
			row.set_Item_String (dictionary.Eiffel_name_column_title, a_class.get_eiffel_name)
			row.set_Item_String (dictionary.External_name_column_title, a_class.get_external_name)			
		end

	build_empty_row (row_count: INTEGER) is 
		indexing
			description: "Build a row at index `row_count'."
			external_name: "BuildEmptyRow"
		require
			positive_row_count: row_count >= 0
		local
			row: SYSTEM_DATA_DATAROW
		do
			row := data_table.New_Row
			data_table.get_rows.Add (row)
			row.get_Table.get_Default_View.set_Allow_Edit (False)
			row.get_Table.get_Default_View.set_Allow_New (False)
			row.get_Table.get_Default_View.set_Allow_Delete (False)
			row.set_Item_String (dictionary.Eiffel_name_column_title, dictionary.Empty_string)
			row.set_Item_String (dictionary.External_name_column_title, dictionary.Empty_string)		
		end
		
	fill_data_grid is
		indexing
			description: "Fill data grid with empty rows if not enough dependancies to fill the grid."
			external_name: "FillDataGrid"
		require
			non_void_data_grid: data_grid /= Void
		local
			i: INTEGER
			difference: INTEGER
			rows: SYSTEM_DATA_DATAROWCOLLECTION
			retried: BOOLEAN
		do
			if not retried then
				rows := data_table.get_rows
				if (rows.get_count + 3) * dictionary.Row_height < get_height - 4 * dictionary.Margin - 4 * dictionary.Label_height then
					difference := get_height - 4 * dictionary.Margin - 4 * dictionary.Label_height - (rows.get_count + 3) * dictionary.Row_height
					empty_row_count := difference // dictionary.Row_height + 1
					from
					until
						i = empty_row_count
					loop
						build_empty_row (rows.get_count)
						i := i + 1
					end
				end
			end
		rescue
			retried := True
			retry
		end
	
	empty_row_count: INTEGER
		indexing
			description: "Number of empty rows added to the data grid"
			external_name: "EmptyRowCount"
		end

	sort_classes is
		indexing
			description: "Sort classes by Eiffel name."
			external_name: "SortClasses"
		require
			non_void_type_list: type_list /= Void
		local
			sort_support: SORTING_SUPPORT
		do
			create sort_support
			sort_support.sort_eiffel_classes (type_list)
			type_list := sort_support.sorted_list
		end
		
end -- class ASSEMBLY_VIEW