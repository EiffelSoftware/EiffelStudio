indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGridTextBoxColumn"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATA_GRID_TEXT_BOX_COLUMN

inherit
	WINFORMS_DATA_GRID_COLUMN_STYLE
		redefine
			paint_graphics_rectangle_currency_manager_int32_brush,
			concede_focus,
			enter_null_value,
			set_read_only,
			get_read_only,
			set_data_grid_in_column,
			set_property_descriptor,
			update_ui
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WINFORMS_IDATA_GRID_COLUMN_STYLE_EDITING_NOTIFICATION_SERVICE
		rename
			column_started_editing as system_windows_forms_idata_grid_column_style_editing_notification_service_column_started_editing
		end

create
	make_winforms_data_grid_text_box_column_1,
	make_winforms_data_grid_text_box_column_2,
	make_winforms_data_grid_text_box_column_3,
	make_winforms_data_grid_text_box_column,
	make_winforms_data_grid_text_box_column_4

feature {NONE} -- Initialization

	frozen make_winforms_data_grid_text_box_column_1 (prop: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor) use System.Windows.Forms.DataGridTextBoxColumn"
		end

	frozen make_winforms_data_grid_text_box_column_2 (prop: SYSTEM_DLL_PROPERTY_DESCRIPTOR; format: SYSTEM_STRING) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor, System.String) use System.Windows.Forms.DataGridTextBoxColumn"
		end

	frozen make_winforms_data_grid_text_box_column_3 (prop: SYSTEM_DLL_PROPERTY_DESCRIPTOR; format: SYSTEM_STRING; is_default: BOOLEAN) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor, System.String, System.Boolean) use System.Windows.Forms.DataGridTextBoxColumn"
		end

	frozen make_winforms_data_grid_text_box_column is
		external
			"IL creator use System.Windows.Forms.DataGridTextBoxColumn"
		end

	frozen make_winforms_data_grid_text_box_column_4 (prop: SYSTEM_DLL_PROPERTY_DESCRIPTOR; is_default: BOOLEAN) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor, System.Boolean) use System.Windows.Forms.DataGridTextBoxColumn"
		end

feature -- Access

	get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"get_ReadOnly"
		end

	get_text_box: WINFORMS_TEXT_BOX is
		external
			"IL signature (): System.Windows.Forms.TextBox use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"get_TextBox"
		end

	frozen get_format_info: IFORMAT_PROVIDER is
		external
			"IL signature (): System.IFormatProvider use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"get_FormatInfo"
		end

	frozen get_format: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"get_Format"
		end

feature -- Element Change

	set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"set_ReadOnly"
		end

	set_property_descriptor (value: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"set_PropertyDescriptor"
		end

	frozen set_format (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"set_Format"
		end

	frozen set_format_info (value: IFORMAT_PROVIDER) is
		external
			"IL signature (System.IFormatProvider): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"set_FormatInfo"
		end

feature {NONE} -- Implementation

	paint_graphics_rectangle_currency_manager_int32_boolean (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; align_to_right: BOOLEAN) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32, System.Boolean): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"Paint"
		end

	commit (data_source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32): System.Boolean use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"Commit"
		end

	get_preferred_height (g: DRAWING_GRAPHICS; value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Drawing.Graphics, System.Object): System.Int32 use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"GetPreferredHeight"
		end

	concede_focus is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"ConcedeFocus"
		end

	paint_graphics_rectangle_currency_manager_int32_brush (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; back_brush: DRAWING_BRUSH; fore_brush: DRAWING_BRUSH; align_to_right: BOOLEAN) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Brush, System.Drawing.Brush, System.Boolean): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"Paint"
		end

	set_data_grid_in_column (value: WINFORMS_DATA_GRID) is
		external
			"IL signature (System.Windows.Forms.DataGrid): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"SetDataGridInColumn"
		end

	paint (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"Paint"
		end

	get_preferred_size (g: DRAWING_GRAPHICS; value: SYSTEM_OBJECT): DRAWING_SIZE is
		external
			"IL signature (System.Drawing.Graphics, System.Object): System.Drawing.Size use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"GetPreferredSize"
		end

	frozen hide_edit_box is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"HideEditBox"
		end

	enter_null_value is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"EnterNullValue"
		end

	frozen paint_text_graphics_rectangle_string_brush (g: DRAWING_GRAPHICS; text_bounds: DRAWING_RECTANGLE; text: SYSTEM_STRING; back_brush: DRAWING_BRUSH; fore_brush: DRAWING_BRUSH; align_to_right: BOOLEAN) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.String, System.Drawing.Brush, System.Drawing.Brush, System.Boolean): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"PaintText"
		end

	frozen end_edit is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"EndEdit"
		end

	get_minimum_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"GetMinimumHeight"
		end

	abort (row_num: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"Abort"
		end

	update_ui (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; instant_text: SYSTEM_STRING) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.String): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"UpdateUI"
		end

	edit_currency_manager_int32_rectangle_boolean_string_boolean (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; bounds: DRAWING_RECTANGLE; read_only: BOOLEAN; instant_text: SYSTEM_STRING; cell_is_visible: BOOLEAN) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Rectangle, System.Boolean, System.String, System.Boolean): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"Edit"
		end

	frozen paint_text (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; text: SYSTEM_STRING; align_to_right: BOOLEAN) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.String, System.Boolean): System.Void use System.Windows.Forms.DataGridTextBoxColumn"
		alias
			"PaintText"
		end

end -- class WINFORMS_DATA_GRID_TEXT_BOX_COLUMN
