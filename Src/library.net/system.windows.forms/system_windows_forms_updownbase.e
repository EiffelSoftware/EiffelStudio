indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.UpDownBase"

deferred external class
	SYSTEM_WINDOWS_FORMS_UPDOWNBASE

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
			set_auto_scroll,
			get_auto_scroll,
			set_bounds_core,
			on_mouse_wheel,
			on_layout,
			on_handle_created,
			on_font_changed,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			get_focused,
			get_default_size,
			get_create_params,
			set_context_menu,
			get_context_menu,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color
		end

feature -- Access

	get_auto_scroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UpDownBase"
		alias
			"get_AutoScroll"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.UpDownBase"
		alias
			"get_BackgroundImage"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.UpDownBase"
		alias
			"get_ForeColor"
		end

	frozen get_text_align: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.UpDownBase"
		alias
			"get_TextAlign"
		end

	frozen get_dock_padding_dock_padding_edges: DOCKPADDINGEDGES_IN_SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL is
		external
			"IL signature (): System.Windows.Forms.ScrollableControl+DockPaddingEdges use System.Windows.Forms.UpDownBase"
		alias
			"get_DockPadding"
		end

	frozen get_auto_scroll_min_size_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.UpDownBase"
		alias
			"get_AutoScrollMinSize"
		end

	frozen get_up_down_align: SYSTEM_WINDOWS_FORMS_LEFTRIGHTALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.LeftRightAlignment use System.Windows.Forms.UpDownBase"
		alias
			"get_UpDownAlign"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.UpDownBase"
		alias
			"get_Text"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.UpDownBase"
		alias
			"get_BorderStyle"
		end

	get_context_menu: SYSTEM_WINDOWS_FORMS_CONTEXTMENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.UpDownBase"
		alias
			"get_ContextMenu"
		end

	frozen get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UpDownBase"
		alias
			"get_ReadOnly"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.UpDownBase"
		alias
			"get_BackColor"
		end

	get_focused: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UpDownBase"
		alias
			"get_Focused"
		end

	frozen get_auto_scroll_margin_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.UpDownBase"
		alias
			"get_AutoScrollMargin"
		end

	frozen get_intercept_arrow_keys: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UpDownBase"
		alias
			"get_InterceptArrowKeys"
		end

	frozen get_preferred_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.UpDownBase"
		alias
			"get_PreferredHeight"
		end

feature -- Element Change

	set_context_menu (value: SYSTEM_WINDOWS_FORMS_CONTEXTMENU) is
		external
			"IL signature (System.Windows.Forms.ContextMenu): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_ContextMenu"
		end

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_Text"
		end

	frozen set_text_align (value: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_TextAlign"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_BackColor"
		end

	frozen set_up_down_align (value: SYSTEM_WINDOWS_FORMS_LEFTRIGHTALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.LeftRightAlignment): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_UpDownAlign"
		end

	frozen set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_ReadOnly"
		end

	set_auto_scroll (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_AutoScroll"
		end

	frozen set_intercept_arrow_keys (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_InterceptArrowKeys"
		end

	frozen set_auto_scroll_margin_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_AutoScrollMargin"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_ForeColor"
		end

	frozen set_auto_scroll_min_size_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_AutoScrollMinSize"
		end

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_BORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_BorderStyle"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	down_button is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"DownButton"
		end

	frozen select__int32 (start: INTEGER; length: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"Select"
		end

	up_button is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"UpButton"
		end

feature {NONE} -- Implementation

	frozen set_changing_text (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_ChangingText"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.UpDownBase"
		alias
			"get_CreateParams"
		end

	on_mouse_wheel (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnMouseWheel"
		end

	frozen get_user_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UpDownBase"
		alias
			"get_UserEdit"
		end

	on_text_box_resize (source: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnTextBoxResize"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnHandleCreated"
		end

	update_edit_text is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"UpdateEditText"
		end

	on_text_box_lost_focus (source: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnTextBoxLostFocus"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.UpDownBase"
		alias
			"get_DefaultSize"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"SetBoundsCore"
		end

	on_layout (e: SYSTEM_WINDOWS_FORMS_LAYOUTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.LayoutEventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnLayout"
		end

	on_text_box_key_down (source: ANY; e: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnTextBoxKeyDown"
		end

	validate_edit_text is
		external
			"IL signature (): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"ValidateEditText"
		end

	on_changed (source: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnChanged"
		end

	on_text_box_text_changed (source: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnTextBoxTextChanged"
		end

	on_font_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnFontChanged"
		end

	frozen get_changing_text: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UpDownBase"
		alias
			"get_ChangingText"
		end

	on_text_box_key_press (source: ANY; e: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.KeyPressEventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnTextBoxKeyPress"
		end

	frozen set_user_edit (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_UserEdit"
		end

end -- class SYSTEM_WINDOWS_FORMS_UPDOWNBASE
