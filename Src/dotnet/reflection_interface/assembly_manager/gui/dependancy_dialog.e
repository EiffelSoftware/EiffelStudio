indexing
	description: "Dialog showing dependancies of a .NET assembly"
	external_name: "ISE.AssemblyManager.DependancyDialog"

deferred class
	DEPENDANCY_DIALOG
	
inherit
	DIALOG
		redefine
			dictionary
		end

feature -- Access

	dependancies: ARRAY [CLI_CELL[ASSEMBLY_NAME]]
		indexing
			description: "Assembly dependancies"
			external_name: "Dependancies"
		end

	dependancies_label: WINFORMS_LABEL
		indexing
			description: "Dependancies label"
			external_name: "DependanciesLabel"
		end

	dictionary: DEPENDANCY_DIALOG_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once 
			create Result
		end
		
feature {NONE} -- Implementation

	assembly_name_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Assembly name column style"
			external_name: "AssemblyNameColumnStyle"
		end
		
	assembly_version_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Assembly versopm column style"
			external_name: "AssemblyVersionColumnStyle"
		end
		
	assembly_culture_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Assembly culture column style"
			external_name: "AssemblyCultureColumnStyle"
		end
		
	assembly_public_key_column_style: WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
		indexing
			description: "Assembly public key column style"
			external_name: "AssemblyPublicKeyColumnStyle"
		end

	assembly_name_column: DATA_DATA_COLUMN
		indexing
			description: "Assembly name column"
			external_name: "AssemblyNameColumn"
		end

	assembly_version_column: DATA_DATA_COLUMN
		indexing
			description: "Assembly version column"
			external_name: "AssemblyVersionColumn"
		end

	assembly_culture_column: DATA_DATA_COLUMN
		indexing
			description: "Assembly culture column"
			external_name: "AssemblyCultureColumn"
		end

	assembly_public_key_column: DATA_DATA_COLUMN
		indexing
			description: "Assembly public_key column"
			external_name: "AssemblyPublicKeyColumn"
		end

	data_grid: WINFORMS_DATA_GRID
		indexing
			description: "Data grid associated with `data_table'"
			external_name: "DataGrid"
		end
				
	data_table: DATA_DATA_TABLE
		indexing
			description: "Data table"
			external_name: "DataTable"
		end

	data_grid_font: DRAWING_FONT
		indexing
			description: "Data grid font"
			external_name: "DataGridFont"
		end

	type_factory: TYPE
		indexing
			description: "Statics needed to create a type"
			external_name: "TypeFactory"
		end
		
	build_table is
		indexing
			description: "Build dependancies table."
			external_name: "BuildTable"
		do
			build_data_table
			build_data_grid
		end
		
	build_data_table is
		indexing
			description: "Build `data_table'."
			external_name: "BuildDataTable"
		local
			type: TYPE
		do
			create data_table.make_data_data_table_1 (dictionary.Data_table_title.to_cil)
			
				-- Create table columns
			type := type_factory.Get_Type_String (dictionary.System_string_type.to_cil);
			create assembly_name_column.make_data_data_column_2 (dictionary.Assembly_name_column_title.to_cil, type)
			create assembly_version_column.make_data_data_column_2 (dictionary.Assembly_version_column_title.to_cil, type)
			create assembly_culture_column.make_data_data_column_2 (dictionary.Assembly_culture_column_title.to_cil, type)
			create assembly_public_key_column.make_data_data_column_2 (dictionary.Assembly_public_key_column_title.to_cil, type)

				-- Add columns to data table
			data_table.get_Columns.Add_Data_Column (assembly_name_column)
			data_table.get_Columns.Add_Data_Column (assembly_version_column)
			data_table.get_Columns.Add_Data_Column (assembly_culture_column)
			data_table.get_Columns.Add_Data_Column (assembly_public_key_column)
		end

	build_data_grid is
		indexing
			description: "Build `data_grid' and associate actions."
			external_name: "BuildDataGrid"
		local
			row: DATA_DATA_ROW
			data_grid_table_style: WINFORMS_DATA_GRID_TABLE_STYLE		
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			added: INTEGER
			assembly: ASSEMBLY
			a_color: DRAWING_COLOR
			style: DRAWING_FONT_STYLE
		do
				-- Build data grid	
			create data_grid.make_winforms_data_grid
			data_grid.Begin_Init
			data_grid.set_Visible (True)
			create data_grid_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Regular)
			data_grid.set_font (data_grid_font)
			
			a_point.set_x (0)
			a_point.set_y (dictionary.Margin + 4 * dictionary.Label_height)
			data_grid.set_location (a_point)
			data_grid.set_Data_Source (data_table)
			data_grid.set_Tab_Index (0)
			data_grid.End_Init 
			
				-- Table styles
			create assembly_name_column_style.make_winforms_data_grid_text_box_column
			create assembly_version_column_style.make_winforms_data_grid_text_box_column
			create assembly_culture_column_style.make_winforms_data_grid_text_box_column
			create assembly_public_key_column_style.make_winforms_data_grid_text_box_column
			
				-- Set `MappingName'.
			assembly_name_column_style.set_mapping_name (dictionary.Assembly_name_column_title.to_cil)
			assembly_version_column_style.set_mapping_name (dictionary.Assembly_version_column_title.to_cil)
			assembly_culture_column_style.set_mapping_name (dictionary.Assembly_culture_column_title.to_cil)
			assembly_public_key_column_style.set_mapping_name (dictionary.Assembly_public_key_column_title.to_cil)

				-- Set `HeaderText'.
			assembly_name_column_style.set_header_text (dictionary.Assembly_name_column_title.to_cil)
			assembly_version_column_style.set_header_text (dictionary.Assembly_version_column_title.to_cil)
			assembly_culture_column_style.set_header_text (dictionary.Assembly_culture_column_title.to_cil)
			assembly_public_key_column_style.set_header_text (dictionary.Assembly_public_key_column_title.to_cil)
			
				-- Set `width'.
			set_default_column_width
			set_read_only
			
				-- Set styles.
			create data_grid_table_style.make_winforms_data_grid_table_style_1 
			data_grid_table_style.set_back_color (a_color.get_White)
			data_grid_table_style.set_Preferred_Column_Width (dictionary.Window_width // 6)
			data_grid_table_style.set_preferred_row_height (dictionary.Row_height)
			data_grid_table_style.set_read_only (True)
			data_grid_table_style.set_row_headers_visible (False)
			data_grid_table_style.set_column_headers_visible (True)
			data_grid_table_style.set_mapping_name (dictionary.Data_table_title.to_cil)
			data_grid_table_style.set_allow_sorting (False)
			
			added := data_grid_table_style.get_grid_column_styles.add (assembly_name_column_style)
			added := data_grid_table_style.get_grid_column_styles.add (assembly_version_column_style)
			added := data_grid_table_style.get_grid_column_styles.add (assembly_culture_column_style)
			added := data_grid_table_style.get_grid_column_styles.add (assembly_public_key_column_style)
			
			if not data_grid.get_Table_Styles.contains_data_grid_table_style (data_grid_table_style) then
				added := data_grid.get_Table_Styles.add (data_grid_table_style)
			end	
		end

	build_dependancies_list is			
		indexing
			description: "Build `dependancies_list'"
			external_name: "BuildDependanciesList"
		local
			support: CONVERSION_SUPPORT
			an_assembly_name: ASSEMBLY_NAME
			a_descriptor: ASSEMBLY_DESCRIPTOR
			retried: BOOLEAN
			item: CLI_CELL [ASSEMBLY_NAME]
			i: INTEGER
		do
			create dependancies_list.make
			if not retried then
				create support
				from
					i := 1
				until
					i > dependancies.count
				loop
					item := dependancies.item (i)
					if item /= Void then 
						an_assembly_name := item.item
						if an_assembly_name /= Void then
							a_descriptor := support.assembly_descriptor_from_name (an_assembly_name)
							if a_descriptor /= Void then
								dependancies_list.extend (a_descriptor)
							end
						end
					end
					i := i +1
				end
			end
		ensure
			non_void_dependancies_list: dependancies_list /= Void
		rescue
			retried := True
			retry
		end
	
	dependancies_list: LINKED_LIST [ASSEMBLY_DESCRIPTOR] 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ASSEMBLYDESCRIPTOR]
		indexing
			description: "Dependancies list"
			external_name: "DependanciesList"
		end
	
	set_default_column_width is
		indexing
			description: "Set default column width according to the content."
			external_name: "SetDefaultColumnWidth"
		local
			resizing_support: RESIZING_SUPPORT
			name_width: INTEGER
			version_width: INTEGER
			culture_width: INTEGER
			total_width: INTEGER
		do
			create resizing_support.make (data_grid_font, dictionary.Window_width)
			name_width := resizing_support.assembly_name_column_width_from_info (dependancies_list)
			version_width := resizing_support.assembly_version_column_width_from_info (dependancies_list)
			culture_width := resizing_support.assembly_culture_column_width_from_info (dependancies_list)
			assembly_name_column_style.set_width (name_width)
			assembly_version_column_style.set_width (version_width)
			assembly_culture_column_style.set_width (culture_width)
			total_width := name_width + version_width + culture_width
			assembly_public_key_column_style.set_width (dictionary.Window_width - total_width - dictionary.Scrollbar_width)
		end

	set_read_only is
		indexing
			description: "Set read-only property to each column of the data grid."
			external_name: "SetReadOnly"
		do
			assembly_name_column_style.set_read_only (True)
			assembly_version_column_style.set_read_only (True)
			assembly_culture_column_style.set_read_only (True)
			assembly_public_key_column_style.set_read_only (True)	
		end
		
	display_dependancies is
		indexing
			description: "Display dependancies."
			external_name: "DisplayDependancies"
		require
			non_void_dependancies_list: dependancies_list /= Void
		local
			row_count: INTEGER
			i: INTEGER
			a_descriptor: ASSEMBLY_DESCRIPTOR
		do
			from
				row_count := 0
				dependancies_list.start
			until
				dependancies_list.after
			loop
				a_descriptor ?= dependancies_list.item
				if a_descriptor /= Void then
					build_row (a_descriptor, row_count)
					row_count := row_count + 1
				end
				dependancies_list.forth
			end
			fill_data_grid
		end

	build_row (a_descriptor: ASSEMBLY_DESCRIPTOR; row_count: INTEGER) is 
		indexing
			description: "Build a row at index `row_count' and fill row with information from `a_descriptor'."
			external_name: "BuildRow"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			positive_row_count: row_count >= 0
		local
			row: DATA_DATA_ROW
		do
			row := data_table.New_Row
			data_table.get_rows.Add (row)
			row.get_Table.get_Default_View.set_Allow_Edit (False)
			row.get_Table.get_Default_View.set_Allow_New (False)
			row.get_Table.get_Default_View.set_Allow_Delete (False)
			row.set_Item_String (dictionary.Assembly_name_column_title.to_cil, a_descriptor.name.to_cil)
			row.set_Item_String (dictionary.Assembly_version_column_title.to_cil, a_descriptor.version.to_cil)
			row.set_Item_String (dictionary.Assembly_culture_column_title.to_cil, a_descriptor.culture.to_cil)
			row.set_Item_String (dictionary.Assembly_public_key_column_title.to_cil, a_descriptor.public_key.to_cil)			
		end

	build_empty_row (row_count: INTEGER) is 
		indexing
			description: "Build a row at index `row_count'."
			external_name: "BuildEmptyRow"
		require
			positive_row_count: row_count >= 0
		local
			row: DATA_DATA_ROW
		do
			row := data_table.New_Row
			data_table.get_rows.Add (row)
			row.get_Table.get_Default_View.set_Allow_Edit (False)
			row.get_Table.get_Default_View.set_Allow_New (False)
			row.get_Table.get_Default_View.set_Allow_Delete (False)
			row.set_Item_String (dictionary.Assembly_name_column_title.to_cil, dictionary.Empty_string.to_cil)
			row.set_Item_String (dictionary.Assembly_version_column_title.to_cil, dictionary.Empty_string.to_cil)
			row.set_Item_String (dictionary.Assembly_culture_column_title.to_cil, dictionary.Empty_string.to_cil)
			row.set_Item_String (dictionary.Assembly_public_key_column_title.to_cil, dictionary.Empty_string.to_cil)			
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
			rows: DATA_DATA_ROW_COLLECTION
			retried: BOOLEAN
		do
			if not retried then
				rows := data_table.get_rows
				if (rows.get_count + 3) * dictionary.Row_height < dictionary.Window_height - 4 * dictionary.Margin - 4 * dictionary.Label_height then
					difference := dictionary.Window_height - 4 * dictionary.Margin - 4 * dictionary.Label_height - (rows.get_count + 3) * dictionary.Row_height
					empty_row_count := difference // dictionary.Row_height + 1
					from
					until
						i = empty_row_count
					loop
						build_empty_row (rows.get_count)
						i := i + 1
					end
				else
					build_empty_row (rows.get_count)
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

end -- class DEPENDANCY_DIALOG
