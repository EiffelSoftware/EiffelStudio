indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Control"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONTROL

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			set_site,
			get_site,
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

create
	make_winforms_control_4,
	make_winforms_control,
	make_winforms_control_1,
	make_winforms_control_3,
	make_winforms_control_2

feature {NONE} -- Initialization

	frozen make_winforms_control_4 (parent: WINFORMS_CONTROL; text: SYSTEM_STRING; left: INTEGER; top: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.Control, System.String, System.Int32, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.Control"
		end

	frozen make_winforms_control is
		external
			"IL creator use System.Windows.Forms.Control"
		end

	frozen make_winforms_control_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.Control"
		end

	frozen make_winforms_control_3 (parent: WINFORMS_CONTROL; text: SYSTEM_STRING) is
		external
			"IL creator signature (System.Windows.Forms.Control, System.String) use System.Windows.Forms.Control"
		end

	frozen make_winforms_control_2 (text: SYSTEM_STRING; left: INTEGER; top: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.Control"
		end

feature -- Access

	frozen get_disposing: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_Disposing"
		end

	frozen get_client_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Control"
		alias
			"get_ClientSize"
		end

	frozen get_company_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_CompanyName"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_Name"
		end

	frozen get_top_level_control: WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"get_TopLevelControl"
		end

	frozen get_can_select: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_CanSelect"
		end

	frozen get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_Visible"
		end

	frozen get_recreating_handle: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_RecreatingHandle"
		end

	frozen get_accessible_role: WINFORMS_ACCESSIBLE_ROLE is
		external
			"IL signature (): System.Windows.Forms.AccessibleRole use System.Windows.Forms.Control"
		alias
			"get_AccessibleRole"
		end

	frozen get_invoke_required: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_InvokeRequired"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.Control"
		alias
			"get_BackColor"
		end

	frozen get_default_font: DRAWING_FONT is
		external
			"IL static signature (): System.Drawing.Font use System.Windows.Forms.Control"
		alias
			"get_DefaultFont"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.Control"
		alias
			"get_BackgroundImage"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.Control"
		alias
			"get_ForeColor"
		end

	get_right_to_left: WINFORMS_RIGHT_TO_LEFT is
		external
			"IL signature (): System.Windows.Forms.RightToLeft use System.Windows.Forms.Control"
		alias
			"get_RightToLeft"
		end

	frozen get_bottom: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control"
		alias
			"get_Bottom"
		end

	get_context_menu: WINFORMS_CONTEXT_MENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.Control"
		alias
			"get_ContextMenu"
		end

	get_site: SYSTEM_DLL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Windows.Forms.Control"
		alias
			"get_Site"
		end

	frozen get_contains_focus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_ContainsFocus"
		end

	frozen get_right: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control"
		alias
			"get_Right"
		end

	get_display_rectangle: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Control"
		alias
			"get_DisplayRectangle"
		end

	frozen get_capture: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_Capture"
		end

	frozen get_mouse_buttons: WINFORMS_MOUSE_BUTTONS is
		external
			"IL static signature (): System.Windows.Forms.MouseButtons use System.Windows.Forms.Control"
		alias
			"get_MouseButtons"
		end

	frozen get_left: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control"
		alias
			"get_Left"
		end

	frozen get_region: DRAWING_REGION is
		external
			"IL signature (): System.Drawing.Region use System.Windows.Forms.Control"
		alias
			"get_Region"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_Text"
		end

	frozen get_accessible_default_action_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_AccessibleDefaultActionDescription"
		end

	frozen get_default_fore_color: DRAWING_COLOR is
		external
			"IL static signature (): System.Drawing.Color use System.Windows.Forms.Control"
		alias
			"get_DefaultForeColor"
		end

	frozen get_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Control"
		alias
			"get_Size"
		end

	frozen get_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Control"
		alias
			"get_ImeMode"
		end

	frozen get_tag: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.Control"
		alias
			"get_Tag"
		end

	frozen get_window_target: WINFORMS_IWINDOW_TARGET is
		external
			"IL signature (): System.Windows.Forms.IWindowTarget use System.Windows.Forms.Control"
		alias
			"get_WindowTarget"
		end

	frozen get_modifier_keys: WINFORMS_KEYS is
		external
			"IL static signature (): System.Windows.Forms.Keys use System.Windows.Forms.Control"
		alias
			"get_ModifierKeys"
		end

	get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.Control"
		alias
			"get_Font"
		end

	frozen get_is_handle_created: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_IsHandleCreated"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Control"
		alias
			"get_Handle"
		end

	get_anchor: WINFORMS_ANCHOR_STYLES is
		external
			"IL signature (): System.Windows.Forms.AnchorStyles use System.Windows.Forms.Control"
		alias
			"get_Anchor"
		end

	frozen get_is_disposed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_IsDisposed"
		end

	frozen get_controls: WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.Control"
		alias
			"get_Controls"
		end

	frozen get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Control"
		alias
			"get_Bounds"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control"
		alias
			"get_Width"
		end

	frozen get_product_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_ProductName"
		end

	frozen get_parent: WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"get_Parent"
		end

	frozen get_accessible_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_AccessibleName"
		end

	frozen get_created: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_Created"
		end

	frozen get_accessibility_object: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.Control"
		alias
			"get_AccessibilityObject"
		end

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control"
		alias
			"get_Height"
		end

	frozen get_tab_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control"
		alias
			"get_TabIndex"
		end

	frozen get_data_bindings: WINFORMS_CONTROL_BINDINGS_COLLECTION is
		external
			"IL signature (): System.Windows.Forms.ControlBindingsCollection use System.Windows.Forms.Control"
		alias
			"get_DataBindings"
		end

	frozen get_product_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_ProductVersion"
		end

	get_cursor: WINFORMS_CURSOR is
		external
			"IL signature (): System.Windows.Forms.Cursor use System.Windows.Forms.Control"
		alias
			"get_Cursor"
		end

	frozen get_top: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control"
		alias
			"get_Top"
		end

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_Enabled"
		end

	frozen get_can_focus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_CanFocus"
		end

	get_binding_context: WINFORMS_BINDING_CONTEXT is
		external
			"IL signature (): System.Windows.Forms.BindingContext use System.Windows.Forms.Control"
		alias
			"get_BindingContext"
		end

	frozen get_mouse_position: DRAWING_POINT is
		external
			"IL static signature (): System.Drawing.Point use System.Windows.Forms.Control"
		alias
			"get_MousePosition"
		end

	get_allow_drop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_AllowDrop"
		end

	get_dock: WINFORMS_DOCK_STYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.Control"
		alias
			"get_Dock"
		end

	frozen get_client_rectangle: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.Control"
		alias
			"get_ClientRectangle"
		end

	frozen get_is_accessible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_IsAccessible"
		end

	frozen get_has_children: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_HasChildren"
		end

	frozen get_tab_stop: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_TabStop"
		end

	frozen get_accessible_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_AccessibleDescription"
		end

	frozen get_causes_validation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_CausesValidation"
		end

	get_focused: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_Focused"
		end

	frozen get_default_back_color: DRAWING_COLOR is
		external
			"IL static signature (): System.Drawing.Color use System.Windows.Forms.Control"
		alias
			"get_DefaultBackColor"
		end

	frozen get_location: DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.Control"
		alias
			"get_Location"
		end

feature -- Element Change

	frozen add_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Click"
		end

	frozen add_enter (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Enter"
		end

	frozen remove_tab_index_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_TabIndexChanged"
		end

	frozen remove_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Click"
		end

	frozen remove_layout (value: WINFORMS_LAYOUT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.LayoutEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Layout"
		end

	frozen remove_size_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_SizeChanged"
		end

	frozen add_drag_over (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DragOver"
		end

	frozen remove_binding_context_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_BindingContextChanged"
		end

	frozen remove_right_to_left_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_RightToLeftChanged"
		end

	frozen add_size_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_SizeChanged"
		end

	frozen remove_key_down (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_KeyDown"
		end

	frozen add_fore_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ForeColorChanged"
		end

	frozen remove_drag_over (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DragOver"
		end

	frozen set_parent (value: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Control"
		alias
			"set_Parent"
		end

	frozen remove_resize (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Resize"
		end

	frozen add_paint (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Paint"
		end

	frozen add_mouse_move (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseMove"
		end

	frozen remove_paint (value: WINFORMS_PAINT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Paint"
		end

	frozen remove_enter (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Enter"
		end

	frozen add_key_up (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_KeyUp"
		end

	frozen add_validated (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Validated"
		end

	frozen add_invalidated (value: WINFORMS_INVALIDATE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.InvalidateEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Invalidated"
		end

	frozen add_query_continue_drag (value: WINFORMS_QUERY_CONTINUE_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_QueryContinueDrag"
		end

	frozen add_mouse_leave (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseLeave"
		end

	frozen add_location_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_LocationChanged"
		end

	frozen set_accessible_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_AccessibleName"
		end

	frozen remove_mouse_wheel (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseWheel"
		end

	frozen add_style_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_StyleChanged"
		end

	frozen add_dock_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DockChanged"
		end

	frozen remove_drag_leave (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DragLeave"
		end

	frozen set_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"set_Height"
		end

	frozen remove_double_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DoubleClick"
		end

	frozen add_context_menu_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ContextMenuChanged"
		end

	frozen add_got_focus (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_GotFocus"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"set_Enabled"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Windows.Forms.Control"
		alias
			"set_Site"
		end

	frozen add_parent_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ParentChanged"
		end

	frozen remove_fore_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ForeColorChanged"
		end

	frozen add_enabled_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_EnabledChanged"
		end

	frozen remove_ime_mode_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ImeModeChanged"
		end

	frozen remove_query_continue_drag (value: WINFORMS_QUERY_CONTINUE_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_QueryContinueDrag"
		end

	frozen add_help_requested (value: WINFORMS_HELP_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.HelpEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_HelpRequested"
		end

	frozen remove_visible_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_VisibleChanged"
		end

	frozen remove_mouse_move (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseMove"
		end

	frozen add_right_to_left_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_RightToLeftChanged"
		end

	frozen remove_lost_focus (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_LostFocus"
		end

	set_allow_drop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"set_AllowDrop"
		end

	set_dock (value: WINFORMS_DOCK_STYLE) is
		external
			"IL signature (System.Windows.Forms.DockStyle): System.Void use System.Windows.Forms.Control"
		alias
			"set_Dock"
		end

	frozen add_drag_leave (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DragLeave"
		end

	frozen remove_validated (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Validated"
		end

	frozen add_leave (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Leave"
		end

	frozen remove_mouse_enter (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseEnter"
		end

	frozen remove_font_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_FontChanged"
		end

	frozen add_give_feedback (value: WINFORMS_GIVE_FEEDBACK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_GiveFeedback"
		end

	frozen add_double_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DoubleClick"
		end

	frozen add_validating (value: SYSTEM_DLL_CANCEL_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CancelEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Validating"
		end

	frozen set_capture (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"set_Capture"
		end

	frozen set_window_target (value: WINFORMS_IWINDOW_TARGET) is
		external
			"IL signature (System.Windows.Forms.IWindowTarget): System.Void use System.Windows.Forms.Control"
		alias
			"set_WindowTarget"
		end

	set_context_menu (value: WINFORMS_CONTEXT_MENU) is
		external
			"IL signature (System.Windows.Forms.ContextMenu): System.Void use System.Windows.Forms.Control"
		alias
			"set_ContextMenu"
		end

	frozen remove_mouse_leave (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseLeave"
		end

	frozen add_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_BackColorChanged"
		end

	frozen add_mouse_enter (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseEnter"
		end

	frozen set_region (value: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Windows.Forms.Control"
		alias
			"set_Region"
		end

	frozen remove_tab_stop_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_TabStopChanged"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.Control"
		alias
			"set_ForeColor"
		end

	frozen remove_handle_created (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_HandleCreated"
		end

	frozen set_size (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Control"
		alias
			"set_Size"
		end

	frozen set_accessible_description (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_AccessibleDescription"
		end

	frozen add_cursor_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_CursorChanged"
		end

	frozen remove_drag_enter (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DragEnter"
		end

	frozen add_background_image_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_BackgroundImageChanged"
		end

	frozen remove_background_image_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_BackgroundImageChanged"
		end

	frozen set_tab_stop (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"set_TabStop"
		end

	frozen add_font_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_FontChanged"
		end

	frozen remove_control_removed (value: WINFORMS_CONTROL_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ControlEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ControlRemoved"
		end

	frozen add_control_removed (value: WINFORMS_CONTROL_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ControlEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ControlRemoved"
		end

	frozen remove_leave (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Leave"
		end

	frozen set_location (value: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Windows.Forms.Control"
		alias
			"set_Location"
		end

	frozen add_visible_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_VisibleChanged"
		end

	frozen remove_drag_drop (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DragDrop"
		end

	frozen add_binding_context_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_BindingContextChanged"
		end

	set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.Control"
		alias
			"set_Font"
		end

	frozen remove_key_press (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_KeyPress"
		end

	frozen remove_change_uicues (value: WINFORMS_UICUES_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.UICuesEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ChangeUICues"
		end

	set_binding_context (value: WINFORMS_BINDING_CONTEXT) is
		external
			"IL signature (System.Windows.Forms.BindingContext): System.Void use System.Windows.Forms.Control"
		alias
			"set_BindingContext"
		end

	frozen remove_move (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Move"
		end

	frozen remove_invalidated (value: WINFORMS_INVALIDATE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.InvalidateEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Invalidated"
		end

	frozen set_is_accessible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"set_IsAccessible"
		end

	frozen add_key_press (value: WINFORMS_KEY_PRESS_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_KeyPress"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_Name"
		end

	frozen add_system_colors_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_SystemColorsChanged"
		end

	frozen add_mouse_hover (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseHover"
		end

	frozen add_mouse_up (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseUp"
		end

	frozen remove_mouse_hover (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseHover"
		end

	frozen add_handle_created (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_HandleCreated"
		end

	frozen set_accessible_default_action_description (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_AccessibleDefaultActionDescription"
		end

	frozen remove_enabled_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_EnabledChanged"
		end

	frozen remove_causes_validation_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_CausesValidationChanged"
		end

	frozen remove_control_added (value: WINFORMS_CONTROL_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ControlEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ControlAdded"
		end

	frozen remove_parent_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ParentChanged"
		end

	frozen set_ime_mode (value: WINFORMS_IME_MODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.Control"
		alias
			"set_ImeMode"
		end

	frozen add_drag_enter (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DragEnter"
		end

	frozen set_left (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"set_Left"
		end

	frozen set_causes_validation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"set_CausesValidation"
		end

	frozen add_handle_destroyed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_HandleDestroyed"
		end

	frozen remove_system_colors_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_SystemColorsChanged"
		end

	frozen remove_context_menu_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ContextMenuChanged"
		end

	frozen add_layout (value: WINFORMS_LAYOUT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.LayoutEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Layout"
		end

	frozen remove_text_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_TextChanged"
		end

	frozen set_accessible_role (value: WINFORMS_ACCESSIBLE_ROLE) is
		external
			"IL signature (System.Windows.Forms.AccessibleRole): System.Void use System.Windows.Forms.Control"
		alias
			"set_AccessibleRole"
		end

	frozen remove_got_focus (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_GotFocus"
		end

	frozen remove_location_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_LocationChanged"
		end

	frozen set_top (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"set_Top"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_Text"
		end

	frozen set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"set_Visible"
		end

	frozen set_tab_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"set_TabIndex"
		end

	frozen set_width (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"set_Width"
		end

	frozen remove_style_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_StyleChanged"
		end

	set_cursor (value: WINFORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.Control"
		alias
			"set_Cursor"
		end

	frozen remove_give_feedback (value: WINFORMS_GIVE_FEEDBACK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_GiveFeedback"
		end

	frozen add_ime_mode_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ImeModeChanged"
		end

	frozen add_key_down (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_KeyDown"
		end

	frozen add_causes_validation_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_CausesValidationChanged"
		end

	frozen add_change_uicues (value: WINFORMS_UICUES_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.UICuesEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ChangeUICues"
		end

	frozen add_mouse_wheel (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseWheel"
		end

	frozen add_lost_focus (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_LostFocus"
		end

	frozen add_query_accessibility_help (value: WINFORMS_QUERY_ACCESSIBILITY_HELP_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryAccessibilityHelpEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_QueryAccessibilityHelp"
		end

	frozen set_client_size (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Control"
		alias
			"set_ClientSize"
		end

	set_right_to_left (value: WINFORMS_RIGHT_TO_LEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.Control"
		alias
			"set_RightToLeft"
		end

	frozen remove_dock_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DockChanged"
		end

	frozen remove_validating (value: SYSTEM_DLL_CANCEL_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CancelEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Validating"
		end

	frozen add_resize (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Resize"
		end

	frozen add_move (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Move"
		end

	frozen remove_query_accessibility_help (value: WINFORMS_QUERY_ACCESSIBILITY_HELP_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryAccessibilityHelpEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_QueryAccessibilityHelp"
		end

	frozen remove_key_up (value: WINFORMS_KEY_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_KeyUp"
		end

	frozen add_text_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_TextChanged"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.Control"
		alias
			"set_BackgroundImage"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.Control"
		alias
			"set_BackColor"
		end

	frozen add_drag_drop (value: WINFORMS_DRAG_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DragDrop"
		end

	frozen add_control_added (value: WINFORMS_CONTROL_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ControlEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ControlAdded"
		end

	frozen remove_mouse_down (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseDown"
		end

	frozen add_mouse_down (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseDown"
		end

	frozen remove_mouse_up (value: WINFORMS_MOUSE_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseUp"
		end

	frozen add_tab_index_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_TabIndexChanged"
		end

	frozen remove_cursor_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_CursorChanged"
		end

	set_anchor (value: WINFORMS_ANCHOR_STYLES) is
		external
			"IL signature (System.Windows.Forms.AnchorStyles): System.Void use System.Windows.Forms.Control"
		alias
			"set_Anchor"
		end

	frozen set_bounds (value: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Control"
		alias
			"set_Bounds"
		end

	frozen remove_handle_destroyed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_HandleDestroyed"
		end

	frozen remove_help_requested (value: WINFORMS_HELP_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.HelpEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_HelpRequested"
		end

	frozen add_tab_stop_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_TabStopChanged"
		end

	frozen remove_back_color_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_BackColorChanged"
		end

	frozen set_tag (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.Control"
		alias
			"set_Tag"
		end

feature -- Basic Operations

	reset_cursor is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetCursor"
		end

	frozen resume_layout is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResumeLayout"
		end

	frozen perform_layout_control (affected_control: WINFORMS_CONTROL; affected_property: SYSTEM_STRING) is
		external
			"IL signature (System.Windows.Forms.Control, System.String): System.Void use System.Windows.Forms.Control"
		alias
			"PerformLayout"
		end

	reset_font is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetFont"
		end

	frozen begin_invoke_delegate_array_object (method: DELEGATE; args: NATIVE_ARRAY [SYSTEM_OBJECT]): IASYNC_RESULT is
		external
			"IL signature (System.Delegate, System.Object[]): System.IAsyncResult use System.Windows.Forms.Control"
		alias
			"BeginInvoke"
		end

	frozen create_control is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"CreateControl"
		end

	frozen invalidate is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"Invalidate"
		end

	frozen bring_to_front is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"BringToFront"
		end

	frozen reset_ime_mode is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetImeMode"
		end

	frozen invoke_delegate_array_object (method: DELEGATE; args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.Delegate, System.Object[]): System.Object use System.Windows.Forms.Control"
		alias
			"Invoke"
		end

	frozen begin_invoke (method: DELEGATE): IASYNC_RESULT is
		external
			"IL signature (System.Delegate): System.IAsyncResult use System.Windows.Forms.Control"
		alias
			"BeginInvoke"
		end

	frozen scale (ratio: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Windows.Forms.Control"
		alias
			"Scale"
		end

	frozen create_graphics: DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Windows.Forms.Control"
		alias
			"CreateGraphics"
		end

	frozen get_next_control (ctl: WINFORMS_CONTROL; forward: BOOLEAN): WINFORMS_CONTROL is
		external
			"IL signature (System.Windows.Forms.Control, System.Boolean): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"GetNextControl"
		end

	frozen set_bounds_int32_int32_int32_int32_bounds_specified (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.Control"
		alias
			"SetBounds"
		end

	reset_back_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetBackColor"
		end

	frozen invalidate_rectangle (rc: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Control"
		alias
			"Invalidate"
		end

	frozen show is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"Show"
		end

	frozen point_to_client (p: DRAWING_POINT): DRAWING_POINT is
		external
			"IL signature (System.Drawing.Point): System.Drawing.Point use System.Windows.Forms.Control"
		alias
			"PointToClient"
		end

	frozen send_to_back is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"SendToBack"
		end

	frozen invalidate_rectangle_boolean (rc: DRAWING_RECTANGLE; invalidate_children: BOOLEAN) is
		external
			"IL signature (System.Drawing.Rectangle, System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"Invalidate"
		end

	frozen from_child_handle (handle: POINTER): WINFORMS_CONTROL is
		external
			"IL static signature (System.IntPtr): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"FromChildHandle"
		end

	frozen get_container_control: WINFORMS_ICONTAINER_CONTROL is
		external
			"IL signature (): System.Windows.Forms.IContainerControl use System.Windows.Forms.Control"
		alias
			"GetContainerControl"
		end

	frozen focus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"Focus"
		end

	reset_text is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetText"
		end

	frozen hide is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"Hide"
		end

	frozen select_next_control (ctl: WINFORMS_CONTROL; forward: BOOLEAN; tab_stop_only: BOOLEAN; nested: BOOLEAN; wrap: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Control, System.Boolean, System.Boolean, System.Boolean, System.Boolean): System.Boolean use System.Windows.Forms.Control"
		alias
			"SelectNextControl"
		end

	frozen rectangle_to_client (r: DRAWING_RECTANGLE): DRAWING_RECTANGLE is
		external
			"IL signature (System.Drawing.Rectangle): System.Drawing.Rectangle use System.Windows.Forms.Control"
		alias
			"RectangleToClient"
		end

	frozen rectangle_to_screen (r: DRAWING_RECTANGLE): DRAWING_RECTANGLE is
		external
			"IL signature (System.Drawing.Rectangle): System.Drawing.Rectangle use System.Windows.Forms.Control"
		alias
			"RectangleToScreen"
		end

	refresh is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"Refresh"
		end

	frozen find_form: WINFORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.Control"
		alias
			"FindForm"
		end

	frozen invoke (method: DELEGATE): SYSTEM_OBJECT is
		external
			"IL signature (System.Delegate): System.Object use System.Windows.Forms.Control"
		alias
			"Invoke"
		end

	frozen invalidate_region_boolean (region: DRAWING_REGION; invalidate_children: BOOLEAN) is
		external
			"IL signature (System.Drawing.Region, System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"Invalidate"
		end

	frozen invalidate_boolean (invalidate_children: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"Invalidate"
		end

	frozen resume_layout_boolean (perform_layout2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"ResumeLayout"
		end

	pre_process_message (msg: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Control"
		alias
			"PreProcessMessage"
		end

	frozen select_ is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"Select"
		end

	frozen invalidate_region (region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Windows.Forms.Control"
		alias
			"Invalidate"
		end

	frozen scale_single_single (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Windows.Forms.Control"
		alias
			"Scale"
		end

	reset_fore_color is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetForeColor"
		end

	frozen do_drag_drop (data: SYSTEM_OBJECT; allowed_effects: WINFORMS_DRAG_DROP_EFFECTS): WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL signature (System.Object, System.Windows.Forms.DragDropEffects): System.Windows.Forms.DragDropEffects use System.Windows.Forms.Control"
		alias
			"DoDragDrop"
		end

	frozen contains (ctl: WINFORMS_CONTROL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Control): System.Boolean use System.Windows.Forms.Control"
		alias
			"Contains"
		end

	frozen set_bounds_int32_int32_int32_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"SetBounds"
		end

	frozen get_child_at_point (pt: DRAWING_POINT): WINFORMS_CONTROL is
		external
			"IL signature (System.Drawing.Point): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"GetChildAtPoint"
		end

	frozen update is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"Update"
		end

	reset_right_to_left is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetRightToLeft"
		end

	frozen from_handle (handle: POINTER): WINFORMS_CONTROL is
		external
			"IL static signature (System.IntPtr): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"FromHandle"
		end

	frozen end_invoke (async_result: IASYNC_RESULT): SYSTEM_OBJECT is
		external
			"IL signature (System.IAsyncResult): System.Object use System.Windows.Forms.Control"
		alias
			"EndInvoke"
		end

	frozen reset_bindings is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetBindings"
		end

	frozen is_mnemonic (char_code: CHARACTER; text: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.Char, System.String): System.Boolean use System.Windows.Forms.Control"
		alias
			"IsMnemonic"
		end

	frozen point_to_screen (p: DRAWING_POINT): DRAWING_POINT is
		external
			"IL signature (System.Drawing.Point): System.Drawing.Point use System.Windows.Forms.Control"
		alias
			"PointToScreen"
		end

	frozen perform_layout is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"PerformLayout"
		end

	frozen suspend_layout is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"SuspendLayout"
		end

feature {NONE} -- Implementation

	frozen raise_mouse_event (key: SYSTEM_OBJECT; e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"RaiseMouseEvent"
		end

	on_paint_background (pevent: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnPaintBackground"
		end

	on_drag_enter (drgevent: WINFORMS_DRAG_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.DragEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDragEnter"
		end

	process_mnemonic (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessMnemonic"
		end

	frozen update_bounds_int32_int32_int32_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"UpdateBounds"
		end

	on_parent_enabled_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentEnabledChanged"
		end

	frozen update_bounds is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"UpdateBounds"
		end

	def_wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.Control"
		alias
			"DefWndProc"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"Dispose"
		end

	create_accessibility_instance: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.Control"
		alias
			"CreateAccessibilityInstance"
		end

	on_invalidated (e: WINFORMS_INVALIDATE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.InvalidateEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnInvalidated"
		end

	frozen get_top_level: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"GetTopLevel"
		end

	on_control_removed (e: WINFORMS_CONTROL_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ControlEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnControlRemoved"
		end

	on_parent_background_image_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentBackgroundImageChanged"
		end

	frozen invoke_got_focus (to_invoke: WINFORMS_CONTROL; e: EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.Control, System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"InvokeGotFocus"
		end

	set_client_size_core (x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"SetClientSizeCore"
		end

	init_layout is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"InitLayout"
		end

	frozen invoke_on_click (to_invoke: WINFORMS_CONTROL; e: EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.Control, System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"InvokeOnClick"
		end

	on_lost_focus (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnLostFocus"
		end

	process_key_event_args (m: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessKeyEventArgs"
		end

	on_ime_mode_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnImeModeChanged"
		end

	frozen rtl_translate_alignment (align: DRAWING_CONTENT_ALIGNMENT): DRAWING_CONTENT_ALIGNMENT is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Drawing.ContentAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateAlignment"
		end

	frozen get_style (flag: WINFORMS_CONTROL_STYLES): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ControlStyles): System.Boolean use System.Windows.Forms.Control"
		alias
			"GetStyle"
		end

	on_parent_right_to_left_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentRightToLeftChanged"
		end

	on_visible_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnVisibleChanged"
		end

	on_layout (levent: WINFORMS_LAYOUT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.LayoutEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnLayout"
		end

	on_double_click (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDoubleClick"
		end

	on_give_feedback (gfbevent: WINFORMS_GIVE_FEEDBACK_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnGiveFeedback"
		end

	frozen accessibility_notify_clients (acc_event: WINFORMS_ACCESSIBLE_EVENTS; child_id: INTEGER) is
		external
			"IL signature (System.Windows.Forms.AccessibleEvents, System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"AccessibilityNotifyClients"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnHandleCreated"
		end

	on_query_continue_drag (qcdevent: WINFORMS_QUERY_CONTINUE_DRAG_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnQueryContinueDrag"
		end

	on_dock_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDockChanged"
		end

	frozen get_font_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control"
		alias
			"get_FontHeight"
		end

	on_parent_binding_context_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentBindingContextChanged"
		end

	set_visible_core (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"SetVisibleCore"
		end

	get_show_focus_cues: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_ShowFocusCues"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Control"
		alias
			"get_DefaultSize"
		end

	on_help_requested (hevent: WINFORMS_HELP_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.HelpEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnHelpRequested"
		end

	on_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnBackColorChanged"
		end

	create_controls_instance: WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.Control"
		alias
			"CreateControlsInstance"
		end

	frozen invoke_lost_focus (to_invoke: WINFORMS_CONTROL; e: EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.Control, System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"InvokeLostFocus"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnFontChanged"
		end

	select__boolean (directed: BOOLEAN; forward: BOOLEAN) is
		external
			"IL signature (System.Boolean, System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"Select"
		end

	destroy_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"DestroyHandle"
		end

	on_text_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnTextChanged"
		end

	on_mouse_down (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseDown"
		end

	frozen rtl_translate_left_right (align: WINFORMS_LEFT_RIGHT_ALIGNMENT): WINFORMS_LEFT_RIGHT_ALIGNMENT is
		external
			"IL signature (System.Windows.Forms.LeftRightAlignment): System.Windows.Forms.LeftRightAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateLeftRight"
		end

	process_cmd_key (msg: WINFORMS_MESSAGE; key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&, System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessCmdKey"
		end

	on_context_menu_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnContextMenuChanged"
		end

	on_size_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnSizeChanged"
		end

	frozen set_top_level (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"SetTopLevel"
		end

	frozen update_styles is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"UpdateStyles"
		end

	frozen invoke_paint (c: WINFORMS_CONTROL; e: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.Control, System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"InvokePaint"
		end

	on_parent_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentChanged"
		end

	on_move (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMove"
		end

	on_validating (e: SYSTEM_DLL_CANCEL_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CancelEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnValidating"
		end

	frozen raise_paint_event (key: SYSTEM_OBJECT; e: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"RaisePaintEvent"
		end

	on_background_image_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnBackgroundImageChanged"
		end

	on_mouse_up (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseUp"
		end

	on_paint (e: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnPaint"
		end

	on_mouse_hover (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseHover"
		end

	process_dialog_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessDialogKey"
		end

	frozen get_show_keyboard_cues: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_ShowKeyboardCues"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.Control"
		alias
			"get_CreateParams"
		end

	on_create_control is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"OnCreateControl"
		end

	on_enter (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnEnter"
		end

	scale_core (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Windows.Forms.Control"
		alias
			"ScaleCore"
		end

	frozen reflect_message (h_wnd: POINTER; m: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL static signature (System.IntPtr, System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Control"
		alias
			"ReflectMessage"
		end

	process_dialog_char (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessDialogChar"
		end

	on_validated (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnValidated"
		end

	frozen rtl_translate_horizontal (align: WINFORMS_HORIZONTAL_ALIGNMENT): WINFORMS_HORIZONTAL_ALIGNMENT is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateHorizontal"
		end

	on_fore_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnForeColorChanged"
		end

	on_mouse_leave (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseLeave"
		end

	frozen raise_key_event (key: SYSTEM_OBJECT; e: WINFORMS_KEY_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"RaiseKeyEvent"
		end

	on_key_down (e: WINFORMS_KEY_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnKeyDown"
		end

	on_binding_context_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnBindingContextChanged"
		end

	on_enabled_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnEnabledChanged"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"CreateHandle"
		end

	on_parent_visible_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentVisibleChanged"
		end

	is_input_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Control"
		alias
			"IsInputKey"
		end

	on_drag_over (drgevent: WINFORMS_DRAG_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.DragEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDragOver"
		end

	frozen get_render_right_to_left: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_RenderRightToLeft"
		end

	frozen set_font_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"set_FontHeight"
		end

	on_location_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnLocationChanged"
		end

	on_resize (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnResize"
		end

	on_got_focus (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnGotFocus"
		end

	on_key_up (e: WINFORMS_KEY_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnKeyUp"
		end

	on_change_uicues (e: WINFORMS_UICUES_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.UICuesEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnChangeUICues"
		end

	on_control_added (e: WINFORMS_CONTROL_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ControlEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnControlAdded"
		end

	on_mouse_enter (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseEnter"
		end

	frozen rtl_translate_content (align: DRAWING_CONTENT_ALIGNMENT): DRAWING_CONTENT_ALIGNMENT is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Drawing.ContentAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateContent"
		end

	on_leave (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnLeave"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.Control"
		alias
			"WndProc"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.Control"
		alias
			"SetBoundsCore"
		end

	frozen update_zorder is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"UpdateZOrder"
		end

	on_right_to_left_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnRightToLeftChanged"
		end

	on_style_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnStyleChanged"
		end

	on_tab_index_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnTabIndexChanged"
		end

	frozen rtl_translate_alignment_left_right_alignment (align: WINFORMS_LEFT_RIGHT_ALIGNMENT): WINFORMS_LEFT_RIGHT_ALIGNMENT is
		external
			"IL signature (System.Windows.Forms.LeftRightAlignment): System.Windows.Forms.LeftRightAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateAlignment"
		end

	on_click (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnClick"
		end

	frozen invoke_paint_background (c: WINFORMS_CONTROL; e: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.Control, System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"InvokePaintBackground"
		end

	frozen set_resize_redraw (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"set_ResizeRedraw"
		end

	process_key_message (m: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessKeyMessage"
		end

	on_notify_message (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message): System.Void use System.Windows.Forms.Control"
		alias
			"OnNotifyMessage"
		end

	is_input_char (char_code: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Windows.Forms.Control"
		alias
			"IsInputChar"
		end

	on_parent_fore_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentForeColorChanged"
		end

	process_key_preview (m: WINFORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessKeyPreview"
		end

	frozen update_bounds_int32_int32_int32_int32_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; client_width: INTEGER; client_height: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"UpdateBounds"
		end

	on_drag_leave (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDragLeave"
		end

	frozen rtl_translate_alignment_horizontal_alignment (align: WINFORMS_HORIZONTAL_ALIGNMENT): WINFORMS_HORIZONTAL_ALIGNMENT is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateAlignment"
		end

	on_causes_validation_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnCausesValidationChanged"
		end

	on_drag_drop (drgevent: WINFORMS_DRAG_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.DragEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDragDrop"
		end

	on_handle_destroyed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnHandleDestroyed"
		end

	frozen set_style (flag: WINFORMS_CONTROL_STYLES; value: BOOLEAN) is
		external
			"IL signature (System.Windows.Forms.ControlStyles, System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"SetStyle"
		end

	on_mouse_wheel (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseWheel"
		end

	on_parent_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentBackColorChanged"
		end

	notify_invalidate (invalidated_area: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Control"
		alias
			"NotifyInvalidate"
		end

	on_mouse_move (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseMove"
		end

	frozen get_resize_redraw: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_ResizeRedraw"
		end

	on_cursor_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnCursorChanged"
		end

	on_key_press (e: WINFORMS_KEY_PRESS_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnKeyPress"
		end

	frozen recreate_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"RecreateHandle"
		end

	frozen reset_mouse_event_args is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"ResetMouseEventArgs"
		end

	frozen raise_drag_event (key: SYSTEM_OBJECT; e: WINFORMS_DRAG_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.DragEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"RaiseDragEvent"
		end

	on_parent_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentFontChanged"
		end

	get_default_ime_mode: WINFORMS_IME_MODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Control"
		alias
			"get_DefaultImeMode"
		end

	on_system_colors_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnSystemColorsChanged"
		end

	on_tab_stop_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnTabStopChanged"
		end

end -- class WINFORMS_CONTROL
