indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGridBoolColumn"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATA_GRID_BOOL_COLUMN

inherit
	WINFORMS_DATA_GRID_COLUMN_STYLE
		redefine
			set_column_value_at_row,
			paint_graphics_rectangle_currency_manager_int32_brush,
			concede_focus,
			enter_null_value,
			get_column_value_at_row
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WINFORMS_IDATA_GRID_COLUMN_STYLE_EDITING_NOTIFICATION_SERVICE
		rename
			column_started_editing as system_windows_forms_idata_grid_column_style_editing_notification_service_column_started_editing
		end

create
	make_winforms_data_grid_bool_column,
	make_winforms_data_grid_bool_column_1,
	make_winforms_data_grid_bool_column_2

feature {NONE} -- Initialization

	frozen make_winforms_data_grid_bool_column is
		external
			"IL creator use System.Windows.Forms.DataGridBoolColumn"
		end

	frozen make_winforms_data_grid_bool_column_1 (prop: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor) use System.Windows.Forms.DataGridBoolColumn"
		end

	frozen make_winforms_data_grid_bool_column_2 (prop: SYSTEM_DLL_PROPERTY_DESCRIPTOR; is_default: BOOLEAN) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor, System.Boolean) use System.Windows.Forms.DataGridBoolColumn"
		end

feature -- Access

	frozen get_false_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.DataGridBoolColumn"
		alias
			"get_FalseValue"
		end

	frozen get_null_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.DataGridBoolColumn"
		alias
			"get_NullValue"
		end

	frozen get_allow_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DataGridBoolColumn"
		alias
			"get_AllowNull"
		end

	frozen get_true_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.DataGridBoolColumn"
		alias
			"get_TrueValue"
		end

feature -- Element Change

	frozen set_null_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"set_NullValue"
		end

	frozen remove_true_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"remove_TrueValueChanged"
		end

	frozen remove_allow_null_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"remove_AllowNullChanged"
		end

	frozen add_false_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"add_FalseValueChanged"
		end

	frozen remove_false_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"remove_FalseValueChanged"
		end

	frozen add_true_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"add_TrueValueChanged"
		end

	frozen set_true_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"set_TrueValue"
		end

	frozen set_allow_null (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"set_AllowNull"
		end

	frozen set_false_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"set_FalseValue"
		end

	frozen add_allow_null_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"add_AllowNullChanged"
		end

feature {NONE} -- Implementation

	edit_currency_manager_int32_rectangle_boolean_string_boolean (source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; bounds: DRAWING_RECTANGLE; read_only: BOOLEAN; instant_text: SYSTEM_STRING; cell_is_visible: BOOLEAN) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Rectangle, System.Boolean, System.String, System.Boolean): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"Edit"
		end

	enter_null_value is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"EnterNullValue"
		end

	paint (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"Paint"
		end

	paint_graphics_rectangle_currency_manager_int32_boolean (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; align_to_right: BOOLEAN) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32, System.Boolean): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"Paint"
		end

	get_minimum_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridBoolColumn"
		alias
			"GetMinimumHeight"
		end

	concede_focus is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"ConcedeFocus"
		end

	set_column_value_at_row (lm: WINFORMS_CURRENCY_MANAGER; row: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.Object): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"SetColumnValueAtRow"
		end

	get_column_value_at_row (lm: WINFORMS_CURRENCY_MANAGER; row: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32): System.Object use System.Windows.Forms.DataGridBoolColumn"
		alias
			"GetColumnValueAtRow"
		end

	get_preferred_size (g: DRAWING_GRAPHICS; value: SYSTEM_OBJECT): DRAWING_SIZE is
		external
			"IL signature (System.Drawing.Graphics, System.Object): System.Drawing.Size use System.Windows.Forms.DataGridBoolColumn"
		alias
			"GetPreferredSize"
		end

	paint_graphics_rectangle_currency_manager_int32_brush (g: DRAWING_GRAPHICS; bounds: DRAWING_RECTANGLE; source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER; back_brush: DRAWING_BRUSH; fore_brush: DRAWING_BRUSH; align_to_right: BOOLEAN) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Brush, System.Drawing.Brush, System.Boolean): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"Paint"
		end

	commit (data_source: WINFORMS_CURRENCY_MANAGER; row_num: INTEGER): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32): System.Boolean use System.Windows.Forms.DataGridBoolColumn"
		alias
			"Commit"
		end

	abort (row_num: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"Abort"
		end

	get_preferred_height (g: DRAWING_GRAPHICS; value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Drawing.Graphics, System.Object): System.Int32 use System.Windows.Forms.DataGridBoolColumn"
		alias
			"GetPreferredHeight"
		end

end -- class WINFORMS_DATA_GRID_BOOL_COLUMN
