indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.UpDownBase"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_UP_DOWN_BASE

inherit
	WINFORMS_CONTAINER_CONTROL
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
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW
	WINFORMS_ICONTAINER_CONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end

feature -- Access

	get_auto_scroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UpDownBase"
		alias
			"get_AutoScroll"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.UpDownBase"
		alias
			"get_BackgroundImage"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.UpDownBase"
		alias
			"get_ForeColor"
		end

	frozen get_text_align: WINFORMS_HORIZONTAL_ALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.UpDownBase"
		alias
			"get_TextAlign"
		end

	frozen get_dock_padding_dock_padding_edges: WINFORMS_DOCK_PADDING_EDGES_IN_WINFORMS_SCROLLABLE_CONTROL is
		external
			"IL signature (): System.Windows.Forms.ScrollableControl+DockPaddingEdges use System.Windows.Forms.UpDownBase"
		alias
			"get_DockPadding"
		end

	frozen get_auto_scroll_min_size_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.UpDownBase"
		alias
			"get_AutoScrollMinSize"
		end

	frozen get_up_down_align: WINFORMS_LEFT_RIGHT_ALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.LeftRightAlignment use System.Windows.Forms.UpDownBase"
		alias
			"get_UpDownAlign"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.UpDownBase"
		alias
			"get_Text"
		end

	frozen get_border_style: WINFORMS_BORDER_STYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.UpDownBase"
		alias
			"get_BorderStyle"
		end

	get_context_menu: WINFORMS_CONTEXT_MENU is
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

	get_back_color: DRAWING_COLOR is
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

	frozen get_auto_scroll_margin_size: DRAWING_SIZE is
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

	set_context_menu (value: WINFORMS_CONTEXT_MENU) is
		external
			"IL signature (System.Windows.Forms.ContextMenu): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_ContextMenu"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_Text"
		end

	frozen set_text_align (value: WINFORMS_HORIZONTAL_ALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_TextAlign"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_BackColor"
		end

	frozen set_up_down_align (value: WINFORMS_LEFT_RIGHT_ALIGNMENT) is
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

	frozen set_auto_scroll_margin_size (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_AutoScrollMargin"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_ForeColor"
		end

	frozen set_auto_scroll_min_size_size (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_AutoScrollMinSize"
		end

	frozen set_border_style (value: WINFORMS_BORDER_STYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"set_BorderStyle"
		end

	set_background_image (value: DRAWING_IMAGE) is
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

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.UpDownBase"
		alias
			"get_CreateParams"
		end

	on_mouse_wheel (e: WINFORMS_MOUSE_EVENT_ARGS) is
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

	on_text_box_resize (source: SYSTEM_OBJECT; e: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnTextBoxResize"
		end

	on_handle_created (e: EVENT_ARGS) is
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

	on_text_box_lost_focus (source: SYSTEM_OBJECT; e: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnTextBoxLostFocus"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.UpDownBase"
		alias
			"get_DefaultSize"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"SetBoundsCore"
		end

	on_layout (e: WINFORMS_LAYOUT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.LayoutEventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnLayout"
		end

	on_text_box_key_down (source: SYSTEM_OBJECT; e: WINFORMS_KEY_EVENT_ARGS) is
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

	on_changed (source: SYSTEM_OBJECT; e: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnChanged"
		end

	on_text_box_text_changed (source: SYSTEM_OBJECT; e: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.UpDownBase"
		alias
			"OnTextBoxTextChanged"
		end

	on_font_changed (e: EVENT_ARGS) is
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

	on_text_box_key_press (source: SYSTEM_OBJECT; e: WINFORMS_KEY_PRESS_EVENT_ARGS) is
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

end -- class WINFORMS_UP_DOWN_BASE
