indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.StatusBar"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_STATUS_BAR

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			on_resize,
			on_mouse_down,
			on_layout,
			on_handle_destroyed,
			on_handle_created,
			create_handle,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			set_font,
			get_font,
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
	make_winforms_status_bar

feature {NONE} -- Initialization

	frozen make_winforms_status_bar is
		external
			"IL creator use System.Windows.Forms.StatusBar"
		end

feature -- Access

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar"
		alias
			"get_TabStop"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.StatusBar"
		alias
			"get_BackColor"
		end

	get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.StatusBar"
		alias
			"get_Font"
		end

	get_dock: WINFORMS_DOCK_STYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.StatusBar"
		alias
			"get_Dock"
		end

	frozen get_show_panels: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar"
		alias
			"get_ShowPanels"
		end

	frozen get_panels: WINFORMS_STATUS_BAR_PANEL_COLLECTION_IN_WINFORMS_STATUS_BAR is
		external
			"IL signature (): System.Windows.Forms.StatusBar+StatusBarPanelCollection use System.Windows.Forms.StatusBar"
		alias
			"get_Panels"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBar"
		alias
			"get_Text"
		end

	frozen get_ime_mode_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.StatusBar"
		alias
			"get_ImeMode"
		end

	frozen get_sizing_grip: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar"
		alias
			"get_SizingGrip"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.StatusBar"
		alias
			"get_ForeColor"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.StatusBar"
		alias
			"get_BackgroundImage"
		end

feature -- Element Change

	frozen add_panel_click (value: WINFORMS_STATUS_BAR_PANEL_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelClickEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"add_PanelClick"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_Text"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_TabStop"
		end

	frozen remove_draw_item (value: WINFORMS_STATUS_BAR_DRAW_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.StatusBarDrawItemEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"remove_DrawItem"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_BackColor"
		end

	frozen add_draw_item (value: WINFORMS_STATUS_BAR_DRAW_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.StatusBarDrawItemEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"add_DrawItem"
		end

	set_dock (value: WINFORMS_DOCK_STYLE) is
		external
			"IL signature (System.Windows.Forms.DockStyle): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_Dock"
		end

	frozen set_ime_mode_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_ImeMode"
		end

	set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_Font"
		end

	frozen add_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"add_Paint"
		end

	frozen set_sizing_grip (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_SizingGrip"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_ForeColor"
		end

	frozen remove_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"remove_Paint"
		end

	frozen set_show_panels (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_ShowPanels"
		end

	frozen remove_panel_click (value: WINFORMS_STATUS_BAR_PANEL_CLICK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelClickEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"remove_PanelClick"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBar"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.StatusBar"
		alias
			"get_DefaultSize"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.StatusBar"
		alias
			"get_CreateParams"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.StatusBar"
		alias
			"CreateHandle"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.StatusBar"
		alias
			"Dispose"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.StatusBar"
		alias
			"get_DefaultImeMode"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnHandleCreated"
		end

	on_handle_destroyed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnHandleDestroyed"
		end

	on_resize (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnResize"
		end

	on_layout (levent: WINFORMS_LAYOUT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.LayoutEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnLayout"
		end

	on_draw_item (sbdievent: WINFORMS_STATUS_BAR_DRAW_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.StatusBarDrawItemEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnDrawItem"
		end

	on_panel_click (e: WINFORMS_STATUS_BAR_PANEL_CLICK_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelClickEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnPanelClick"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.StatusBar"
		alias
			"WndProc"
		end

	on_mouse_down (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnMouseDown"
		end

end -- class WINFORMS_STATUS_BAR
