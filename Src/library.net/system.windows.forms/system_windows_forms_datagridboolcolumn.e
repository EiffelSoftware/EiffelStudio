indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DataGridBoolColumn"

external class
	SYSTEM_WINDOWS_FORMS_DATAGRIDBOOLCOLUMN

inherit
	SYSTEM_WINDOWS_FORMS_DATAGRIDCOLUMNSTYLE
		redefine
			set_column_value_at_row,
			paint_graphics_rectangle_currency_manager_int32_brush,
			concede_focus,
			enter_null_value,
			get_column_value_at_row
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_IDATAGRIDCOLUMNSTYLEEDITINGNOTIFICATIONSERVICE
		rename
			column_started_editing as system_windows_forms_idata_grid_column_style_editing_notification_service_column_started_editing
		end
	SYSTEM_IDISPOSABLE

create
	make_datagridboolcolumn,
	make_datagridboolcolumn_1,
	make_datagridboolcolumn_2

feature {NONE} -- Initialization

	frozen make_datagridboolcolumn is
		external
			"IL creator use System.Windows.Forms.DataGridBoolColumn"
		end

	frozen make_datagridboolcolumn_1 (prop: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor) use System.Windows.Forms.DataGridBoolColumn"
		end

	frozen make_datagridboolcolumn_2 (prop: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; is_default: BOOLEAN) is
		external
			"IL creator signature (System.ComponentModel.PropertyDescriptor, System.Boolean) use System.Windows.Forms.DataGridBoolColumn"
		end

feature -- Access

	frozen get_false_value: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.DataGridBoolColumn"
		alias
			"get_FalseValue"
		end

	frozen get_null_value: ANY is
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

	frozen get_true_value: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.DataGridBoolColumn"
		alias
			"get_TrueValue"
		end

feature -- Element Change

	frozen set_null_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"set_NullValue"
		end

	frozen remove_true_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"remove_TrueValueChanged"
		end

	frozen remove_allow_null_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"remove_AllowNullChanged"
		end

	frozen add_false_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"add_FalseValueChanged"
		end

	frozen remove_false_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"remove_FalseValueChanged"
		end

	frozen add_true_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"add_TrueValueChanged"
		end

	frozen set_true_value (value: ANY) is
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

	frozen set_false_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"set_FalseValue"
		end

	frozen add_allow_null_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"add_AllowNullChanged"
		end

feature {NONE} -- Implementation

	edit_currency_manager_int32_rectangle_boolean_string_boolean (source: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER; row_num: INTEGER; bounds: SYSTEM_DRAWING_RECTANGLE; read_only: BOOLEAN; instant_text: STRING; cell_is_visible: BOOLEAN) is
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

	paint (g: SYSTEM_DRAWING_GRAPHICS; bounds: SYSTEM_DRAWING_RECTANGLE; source: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER; row_num: INTEGER) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"Paint"
		end

	paint_graphics_rectangle_currency_manager_int32_boolean (g: SYSTEM_DRAWING_GRAPHICS; bounds: SYSTEM_DRAWING_RECTANGLE; source: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER; row_num: INTEGER; align_to_right: BOOLEAN) is
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

	set_column_value_at_row (lm: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER; row: INTEGER; value: ANY) is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32, System.Object): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"SetColumnValueAtRow"
		end

	get_column_value_at_row (lm: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER; row: INTEGER): ANY is
		external
			"IL signature (System.Windows.Forms.CurrencyManager, System.Int32): System.Object use System.Windows.Forms.DataGridBoolColumn"
		alias
			"GetColumnValueAtRow"
		end

	get_preferred_size (g: SYSTEM_DRAWING_GRAPHICS; value: ANY): SYSTEM_DRAWING_SIZE is
		external
			"IL signature (System.Drawing.Graphics, System.Object): System.Drawing.Size use System.Windows.Forms.DataGridBoolColumn"
		alias
			"GetPreferredSize"
		end

	paint_graphics_rectangle_currency_manager_int32_brush (g: SYSTEM_DRAWING_GRAPHICS; bounds: SYSTEM_DRAWING_RECTANGLE; source: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER; row_num: INTEGER; back_brush: SYSTEM_DRAWING_BRUSH; fore_brush: SYSTEM_DRAWING_BRUSH; align_to_right: BOOLEAN) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle, System.Windows.Forms.CurrencyManager, System.Int32, System.Drawing.Brush, System.Drawing.Brush, System.Boolean): System.Void use System.Windows.Forms.DataGridBoolColumn"
		alias
			"Paint"
		end

	commit (data_source: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER; row_num: INTEGER): BOOLEAN is
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

	get_preferred_height (g: SYSTEM_DRAWING_GRAPHICS; value: ANY): INTEGER is
		external
			"IL signature (System.Drawing.Graphics, System.Object): System.Int32 use System.Windows.Forms.DataGridBoolColumn"
		alias
			"GetPreferredHeight"
		end

end -- class SYSTEM_WINDOWS_FORMS_DATAGRIDBOOLCOLUMN
