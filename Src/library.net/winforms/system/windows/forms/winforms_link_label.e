indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.LinkLabel"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LINK_LABEL

inherit
	WINFORMS_LABEL
		redefine
			on_text_align_changed,
			wnd_proc,
			set_bounds_core,
			select__boolean,
			process_dialog_key,
			on_paint_background,
			on_paint,
			on_mouse_up,
			on_mouse_move,
			on_mouse_leave,
			on_mouse_down,
			on_lost_focus,
			on_key_down,
			on_got_focus,
			on_text_changed,
			on_font_changed,
			on_enabled_changed,
			create_handle,
			create_accessibility_instance,
			set_text,
			get_text
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW
	WINFORMS_IBUTTON_CONTROL
		rename
			perform_click as system_windows_forms_ibutton_control_perform_click,
			notify_default as system_windows_forms_ibutton_control_notify_default,
			set_dialog_result as system_windows_forms_ibutton_control_set_dialog_result,
			get_dialog_result as system_windows_forms_ibutton_control_get_dialog_result
		end

create
	make_winforms_link_label

feature {NONE} -- Initialization

	frozen make_winforms_link_label is
		external
			"IL creator use System.Windows.Forms.LinkLabel"
		end

feature -- Access

	frozen get_link_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.LinkLabel"
		alias
			"get_LinkColor"
		end

	frozen get_visited_link_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.LinkLabel"
		alias
			"get_VisitedLinkColor"
		end

	frozen get_links: WINFORMS_LINK_COLLECTION_IN_WINFORMS_LINK_LABEL is
		external
			"IL signature (): System.Windows.Forms.LinkLabel+LinkCollection use System.Windows.Forms.LinkLabel"
		alias
			"get_Links"
		end

	frozen get_link_area: WINFORMS_LINK_AREA is
		external
			"IL signature (): System.Windows.Forms.LinkArea use System.Windows.Forms.LinkLabel"
		alias
			"get_LinkArea"
		end

	frozen get_disabled_link_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.LinkLabel"
		alias
			"get_DisabledLinkColor"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LinkLabel"
		alias
			"get_Text"
		end

	frozen get_link_visited: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LinkLabel"
		alias
			"get_LinkVisited"
		end

	frozen get_active_link_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.LinkLabel"
		alias
			"get_ActiveLinkColor"
		end

	frozen get_link_behavior: WINFORMS_LINK_BEHAVIOR is
		external
			"IL signature (): System.Windows.Forms.LinkBehavior use System.Windows.Forms.LinkLabel"
		alias
			"get_LinkBehavior"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_Text"
		end

	frozen set_disabled_link_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_DisabledLinkColor"
		end

	frozen set_link_area (value: WINFORMS_LINK_AREA) is
		external
			"IL signature (System.Windows.Forms.LinkArea): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_LinkArea"
		end

	frozen set_link_visited (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_LinkVisited"
		end

	frozen set_active_link_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_ActiveLinkColor"
		end

	frozen remove_link_clicked (value: WINFORMS_LINK_LABEL_LINK_CLICKED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.LinkLabelLinkClickedEventHandler): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"remove_LinkClicked"
		end

	frozen set_visited_link_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_VisitedLinkColor"
		end

	frozen add_link_clicked (value: WINFORMS_LINK_LABEL_LINK_CLICKED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.LinkLabelLinkClickedEventHandler): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"add_LinkClicked"
		end

	frozen set_link_behavior (value: WINFORMS_LINK_BEHAVIOR) is
		external
			"IL signature (System.Windows.Forms.LinkBehavior): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_LinkBehavior"
		end

	frozen set_link_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_LinkColor"
		end

feature {NONE} -- Implementation

	on_mouse_down (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnMouseDown"
		end

	on_lost_focus (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnLostFocus"
		end

	select__boolean (directed: BOOLEAN; forward: BOOLEAN) is
		external
			"IL signature (System.Boolean, System.Boolean): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"Select"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"CreateHandle"
		end

	on_enabled_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnEnabledChanged"
		end

	on_paint_background (e: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnPaintBackground"
		end

	wnd_proc (msg: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"WndProc"
		end

	on_mouse_up (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnMouseUp"
		end

	on_key_down (e: WINFORMS_KEY_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnKeyDown"
		end

	create_accessibility_instance: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.LinkLabel"
		alias
			"CreateAccessibilityInstance"
		end

	on_paint (e: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnPaint"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"SetBoundsCore"
		end

	on_text_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnTextChanged"
		end

	frozen system_windows_forms_ibutton_control_notify_default (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"System.Windows.Forms.IButtonControl.NotifyDefault"
		end

	frozen point_in_link (x: INTEGER; y: INTEGER): WINFORMS_LINK_IN_WINFORMS_LINK_LABEL is
		external
			"IL signature (System.Int32, System.Int32): System.Windows.Forms.LinkLabel+Link use System.Windows.Forms.LinkLabel"
		alias
			"PointInLink"
		end

	frozen system_windows_forms_ibutton_control_perform_click is
		external
			"IL signature (): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"System.Windows.Forms.IButtonControl.PerformClick"
		end

	frozen set_override_cursor (value: WINFORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"set_OverrideCursor"
		end

	on_mouse_move (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnMouseMove"
		end

	on_text_align_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnTextAlignChanged"
		end

	frozen get_override_cursor: WINFORMS_CURSOR is
		external
			"IL signature (): System.Windows.Forms.Cursor use System.Windows.Forms.LinkLabel"
		alias
			"get_OverrideCursor"
		end

	on_got_focus (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnGotFocus"
		end

	process_dialog_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.LinkLabel"
		alias
			"ProcessDialogKey"
		end

	frozen system_windows_forms_ibutton_control_get_dialog_result: WINFORMS_DIALOG_RESULT is
		external
			"IL signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.LinkLabel"
		alias
			"System.Windows.Forms.IButtonControl.get_DialogResult"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnFontChanged"
		end

	on_mouse_leave (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnMouseLeave"
		end

	on_link_clicked (e: WINFORMS_LINK_LABEL_LINK_CLICKED_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.LinkLabelLinkClickedEventArgs): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"OnLinkClicked"
		end

	frozen system_windows_forms_ibutton_control_set_dialog_result (value: WINFORMS_DIALOG_RESULT) is
		external
			"IL signature (System.Windows.Forms.DialogResult): System.Void use System.Windows.Forms.LinkLabel"
		alias
			"System.Windows.Forms.IButtonControl.set_DialogResult"
		end

end -- class WINFORMS_LINK_LABEL
