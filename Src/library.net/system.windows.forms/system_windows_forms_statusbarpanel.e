indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.StatusBarPanel"

external class
	SYSTEM_WINDOWS_FORMS_STATUSBARPANEL

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ISUPPORTINITIALIZE

create
	make_statusbarpanel

feature {NONE} -- Initialization

	frozen make_statusbarpanel is
		external
			"IL creator use System.Windows.Forms.StatusBarPanel"
		end

feature -- Access

	frozen get_icon: SYSTEM_DRAWING_ICON is
		external
			"IL signature (): System.Drawing.Icon use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Icon"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Width"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Text"
		end

	frozen get_style: SYSTEM_WINDOWS_FORMS_STATUSBARPANELSTYLE is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanelStyle use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Style"
		end

	frozen get_tool_tip_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBarPanel"
		alias
			"get_ToolTipText"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_STATUSBARPANELBORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanelBorderStyle use System.Windows.Forms.StatusBarPanel"
		alias
			"get_BorderStyle"
		end

	frozen get_parent: SYSTEM_WINDOWS_FORMS_STATUSBAR is
		external
			"IL signature (): System.Windows.Forms.StatusBar use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Parent"
		end

	frozen get_min_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.StatusBarPanel"
		alias
			"get_MinWidth"
		end

	frozen get_alignment: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Alignment"
		end

	frozen get_auto_size: SYSTEM_WINDOWS_FORMS_STATUSBARPANELAUTOSIZE is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanelAutoSize use System.Windows.Forms.StatusBarPanel"
		alias
			"get_AutoSize"
		end

feature -- Element Change

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_STATUSBARPANELBORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelBorderStyle): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_BorderStyle"
		end

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_Text"
		end

	frozen set_min_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_MinWidth"
		end

	frozen set_icon (value: SYSTEM_DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_Icon"
		end

	frozen set_tool_tip_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_ToolTipText"
		end

	frozen set_alignment (value: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_Alignment"
		end

	frozen set_auto_size (value: SYSTEM_WINDOWS_FORMS_STATUSBARPANELAUTOSIZE) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelAutoSize): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_AutoSize"
		end

	frozen set_style (value: SYSTEM_WINDOWS_FORMS_STATUSBARPANELSTYLE) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelStyle): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_Style"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_Width"
		end

feature -- Basic Operations

	frozen end_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"EndInit"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBarPanel"
		alias
			"ToString"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"BeginInit"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"Dispose"
		end

end -- class SYSTEM_WINDOWS_FORMS_STATUSBARPANEL
