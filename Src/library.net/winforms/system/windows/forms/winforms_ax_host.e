indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AxHost"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_AX_HOST

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			set_visible_core,
			set_bounds_core,
			process_mnemonic,
			pre_process_message,
			on_lost_focus,
			on_handle_created,
			on_fore_color_changed,
			on_font_changed,
			on_back_color_changed,
			is_input_char,
			destroy_handle,
			create_handle,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			set_font,
			get_font,
			get_default_size,
			set_cursor,
			get_cursor,
			get_create_params,
			set_context_menu,
			get_context_menu,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			set_site,
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW
	SYSTEM_DLL_ISUPPORT_INITIALIZE
	SYSTEM_DLL_ICUSTOM_TYPE_DESCRIPTOR
		rename
			get_property_owner as system_component_model_icustom_type_descriptor_get_property_owner,
			get_properties as system_component_model_icustom_type_descriptor_get_properties,
			get_events as system_component_model_icustom_type_descriptor_get_events,
			get_editor as system_component_model_icustom_type_descriptor_get_editor,
			get_default_property as system_component_model_icustom_type_descriptor_get_default_property,
			get_default_event as system_component_model_icustom_type_descriptor_get_default_event,
			get_converter as system_component_model_icustom_type_descriptor_get_converter,
			get_component_name as system_component_model_icustom_type_descriptor_get_component_name,
			get_class_name as system_component_model_icustom_type_descriptor_get_class_name,
			get_attributes as system_component_model_icustom_type_descriptor_get_attributes
		end

feature -- Access

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.AxHost"
		alias
			"get_BackgroundImage"
		end

	get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.AxHost"
		alias
			"get_Font"
		end

	get_enabled_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"get_Enabled"
		end

	get_right_to_left_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"get_RightToLeft"
		end

	frozen get_edit_mode: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"get_EditMode"
		end

	frozen get_ocx_state: WINFORMS_STATE_IN_WINFORMS_AX_HOST is
		external
			"IL signature (): System.Windows.Forms.AxHost+State use System.Windows.Forms.AxHost"
		alias
			"get_OcxState"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AxHost"
		alias
			"get_Text"
		end

	get_context_menu: WINFORMS_CONTEXT_MENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.AxHost"
		alias
			"get_ContextMenu"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.AxHost"
		alias
			"get_ForeColor"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.AxHost"
		alias
			"get_BackColor"
		end

	frozen get_containing_control: WINFORMS_CONTAINER_CONTROL is
		external
			"IL signature (): System.Windows.Forms.ContainerControl use System.Windows.Forms.AxHost"
		alias
			"get_ContainingControl"
		end

	get_cursor: WINFORMS_CURSOR is
		external
			"IL signature (): System.Windows.Forms.Cursor use System.Windows.Forms.AxHost"
		alias
			"get_Cursor"
		end

	frozen get_has_about_box: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"get_HasAboutBox"
		end

feature -- Element Change

	frozen remove_drag_over_drag_event_handler (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_DragOver"
		end

	frozen add_help_requested_help_event_handler (value: WINFORMS_HELP_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.HelpEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_HelpRequested"
		end

	frozen add_binding_context_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_BindingContextChanged"
		end

	frozen set_ocx_state (value: WINFORMS_STATE_IN_WINFORMS_AX_HOST) is
		external
			"IL signature (System.Windows.Forms.AxHost+State): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_OcxState"
		end

	frozen remove_background_image_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_BackgroundImageChanged"
		end

	frozen remove_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_KeyDown"
		end

	frozen remove_query_continue_drag_query_continue_drag_event_handler (value: WINFORMS_QUERY_CONTINUE_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_QueryContinueDrag"
		end

	frozen add_back_color_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_BackColorChanged"
		end

	frozen add_fore_color_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_ForeColorChanged"
		end

	frozen add_query_accessibility_help_query_accessibility_help_event_handler (value: WINFORMS_QUERY_ACCESSIBILITY_HELP_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryAccessibilityHelpEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_QueryAccessibilityHelp"
		end

	frozen add_give_feedback_give_feedback_event_handler (value: WINFORMS_GIVE_FEEDBACK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_GiveFeedback"
		end

	frozen add_drag_over_drag_event_handler (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_DragOver"
		end

	frozen add_font_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_FontChanged"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_BackgroundImage"
		end

	frozen remove_mouse_enter_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_MouseEnter"
		end

	frozen add_mouse_down_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_MouseDown"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_Site"
		end

	frozen remove_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_Click"
		end

	frozen set_containing_control (value: WINFORMS_CONTAINER_CONTROL) is
		external
			"IL signature (System.Windows.Forms.ContainerControl): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_ContainingControl"
		end

	frozen remove_binding_context_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_BindingContextChanged"
		end

	frozen add_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_KeyUp"
		end

	frozen remove_cursor_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_CursorChanged"
		end

	frozen remove_layout_layout_event_handler (value: WINFORMS_LAYOUT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.LayoutEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_Layout"
		end

	frozen remove_style_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_StyleChanged"
		end

	frozen add_ime_mode_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_ImeModeChanged"
		end

	frozen remove_back_color_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_BackColorChanged"
		end

	frozen add_right_to_left_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_RightToLeftChanged"
		end

	frozen remove_font_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_FontChanged"
		end

	frozen remove_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_Paint"
		end

	frozen remove_context_menu_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_ContextMenuChanged"
		end

	frozen add_mouse_enter_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_MouseEnter"
		end

	frozen add_mouse_wheel_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_MouseWheel"
		end

	set_context_menu (value: WINFORMS_CONTEXT_MENU) is
		external
			"IL signature (System.Windows.Forms.ContextMenu): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_ContextMenu"
		end

	frozen remove_key_up_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_KeyUp"
		end

	set_right_to_left_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_RightToLeft"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_ForeColor"
		end

	frozen remove_mouse_leave_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_MouseLeave"
		end

	frozen remove_tab_stop_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_TabStopChanged"
		end

	frozen remove_change_uicues_uicues_event_handler (value: WINFORMS_UICUES_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.UICuesEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_ChangeUICues"
		end

	frozen remove_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_KeyPress"
		end

	frozen add_drag_drop_drag_event_handler (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_DragDrop"
		end

	frozen add_mouse_hover_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_MouseHover"
		end

	frozen add_context_menu_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_ContextMenuChanged"
		end

	set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_Font"
		end

	frozen remove_drag_drop_drag_event_handler (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_DragDrop"
		end

	frozen remove_right_to_left_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_RightToLeftChanged"
		end

	frozen add_layout_layout_event_handler (value: WINFORMS_LAYOUT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.LayoutEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_Layout"
		end

	frozen remove_drag_leave_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_DragLeave"
		end

	frozen remove_query_accessibility_help_query_accessibility_help_event_handler (value: WINFORMS_QUERY_ACCESSIBILITY_HELP_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryAccessibilityHelpEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_QueryAccessibilityHelp"
		end

	frozen add_key_down_key_event_handler (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_KeyDown"
		end

	frozen remove_mouse_hover_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_MouseHover"
		end

	frozen remove_mouse_up_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_MouseUp"
		end

	frozen add_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_DoubleClick"
		end

	frozen add_style_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_StyleChanged"
		end

	frozen add_background_image_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_BackgroundImageChanged"
		end

	frozen remove_tab_index_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_TabIndexChanged"
		end

	frozen remove_mouse_down_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_MouseDown"
		end

	frozen add_mouse_leave_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_MouseLeave"
		end

	frozen add_change_uicues_uicues_event_handler (value: WINFORMS_UICUES_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.UICuesEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_ChangeUICues"
		end

	frozen add_tab_index_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_TabIndexChanged"
		end

	frozen remove_fore_color_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_ForeColorChanged"
		end

	frozen remove_double_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_DoubleClick"
		end

	frozen remove_enabled_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_EnabledChanged"
		end

	frozen remove_give_feedback_give_feedback_event_handler (value: WINFORMS_GIVE_FEEDBACK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_GiveFeedback"
		end

	frozen add_query_continue_drag_query_continue_drag_event_handler (value: WINFORMS_QUERY_CONTINUE_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_QueryContinueDrag"
		end

	frozen remove_text_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_TextChanged"
		end

	frozen remove_mouse_move_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_MouseMove"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_Text"
		end

	frozen add_cursor_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_CursorChanged"
		end

	frozen add_mouse_up_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_MouseUp"
		end

	frozen remove_ime_mode_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_ImeModeChanged"
		end

	set_cursor (value: WINFORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_Cursor"
		end

	frozen remove_drag_enter_drag_event_handler (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_DragEnter"
		end

	frozen add_mouse_move_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_MouseMove"
		end

	frozen add_drag_enter_drag_event_handler (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_DragEnter"
		end

	frozen add_tab_stop_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_TabStopChanged"
		end

	set_enabled_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_Enabled"
		end

	frozen remove_mouse_wheel_mouse_event_handler (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_MouseWheel"
		end

	frozen add_enabled_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_EnabledChanged"
		end

	frozen add_text_changed_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_TextChanged"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.AxHost"
		alias
			"set_BackColor"
		end

	frozen add_key_press_key_press_event_handler (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_KeyPress"
		end

	frozen add_paint_paint_event_handler (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_Paint"
		end

	frozen add_drag_leave_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_DragLeave"
		end

	frozen remove_help_requested_help_event_handler (value: WINFORMS_HELP_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.HelpEventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"remove_HelpRequested"
		end

	frozen add_click_event_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.AxHost"
		alias
			"add_Click"
		end

feature -- Basic Operations

	pre_process_message (msg: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"PreProcessMessage"
		end

	frozen do_verb (verb: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.AxHost"
		alias
			"DoVerb"
		end

	frozen get_ocx: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.AxHost"
		alias
			"GetOcx"
		end

	frozen end_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"EndInit"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"BeginInit"
		end

	frozen make_dirty is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"MakeDirty"
		end

	frozen invoke_edit_mode is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"InvokeEditMode"
		end

	frozen show_about_box is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"ShowAboutBox"
		end

	frozen show_property_pages_control (control: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.AxHost"
		alias
			"ShowPropertyPages"
		end

	frozen has_property_pages: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"HasPropertyPages"
		end

	frozen show_property_pages is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"ShowPropertyPages"
		end

feature {NONE} -- Implementation

	frozen get_picture_from_ipicture (picture: SYSTEM_OBJECT): DRAWING_IMAGE is
		external
			"IL static signature (System.Object): System.Drawing.Image use System.Windows.Forms.AxHost"
		alias
			"GetPictureFromIPicture"
		end

	frozen raise_on_mouse_up (button: INTEGER_16; shift: INTEGER_16; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int16, System.Int16, System.Int32, System.Int32): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseUp"
		end

	frozen raise_on_mouse_move (button: INTEGER_16; shift: INTEGER_16; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int16, System.Int16, System.Int32, System.Int32): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseMove"
		end

	create_sink is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"CreateSink"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"CreateHandle"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"ProcessMnemonic"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.AxHost"
		alias
			"OnHandleCreated"
		end

	frozen raise_on_mouse_move_int16_int16_single (button: INTEGER_16; shift: INTEGER_16; x: REAL; y: REAL) is
		external
			"IL signature (System.Int16, System.Int16, System.Single, System.Single): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseMove"
		end

	on_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.AxHost"
		alias
			"OnBackColorChanged"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.AxHost"
		alias
			"OnFontChanged"
		end

	frozen get_picture_from_ipicture_disp (picture: SYSTEM_OBJECT): DRAWING_IMAGE is
		external
			"IL static signature (System.Object): System.Drawing.Image use System.Windows.Forms.AxHost"
		alias
			"GetPictureFromIPictureDisp"
		end

	frozen get_events_array_attribute (attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Attribute[]): System.ComponentModel.EventDescriptorCollection use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEvents"
		end

	frozen system_component_model_icustom_type_descriptor_get_component_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetComponentName"
		end

	on_in_place_active is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"OnInPlaceActive"
		end

	frozen props_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"PropsValid"
		end

	frozen get_properties_array_attribute (attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetProperties"
		end

	frozen get_time_from_oadate (date: DOUBLE): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.Double): System.DateTime use System.Windows.Forms.AxHost"
		alias
			"GetTimeFromOADate"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.AxHost"
		alias
			"get_DefaultSize"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.AxHost"
		alias
			"Dispose"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.AxHost"
		alias
			"WndProc"
		end

	attach_interfaces is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"AttachInterfaces"
		end

	set_visible_core (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.AxHost"
		alias
			"SetVisibleCore"
		end

	destroy_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"DestroyHandle"
		end

	frozen get_font_from_ifont_disp (font: SYSTEM_OBJECT): DRAWING_FONT is
		external
			"IL static signature (System.Object): System.Drawing.Font use System.Windows.Forms.AxHost"
		alias
			"GetFontFromIFontDisp"
		end

	frozen get_ipicture_from_cursor (cursor: WINFORMS_CURSOR): SYSTEM_OBJECT is
		external
			"IL static signature (System.Windows.Forms.Cursor): System.Object use System.Windows.Forms.AxHost"
		alias
			"GetIPictureFromCursor"
		end

	frozen get_oadate_from_time (time: SYSTEM_DATE_TIME): DOUBLE is
		external
			"IL static signature (System.DateTime): System.Double use System.Windows.Forms.AxHost"
		alias
			"GetOADateFromTime"
		end

	on_fore_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.AxHost"
		alias
			"OnForeColorChanged"
		end

	frozen get_ipicture_from_picture (image: DRAWING_IMAGE): SYSTEM_OBJECT is
		external
			"IL static signature (System.Drawing.Image): System.Object use System.Windows.Forms.AxHost"
		alias
			"GetIPictureFromPicture"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.AxHost"
		alias
			"get_CreateParams"
		end

	frozen system_component_model_icustom_type_descriptor_get_converter: SYSTEM_DLL_TYPE_CONVERTER is
		external
			"IL signature (): System.ComponentModel.TypeConverter use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetConverter"
		end

	on_lost_focus (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.AxHost"
		alias
			"OnLostFocus"
		end

	frozen set_about_box_delegate (d: WINFORMS_ABOUT_BOX_DELEGATE_IN_WINFORMS_AX_HOST) is
		external
			"IL signature (System.Windows.Forms.AxHost+AboutBoxDelegate): System.Void use System.Windows.Forms.AxHost"
		alias
			"SetAboutBoxDelegate"
		end

	frozen raise_on_mouse_move_object (o1: SYSTEM_OBJECT; o2: SYSTEM_OBJECT; o3: SYSTEM_OBJECT; o4: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object, System.Object, System.Object): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseMove"
		end

	frozen system_component_model_icustom_type_descriptor_get_attributes: SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.ComponentModel.AttributeCollection use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetAttributes"
		end

	frozen system_component_model_icustom_type_descriptor_get_property_owner (pd: SYSTEM_DLL_PROPERTY_DESCRIPTOR): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor): System.Object use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetPropertyOwner"
		end

	frozen raise_on_mouse_up_int16_int16_single (button: INTEGER_16; shift: INTEGER_16; x: REAL; y: REAL) is
		external
			"IL signature (System.Int16, System.Int16, System.Single, System.Single): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseUp"
		end

	detach_sink is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost"
		alias
			"DetachSink"
		end

	frozen get_ifont_from_font (font: DRAWING_FONT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Drawing.Font): System.Object use System.Windows.Forms.AxHost"
		alias
			"GetIFontFromFont"
		end

	frozen raise_on_mouse_up_object (o1: SYSTEM_OBJECT; o2: SYSTEM_OBJECT; o3: SYSTEM_OBJECT; o4: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object, System.Object, System.Object): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseUp"
		end

	frozen get_ipicture_disp_from_picture (image: DRAWING_IMAGE): SYSTEM_OBJECT is
		external
			"IL static signature (System.Drawing.Image): System.Object use System.Windows.Forms.AxHost"
		alias
			"GetIPictureDispFromPicture"
		end

	frozen get_ifont_disp_from_font (font: DRAWING_FONT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Drawing.Font): System.Object use System.Windows.Forms.AxHost"
		alias
			"GetIFontDispFromFont"
		end

	frozen system_component_model_icustom_type_descriptor_get_class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetClassName"
		end

	is_input_char (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.AxHost"
		alias
			"IsInputChar"
		end

	frozen system_component_model_icustom_type_descriptor_get_editor (editor_base_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEditor"
		end

	frozen raise_on_mouse_down (button: INTEGER_16; shift: INTEGER_16; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int16, System.Int16, System.Int32, System.Int32): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseDown"
		end

	frozen system_component_model_icustom_type_descriptor_get_default_event: SYSTEM_DLL_EVENT_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.EventDescriptor use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetDefaultEvent"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.AxHost"
		alias
			"SetBoundsCore"
		end

	frozen system_component_model_icustom_type_descriptor_get_default_property: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetDefaultProperty"
		end

	frozen raise_on_mouse_down_int16_int16_single (button: INTEGER_16; shift: INTEGER_16; x: REAL; y: REAL) is
		external
			"IL signature (System.Int16, System.Int16, System.Single, System.Single): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseDown"
		end

	frozen get_font_from_ifont (font: SYSTEM_OBJECT): DRAWING_FONT is
		external
			"IL static signature (System.Object): System.Drawing.Font use System.Windows.Forms.AxHost"
		alias
			"GetFontFromIFont"
		end

	frozen raise_on_mouse_down_object (o1: SYSTEM_OBJECT; o2: SYSTEM_OBJECT; o3: SYSTEM_OBJECT; o4: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object, System.Object, System.Object): System.Void use System.Windows.Forms.AxHost"
		alias
			"RaiseOnMouseDown"
		end

	frozen system_component_model_icustom_type_descriptor_get_properties: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetProperties"
		end

	frozen system_component_model_icustom_type_descriptor_get_events: SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION is
		external
			"IL signature (): System.ComponentModel.EventDescriptorCollection use System.Windows.Forms.AxHost"
		alias
			"System.ComponentModel.ICustomTypeDescriptor.GetEvents"
		end

end -- class WINFORMS_AX_HOST
