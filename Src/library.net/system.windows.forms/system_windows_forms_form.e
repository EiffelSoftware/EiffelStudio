indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Form"

external class
	SYSTEM_WINDOWS_FORMS_FORM

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW
	SYSTEM_WINDOWS_FORMS_CONTAINERCONTROL
		redefine
			update_default_button,
			process_tab_key,
			adjust_form_scrollbars,
			set_auto_scroll,
			get_auto_scroll,
			wnd_proc,
			set_visible_core,
			set_client_size_core,
			set_bounds_core,
			select__boolean,
			scale_core,
			process_key_preview,
			process_dialog_key,
			process_cmd_key,
			on_style_changed,
			on_resize,
			on_paint,
			on_handle_destroyed,
			on_handle_created,
			on_create_control,
			on_visible_changed,
			on_text_changed,
			on_font_changed,
			def_wnd_proc,
			create_handle,
			create_controls_instance,
			get_default_size,
			get_default_ime_mode,
			get_create_params,
			set_back_color,
			get_back_color,
			dispose_boolean,
			to_string
		end

create
	make_form

feature {NONE} -- Initialization

	frozen make_form is
		external
			"IL creator use System.Windows.Forms.Form"
		end

feature -- Access

	frozen get_owner: SYSTEM_WINDOWS_FORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.Form"
		alias
			"get_Owner"
		end

	frozen get_is_restricted_window: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_IsRestrictedWindow"
		end

	frozen get_menu: SYSTEM_WINDOWS_FORMS_MAINMENU is
		external
			"IL signature (): System.Windows.Forms.MainMenu use System.Windows.Forms.Form"
		alias
			"get_Menu"
		end

	frozen get_control_box: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_ControlBox"
		end

	frozen get_modal: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_Modal"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.Form"
		alias
			"get_BackColor"
		end

	frozen get_show_in_taskbar: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_ShowInTaskbar"
		end

	frozen get_top_level_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_TopLevel"
		end

	frozen get_minimum_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Form"
		alias
			"get_MinimumSize"
		end

	frozen get_help_button: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_HelpButton"
		end

	frozen get_active_form: SYSTEM_WINDOWS_FORMS_FORM is
		external
			"IL static signature (): System.Windows.Forms.Form use System.Windows.Forms.Form"
		alias
			"get_ActiveForm"
		end

	frozen get_auto_scale: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_AutoScale"
		end

	frozen get_mdi_children: ARRAY [SYSTEM_WINDOWS_FORMS_FORM] is
		external
			"IL signature (): System.Windows.Forms.Form[] use System.Windows.Forms.Form"
		alias
			"get_MdiChildren"
		end

	frozen get_active_mdi_child: SYSTEM_WINDOWS_FORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.Form"
		alias
			"get_ActiveMdiChild"
		end

	frozen get_form_border_style: SYSTEM_WINDOWS_FORMS_FORMBORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.FormBorderStyle use System.Windows.Forms.Form"
		alias
			"get_FormBorderStyle"
		end

	frozen get_opacity: DOUBLE is
		external
			"IL signature (): System.Double use System.Windows.Forms.Form"
		alias
			"get_Opacity"
		end

	frozen get_accept_button: SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL is
		external
			"IL signature (): System.Windows.Forms.IButtonControl use System.Windows.Forms.Form"
		alias
			"get_AcceptButton"
		end

	frozen get_is_mdi_child: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_IsMdiChild"
		end

	frozen get_window_state: SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE is
		external
			"IL signature (): System.Windows.Forms.FormWindowState use System.Windows.Forms.Form"
		alias
			"get_WindowState"
		end

	frozen get_mdi_parent: SYSTEM_WINDOWS_FORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.Form"
		alias
			"get_MdiParent"
		end

	frozen get_transparency_key: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.Form"
		alias
			"get_TransparencyKey"
		end

	frozen get_desktop_location: SYSTEM_DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.Form"
		alias
			"get_DesktopLocation"
		end

	frozen get_owned_forms: ARRAY [SYSTEM_WINDOWS_FORMS_FORM] is
		external
			"IL signature (): System.Windows.Forms.Form[] use System.Windows.Forms.Form"
		alias
			"get_OwnedForms"
		end

	frozen get_tab_index_int32: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Form"
		alias
			"get_TabIndex"
		end

	frozen get_icon: SYSTEM_DRAWING_ICON is
		external
			"IL signature (): System.Drawing.Icon use System.Windows.Forms.Form"
		alias
			"get_Icon"
		end

	frozen get_client_size_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Form"
		alias
			"get_ClientSize"
		end

	frozen get_size_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Form"
		alias
			"get_Size"
		end

	frozen get_merged_menu: SYSTEM_WINDOWS_FORMS_MAINMENU is
		external
			"IL signature (): System.Windows.Forms.MainMenu use System.Windows.Forms.Form"
		alias
			"get_MergedMenu"
		end

	get_auto_scroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_AutoScroll"
		end

	frozen get_desktop_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Form"
		alias
			"get_DesktopBounds"
		end

	frozen get_top_most: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_TopMost"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_FORMBORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.FormBorderStyle use System.Windows.Forms.Form"
		alias
			"get_BorderStyle"
		end

	frozen get_minimize_box: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_MinimizeBox"
		end

	get_auto_scale_base_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Form"
		alias
			"get_AutoScaleBaseSize"
		end

	frozen get_is_mdi_container: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_IsMdiContainer"
		end

	frozen get_start_position: SYSTEM_WINDOWS_FORMS_FORMSTARTPOSITION is
		external
			"IL signature (): System.Windows.Forms.FormStartPosition use System.Windows.Forms.Form"
		alias
			"get_StartPosition"
		end

	frozen get_maximum_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Form"
		alias
			"get_MaximumSize"
		end

	frozen get_maximize_box: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_MaximizeBox"
		end

	frozen get_dialog_result: SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.Form"
		alias
			"get_DialogResult"
		end

	frozen get_size_grip_style: SYSTEM_WINDOWS_FORMS_SIZEGRIPSTYLE is
		external
			"IL signature (): System.Windows.Forms.SizeGripStyle use System.Windows.Forms.Form"
		alias
			"get_SizeGripStyle"
		end

	frozen get_cancel_button: SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL is
		external
			"IL signature (): System.Windows.Forms.IButtonControl use System.Windows.Forms.Form"
		alias
			"get_CancelButton"
		end

	frozen get_allow_transparency: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_AllowTransparency"
		end

	frozen get_key_preview: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Form"
		alias
			"get_KeyPreview"
		end

feature -- Element Change

	frozen set_mdi_parent (value: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL signature (System.Windows.Forms.Form): System.Void use System.Windows.Forms.Form"
		alias
			"set_MdiParent"
		end

	frozen remove_activated (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_Activated"
		end

	frozen set_size_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Form"
		alias
			"set_Size"
		end

	frozen set_top_most (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_TopMost"
		end

	frozen set_desktop_bounds (value: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Form"
		alias
			"set_DesktopBounds"
		end

	frozen add_maximized_bounds_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_MaximizedBoundsChanged"
		end

	frozen set_menu (value: SYSTEM_WINDOWS_FORMS_MAINMENU) is
		external
			"IL signature (System.Windows.Forms.MainMenu): System.Void use System.Windows.Forms.Form"
		alias
			"set_Menu"
		end

	frozen add_minimum_size_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_MinimumSizeChanged"
		end

	frozen remove_deactivate (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_Deactivate"
		end

	frozen set_size_grip_style (value: SYSTEM_WINDOWS_FORMS_SIZEGRIPSTYLE) is
		external
			"IL signature (System.Windows.Forms.SizeGripStyle): System.Void use System.Windows.Forms.Form"
		alias
			"set_SizeGripStyle"
		end

	frozen set_top_level_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_TopLevel"
		end

	frozen remove_minimum_size_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_MinimumSizeChanged"
		end

	frozen add_load (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_Load"
		end

	frozen set_cancel_button (value: SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL) is
		external
			"IL signature (System.Windows.Forms.IButtonControl): System.Void use System.Windows.Forms.Form"
		alias
			"set_CancelButton"
		end

	frozen add_input_language_changed (value: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.InputLanguageChangedEventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_InputLanguageChanged"
		end

	frozen set_auto_scale (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_AutoScale"
		end

	frozen set_form_border_style (value: SYSTEM_WINDOWS_FORMS_FORMBORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.FormBorderStyle): System.Void use System.Windows.Forms.Form"
		alias
			"set_FormBorderStyle"
		end

	frozen set_help_button (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_HelpButton"
		end

	frozen set_key_preview (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_KeyPreview"
		end

	frozen set_owner (value: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL signature (System.Windows.Forms.Form): System.Void use System.Windows.Forms.Form"
		alias
			"set_Owner"
		end

	frozen set_transparency_key (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.Form"
		alias
			"set_TransparencyKey"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.Form"
		alias
			"set_BackColor"
		end

	frozen remove_closed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_Closed"
		end

	frozen remove_input_language_changing (value: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGINGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.InputLanguageChangingEventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_InputLanguageChanging"
		end

	frozen remove_maximized_bounds_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_MaximizedBoundsChanged"
		end

	frozen add_menu_start (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_MenuStart"
		end

	frozen set_icon (value: SYSTEM_DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.Form"
		alias
			"set_Icon"
		end

	set_auto_scale_base_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Form"
		alias
			"set_AutoScaleBaseSize"
		end

	frozen set_tab_index_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Form"
		alias
			"set_TabIndex"
		end

	frozen set_show_in_taskbar (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_ShowInTaskbar"
		end

	frozen add_maximum_size_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_MaximumSizeChanged"
		end

	frozen add_activated (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_Activated"
		end

	frozen set_allow_transparency (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_AllowTransparency"
		end

	frozen add_closed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_Closed"
		end

	frozen add_menu_complete (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_MenuComplete"
		end

	frozen set_maximum_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Form"
		alias
			"set_MaximumSize"
		end

	frozen set_window_state (value: SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE) is
		external
			"IL signature (System.Windows.Forms.FormWindowState): System.Void use System.Windows.Forms.Form"
		alias
			"set_WindowState"
		end

	frozen set_minimum_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Form"
		alias
			"set_MinimumSize"
		end

	frozen remove_menu_complete (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_MenuComplete"
		end

	frozen set_accept_button (value: SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL) is
		external
			"IL signature (System.Windows.Forms.IButtonControl): System.Void use System.Windows.Forms.Form"
		alias
			"set_AcceptButton"
		end

	frozen set_maximize_box (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_MaximizeBox"
		end

	frozen remove_input_language_changed (value: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGEDEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.InputLanguageChangedEventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_InputLanguageChanged"
		end

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_FORMBORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.FormBorderStyle): System.Void use System.Windows.Forms.Form"
		alias
			"set_BorderStyle"
		end

	frozen add_input_language_changing (value: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGINGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.InputLanguageChangingEventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_InputLanguageChanging"
		end

	frozen add_closing (value: SYSTEM_COMPONENTMODEL_CANCELEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CancelEventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_Closing"
		end

	frozen set_client_size_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Form"
		alias
			"set_ClientSize"
		end

	frozen remove_closing (value: SYSTEM_COMPONENTMODEL_CANCELEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CancelEventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_Closing"
		end

	frozen remove_maximum_size_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_MaximumSizeChanged"
		end

	frozen set_control_box (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_ControlBox"
		end

	frozen set_desktop_location (value: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Windows.Forms.Form"
		alias
			"set_DesktopLocation"
		end

	frozen remove_mdi_child_activate (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_MdiChildActivate"
		end

	frozen add_deactivate (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_Deactivate"
		end

	frozen set_minimize_box (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_MinimizeBox"
		end

	frozen set_opacity (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.Windows.Forms.Form"
		alias
			"set_Opacity"
		end

	set_auto_scroll (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_AutoScroll"
		end

	frozen remove_load (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_Load"
		end

	frozen remove_menu_start (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"remove_MenuStart"
		end

	frozen set_dialog_result (value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT) is
		external
			"IL signature (System.Windows.Forms.DialogResult): System.Void use System.Windows.Forms.Form"
		alias
			"set_DialogResult"
		end

	frozen add_mdi_child_activate (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Form"
		alias
			"add_MdiChildActivate"
		end

	frozen set_is_mdi_container (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"set_IsMdiContainer"
		end

	frozen set_start_position (value: SYSTEM_WINDOWS_FORMS_FORMSTARTPOSITION) is
		external
			"IL signature (System.Windows.Forms.FormStartPosition): System.Void use System.Windows.Forms.Form"
		alias
			"set_StartPosition"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Form"
		alias
			"ToString"
		end

	frozen show_dialog_iwin32_window (owner: SYSTEM_WINDOWS_FORMS_IWIN32WINDOW): SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (System.Windows.Forms.IWin32Window): System.Windows.Forms.DialogResult use System.Windows.Forms.Form"
		alias
			"ShowDialog"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Windows.Forms.Form"
		alias
			"Close"
		end

	frozen get_auto_scale_size (font: SYSTEM_DRAWING_FONT): SYSTEM_DRAWING_SIZEF is
		external
			"IL static signature (System.Drawing.Font): System.Drawing.SizeF use System.Windows.Forms.Form"
		alias
			"GetAutoScaleSize"
		end

	frozen add_owned_form (owned_form: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL signature (System.Windows.Forms.Form): System.Void use System.Windows.Forms.Form"
		alias
			"AddOwnedForm"
		end

	frozen show_dialog: SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.Form"
		alias
			"ShowDialog"
		end

	frozen set_desktop_bounds_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.Form"
		alias
			"SetDesktopBounds"
		end

	frozen layout_mdi (value: SYSTEM_WINDOWS_FORMS_MDILAYOUT) is
		external
			"IL signature (System.Windows.Forms.MdiLayout): System.Void use System.Windows.Forms.Form"
		alias
			"LayoutMdi"
		end

	frozen set_desktop_location_int32 (x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.Form"
		alias
			"SetDesktopLocation"
		end

	frozen remove_owned_form (owned_form: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL signature (System.Windows.Forms.Form): System.Void use System.Windows.Forms.Form"
		alias
			"RemoveOwnedForm"
		end

	frozen activate is
		external
			"IL signature (): System.Void use System.Windows.Forms.Form"
		alias
			"Activate"
		end

feature {NONE} -- Implementation

	on_paint (e: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnPaint"
		end

	on_input_language_changing (e: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGINGEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.InputLanguageChangingEventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnInputLanguageChanging"
		end

	frozen apply_auto_scaling is
		external
			"IL signature (): System.Void use System.Windows.Forms.Form"
		alias
			"ApplyAutoScaling"
		end

	on_handle_destroyed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnHandleDestroyed"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.Form"
		alias
			"CreateHandle"
		end

	on_menu_complete (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnMenuComplete"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnHandleCreated"
		end

	on_font_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnFontChanged"
		end

	on_menu_start (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnMenuStart"
		end

	on_text_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnTextChanged"
		end

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Form"
		alias
			"get_DefaultImeMode"
		end

	on_load (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnLoad"
		end

	process_cmd_key (msg: SYSTEM_WINDOWS_FORMS_MESSAGE; key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&, System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Form"
		alias
			"ProcessCmdKey"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"Dispose"
		end

	set_client_size_core (x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.Form"
		alias
			"SetClientSizeCore"
		end

	set_visible_core (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"SetVisibleCore"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.Form"
		alias
			"WndProc"
		end

	on_maximum_size_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnMaximumSizeChanged"
		end

	on_maximized_bounds_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnMaximizedBoundsChanged"
		end

	on_minimum_size_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnMinimumSizeChanged"
		end

	on_deactivate (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnDeactivate"
		end

	process_key_preview (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Form"
		alias
			"ProcessKeyPreview"
		end

	def_wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.Form"
		alias
			"DefWndProc"
		end

	on_create_control is
		external
			"IL signature (): System.Void use System.Windows.Forms.Form"
		alias
			"OnCreateControl"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Form"
		alias
			"get_CreateParams"
		end

	frozen get_maximized_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Form"
		alias
			"get_MaximizedBounds"
		end

	on_closing (e: SYSTEM_COMPONENTMODEL_CANCELEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CancelEventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnClosing"
		end

	frozen activate_mdi_child (form: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL signature (System.Windows.Forms.Form): System.Void use System.Windows.Forms.Form"
		alias
			"ActivateMdiChild"
		end

	frozen center_to_screen is
		external
			"IL signature (): System.Void use System.Windows.Forms.Form"
		alias
			"CenterToScreen"
		end

	on_activated (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnActivated"
		end

	on_closed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnClosed"
		end

	adjust_form_scrollbars (display_scrollbars: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"AdjustFormScrollbars"
		end

	frozen set_maximized_bounds (value: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Form"
		alias
			"set_MaximizedBounds"
		end

	update_default_button is
		external
			"IL signature (): System.Void use System.Windows.Forms.Form"
		alias
			"UpdateDefaultButton"
		end

	on_mdi_child_activate (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnMdiChildActivate"
		end

	process_dialog_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Form"
		alias
			"ProcessDialogKey"
		end

	process_tab_key (forward: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean): System.Boolean use System.Windows.Forms.Form"
		alias
			"ProcessTabKey"
		end

	scale_core (x: REAL; y: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Windows.Forms.Form"
		alias
			"ScaleCore"
		end

	on_visible_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnVisibleChanged"
		end

	on_style_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnStyleChanged"
		end

	create_controls_instance: CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.Form"
		alias
			"CreateControlsInstance"
		end

	on_resize (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnResize"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.Form"
		alias
			"SetBoundsCore"
		end

	on_input_language_changed (e: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECHANGEDEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.InputLanguageChangedEventArgs): System.Void use System.Windows.Forms.Form"
		alias
			"OnInputLanguageChanged"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Form"
		alias
			"get_DefaultSize"
		end

	select__boolean (directed: BOOLEAN; forward: BOOLEAN) is
		external
			"IL signature (System.Boolean, System.Boolean): System.Void use System.Windows.Forms.Form"
		alias
			"Select"
		end

	frozen center_to_parent is
		external
			"IL signature (): System.Void use System.Windows.Forms.Form"
		alias
			"CenterToParent"
		end

end -- class SYSTEM_WINDOWS_FORMS_FORM
