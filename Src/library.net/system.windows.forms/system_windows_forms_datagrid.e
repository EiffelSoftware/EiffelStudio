indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DataGrid"

external class
	SYSTEM_WINDOWS_FORMS_DATAGRID

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISUPPORTINITIALIZE
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IDATAGRIDEDITINGSERVICE
	SYSTEM_WINDOWS_FORMS_CONTROL
		redefine
			reset_fore_color,
			reset_back_color,
			process_key_preview,
			process_dialog_key,
			on_resize,
			on_paint_background,
			on_paint,
			on_mouse_wheel,
			on_mouse_up,
			on_mouse_move,
			on_mouse_leave,
			on_mouse_down,
			on_leave,
			on_layout,
			on_key_press,
			on_key_down,
			on_enter,
			on_handle_destroyed,
			on_handle_created,
			on_fore_color_changed,
			on_font_changed,
			on_binding_context_changed,
			on_back_color_changed,
			create_accessibility_instance,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			get_default_size,
			set_cursor,
			get_cursor,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			dispose_boolean
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_datagrid

feature {NONE} -- Initialization

	frozen make_datagrid is
		external
			"IL creator use System.Windows.Forms.DataGrid"
		end

feature -- Access

	frozen get_row_header_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid"
		alias
			"get_RowHeaderWidth"
		end

	frozen get_caption_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.DataGrid"
		alias
			"get_CaptionFont"
		end

	frozen get_parent_rows_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_ParentRowsBackColor"
		end

	frozen get_flat_mode: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"get_FlatMode"
		end

	frozen get_visible_column_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid"
		alias
			"get_VisibleColumnCount"
		end

	frozen get_parent_rows_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_ParentRowsForeColor"
		end

	frozen get_current_cell: SYSTEM_WINDOWS_FORMS_DATAGRIDCELL is
		external
			"IL signature (): System.Windows.Forms.DataGridCell use System.Windows.Forms.DataGrid"
		alias
			"get_CurrentCell"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_BackColor"
		end

	frozen get_alternating_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_AlternatingBackColor"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.DataGrid"
		alias
			"get_BackgroundImage"
		end

	frozen get_grid_line_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_GridLineColor"
		end

	frozen get_selection_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_SelectionBackColor"
		end

	frozen get_visible_row_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid"
		alias
			"get_VisibleRowCount"
		end

	frozen get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"get_ReadOnly"
		end

	frozen get_selection_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_SelectionForeColor"
		end

	frozen get_current_row_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid"
		alias
			"get_CurrentRowIndex"
		end

	frozen get_link_hover_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_LinkHoverColor"
		end

	frozen get_allow_sorting: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"get_AllowSorting"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGrid"
		alias
			"get_Text"
		end

	frozen get_caption_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_CaptionForeColor"
		end

	frozen get_caption_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"get_CaptionVisible"
		end

	frozen get_caption_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGrid"
		alias
			"get_CaptionText"
		end

	frozen auto_column_size: INTEGER is 0xffffffff

	frozen get_grid_line_style: SYSTEM_WINDOWS_FORMS_DATAGRIDLINESTYLE is
		external
			"IL signature (): System.Windows.Forms.DataGridLineStyle use System.Windows.Forms.DataGrid"
		alias
			"get_GridLineStyle"
		end

	frozen get_header_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_HeaderForeColor"
		end

	frozen get_data_member: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGrid"
		alias
			"get_DataMember"
		end

	frozen get_column_headers_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"get_ColumnHeadersVisible"
		end

	frozen get_link_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_LinkColor"
		end

	frozen get_header_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_HeaderBackColor"
		end

	frozen get_header_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.DataGrid"
		alias
			"get_HeaderFont"
		end

	frozen get_parent_rows_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"get_ParentRowsVisible"
		end

	frozen get_item_int32 (row_index: INTEGER; column_index: INTEGER): ANY is
		external
			"IL signature (System.Int32, System.Int32): System.Object use System.Windows.Forms.DataGrid"
		alias
			"get_Item"
		end

	frozen get_first_visible_column: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid"
		alias
			"get_FirstVisibleColumn"
		end

	frozen get_preferred_row_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid"
		alias
			"get_PreferredRowHeight"
		end

	get_cursor: SYSTEM_WINDOWS_FORMS_CURSOR is
		external
			"IL signature (): System.Windows.Forms.Cursor use System.Windows.Forms.DataGrid"
		alias
			"get_Cursor"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.DataGrid"
		alias
			"get_BorderStyle"
		end

	frozen get_row_headers_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"get_RowHeadersVisible"
		end

	frozen get_background_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_BackgroundColor"
		end

	frozen get_caption_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_CaptionBackColor"
		end

	frozen get_preferred_column_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid"
		alias
			"get_PreferredColumnWidth"
		end

	frozen get_parent_rows_label_style: SYSTEM_WINDOWS_FORMS_DATAGRIDPARENTROWSLABELSTYLE is
		external
			"IL signature (): System.Windows.Forms.DataGridParentRowsLabelStyle use System.Windows.Forms.DataGrid"
		alias
			"get_ParentRowsLabelStyle"
		end

	frozen get_table_styles: SYSTEM_WINDOWS_FORMS_GRIDTABLESTYLESCOLLECTION is
		external
			"IL signature (): System.Windows.Forms.GridTableStylesCollection use System.Windows.Forms.DataGrid"
		alias
			"get_TableStyles"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DataGrid"
		alias
			"get_ForeColor"
		end

	frozen get_item (cell: SYSTEM_WINDOWS_FORMS_DATAGRIDCELL): ANY is
		external
			"IL signature (System.Windows.Forms.DataGridCell): System.Object use System.Windows.Forms.DataGrid"
		alias
			"get_Item"
		end

	frozen get_allow_navigation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"get_AllowNavigation"
		end

	frozen get_data_source: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.DataGrid"
		alias
			"get_DataSource"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_Text"
		end

	set_cursor (value: SYSTEM_WINDOWS_FORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_Cursor"
		end

	frozen set_header_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_HeaderFont"
		end

	frozen set_parent_rows_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_ParentRowsBackColor"
		end

	frozen add_read_only_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_ReadOnlyChanged"
		end

	frozen set_caption_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_CaptionVisible"
		end

	frozen remove_allow_navigation_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_AllowNavigationChanged"
		end

	frozen set_grid_line_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_GridLineColor"
		end

	frozen remove_navigate (value: SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.NavigateEventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_Navigate"
		end

	frozen set_grid_line_style (value: SYSTEM_WINDOWS_FORMS_DATAGRIDLINESTYLE) is
		external
			"IL signature (System.Windows.Forms.DataGridLineStyle): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_GridLineStyle"
		end

	frozen remove_parent_rows_label_style_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_ParentRowsLabelStyleChanged"
		end

	frozen add_scroll (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_Scroll"
		end

	frozen set_data_source (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_DataSource"
		end

	frozen set_alternating_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_AlternatingBackColor"
		end

	frozen set_data_member (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_DataMember"
		end

	frozen set_caption_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_CaptionBackColor"
		end

	frozen set_preferred_column_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_PreferredColumnWidth"
		end

	frozen remove_background_color_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_BackgroundColorChanged"
		end

	frozen set_link_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_LinkColor"
		end

	frozen set_link_hover_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_LinkHoverColor"
		end

	frozen set_caption_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_CaptionForeColor"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_BackColor"
		end

	frozen add_border_style_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_BorderStyleChanged"
		end

	frozen set_allow_navigation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_AllowNavigation"
		end

	frozen add_show_parent_details_button_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_ShowParentDetailsButtonClick"
		end

	frozen remove_data_source_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_DataSourceChanged"
		end

	frozen set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_ReadOnly"
		end

	frozen set_background_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_BackgroundColor"
		end

	frozen set_allow_sorting (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_AllowSorting"
		end

	frozen remove_read_only_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_ReadOnlyChanged"
		end

	frozen set_column_headers_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_ColumnHeadersVisible"
		end

	frozen add_parent_rows_label_style_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_ParentRowsLabelStyleChanged"
		end

	frozen remove_parent_rows_visible_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_ParentRowsVisibleChanged"
		end

	frozen add_caption_visible_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_CaptionVisibleChanged"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_BackgroundImage"
		end

	frozen add_flat_mode_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_FlatModeChanged"
		end

	frozen add_back_button_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_BackButtonClick"
		end

	frozen remove_caption_visible_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_CaptionVisibleChanged"
		end

	frozen set_header_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_HeaderForeColor"
		end

	frozen remove_show_parent_details_button_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_ShowParentDetailsButtonClick"
		end

	frozen remove_scroll (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_Scroll"
		end

	frozen add_data_source_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_DataSourceChanged"
		end

	frozen set_flat_mode (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_FlatMode"
		end

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_BORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_BorderStyle"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_ForeColor"
		end

	frozen add_current_cell_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_CurrentCellChanged"
		end

	frozen add_parent_rows_visible_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_ParentRowsVisibleChanged"
		end

	frozen set_header_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_HeaderBackColor"
		end

	frozen set_parent_rows_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_ParentRowsForeColor"
		end

	frozen add_navigate (value: SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.NavigateEventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_Navigate"
		end

	frozen remove_current_cell_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_CurrentCellChanged"
		end

	frozen set_parent_rows_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_ParentRowsVisible"
		end

	frozen set_current_row_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_CurrentRowIndex"
		end

	frozen add_background_color_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_BackgroundColorChanged"
		end

	frozen set_caption_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_CaptionFont"
		end

	frozen set_selection_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_SelectionBackColor"
		end

	frozen set_current_cell (value: SYSTEM_WINDOWS_FORMS_DATAGRIDCELL) is
		external
			"IL signature (System.Windows.Forms.DataGridCell): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_CurrentCell"
		end

	frozen set_preferred_row_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_PreferredRowHeight"
		end

	frozen set_parent_rows_label_style (value: SYSTEM_WINDOWS_FORMS_DATAGRIDPARENTROWSLABELSTYLE) is
		external
			"IL signature (System.Windows.Forms.DataGridParentRowsLabelStyle): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_ParentRowsLabelStyle"
		end

	frozen add_allow_navigation_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_AllowNavigationChanged"
		end

	frozen remove_border_style_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_BorderStyleChanged"
		end

	frozen set_caption_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_CaptionText"
		end

	frozen remove_back_button_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_BackButtonClick"
		end

	frozen set_selection_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_SelectionForeColor"
		end

	frozen set_item_int32 (row_index: INTEGER; column_index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Int32, System.Object): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_Item"
		end

	frozen set_row_header_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_RowHeaderWidth"
		end

	frozen set_row_headers_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_RowHeadersVisible"
		end

	frozen remove_flat_mode_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_FlatModeChanged"
		end

	frozen set_item (cell: SYSTEM_WINDOWS_FORMS_DATAGRIDCELL; value: ANY) is
		external
			"IL signature (System.Windows.Forms.DataGridCell, System.Object): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen reset_header_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetHeaderBackColor"
		end

	frozen reset_selection_fore_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetSelectionForeColor"
		end

	frozen reset_link_hover_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetLinkHoverColor"
		end

	frozen reset_grid_line_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetGridLineColor"
		end

	frozen un_select (row: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGrid"
		alias
			"UnSelect"
		end

	reset_fore_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetForeColor"
		end

	frozen get_cell_bounds_int32 (row: INTEGER; col: INTEGER): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (System.Int32, System.Int32): System.Drawing.Rectangle use System.Windows.Forms.DataGrid"
		alias
			"GetCellBounds"
		end

	frozen set_data_binding (data_source: ANY; data_member: STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Windows.Forms.DataGrid"
		alias
			"SetDataBinding"
		end

	frozen end_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"EndInit"
		end

	frozen reset_link_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetLinkColor"
		end

	frozen get_cell_bounds (dgc: SYSTEM_WINDOWS_FORMS_DATAGRIDCELL): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (System.Windows.Forms.DataGridCell): System.Drawing.Rectangle use System.Windows.Forms.DataGrid"
		alias
			"GetCellBounds"
		end

	frozen select__int32 (row: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGrid"
		alias
			"Select"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"BeginInit"
		end

	frozen get_current_cell_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.DataGrid"
		alias
			"GetCurrentCellBounds"
		end

	frozen hit_test_int32 (x: INTEGER; y: INTEGER): HITTESTINFO_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL signature (System.Int32, System.Int32): System.Windows.Forms.DataGrid+HitTestInfo use System.Windows.Forms.DataGrid"
		alias
			"HitTest"
		end

	reset_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetBackColor"
		end

	frozen begin_edit (grid_column: SYSTEM_WINDOWS_FORMS_DATAGRIDCOLUMNSTYLE; row_number: INTEGER): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle, System.Int32): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"BeginEdit"
		end

	frozen end_edit (grid_column: SYSTEM_WINDOWS_FORMS_DATAGRIDCOLUMNSTYLE; row_number: INTEGER; should_abort: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.DataGridColumnStyle, System.Int32, System.Boolean): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"EndEdit"
		end

	frozen expand (row: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGrid"
		alias
			"Expand"
		end

	frozen is_selected (row: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"IsSelected"
		end

	frozen sub_objects_site_change (site: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"SubObjectsSiteChange"
		end

	frozen is_expanded (row_number: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"IsExpanded"
		end

	frozen navigate_to (row_number: INTEGER; relation_name: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Windows.Forms.DataGrid"
		alias
			"NavigateTo"
		end

	frozen reset_selection_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetSelectionBackColor"
		end

	frozen collapse (row: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGrid"
		alias
			"Collapse"
		end

	frozen reset_header_font is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetHeaderFont"
		end

	frozen navigate_back is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"NavigateBack"
		end

	frozen hit_test (position: SYSTEM_DRAWING_POINT): HITTESTINFO_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL signature (System.Drawing.Point): System.Windows.Forms.DataGrid+HitTestInfo use System.Windows.Forms.DataGrid"
		alias
			"HitTest"
		end

	frozen reset_alternating_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetAlternatingBackColor"
		end

	frozen reset_header_fore_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetHeaderForeColor"
		end

feature {NONE} -- Implementation

	on_paint (pe: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnPaint"
		end

	create_accessibility_instance: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.DataGrid"
		alias
			"CreateAccessibilityInstance"
		end

	on_mouse_wheel (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnMouseWheel"
		end

	on_mouse_up (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnMouseUp"
		end

	on_current_cell_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnCurrentCellChanged"
		end

	frozen on_show_parent_details_button_clicked (sender: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnShowParentDetailsButtonClicked"
		end

	on_handle_destroyed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnHandleDestroyed"
		end

	frozen add_row_header_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"add_RowHeaderClick"
		end

	cancel_editing is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"CancelEditing"
		end

	on_leave (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnLeave"
		end

	get_output_text_delimiter: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGrid"
		alias
			"GetOutputTextDelimiter"
		end

	frozen process_tab_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ProcessTabKey"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnHandleCreated"
		end

	frozen on_navigate (e: SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.NavigateEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnNavigate"
		end

	on_caption_visible_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnCaptionVisibleChanged"
		end

	frozen on_row_header_click (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnRowHeaderClick"
		end

	on_binding_context_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnBindingContextChanged"
		end

	frozen should_serialize_header_font: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeHeaderFont"
		end

	frozen should_serialize_selection_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeSelectionBackColor"
		end

	should_serialize_parent_rows_fore_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeParentRowsForeColor"
		end

	frozen remove_row_header_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGrid"
		alias
			"remove_RowHeaderClick"
		end

	on_enter (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnEnter"
		end

	on_background_color_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnBackgroundColorChanged"
		end

	frozen reset_selection is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ResetSelection"
		end

	on_paint_background (ebe: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnPaintBackground"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.DataGrid"
		alias
			"get_DefaultSize"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGrid"
		alias
			"Dispose"
		end

	on_read_only_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnReadOnlyChanged"
		end

	frozen process_grid_key (ke: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ProcessGridKey"
		end

	should_serialize_caption_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeCaptionBackColor"
		end

	on_mouse_leave (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnMouseLeave"
		end

	frozen get_vert_scroll_bar: SYSTEM_WINDOWS_FORMS_SCROLLBAR is
		external
			"IL signature (): System.Windows.Forms.ScrollBar use System.Windows.Forms.DataGrid"
		alias
			"get_VertScrollBar"
		end

	frozen on_back_button_clicked (sender: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnBackButtonClicked"
		end

	grid_hscrolled (sender: ANY; se: SYSTEM_WINDOWS_FORMS_SCROLLEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.ScrollEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"GridHScrolled"
		end

	on_layout (levent: SYSTEM_WINDOWS_FORMS_LAYOUTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.LayoutEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnLayout"
		end

	grid_vscrolled (sender: ANY; se: SYSTEM_WINDOWS_FORMS_SCROLLEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.ScrollEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"GridVScrolled"
		end

	on_fore_color_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnForeColorChanged"
		end

	on_border_style_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnBorderStyleChanged"
		end

	process_key_preview (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ProcessKeyPreview"
		end

	create_grid_column (prop: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): SYSTEM_WINDOWS_FORMS_DATAGRIDCOLUMNSTYLE is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Windows.Forms.DataGridColumnStyle use System.Windows.Forms.DataGrid"
		alias
			"CreateGridColumn"
		end

	on_allow_navigation_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnAllowNavigationChanged"
		end

	should_serialize_caption_fore_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeCaptionForeColor"
		end

	on_parent_rows_label_style_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnParentRowsLabelStyleChanged"
		end

	on_back_color_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnBackColorChanged"
		end

	frozen get_horiz_scroll_bar: SYSTEM_WINDOWS_FORMS_SCROLLBAR is
		external
			"IL signature (): System.Windows.Forms.ScrollBar use System.Windows.Forms.DataGrid"
		alias
			"get_HorizScrollBar"
		end

	column_started_editing_control (editing_control: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ColumnStartedEditing"
		end

	frozen should_serialize_preferred_row_height: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializePreferredRowHeight"
		end

	should_serialize_grid_line_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeGridLineColor"
		end

	on_flat_mode_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnFlatModeChanged"
		end

	should_serialize_selection_fore_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeSelectionForeColor"
		end

	frozen get_list_manager: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER is
		external
			"IL signature (): System.Windows.Forms.CurrencyManager use System.Windows.Forms.DataGrid"
		alias
			"get_ListManager"
		end

	frozen on_scroll (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnScroll"
		end

	should_serialize_link_hover_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeLinkHoverColor"
		end

	on_font_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnFontChanged"
		end

	should_serialize_header_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeHeaderBackColor"
		end

	process_dialog_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ProcessDialogKey"
		end

	column_started_editing (bounds: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.DataGrid"
		alias
			"ColumnStartedEditing"
		end

	on_parent_rows_visible_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnParentRowsVisibleChanged"
		end

	create_grid_column_property_descriptor_boolean (prop: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; is_default: BOOLEAN): SYSTEM_WINDOWS_FORMS_DATAGRIDCOLUMNSTYLE is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor, System.Boolean): System.Windows.Forms.DataGridColumnStyle use System.Windows.Forms.DataGrid"
		alias
			"CreateGridColumn"
		end

	on_mouse_down (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnMouseDown"
		end

	should_serialize_alternating_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeAlternatingBackColor"
		end

	on_resize (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnResize"
		end

	on_key_down (ke: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnKeyDown"
		end

	on_mouse_move (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnMouseMove"
		end

	should_serialize_parent_rows_back_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeParentRowsBackColor"
		end

	should_serialize_background_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeBackgroundColor"
		end

	should_serialize_header_fore_color: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGrid"
		alias
			"ShouldSerializeHeaderForeColor"
		end

	on_key_press (kpe: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnKeyPress"
		end

	frozen set_list_manager (value: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager): System.Void use System.Windows.Forms.DataGrid"
		alias
			"set_ListManager"
		end

	on_data_source_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.DataGrid"
		alias
			"OnDataSourceChanged"
		end

end -- class SYSTEM_WINDOWS_FORMS_DATAGRID
