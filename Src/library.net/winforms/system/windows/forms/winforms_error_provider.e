indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ErrorProvider"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_ERROR_PROVIDER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			set_site,
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_IEXTENDER_PROVIDER

create
	make_winforms_error_provider,
	make_winforms_error_provider_1

feature {NONE} -- Initialization

	frozen make_winforms_error_provider is
		external
			"IL creator use System.Windows.Forms.ErrorProvider"
		end

	frozen make_winforms_error_provider_1 (parent_control: WINFORMS_CONTAINER_CONTROL) is
		external
			"IL creator signature (System.Windows.Forms.ContainerControl) use System.Windows.Forms.ErrorProvider"
		end

feature -- Access

	frozen get_container_control: WINFORMS_CONTAINER_CONTROL is
		external
			"IL signature (): System.Windows.Forms.ContainerControl use System.Windows.Forms.ErrorProvider"
		alias
			"get_ContainerControl"
		end

	frozen get_data_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ErrorProvider"
		alias
			"get_DataSource"
		end

	frozen get_blink_style: WINFORMS_ERROR_BLINK_STYLE is
		external
			"IL signature (): System.Windows.Forms.ErrorBlinkStyle use System.Windows.Forms.ErrorProvider"
		alias
			"get_BlinkStyle"
		end

	frozen get_blink_rate: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ErrorProvider"
		alias
			"get_BlinkRate"
		end

	frozen get_icon: DRAWING_ICON is
		external
			"IL signature (): System.Drawing.Icon use System.Windows.Forms.ErrorProvider"
		alias
			"get_Icon"
		end

	frozen get_data_member: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ErrorProvider"
		alias
			"get_DataMember"
		end

feature -- Element Change

	frozen set_blink_rate (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_BlinkRate"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_Site"
		end

	frozen set_data_member (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_DataMember"
		end

	frozen set_container_control (value: WINFORMS_CONTAINER_CONTROL) is
		external
			"IL signature (System.Windows.Forms.ContainerControl): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_ContainerControl"
		end

	frozen set_data_source (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_DataSource"
		end

	frozen set_blink_style (value: WINFORMS_ERROR_BLINK_STYLE) is
		external
			"IL signature (System.Windows.Forms.ErrorBlinkStyle): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_BlinkStyle"
		end

	frozen set_icon (value: DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_Icon"
		end

feature -- Basic Operations

	frozen set_icon_alignment (control: WINFORMS_CONTROL; value: WINFORMS_ERROR_ICON_ALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.Control, System.Windows.Forms.ErrorIconAlignment): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"SetIconAlignment"
		end

	frozen get_icon_alignment (control: WINFORMS_CONTROL): WINFORMS_ERROR_ICON_ALIGNMENT is
		external
			"IL signature (System.Windows.Forms.Control): System.Windows.Forms.ErrorIconAlignment use System.Windows.Forms.ErrorProvider"
		alias
			"GetIconAlignment"
		end

	frozen get_error (control: WINFORMS_CONTROL): SYSTEM_STRING is
		external
			"IL signature (System.Windows.Forms.Control): System.String use System.Windows.Forms.ErrorProvider"
		alias
			"GetError"
		end

	frozen get_icon_padding (control: WINFORMS_CONTROL): INTEGER is
		external
			"IL signature (System.Windows.Forms.Control): System.Int32 use System.Windows.Forms.ErrorProvider"
		alias
			"GetIconPadding"
		end

	frozen set_icon_padding (control: WINFORMS_CONTROL; padding: INTEGER) is
		external
			"IL signature (System.Windows.Forms.Control, System.Int32): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"SetIconPadding"
		end

	frozen set_error (control: WINFORMS_CONTROL; value: SYSTEM_STRING) is
		external
			"IL signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"SetError"
		end

	frozen bind_to_data_and_errors (new_data_source: SYSTEM_OBJECT; new_data_member: SYSTEM_STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"BindToDataAndErrors"
		end

	frozen can_extend (extendee: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ErrorProvider"
		alias
			"CanExtend"
		end

	frozen update_binding is
		external
			"IL signature (): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"UpdateBinding"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"Dispose"
		end

end -- class WINFORMS_ERROR_PROVIDER
