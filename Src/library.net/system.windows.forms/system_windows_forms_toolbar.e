indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ToolBar"

external class
	SYSTEM_WINDOWS_FORMS_TOOLBAR

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_CONTROL
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
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_toolbar

feature {NONE} -- Initialization

	frozen make_toolbar is
		external
			"IL creator use System.Windows.Forms.ToolBar"
		end

feature -- Access

	frozen get_buttons: TOOLBARBUTTONCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_TOOLBAR is
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

	frozen get_button_size: SYSTEM_DRAWING_SIZE is
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

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolBar"
		alias
			"get_Text"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.ToolBar"
		alias
			"get_BorderStyle"
		end

	frozen get_appearance: SYSTEM_WINDOWS_FORMS_TOOLBARAPPEARANCE is
		external
			"IL signature (): System.Windows.Forms.ToolBarAppearance use System.Windows.Forms.ToolBar"
		alias
			"get_Appearance"
		end

	frozen get_image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.ToolBar"
		alias
			"get_ImageList"
		end

	frozen get_ime_mode_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
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

	frozen get_image_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ToolBar"
		alias
			"get_ImageSize"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ToolBar"
		alias
			"get_BackColor"
		end

	frozen get_text_align: SYSTEM_WINDOWS_FORMS_TOOLBARTEXTALIGN is
		external
			"IL signature (): System.Windows.Forms.ToolBarTextAlign use System.Windows.Forms.ToolBar"
		alias
			"get_TextAlign"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
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

	get_dock: SYSTEM_WINDOWS_FORMS_DOCKSTYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.ToolBar"
		alias
			"get_Dock"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ToolBar"
		alias
			"get_ForeColor"
		end

	get_right_to_left: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT is
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

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_BackColor"
		end

	set_right_to_left (value: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_RightToLeft"
		end

	frozen set_appearance (value: SYSTEM_WINDOWS_FORMS_TOOLBARAPPEARANCE) is
		external
			"IL signature (System.Windows.Forms.ToolBarAppearance): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_Appearance"
		end

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_BORDERSTYLE) is
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

	frozen set_button_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_ButtonSize"
		end

	frozen add_button_click (value: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"add_ButtonClick"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_Text"
		end

	frozen set_image_list (value: SYSTEM_WINDOWS_FORMS_IMAGELIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_ImageList"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_ForeColor"
		end

	frozen add_button_drop_down (value: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"add_ButtonDropDown"
		end

	set_dock (value: SYSTEM_WINDOWS_FORMS_DOCKSTYLE) is
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

	frozen remove_button_click (value: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"remove_ButtonClick"
		end

	frozen set_text_align (value: SYSTEM_WINDOWS_FORMS_TOOLBARTEXTALIGN) is
		external
			"IL signature (System.Windows.Forms.ToolBarTextAlign): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_TextAlign"
		end

	frozen set_ime_mode_ime_mode (value: SYSTEM_WINDOWS_FORMS_IMEMODE) is
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

	frozen remove_button_drop_down (value: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventHandler): System.Void use System.Windows.Forms.ToolBar"
		alias
			"remove_ButtonDropDown"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ToolBar"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolBar"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ToolBar"
		alias
			"get_DefaultSize"
		end

	on_font_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnFontChanged"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
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

	on_button_drop_down (e: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTARGS) is
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

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.ToolBar"
		alias
			"SetBoundsCore"
		end

	on_resize (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnResize"
		end

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.ToolBar"
		alias
			"get_DefaultImeMode"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnHandleCreated"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.ToolBar"
		alias
			"WndProc"
		end

	on_button_click (e: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ToolBarButtonClickEventArgs): System.Void use System.Windows.Forms.ToolBar"
		alias
			"OnButtonClick"
		end

end -- class SYSTEM_WINDOWS_FORMS_TOOLBAR
