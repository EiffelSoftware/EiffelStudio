indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ToolBarButton"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TOOL_BAR_BUTTON

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_tool_bar_button_1,
	make_winforms_tool_bar_button

feature {NONE} -- Initialization

	frozen make_winforms_tool_bar_button_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.ToolBarButton"
		end

	frozen make_winforms_tool_bar_button is
		external
			"IL creator use System.Windows.Forms.ToolBarButton"
		end

feature -- Access

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBarButton"
		alias
			"get_Enabled"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolBarButton"
		alias
			"get_Text"
		end

	frozen get_style: WINFORMS_TOOL_BAR_BUTTON_STYLE is
		external
			"IL signature (): System.Windows.Forms.ToolBarButtonStyle use System.Windows.Forms.ToolBarButton"
		alias
			"get_Style"
		end

	frozen get_tool_tip_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolBarButton"
		alias
			"get_ToolTipText"
		end

	frozen get_pushed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBarButton"
		alias
			"get_Pushed"
		end

	frozen get_drop_down_menu: WINFORMS_MENU is
		external
			"IL signature (): System.Windows.Forms.Menu use System.Windows.Forms.ToolBarButton"
		alias
			"get_DropDownMenu"
		end

	frozen get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBarButton"
		alias
			"get_Visible"
		end

	frozen get_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ToolBarButton"
		alias
			"get_ImageIndex"
		end

	frozen get_parent: WINFORMS_TOOL_BAR is
		external
			"IL signature (): System.Windows.Forms.ToolBar use System.Windows.Forms.ToolBarButton"
		alias
			"get_Parent"
		end

	frozen get_tag: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ToolBarButton"
		alias
			"get_Tag"
		end

	frozen get_partial_push: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBarButton"
		alias
			"get_PartialPush"
		end

	frozen get_rectangle: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.ToolBarButton"
		alias
			"get_Rectangle"
		end

feature -- Element Change

	frozen set_style (value: WINFORMS_TOOL_BAR_BUTTON_STYLE) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonStyle): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_Style"
		end

	frozen set_tag (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_Tag"
		end

	frozen set_drop_down_menu (value: WINFORMS_MENU) is
		external
			"IL signature (System.Windows.Forms.Menu): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_DropDownMenu"
		end

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_Text"
		end

	frozen set_tool_tip_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_ToolTipText"
		end

	frozen set_partial_push (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_PartialPush"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_Enabled"
		end

	frozen set_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_ImageIndex"
		end

	frozen set_pushed (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_Pushed"
		end

	frozen set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"set_Visible"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolBarButton"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBarButton"
		alias
			"Dispose"
		end

end -- class WINFORMS_TOOL_BAR_BUTTON
