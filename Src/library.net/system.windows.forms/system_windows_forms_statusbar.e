indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.StatusBar"

external class
	SYSTEM_WINDOWS_FORMS_STATUSBAR

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
			on_resize,
			on_mouse_up,
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
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_statusbar

feature {NONE} -- Initialization

	frozen make_statusbar is
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

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.StatusBar"
		alias
			"get_BackColor"
		end

	get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.StatusBar"
		alias
			"get_Font"
		end

	get_dock: SYSTEM_WINDOWS_FORMS_DOCKSTYLE is
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

	frozen get_panels: STATUSBARPANELCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_STATUSBAR is
		external
			"IL signature (): System.Windows.Forms.StatusBar+StatusBarPanelCollection use System.Windows.Forms.StatusBar"
		alias
			"get_Panels"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBar"
		alias
			"get_Text"
		end

	frozen get_ime_mode_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
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

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.StatusBar"
		alias
			"get_ForeColor"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.StatusBar"
		alias
			"get_BackgroundImage"
		end

feature -- Element Change

	frozen add_panel_click (value: SYSTEM_WINDOWS_FORMS_STATUSBARPANELCLICKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelClickEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"add_PanelClick"
		end

	set_text (value: STRING) is
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

	frozen remove_draw_item (value: SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.StatusBarDrawItemEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"remove_DrawItem"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_BackColor"
		end

	frozen add_draw_item (value: SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.StatusBarDrawItemEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"add_DrawItem"
		end

	set_dock (value: SYSTEM_WINDOWS_FORMS_DOCKSTYLE) is
		external
			"IL signature (System.Windows.Forms.DockStyle): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_Dock"
		end

	frozen set_ime_mode_ime_mode (value: SYSTEM_WINDOWS_FORMS_IMEMODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_ImeMode"
		end

	set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_Font"
		end

	frozen set_sizing_grip (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_SizingGrip"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_ForeColor"
		end

	frozen set_show_panels (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_ShowPanels"
		end

	frozen remove_panel_click (value: SYSTEM_WINDOWS_FORMS_STATUSBARPANELCLICKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelClickEventHandler): System.Void use System.Windows.Forms.StatusBar"
		alias
			"remove_PanelClick"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.StatusBar"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBar"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.StatusBar"
		alias
			"get_DefaultSize"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
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

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.StatusBar"
		alias
			"get_DefaultImeMode"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnHandleCreated"
		end

	on_handle_destroyed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnHandleDestroyed"
		end

	on_resize (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnResize"
		end

	on_layout (levent: SYSTEM_WINDOWS_FORMS_LAYOUTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.LayoutEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnLayout"
		end

	on_draw_item (sbdievent: SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.StatusBarDrawItemEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnDrawItem"
		end

	on_panel_click (e: SYSTEM_WINDOWS_FORMS_STATUSBARPANELCLICKEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanelClickEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnPanelClick"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.StatusBar"
		alias
			"WndProc"
		end

	on_mouse_up (mevent: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnMouseUp"
		end

	on_mouse_down (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.StatusBar"
		alias
			"OnMouseDown"
		end

end -- class SYSTEM_WINDOWS_FORMS_STATUSBAR
