indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PrintPreviewDialog"

external class
	SYSTEM_WINDOWS_FORMS_PRINTPREVIEWDIALOG

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
	SYSTEM_WINDOWS_FORMS_FORM
		redefine
			on_closing,
			set_auto_scale_base_size,
			get_auto_scale_base_size,
			set_auto_scroll,
			get_auto_scroll,
			create_handle,
			set_text,
			get_text,
			set_right_to_left,
			get_right_to_left,
			set_fore_color,
			get_fore_color,
			set_font,
			get_font,
			set_dock,
			get_dock,
			set_cursor,
			get_cursor,
			set_context_menu,
			get_context_menu,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			set_anchor,
			get_anchor,
			set_allow_drop,
			get_allow_drop
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_printpreviewdialog

feature {NONE} -- Initialization

	frozen make_printpreviewdialog is
		external
			"IL creator use System.Windows.Forms.PrintPreviewDialog"
		end

feature -- Access

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Text"
		end

	frozen get_icon_icon: SYSTEM_DRAWING_ICON is
		external
			"IL signature (): System.Drawing.Icon use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Icon"
		end

	frozen get_auto_scale_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AutoScale"
		end

	frozen get_accessible_role_accessible_role: SYSTEM_WINDOWS_FORMS_ACCESSIBLEROLE is
		external
			"IL signature (): System.Windows.Forms.AccessibleRole use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AccessibleRole"
		end

	frozen get_show_in_taskbar_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_ShowInTaskbar"
		end

	frozen get_transparency_key_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_TransparencyKey"
		end

	frozen get_form_border_style_form_border_style: SYSTEM_WINDOWS_FORMS_FORMBORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.FormBorderStyle use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_FormBorderStyle"
		end

	frozen get_is_mdi_container_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_IsMdiContainer"
		end

	get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Font"
		end

	frozen get_tag_object: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Tag"
		end

	frozen get_menu_main_menu: SYSTEM_WINDOWS_FORMS_MAINMENU is
		external
			"IL signature (): System.Windows.Forms.MainMenu use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Menu"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_BackColor"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_BackgroundImage"
		end

	frozen get_minimize_box_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_MinimizeBox"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_ForeColor"
		end

	get_right_to_left: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_RightToLeft"
		end

	frozen get_auto_scroll_margin_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AutoScrollMargin"
		end

	frozen get_maximize_box_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_MaximizeBox"
		end

	frozen get_enabled_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Enabled"
		end

	get_auto_scale_base_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AutoScaleBaseSize"
		end

	frozen get_accessible_name_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AccessibleName"
		end

	frozen get_print_preview_control: SYSTEM_WINDOWS_FORMS_PRINTPREVIEWCONTROL is
		external
			"IL signature (): System.Windows.Forms.PrintPreviewControl use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_PrintPreviewControl"
		end

	frozen get_location_point: SYSTEM_DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Location"
		end

	frozen get_maximum_size_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_MaximumSize"
		end

	frozen get_top_most_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_TopMost"
		end

	get_context_menu: SYSTEM_WINDOWS_FORMS_CONTEXTMENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_ContextMenu"
		end

	frozen get_data_bindings_control_bindings_collection: SYSTEM_WINDOWS_FORMS_CONTROLBINDINGSCOLLECTION is
		external
			"IL signature (): System.Windows.Forms.ControlBindingsCollection use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_DataBindings"
		end

	frozen get_opacity_double: DOUBLE is
		external
			"IL signature (): System.Double use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Opacity"
		end

	frozen get_minimum_size_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_MinimumSize"
		end

	get_auto_scroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AutoScroll"
		end

	frozen get_use_anti_alias: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_UseAntiAlias"
		end

	frozen get_window_state_form_window_state: SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE is
		external
			"IL signature (): System.Windows.Forms.FormWindowState use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_WindowState"
		end

	frozen get_auto_scroll_min_size_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AutoScrollMinSize"
		end

	frozen get_dock_padding_dock_padding_edges: DOCKPADDINGEDGES_IN_SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL is
		external
			"IL signature (): System.Windows.Forms.ScrollableControl+DockPaddingEdges use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_DockPadding"
		end

	frozen get_accessible_description_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AccessibleDescription"
		end

	frozen get_cancel_button_ibutton_control: SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL is
		external
			"IL signature (): System.Windows.Forms.IButtonControl use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_CancelButton"
		end

	frozen get_key_preview_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_KeyPreview"
		end

	frozen get_causes_validation_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_CausesValidation"
		end

	frozen get_accept_button_ibutton_control: SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL is
		external
			"IL signature (): System.Windows.Forms.IButtonControl use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AcceptButton"
		end

	frozen get_size_size2: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Size"
		end

	frozen get_tab_stop_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_TabStop"
		end

	get_cursor: SYSTEM_WINDOWS_FORMS_CURSOR is
		external
			"IL signature (): System.Windows.Forms.Cursor use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Cursor"
		end

	get_anchor: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
		external
			"IL signature (): System.Windows.Forms.AnchorStyles use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Anchor"
		end

	frozen get_size_grip_style_size_grip_style: SYSTEM_WINDOWS_FORMS_SIZEGRIPSTYLE is
		external
			"IL signature (): System.Windows.Forms.SizeGripStyle use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_SizeGripStyle"
		end

	get_allow_drop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_AllowDrop"
		end

	get_dock: SYSTEM_WINDOWS_FORMS_DOCKSTYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Dock"
		end

	frozen get_document: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT is
		external
			"IL signature (): System.Drawing.Printing.PrintDocument use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Document"
		end

	frozen get_visible_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_Visible"
		end

	frozen get_control_box_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_ControlBox"
		end

	frozen get_start_position_form_start_position: SYSTEM_WINDOWS_FORMS_FORMSTARTPOSITION is
		external
			"IL signature (): System.Windows.Forms.FormStartPosition use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_StartPosition"
		end

	frozen get_help_button_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_HelpButton"
		end

	frozen get_ime_mode_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.PrintPreviewDialog"
		alias
			"get_ImeMode"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Text"
		end

	set_cursor (value: SYSTEM_WINDOWS_FORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Cursor"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_BackColor"
		end

	frozen set_auto_scale_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AutoScale"
		end

	frozen set_accessible_role_accessible_role (value: SYSTEM_WINDOWS_FORMS_ACCESSIBLEROLE) is
		external
			"IL signature (System.Windows.Forms.AccessibleRole): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AccessibleRole"
		end

	frozen set_cancel_button_ibutton_control (value: SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL) is
		external
			"IL signature (System.Windows.Forms.IButtonControl): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_CancelButton"
		end

	frozen set_use_anti_alias (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_UseAntiAlias"
		end

	set_right_to_left (value: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_RightToLeft"
		end

	frozen set_enabled_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Enabled"
		end

	frozen set_is_mdi_container_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_IsMdiContainer"
		end

	frozen set_visible_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Visible"
		end

	frozen set_minimum_size_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_MinimumSize"
		end

	frozen set_size_grip_style_size_grip_style (value: SYSTEM_WINDOWS_FORMS_SIZEGRIPSTYLE) is
		external
			"IL signature (System.Windows.Forms.SizeGripStyle): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_SizeGripStyle"
		end

	frozen set_key_preview_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_KeyPreview"
		end

	frozen set_causes_validation_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_CausesValidation"
		end

	set_auto_scale_base_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AutoScaleBaseSize"
		end

	frozen set_maximum_size_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_MaximumSize"
		end

	frozen set_auto_scroll_margin_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AutoScrollMargin"
		end

	set_context_menu (value: SYSTEM_WINDOWS_FORMS_CONTEXTMENU) is
		external
			"IL signature (System.Windows.Forms.ContextMenu): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_ContextMenu"
		end

	frozen set_accept_button_ibutton_control (value: SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL) is
		external
			"IL signature (System.Windows.Forms.IButtonControl): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AcceptButton"
		end

	set_anchor (value: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES) is
		external
			"IL signature (System.Windows.Forms.AnchorStyles): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Anchor"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_BackgroundImage"
		end

	frozen set_tab_stop_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_TabStop"
		end

	frozen set_minimize_box_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_MinimizeBox"
		end

	set_dock (value: SYSTEM_WINDOWS_FORMS_DOCKSTYLE) is
		external
			"IL signature (System.Windows.Forms.DockStyle): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Dock"
		end

	frozen set_control_box_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_ControlBox"
		end

	frozen set_form_border_style_form_border_style (value: SYSTEM_WINDOWS_FORMS_FORMBORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.FormBorderStyle): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_FormBorderStyle"
		end

	frozen set_transparency_key_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_TransparencyKey"
		end

	frozen set_location_point (value: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Location"
		end

	frozen set_accessible_description_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AccessibleDescription"
		end

	frozen set_accessible_name_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AccessibleName"
		end

	frozen set_menu_main_menu (value: SYSTEM_WINDOWS_FORMS_MAINMENU) is
		external
			"IL signature (System.Windows.Forms.MainMenu): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Menu"
		end

	frozen set_document (value: SYSTEM_DRAWING_PRINTING_PRINTDOCUMENT) is
		external
			"IL signature (System.Drawing.Printing.PrintDocument): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Document"
		end

	frozen set_opacity_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Opacity"
		end

	frozen set_start_position_form_start_position (value: SYSTEM_WINDOWS_FORMS_FORMSTARTPOSITION) is
		external
			"IL signature (System.Windows.Forms.FormStartPosition): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_StartPosition"
		end

	frozen set_auto_scroll_min_size_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AutoScrollMinSize"
		end

	set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Font"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_ForeColor"
		end

	frozen set_ime_mode_ime_mode (value: SYSTEM_WINDOWS_FORMS_IMEMODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_ImeMode"
		end

	frozen set_icon_icon (value: SYSTEM_DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Icon"
		end

	frozen set_top_most_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_TopMost"
		end

	frozen set_show_in_taskbar_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_ShowInTaskbar"
		end

	frozen set_window_state_form_window_state (value: SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE) is
		external
			"IL signature (System.Windows.Forms.FormWindowState): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_WindowState"
		end

	set_auto_scroll (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AutoScroll"
		end

	frozen set_maximize_box_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_MaximizeBox"
		end

	frozen set_tag_object (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Tag"
		end

	set_allow_drop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_AllowDrop"
		end

	frozen set_help_button_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_HelpButton"
		end

	frozen set_size_size2 (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"set_Size"
		end

feature {NONE} -- Implementation

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"CreateHandle"
		end

	on_closing (e: SYSTEM_COMPONENTMODEL_CANCELEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CancelEventArgs): System.Void use System.Windows.Forms.PrintPreviewDialog"
		alias
			"OnClosing"
		end

end -- class SYSTEM_WINDOWS_FORMS_PRINTPREVIEWDIALOG
