indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGridTableStyle"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATA_GRID_TABLE_STYLE

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WINFORMS_IDATA_GRID_EDITING_SERVICE

create
	make_winforms_data_grid_table_style,
	make_winforms_data_grid_table_style_1,
	make_winforms_data_grid_table_style_2

feature {NONE} -- Initialization

	frozen make_winforms_data_grid_table_style (is_default_table_style: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Windows.Forms.DataGridTableStyle"
		end

	frozen make_winforms_data_grid_table_style_1 is
		external
			"IL creator use System.Windows.Forms.DataGridTableStyle"
		end

	frozen make_winforms_data_grid_table_style_2 (list_manager: WINFORMS_CURRENCY_MANAGER) is
		external
			"IL creator signature (System.Windows.Forms.CurrencyManager) use System.Windows.Forms.DataGridTableStyle"
		end

feature -- Access

	get_grid_column_styles: WINFORMS_GRID_COLUMN_STYLES_COLLECTION is
		external
			"IL signature (): System.Windows.Forms.GridColumnStylesCollection use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_GridColumnStyles"
		end

	frozen get_row_header_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_RowHeaderWidth"
		end

	frozen get_column_headers_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_ColumnHeadersVisible"
		end

	frozen get_preferred_column_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_PreferredColumnWidth"
		end

	frozen get_mapping_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_MappingName"
		end

	frozen get_header_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_HeaderForeColor"
		end

	frozen get_allow_sorting: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_AllowSorting"
		end

	frozen get_header_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_HeaderBackColor"
		end

	frozen default_table_style: WINFORMS_DATA_GRID_TABLE_STYLE is
		external
			"IL static_field signature :System.Windows.Forms.DataGridTableStyle use System.Windows.Forms.DataGridTableStyle"
		alias
			"DefaultTableStyle"
		end

	frozen get_grid_line_style: WINFORMS_DATA_GRID_LINE_STYLE is
		external
			"IL signature (): System.Windows.Forms.DataGridLineStyle use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_GridLineStyle"
		end

	frozen get_header_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_HeaderFont"
		end

	frozen get_row_headers_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_RowHeadersVisible"
		end

	frozen get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_ForeColor"
		end

	get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_ReadOnly"
		end

	frozen get_selection_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_SelectionForeColor"
		end

	frozen get_preferred_row_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_PreferredRowHeight"
		end

	frozen get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_BackColor"
		end

	frozen get_selection_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_SelectionBackColor"
		end

	frozen get_link_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_LinkColor"
		end

	frozen get_link_hover_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_LinkHoverColor"
		end

	frozen get_alternating_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_AlternatingBackColor"
		end

	get_data_grid: WINFORMS_DATA_GRID is
		external
			"IL signature (): System.Windows.Forms.DataGrid use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_DataGrid"
		end

	frozen get_grid_line_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGridTableStyle"
		alias
			"get_GridLineColor"
		end

feature -- Element Change

	frozen remove_header_font_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_HeaderFontChanged"
		end

	frozen set_link_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_LinkColor"
		end

	frozen remove_header_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_HeaderBackColorChanged"
		end

	frozen add_header_fore_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_HeaderForeColorChanged"
		end

	frozen remove_grid_line_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_GridLineColorChanged"
		end

	frozen remove_grid_line_style_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_GridLineStyleChanged"
		end

	frozen set_grid_line_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_GridLineColor"
		end

	frozen add_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_BackColorChanged"
		end

	frozen add_row_header_width_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_RowHeaderWidthChanged"
		end

	frozen remove_fore_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_ForeColorChanged"
		end

	frozen add_fore_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_ForeColorChanged"
		end

	frozen remove_alternating_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_AlternatingBackColorChanged"
		end

	frozen set_alternating_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_AlternatingBackColor"
		end

	frozen remove_row_header_width_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_RowHeaderWidthChanged"
		end

	frozen add_alternating_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_AlternatingBackColorChanged"
		end

	frozen add_column_headers_visible_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_ColumnHeadersVisibleChanged"
		end

	frozen add_preferred_row_height_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_PreferredRowHeightChanged"
		end

	frozen set_preferred_column_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_PreferredColumnWidth"
		end

	frozen remove_allow_sorting_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_AllowSortingChanged"
		end

	frozen add_mapping_name_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_MappingNameChanged"
		end

	frozen remove_mapping_name_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_MappingNameChanged"
		end

	frozen set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_BackColor"
		end

	frozen remove_selection_fore_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_SelectionForeColorChanged"
		end

	frozen add_preferred_column_width_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_PreferredColumnWidthChanged"
		end

	frozen set_grid_line_style (value: WINFORMS_DATA_GRID_LINE_STYLE) is
		external
			"IL signature (System.Windows.Forms.DataGridLineStyle): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_GridLineStyle"
		end

	frozen remove_preferred_column_width_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_PreferredColumnWidthChanged"
		end

	frozen add_link_hover_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_LinkHoverColorChanged"
		end

	frozen add_allow_sorting_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_AllowSortingChanged"
		end

	set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_ReadOnly"
		end

	set_data_grid (value: WINFORMS_DATA_GRID) is
		external
			"IL signature (System.Windows.Forms.DataGrid): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_DataGrid"
		end

	frozen remove_preferred_row_height_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_PreferredRowHeightChanged"
		end

	frozen set_allow_sorting (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_AllowSorting"
		end

	frozen remove_header_fore_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_HeaderForeColorChanged"
		end

	frozen add_grid_line_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_GridLineColorChanged"
		end

	frozen set_column_headers_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_ColumnHeadersVisible"
		end

	frozen add_link_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_LinkColorChanged"
		end

	frozen add_header_font_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_HeaderFontChanged"
		end

	frozen remove_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_BackColorChanged"
		end

	frozen add_row_headers_visible_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_RowHeadersVisibleChanged"
		end

	frozen add_grid_line_style_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_GridLineStyleChanged"
		end

	frozen set_header_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_HeaderForeColor"
		end

	frozen set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_ForeColor"
		end

	frozen remove_column_headers_visible_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_ColumnHeadersVisibleChanged"
		end

	frozen set_preferred_row_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_PreferredRowHeight"
		end

	frozen remove_selection_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_SelectionBackColorChanged"
		end

	frozen set_header_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_HeaderBackColor"
		end

	frozen set_header_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_HeaderFont"
		end

	frozen add_selection_fore_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_SelectionForeColorChanged"
		end

	frozen set_link_hover_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_LinkHoverColor"
		end

	frozen set_selection_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_SelectionBackColor"
		end

	frozen set_mapping_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_MappingName"
		end

	frozen remove_link_hover_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_LinkHoverColorChanged"
		end

	frozen remove_row_headers_visible_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_RowHeadersVisibleChanged"
		end

	frozen add_read_only_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_ReadOnlyChanged"
		end

	frozen add_header_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_HeaderBackColorChanged"
		end

	frozen remove_read_only_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_ReadOnlyChanged"
		end

	frozen set_selection_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_SelectionForeColor"
		end

	frozen set_row_header_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_RowHeaderWidth"
		end

	frozen set_row_headers_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"set_RowHeadersVisible"
		end

	frozen add_selection_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"add_SelectionBackColorChanged"
		end

	frozen remove_link_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"remove_LinkColorChanged"
		end

feature -- Basic Operations

	frozen reset_header_fore_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetHeaderForeColor"
		end

	frozen reset_fore_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetForeColor"
		end

	frozen reset_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetBackColor"
		end

	frozen reset_link_hover_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetLinkHoverColor"
		end

	frozen reset_header_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetHeaderBackColor"
		end

	frozen reset_selection_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetSelectionBackColor"
		end

	frozen reset_grid_line_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetGridLineColor"
		end

	frozen reset_selection_fore_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetSelectionForeColor"
		end

	frozen reset_link_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetLinkColor"
		end

	frozen reset_alternating_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetAlternatingBackColor"
		end

	frozen begin_edit (grid_column: WINFORMS_DATA_GRID_COLUMN_STYLE; row_number: INTEGER): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle, System.Int32): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"BeginEdit"
		end

	frozen end_edit (grid_column: WINFORMS_DATA_GRID_COLUMN_STYLE; row_number: INTEGER; should_abort: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle, System.Int32, System.Boolean): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"EndEdit"
		end

	frozen reset_header_font is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"ResetHeaderFont"
		end

feature {NONE} -- Implementation

	should_serialize_alternating_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeAlternatingBackColor"
		end

	frozen should_serialize_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeBackColor"
		end

	on_link_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnLinkColorChanged"
		end

	should_serialize_link_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeLinkColor"
		end

	frozen should_serialize_fore_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeForeColor"
		end

	frozen should_serialize_selection_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeSelectionBackColor"
		end

	on_link_hover_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnLinkHoverColorChanged"
		end

	on_preferred_column_width_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnPreferredColumnWidthChanged"
		end

	should_serialize_header_fore_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeHeaderForeColor"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"Dispose"
		end

	on_read_only_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnReadOnlyChanged"
		end

	on_column_headers_visible_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnColumnHeadersVisibleChanged"
		end

	on_alternating_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnAlternatingBackColorChanged"
		end

	on_allow_sorting_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnAllowSortingChanged"
		end

	on_fore_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnForeColorChanged"
		end

	on_grid_line_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnGridLineColorChanged"
		end

	create_grid_column (prop: SYSTEM_DLL_PROPERTY_DESCRIPTOR): WINFORMS_DATA_GRID_COLUMN_STYLE is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Windows.Forms.DataGridColumnStyle use System.Windows.Forms.DataGridTableStyle"
		alias
			"CreateGridColumn"
		end

	on_selection_fore_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnSelectionForeColorChanged"
		end

	on_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnBackColorChanged"
		end

	on_preferred_row_height_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnPreferredRowHeightChanged"
		end

	on_grid_line_style_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnGridLineStyleChanged"
		end

	frozen should_serialize_preferred_row_height: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializePreferredRowHeight"
		end

	should_serialize_grid_line_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeGridLineColor"
		end

	should_serialize_selection_fore_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeSelectionForeColor"
		end

	should_serialize_header_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeHeaderBackColor"
		end

	on_selection_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnSelectionBackColorChanged"
		end

	on_row_headers_visible_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnRowHeadersVisibleChanged"
		end

	create_grid_column_property_descriptor_boolean (prop: SYSTEM_DLL_PROPERTY_DESCRIPTOR; is_default: BOOLEAN): WINFORMS_DATA_GRID_COLUMN_STYLE is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor, System.Boolean): System.Windows.Forms.DataGridColumnStyle use System.Windows.Forms.DataGridTableStyle"
		alias
			"CreateGridColumn"
		end

	on_header_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnHeaderBackColorChanged"
		end

	on_header_fore_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnHeaderForeColorChanged"
		end

	on_header_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnHeaderFontChanged"
		end

	should_serialize_link_hover_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTableStyle"
		alias
			"ShouldSerializeLinkHoverColor"
		end

	on_mapping_name_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnMappingNameChanged"
		end

	on_row_header_width_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGridTableStyle"
		alias
			"OnRowHeaderWidthChanged"
		end

end -- class WINFORMS_DATA_GRID_TABLE_STYLE
