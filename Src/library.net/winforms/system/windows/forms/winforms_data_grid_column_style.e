indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGridColumnStyle"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_DATA_GRID_COLUMN_STYLE

inherit
	SYSTEM_DLL_COMPONENT
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WINFORMS_IDATA_GRID_COLUMN_STYLE_EDITING_NOTIFICATION_SERVICE
		rename
			column_started_editing as system_windows_forms_idata_grid_column_style_editing_notification_service_column_started_editing
		end

feature -- Access

	get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_Width"
		end

	frozen get_header_accessible_object: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_HeaderAccessibleObject"
		end

	frozen get_mapping_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_MappingName"
		end

	get_null_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_NullText"
		end

	get_property_descriptor: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_PropertyDescriptor"
		end

	get_header_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_HeaderText"
		end

	get_data_grid_table_style: WINFORMS_DATA_GRID_TABLE_STYLE is
		external
			"IL signature (): System.Windows.Forms.DataGridTableStyle use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_DataGridTableStyle"
		end

	get_alignment: WINFORMS_HORIZONTAL_ALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_Alignment"
		end

	get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_ReadOnly"
		end

feature -- Element Change

	set_property_descriptor (value: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"set_PropertyDescriptor"
		end

	frozen remove_alignment_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"remove_AlignmentChanged"
		end

	frozen add_alignment_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"add_AlignmentChanged"
		end

	frozen add_width_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"add_WidthChanged"
		end

	set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"set_Width"
		end

	frozen set_mapping_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"set_MappingName"
		end

	frozen remove_font_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"remove_FontChanged"
		end

	frozen remove_null_text_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"remove_NullTextChanged"
		end

	frozen add_font_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"add_FontChanged"
		end

	set_alignment (value: WINFORMS_HORIZONTAL_ALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"set_Alignment"
		end

	frozen add_null_text_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"add_NullTextChanged"
		end

	frozen add_read_only_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"add_ReadOnlyChanged"
		end

	frozen remove_header_text_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"remove_HeaderTextChanged"
		end

	frozen add_mapping_name_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"add_MappingNameChanged"
		end

	frozen remove_read_only_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"remove_ReadOnlyChanged"
		end

	frozen add_property_descriptor_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"add_PropertyDescriptorChanged"
		end

	set_null_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"set_NullText"
		end

	set_header_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"set_HeaderText"
		end

	set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"set_ReadOnly"
		end

	frozen remove_property_descriptor_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"remove_PropertyDescriptorChanged"
		end

	frozen remove_width_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"remove_WidthChanged"
		end

	frozen add_header_text_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"add_HeaderTextChanged"
		end

	frozen remove_mapping_name_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"remove_MappingNameChanged"
		end

feature -- Basic Operations

	frozen reset_header_text is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"ResetHeaderText"
		end

feature {NONE} -- Implementation

	paint_graphics_rectangle_currency_manager_int32_boolean (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; align_to_right: BOOLEAN) is
		external
			"IL deferred signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32, System.Boolean): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Paint"
		end

	commit (data_source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.CurrencyManager, System.Int32): System.Boolean use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Commit"
		end

	get_preferred_height (g: DRAWING_GRAPHICS; value: SYSTEM_OBJECT): INTEGER is
		external
			"IL deferred signature (System.Drawing.Graphics, System.Object): System.Int32 use System.Windows.Forms.DataGridColumnStyle"
		alias
			"GetPreferredHeight"
		end

	concede_focus is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"ConcedeFocus"
		end

	paint_graphics_rectangle_currency_manager_int32_brush (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; back_brush: DRAWING_BRUSH; fore_brush: DRAWING_BRUSH; align_to_right: BOOLEAN) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Brush, System.Drawing.Brush, System.Boolean): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Paint"
		end

	edit_currency_manager_int32_rectangle_boolean_string_boolean (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; bounds: DRAWING_RECTANGLE; read_only: BOOLEAN; instant_text: SYSTEM_STRING; cell_is_visible: BOOLEAN) is
		external
			"IL deferred signature (System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Rectangle, System.Boolean, System.String, System.Boolean): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Edit"
		end

	frozen check_valid_data_source (value: WINFORMS_CURRENCY_MANAGER) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"CheckValidDataSource"
		end

	invalidate is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Invalidate"
		end

	get_preferred_size (g: DRAWING_GRAPHICS; value: SYSTEM_OBJECT): DRAWING_SIZE is
		external
			"IL deferred signature (System.Drawing.Graphics, System.Object): System.Drawing.Size use System.Windows.Forms.DataGridColumnStyle"
		alias
			"GetPreferredSize"
		end

	frozen end_update is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"EndUpdate"
		end

	update_ui (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; instant_text: SYSTEM_STRING) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.String): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"UpdateUI"
		end

	edit_currency_manager_int32_rectangle_boolean_string (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; bounds: DRAWING_RECTANGLE; read_only: BOOLEAN; instant_text: SYSTEM_STRING) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Rectangle, System.Boolean, System.String): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Edit"
		end

	set_data_grid_in_column (value: WINFORMS_DATA_GRID) is
		external
			"IL signature (System.Windows.Forms.DataGrid): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"SetDataGridInColumn"
		end

	enter_null_value is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"EnterNullValue"
		end

	paint (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER) is
		external
			"IL deferred signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Paint"
		end

	get_column_value_at_row (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32): System.Object use System.Windows.Forms.DataGridColumnStyle"
		alias
			"GetColumnValueAtRow"
		end

	edit (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; bounds: DRAWING_RECTANGLE; read_only: BOOLEAN) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Rectangle, System.Boolean): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Edit"
		end

	column_started_editing (editing_control: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"ColumnStartedEditing"
		end

	get_minimum_height: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Windows.Forms.DataGridColumnStyle"
		alias
			"GetMinimumHeight"
		end

	frozen system_windows_forms_idata_grid_column_style_editing_notification_service_column_started_editing (editing_control: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"System.Windows.Forms.IDataGridColumnStyleEditingNotificationService.ColumnStartedEditing"
		end

	abort (row_num: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"Abort"
		end

	create_header_accessible_object: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.DataGridColumnStyle"
		alias
			"CreateHeaderAccessibleObject"
		end

	set_column_value_at_row (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.Object): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"SetColumnValueAtRow"
		end

	frozen get_font_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridColumnStyle"
		alias
			"get_FontHeight"
		end

	frozen begin_update is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"BeginUpdate"
		end

	set_data_grid (value: WINFORMS_DATA_GRID) is
		external
			"IL signature (System.Windows.Forms.DataGrid): System.Void use System.Windows.Forms.DataGridColumnStyle"
		alias
			"SetDataGrid"
		end

end -- class WINFORMS_DATA_GRID_COLUMN_STYLE
