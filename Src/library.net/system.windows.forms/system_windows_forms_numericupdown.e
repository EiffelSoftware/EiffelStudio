indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.NumericUpDown"

external class
	SYSTEM_WINDOWS_FORMS_NUMERICUPDOWN

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ISUPPORTINITIALIZE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW
	SYSTEM_WINDOWS_FORMS_UPDOWNBASE
		redefine
			validate_edit_text,
			on_text_box_key_press,
			create_accessibility_instance,
			set_text,
			get_text,
			to_string
		end

create
	make_numericupdown

feature {NONE} -- Initialization

	frozen make_numericupdown is
		external
			"IL creator use System.Windows.Forms.NumericUpDown"
		end

feature -- Access

	frozen get_thousands_separator: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.NumericUpDown"
		alias
			"get_ThousandsSeparator"
		end

	frozen get_value: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Windows.Forms.NumericUpDown"
		alias
			"get_Value"
		end

	frozen get_increment: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Windows.Forms.NumericUpDown"
		alias
			"get_Increment"
		end

	frozen get_hexadecimal: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.NumericUpDown"
		alias
			"get_Hexadecimal"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.NumericUpDown"
		alias
			"get_Text"
		end

	frozen get_maximum: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Windows.Forms.NumericUpDown"
		alias
			"get_Maximum"
		end

	frozen get_minimum: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Windows.Forms.NumericUpDown"
		alias
			"get_Minimum"
		end

	frozen get_decimal_places: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.NumericUpDown"
		alias
			"get_DecimalPlaces"
		end

feature -- Element Change

	frozen set_thousands_separator (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"set_ThousandsSeparator"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"set_Text"
		end

	frozen set_value (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"set_Value"
		end

	frozen set_minimum (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"set_Minimum"
		end

	frozen add_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"add_ValueChanged"
		end

	frozen set_hexadecimal (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"set_Hexadecimal"
		end

	frozen set_increment (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"set_Increment"
		end

	frozen remove_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"remove_ValueChanged"
		end

	frozen set_maximum (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"set_Maximum"
		end

	frozen set_decimal_places (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"set_DecimalPlaces"
		end

feature -- Basic Operations

	frozen end_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"EndInit"
		end

	down_button is
		external
			"IL signature (): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"DownButton"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.NumericUpDown"
		alias
			"ToString"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"BeginInit"
		end

	up_button is
		external
			"IL signature (): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"UpButton"
		end

feature {NONE} -- Implementation

	update_edit_text is
		external
			"IL signature (): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"UpdateEditText"
		end

	on_value_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"OnValueChanged"
		end

	validate_edit_text is
		external
			"IL signature (): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"ValidateEditText"
		end

	on_text_box_key_press (source: ANY; e: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.KeyPressEventArgs): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"OnTextBoxKeyPress"
		end

	frozen parse_edit_text is
		external
			"IL signature (): System.Void use System.Windows.Forms.NumericUpDown"
		alias
			"ParseEditText"
		end

	create_accessibility_instance: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.NumericUpDown"
		alias
			"CreateAccessibilityInstance"
		end

end -- class SYSTEM_WINDOWS_FORMS_NUMERICUPDOWN
