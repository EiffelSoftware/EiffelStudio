indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ToolBar"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TOOL_BAR

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			set_bounds_core,
			on_resize,
			on_handle_created,
			on_font_changed,
			create_handle,
			set_text,
			get_text,
			set_right_to_left,
			get_right_to_left,
			set_fore_color,
			get_fore_color,
			set_dock,
			get_dock,
			get_default_size,
			get_default_ime_mode,
			get_create_params,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW

create
	make_winforms_tool_bar

feature {NONE} -- Initialization

	frozen make_winforms_tool_bar is
		external
			"IL creator use System.Windows.Forms.ToolBar"
		end

feature -- Access

	frozen get_buttons: WINFORMS_TOOL_BAR_BUTTON_COLLECTION_IN_WINFORMS_TOOL_BAR is
		external
			"IL signature (): System.Windows.Forms.ToolBar+ToolBarButtonCollection use System.Windows.Forms.ToolBar"
		alias
			"get_Buttons"
		end

	frozen get_drop_down_arrows: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar"
		alias
			"get_DropDownArrows"
		end

	frozen get_button_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ToolBar"
		alias
			"get_ButtonSize"
		end

	frozen get_auto_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar"
		alias
			"get_AutoSize"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolBar"
		alias
			"get_Text"
		end

	frozen get_border_style: WINFORMS_BORDER_STYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.ToolBar"
		alias
			"get_BorderStyle"
		end

	frozen get_appearance: WINFORMS_TOOL_BAR_APPEARANCE is
		external
			"IL signature (): System.Windows.Forms.ToolBarAppearance use System.Windows.Forms.ToolBar"
		alias
			"get_Appearance"
		end

	frozen get_image_list: WINFORMS_IMAGE_LIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.ToolBar"
		alias
			"get_ImageList"
		end

	frozen get_ime_mode_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ToolBar"
		alias
			"get_ImeMode"
		end

	frozen get_show_tool_tips: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar"
		alias
			"get_ShowToolTips"
		end

	frozen get_divider: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar"
		alias
			"get_Divider"
		end

	frozen get_image_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ToolBar"
		alias
			"get_ImageSize"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ToolBar"
		alias
			"get_BackColor"
		end

	frozen get_text_align: WINFORMS_TOOL_BAR_TEXT_ALIGN is
		external
			"IL signature (): System.Windows.Forms.ToolBarTextAlign use System.Windows.Forms.ToolBar"
		alias
			"get_TextAlign"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.ToolBar"
		alias
			"get_BackgroundImage"
		end

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar"
		alias
			"get_TabStop"
		end

	frozen get_wrappable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar"
		alias
			"get_Wrappable"
		end

	get_dock: WINFORMS_DOCK_STYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.ToolBar"
		alias
			"get_Dock"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ToolBar"
		alias
			"get_ForeColor"
		end

	get_right_to_left: WINFORMS_RIGHT_TO_LEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.ToolBar"
		alias
			"get_RightToLeft"
		end

feature -- Element Change

	frozen set_divider (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_Divider"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_BackColor"
		end

	frozen add_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"add_Paint"
		end

	frozen remove_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"remove_Paint"
		end

	set_right_to_left (value: WINFORMS_RIGHT_TO_LEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_RightToLeft"
		end

	frozen set_appearance (value: WINFORMS_TOOL_BAR_APPEARANCE) is
		external
			"IL signature (System.Windows.Forms.ToolBarAppearance): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_Appearance"
		end

	frozen set_border_style (value: WINFORMS_BORDER_STYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_BorderStyle"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_TabStop"
		end

	frozen set_button_size (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_ButtonSize"
		end

	frozen add_button_click (value: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"add_ButtonClick"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_Text"
		end

	frozen set_image_list (value: WINFORMS_IMAGE_LIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_ImageList"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_ForeColor"
		end

	frozen add_button_drop_down (value: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"add_ButtonDropDown"
		end

	set_dock (value: WINFORMS_DOCK_STYLE) is
		external
			"IL signature (System.Windows.Forms.DockStyle): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_Dock"
		end

	frozen set_drop_down_arrows (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_DropDownArrows"
		end

	frozen set_auto_size (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_AutoSize"
		end

	frozen remove_button_click (value: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"remove_ButtonClick"
		end

	frozen set_text_align (value: WINFORMS_TOOL_BAR_TEXT_ALIGN) is
		external
			"IL signature (System.Windows.Forms.ToolBarTextAlign): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_TextAlign"
		end

	frozen set_ime_mode_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_ImeMode"
		end

	frozen set_wrappable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_Wrappable"
		end

	frozen set_show_tool_tips (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_ShowToolTips"
		end

	frozen remove_button_drop_down (value: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"remove_ButtonDropDown"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolBar"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ToolBar"
		alias
			"get_DefaultSize"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnFontChanged"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ToolBar"
		alias
			"get_CreateParams"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.ToolBar"
		alias
			"CreateHandle"
		end

	on_button_drop_down (e: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnButtonDropDown"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ToolBar"
		alias
			"Dispose"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.ToolBar"
		alias
			"SetBoundsCore"
		end

	on_resize (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnResize"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ToolBar"
		alias
			"get_DefaultImeMode"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnHandleCreated"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.ToolBar"
		alias
			"WndProc"
		end

	on_button_click (e: WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnButtonClick"
		end

end -- class WINFORMS_TOOL_BAR
