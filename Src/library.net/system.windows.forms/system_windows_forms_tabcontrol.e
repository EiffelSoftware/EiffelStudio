indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TabControl"

external class
	SYSTEM_WINDOWS_FORMS_TABCONTROL

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
			process_key_preview,
			on_style_changed,
			on_resize,
			on_key_down,
			on_handle_destroyed,
			on_handle_created,
			on_font_changed,
			is_input_key,
			create_handle,
			create_controls_instance,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			get_display_rectangle,
			get_default_size,
			get_create_params,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			to_string
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_tabcontrol

feature {NONE} -- Initialization

	frozen make_tabcontrol is
		external
			"IL creator use System.Windows.Forms.TabControl"
		end

feature -- Access

	frozen get_item_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.TabControl"
		alias
			"get_ItemSize"
		end

	frozen get_size_mode: SYSTEM_WINDOWS_FORMS_TABSIZEMODE is
		external
			"IL signature (): System.Windows.Forms.TabSizeMode use System.Windows.Forms.TabControl"
		alias
			"get_SizeMode"
		end

	frozen get_show_tool_tips: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabControl"
		alias
			"get_ShowToolTips"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabControl"
		alias
			"get_Text"
		end

	frozen get_appearance: SYSTEM_WINDOWS_FORMS_TABAPPEARANCE is
		external
			"IL signature (): System.Windows.Forms.TabAppearance use System.Windows.Forms.TabControl"
		alias
			"get_Appearance"
		end

	frozen get_row_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TabControl"
		alias
			"get_RowCount"
		end

	frozen get_alignment: SYSTEM_WINDOWS_FORMS_TABALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.TabAlignment use System.Windows.Forms.TabControl"
		alias
			"get_Alignment"
		end

	frozen get_draw_mode: SYSTEM_WINDOWS_FORMS_TABDRAWMODE is
		external
			"IL signature (): System.Windows.Forms.TabDrawMode use System.Windows.Forms.TabControl"
		alias
			"get_DrawMode"
		end

	frozen get_selected_tab: SYSTEM_WINDOWS_FORMS_TABPAGE is
		external
			"IL signature (): System.Windows.Forms.TabPage use System.Windows.Forms.TabControl"
		alias
			"get_SelectedTab"
		end

	frozen get_tab_pages: TABPAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_TABCONTROL is
		external
			"IL signature (): System.Windows.Forms.TabControl+TabPageCollection use System.Windows.Forms.TabControl"
		alias
			"get_TabPages"
		end

	frozen get_image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.TabControl"
		alias
			"get_ImageList"
		end

	frozen get_multiline: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabControl"
		alias
			"get_Multiline"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TabControl"
		alias
			"get_BackColor"
		end

	frozen get_hot_track: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabControl"
		alias
			"get_HotTrack"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.TabControl"
		alias
			"get_BackgroundImage"
		end

	get_display_rectangle: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.TabControl"
		alias
			"get_DisplayRectangle"
		end

	frozen get_padding: SYSTEM_DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.TabControl"
		alias
			"get_Padding"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TabControl"
		alias
			"get_ForeColor"
		end

	frozen get_tab_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TabControl"
		alias
			"get_TabCount"
		end

	frozen get_selected_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TabControl"
		alias
			"get_SelectedIndex"
		end

feature -- Element Change

	frozen set_image_list (value: SYSTEM_WINDOWS_FORMS_IMAGELIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_ImageList"
		end

	frozen set_size_mode (value: SYSTEM_WINDOWS_FORMS_TABSIZEMODE) is
		external
			"IL signature (System.Windows.Forms.TabSizeMode): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_SizeMode"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_BackColor"
		end

	frozen set_selected_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_SelectedIndex"
		end

	frozen set_hot_track (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_HotTrack"
		end

	frozen set_appearance (value: SYSTEM_WINDOWS_FORMS_TABAPPEARANCE) is
		external
			"IL signature (System.Windows.Forms.TabAppearance): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_Appearance"
		end

	frozen set_draw_mode (value: SYSTEM_WINDOWS_FORMS_TABDRAWMODE) is
		external
			"IL signature (System.Windows.Forms.TabDrawMode): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_DrawMode"
		end

	frozen remove_draw_item (value: SYSTEM_WINDOWS_FORMS_DRAWITEMEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventHandler): System.Void use System.Windows.Forms.TabControl"
		alias
			"remove_DrawItem"
		end

	frozen add_selected_index_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TabControl"
		alias
			"add_SelectedIndexChanged"
		end

	frozen remove_selected_index_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TabControl"
		alias
			"remove_SelectedIndexChanged"
		end

	frozen set_padding (value: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_Padding"
		end

	frozen set_show_tool_tips (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_ShowToolTips"
		end

	frozen set_alignment (value: SYSTEM_WINDOWS_FORMS_TABALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.TabAlignment): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_Alignment"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_ForeColor"
		end

	frozen remove_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TabControl"
		alias
			"remove_Click"
		end

	frozen set_item_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_ItemSize"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_Text"
		end

	frozen add_draw_item (value: SYSTEM_WINDOWS_FORMS_DRAWITEMEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventHandler): System.Void use System.Windows.Forms.TabControl"
		alias
			"add_DrawItem"
		end

	frozen set_multiline (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_Multiline"
		end

	frozen set_selected_tab (value: SYSTEM_WINDOWS_FORMS_TABPAGE) is
		external
			"IL signature (System.Windows.Forms.TabPage): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_SelectedTab"
		end

	frozen add_click_event_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.TabControl"
		alias
			"add_Click"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.TabControl"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	frozen get_control (index: INTEGER): SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (System.Int32): System.Windows.Forms.Control use System.Windows.Forms.TabControl"
		alias
			"GetControl"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabControl"
		alias
			"ToString"
		end

	frozen get_tab_rect (index: INTEGER): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (System.Int32): System.Drawing.Rectangle use System.Windows.Forms.TabControl"
		alias
			"GetTabRect"
		end

feature {NONE} -- Implementation

	frozen get_tool_tip_text (item: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.TabControl"
		alias
			"GetToolTipText"
		end

	on_selected_index_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TabControl"
		alias
			"OnSelectedIndexChanged"
		end

	create_controls_instance: CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.TabControl"
		alias
			"CreateControlsInstance"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.TabControl"
		alias
			"get_CreateParams"
		end

	process_key_preview (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.TabControl"
		alias
			"ProcessKeyPreview"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.TabControl"
		alias
			"WndProc"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.TabControl"
		alias
			"CreateHandle"
		end

	get_items_type (base_type: SYSTEM_TYPE): ARRAY [ANY] is
		external
			"IL signature (System.Type): System.Object[] use System.Windows.Forms.TabControl"
		alias
			"GetItems"
		end

	on_key_down (ke: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.TabControl"
		alias
			"OnKeyDown"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.TabControl"
		alias
			"get_DefaultSize"
		end

	get_items: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Windows.Forms.TabControl"
		alias
			"GetItems"
		end

	frozen update_tab_selection (uiselected: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TabControl"
		alias
			"UpdateTabSelection"
		end

	on_resize (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TabControl"
		alias
			"OnResize"
		end

	frozen remove_all is
		external
			"IL signature (): System.Void use System.Windows.Forms.TabControl"
		alias
			"RemoveAll"
		end

	on_draw_item (e: SYSTEM_WINDOWS_FORMS_DRAWITEMEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventArgs): System.Void use System.Windows.Forms.TabControl"
		alias
			"OnDrawItem"
		end

	on_style_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TabControl"
		alias
			"OnStyleChanged"
		end

	on_font_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TabControl"
		alias
			"OnFontChanged"
		end

	on_handle_destroyed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TabControl"
		alias
			"OnHandleDestroyed"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TabControl"
		alias
			"OnHandleCreated"
		end

	is_input_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.TabControl"
		alias
			"IsInputKey"
		end

end -- class SYSTEM_WINDOWS_FORMS_TABCONTROL
