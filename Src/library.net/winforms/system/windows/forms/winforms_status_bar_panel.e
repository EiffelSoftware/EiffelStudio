indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.StatusBarPanel"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_STATUS_BAR_PANEL

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISUPPORT_INITIALIZE

create
	make_winforms_status_bar_panel

feature {NONE} -- Initialization

	frozen make_winforms_status_bar_panel is
		external
			"IL creator use System.Windows.Forms.StatusBarPanel"
		end

feature -- Access

	frozen get_icon: DRAWING_ICON is
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

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Text"
		end

	frozen get_style: WINFORMS_STATUS_BAR_PANEL_STYLE is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanelStyle use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Style"
		end

	frozen get_tool_tip_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBarPanel"
		alias
			"get_ToolTipText"
		end

	frozen get_border_style: WINFORMS_STATUS_BAR_PANEL_BORDER_STYLE is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanelBorderStyle use System.Windows.Forms.StatusBarPanel"
		alias
			"get_BorderStyle"
		end

	frozen get_parent: WINFORMS_STATUS_BAR is
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

	frozen get_alignment: WINFORMS_HORIZONTAL_ALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.StatusBarPanel"
		alias
			"get_Alignment"
		end

	frozen get_auto_size: WINFORMS_STATUS_BAR_PANEL_AUTO_SIZE is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanelAutoSize use System.Windows.Forms.StatusBarPanel"
		alias
			"get_AutoSize"
		end

feature -- Element Change

	frozen set_border_style (value: WINFORMS_STATUS_BAR_PANEL_BORDER_STYLE) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelBorderStyle): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_BorderStyle"
		end

	frozen set_text (value: SYSTEM_STRING) is
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

	frozen set_icon (value: DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_Icon"
		end

	frozen set_tool_tip_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_ToolTipText"
		end

	frozen set_alignment (value: WINFORMS_HORIZONTAL_ALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_Alignment"
		end

	frozen set_auto_size (value: WINFORMS_STATUS_BAR_PANEL_AUTO_SIZE) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelAutoSize): System.Void use System.Windows.Forms.StatusBarPanel"
		alias
			"set_AutoSize"
		end

	frozen set_style (value: WINFORMS_STATUS_BAR_PANEL_STYLE) is
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

	to_string: SYSTEM_STRING is
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

end -- class WINFORMS_STATUS_BAR_PANEL
