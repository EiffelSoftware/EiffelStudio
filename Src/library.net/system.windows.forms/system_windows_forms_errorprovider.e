indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ErrorProvider"

external class
	SYSTEM_WINDOWS_FORMS_ERRORPROVIDER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			set_site,
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER

create
	make_errorprovider,
	make_errorprovider_1

feature {NONE} -- Initialization

	frozen make_errorprovider is
		external
			"IL creator use System.Windows.Forms.ErrorProvider"
		end

	frozen make_errorprovider_1 (parent_control: SYSTEM_WINDOWS_FORMS_CONTAINERCONTROL) is
		external
			"IL creator signature (System.Windows.Forms.ContainerControl) use System.Windows.Forms.ErrorProvider"
		end

feature -- Access

	frozen get_container_control: SYSTEM_WINDOWS_FORMS_CONTAINERCONTROL is
		external
			"IL signature (): System.Windows.Forms.ContainerControl use System.Windows.Forms.ErrorProvider"
		alias
			"get_ContainerControl"
		end

	frozen get_data_source: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ErrorProvider"
		alias
			"get_DataSource"
		end

	frozen get_blink_style: SYSTEM_WINDOWS_FORMS_ERRORBLINKSTYLE is
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

	frozen get_icon: SYSTEM_DRAWING_ICON is
		external
			"IL signature (): System.Drawing.Icon use System.Windows.Forms.ErrorProvider"
		alias
			"get_Icon"
		end

	frozen get_data_member: STRING is
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

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_Site"
		end

	frozen set_data_member (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_DataMember"
		end

	frozen set_container_control (value: SYSTEM_WINDOWS_FORMS_CONTAINERCONTROL) is
		external
			"IL signature (System.Windows.Forms.ContainerControl): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_ContainerControl"
		end

	frozen set_data_source (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_DataSource"
		end

	frozen set_blink_style (value: SYSTEM_WINDOWS_FORMS_ERRORBLINKSTYLE) is
		external
			"IL signature (System.Windows.Forms.ErrorBlinkStyle): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_BlinkStyle"
		end

	frozen set_icon (value: SYSTEM_DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"set_Icon"
		end

feature -- Basic Operations

	frozen set_icon_alignment (control: SYSTEM_WINDOWS_FORMS_CONTROL; value: SYSTEM_WINDOWS_FORMS_ERRORICONALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.Control, System.Windows.Forms.ErrorIconAlignment): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"SetIconAlignment"
		end

	frozen get_icon_alignment (control: SYSTEM_WINDOWS_FORMS_CONTROL): SYSTEM_WINDOWS_FORMS_ERRORICONALIGNMENT is
		external
			"IL signature (System.Windows.Forms.Control): System.Windows.Forms.ErrorIconAlignment use System.Windows.Forms.ErrorProvider"
		alias
			"GetIconAlignment"
		end

	frozen get_error (control: SYSTEM_WINDOWS_FORMS_CONTROL): STRING is
		external
			"IL signature (System.Windows.Forms.Control): System.String use System.Windows.Forms.ErrorProvider"
		alias
			"GetError"
		end

	frozen get_icon_padding (control: SYSTEM_WINDOWS_FORMS_CONTROL): INTEGER is
		external
			"IL signature (System.Windows.Forms.Control): System.Int32 use System.Windows.Forms.ErrorProvider"
		alias
			"GetIconPadding"
		end

	frozen set_icon_padding (control: SYSTEM_WINDOWS_FORMS_CONTROL; padding: INTEGER) is
		external
			"IL signature (System.Windows.Forms.Control, System.Int32): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"SetIconPadding"
		end

	frozen set_error (control: SYSTEM_WINDOWS_FORMS_CONTROL; value: STRING) is
		external
			"IL signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"SetError"
		end

	frozen bind_to_data_and_errors (new_data_source: ANY; new_data_member: STRING) is
		external
			"IL signature (System.Object, System.String): System.Void use System.Windows.Forms.ErrorProvider"
		alias
			"BindToDataAndErrors"
		end

	frozen can_extend (extendee: ANY): BOOLEAN is
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

end -- class SYSTEM_WINDOWS_FORMS_ERRORPROVIDER
