indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Control"

external class
	SYSTEM_WINDOWS_FORMS_CONTROL

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			set_site,
			get_site,
			dispose_boolean
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_control_4,
	make_control_3,
	make_control_2,
	make_control,
	make_control_1

feature {NONE} -- Initialization

	frozen make_control_4 (parent: SYSTEM_WINDOWS_FORMS_CONTROL; text: STRING; left: INTEGER; top: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.Control, System.String, System.Int32, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.Control"
		end

	frozen make_control_3 (parent: SYSTEM_WINDOWS_FORMS_CONTROL; text: STRING) is
		external
			"IL creator signature (System.Windows.Forms.Control, System.String) use System.Windows.Forms.Control"
		end

	frozen make_control_2 (text: STRING; left: INTEGER; top: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.Control"
		end

	frozen make_control is
		external
			"IL creator use System.Windows.Forms.Control"
		end

	frozen make_control_1 (text: STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.Control"
		end

feature -- Access

	frozen get_disposing: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control"
		alias
			"get_Disposing"
		end

	frozen get_client_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Control"
		alias
			"get_ClientSize"
		end

	frozen get_company_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_CompanyName"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_Name"
		end

	frozen get_top_level_control: SYSTEM_WINDOWS_FORMS_CONTROL is
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

	frozen get_accessible_role: SYSTEM_WINDOWS_FORMS_ACCESSIBLEROLE is
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

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.Control"
		alias
			"get_BackColor"
		end

	frozen get_default_font: SYSTEM_DRAWING_FONT is
		external
			"IL static signature (): System.Drawing.Font use System.Windows.Forms.Control"
		alias
			"get_DefaultFont"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.Control"
		alias
			"get_BackgroundImage"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.Control"
		alias
			"get_ForeColor"
		end

	get_right_to_left: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT is
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

	get_context_menu: SYSTEM_WINDOWS_FORMS_CONTEXTMENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.Control"
		alias
			"get_ContextMenu"
		end

	get_site: SYSTEM_COMPONENTMODEL_ISITE is
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

	get_display_rectangle: SYSTEM_DRAWING_RECTANGLE is
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

	frozen get_mouse_buttons: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
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

	frozen get_region: SYSTEM_DRAWING_REGION is
		external
			"IL signature (): System.Drawing.Region use System.Windows.Forms.Control"
		alias
			"get_Region"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_Text"
		end

	frozen get_accessible_default_action_description: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_AccessibleDefaultActionDescription"
		end

	frozen get_default_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (): System.Drawing.Color use System.Windows.Forms.Control"
		alias
			"get_DefaultForeColor"
		end

	frozen get_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Control"
		alias
			"get_Size"
		end

	frozen get_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Control"
		alias
			"get_ImeMode"
		end

	frozen get_tag: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.Control"
		alias
			"get_Tag"
		end

	frozen get_window_target: SYSTEM_WINDOWS_FORMS_IWINDOWTARGET is
		external
			"IL signature (): System.Windows.Forms.IWindowTarget use System.Windows.Forms.Control"
		alias
			"get_WindowTarget"
		end

	frozen get_modifier_keys: SYSTEM_WINDOWS_FORMS_KEYS is
		external
			"IL static signature (): System.Windows.Forms.Keys use System.Windows.Forms.Control"
		alias
			"get_ModifierKeys"
		end

	get_font: SYSTEM_DRAWING_FONT is
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

	get_anchor: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
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

	frozen get_controls: CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.Control"
		alias
			"get_Controls"
		end

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLE is
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

	frozen get_product_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_ProductName"
		end

	frozen get_parent: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"get_Parent"
		end

	frozen get_accessible_name: STRING is
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

	frozen get_accessibility_object: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
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

	frozen get_data_bindings: SYSTEM_WINDOWS_FORMS_CONTROLBINDINGSCOLLECTION is
		external
			"IL signature (): System.Windows.Forms.ControlBindingsCollection use System.Windows.Forms.Control"
		alias
			"get_DataBindings"
		end

	frozen get_product_version: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control"
		alias
			"get_ProductVersion"
		end

	get_cursor: SYSTEM_WINDOWS_FORMS_CURSOR is
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

	get_binding_context: SYSTEM_WINDOWS_FORMS_BINDINGCONTEXT is
		external
			"IL signature (): System.Windows.Forms.BindingContext use System.Windows.Forms.Control"
		alias
			"get_BindingContext"
		end

	frozen get_mouse_position: SYSTEM_DRAWING_POINT is
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

	get_dock: SYSTEM_WINDOWS_FORMS_DOCKSTYLE is
		external
			"IL signature (): System.Windows.Forms.DockStyle use System.Windows.Forms.Control"
		alias
			"get_Dock"
		end

	frozen get_client_rectangle: SYSTEM_DRAWING_RECTANGLE is
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

	frozen get_accessible_description: STRING is
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

	frozen get_default_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (): System.Drawing.Color use System.Windows.Forms.Control"
		alias
			"get_DefaultBackColor"
		end

	frozen get_location: SYSTEM_DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.Control"
		alias
			"get_Location"
		end

feature -- Element Change

	frozen add_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Click"
		end

	frozen add_enter (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Enter"
		end

	frozen remove_tab_index_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_TabIndexChanged"
		end

	frozen remove_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Click"
		end

	frozen remove_layout (value: SYSTEM_WINDOWS_FORMS_LAYOUTEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.LayoutEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Layout"
		end

	frozen remove_size_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_SizeChanged"
		end

	frozen add_drag_over (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DragOver"
		end

	frozen remove_binding_context_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_BindingContextChanged"
		end

	frozen remove_right_to_left_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_RightToLeftChanged"
		end

	frozen add_size_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_SizeChanged"
		end

	frozen remove_key_down (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_KeyDown"
		end

	frozen add_fore_color_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ForeColorChanged"
		end

	frozen remove_drag_over (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DragOver"
		end

	frozen set_parent (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Control"
		alias
			"set_Parent"
		end

	frozen remove_resize (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Resize"
		end

	frozen add_paint (value: SYSTEM_WINDOWS_FORMS_PAINTEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Paint"
		end

	frozen add_mouse_move (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseMove"
		end

	frozen remove_paint (value: SYSTEM_WINDOWS_FORMS_PAINTEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.PaintEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Paint"
		end

	frozen remove_enter (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Enter"
		end

	frozen add_key_up (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_KeyUp"
		end

	frozen add_validated (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Validated"
		end

	frozen add_invalidated (value: SYSTEM_WINDOWS_FORMS_INVALIDATEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.InvalidateEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Invalidated"
		end

	frozen add_query_continue_drag (value: SYSTEM_WINDOWS_FORMS_QUERYCONTINUEDRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_QueryContinueDrag"
		end

	frozen add_mouse_leave (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseLeave"
		end

	frozen add_location_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_LocationChanged"
		end

	frozen set_accessible_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_AccessibleName"
		end

	frozen remove_mouse_wheel (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseWheel"
		end

	frozen add_style_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_StyleChanged"
		end

	frozen add_dock_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DockChanged"
		end

	frozen remove_drag_leave (value: SYSTEM_EVENTHANDLER) is
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

	frozen remove_double_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DoubleClick"
		end

	frozen add_context_menu_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ContextMenuChanged"
		end

	frozen add_got_focus (value: SYSTEM_EVENTHANDLER) is
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

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Windows.Forms.Control"
		alias
			"set_Site"
		end

	frozen add_parent_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ParentChanged"
		end

	frozen remove_fore_color_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ForeColorChanged"
		end

	frozen add_enabled_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_EnabledChanged"
		end

	frozen remove_ime_mode_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ImeModeChanged"
		end

	frozen remove_query_continue_drag (value: SYSTEM_WINDOWS_FORMS_QUERYCONTINUEDRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_QueryContinueDrag"
		end

	frozen add_help_requested (value: SYSTEM_WINDOWS_FORMS_HELPEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.HelpEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_HelpRequested"
		end

	frozen remove_visible_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_VisibleChanged"
		end

	frozen remove_mouse_move (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseMove"
		end

	frozen add_right_to_left_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_RightToLeftChanged"
		end

	frozen remove_lost_focus (value: SYSTEM_EVENTHANDLER) is
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

	set_dock (value: SYSTEM_WINDOWS_FORMS_DOCKSTYLE) is
		external
			"IL signature (System.Windows.Forms.DockStyle): System.Void use System.Windows.Forms.Control"
		alias
			"set_Dock"
		end

	frozen add_drag_leave (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DragLeave"
		end

	frozen remove_validated (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Validated"
		end

	frozen add_leave (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Leave"
		end

	frozen remove_mouse_enter (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseEnter"
		end

	frozen remove_font_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_FontChanged"
		end

	frozen add_give_feedback (value: SYSTEM_WINDOWS_FORMS_GIVEFEEDBACKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_GiveFeedback"
		end

	frozen add_double_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DoubleClick"
		end

	frozen add_validating (value: SYSTEM_COMPONENTMODEL_CANCELEVENTHANDLER) is
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

	frozen set_window_target (value: SYSTEM_WINDOWS_FORMS_IWINDOWTARGET) is
		external
			"IL signature (System.Windows.Forms.IWindowTarget): System.Void use System.Windows.Forms.Control"
		alias
			"set_WindowTarget"
		end

	set_context_menu (value: SYSTEM_WINDOWS_FORMS_CONTEXTMENU) is
		external
			"IL signature (System.Windows.Forms.ContextMenu): System.Void use System.Windows.Forms.Control"
		alias
			"set_ContextMenu"
		end

	frozen remove_mouse_leave (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseLeave"
		end

	frozen add_back_color_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_BackColorChanged"
		end

	frozen add_mouse_enter (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseEnter"
		end

	frozen set_region (value: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Windows.Forms.Control"
		alias
			"set_Region"
		end

	frozen remove_tab_stop_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_TabStopChanged"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.Control"
		alias
			"set_ForeColor"
		end

	frozen remove_handle_created (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_HandleCreated"
		end

	frozen set_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Control"
		alias
			"set_Size"
		end

	frozen set_accessible_description (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_AccessibleDescription"
		end

	frozen add_cursor_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_CursorChanged"
		end

	frozen remove_drag_enter (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DragEnter"
		end

	frozen add_background_image_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_BackgroundImageChanged"
		end

	frozen remove_background_image_changed (value: SYSTEM_EVENTHANDLER) is
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

	frozen add_font_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_FontChanged"
		end

	frozen remove_control_removed (value: SYSTEM_WINDOWS_FORMS_CONTROLEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ControlEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ControlRemoved"
		end

	frozen add_control_removed (value: SYSTEM_WINDOWS_FORMS_CONTROLEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ControlEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ControlRemoved"
		end

	frozen remove_leave (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Leave"
		end

	frozen set_location (value: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Windows.Forms.Control"
		alias
			"set_Location"
		end

	frozen add_visible_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_VisibleChanged"
		end

	frozen remove_drag_drop (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DragDrop"
		end

	frozen add_binding_context_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_BindingContextChanged"
		end

	set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.Control"
		alias
			"set_Font"
		end

	frozen remove_key_press (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_KeyPress"
		end

	frozen remove_change_uicues (value: SYSTEM_WINDOWS_FORMS_UICUESEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.UICuesEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ChangeUICues"
		end

	set_binding_context (value: SYSTEM_WINDOWS_FORMS_BINDINGCONTEXT) is
		external
			"IL signature (System.Windows.Forms.BindingContext): System.Void use System.Windows.Forms.Control"
		alias
			"set_BindingContext"
		end

	frozen remove_move (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Move"
		end

	frozen remove_invalidated (value: SYSTEM_WINDOWS_FORMS_INVALIDATEEVENTHANDLER) is
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

	frozen add_key_press (value: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_KeyPress"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_Name"
		end

	frozen add_system_colors_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_SystemColorsChanged"
		end

	frozen add_mouse_hover (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseHover"
		end

	frozen add_mouse_up (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseUp"
		end

	frozen remove_mouse_hover (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseHover"
		end

	frozen add_handle_created (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_HandleCreated"
		end

	frozen set_accessible_default_action_description (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.Control"
		alias
			"set_AccessibleDefaultActionDescription"
		end

	frozen remove_enabled_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_EnabledChanged"
		end

	frozen remove_causes_validation_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_CausesValidationChanged"
		end

	frozen remove_control_added (value: SYSTEM_WINDOWS_FORMS_CONTROLEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ControlEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ControlAdded"
		end

	frozen remove_parent_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ParentChanged"
		end

	frozen set_ime_mode (value: SYSTEM_WINDOWS_FORMS_IMEMODE) is
		external
			"IL signature (System.Windows.Forms.ImeMode): System.Void use System.Windows.Forms.Control"
		alias
			"set_ImeMode"
		end

	frozen add_drag_enter (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
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

	frozen add_handle_destroyed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_HandleDestroyed"
		end

	frozen remove_system_colors_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_SystemColorsChanged"
		end

	frozen remove_context_menu_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_ContextMenuChanged"
		end

	frozen add_layout (value: SYSTEM_WINDOWS_FORMS_LAYOUTEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.LayoutEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Layout"
		end

	frozen remove_text_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_TextChanged"
		end

	frozen set_accessible_role (value: SYSTEM_WINDOWS_FORMS_ACCESSIBLEROLE) is
		external
			"IL signature (System.Windows.Forms.AccessibleRole): System.Void use System.Windows.Forms.Control"
		alias
			"set_AccessibleRole"
		end

	frozen remove_got_focus (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_GotFocus"
		end

	frozen remove_location_changed (value: SYSTEM_EVENTHANDLER) is
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

	set_text (value: STRING) is
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

	frozen remove_style_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_StyleChanged"
		end

	set_cursor (value: SYSTEM_WINDOWS_FORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.Control"
		alias
			"set_Cursor"
		end

	frozen remove_give_feedback (value: SYSTEM_WINDOWS_FORMS_GIVEFEEDBACKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_GiveFeedback"
		end

	frozen add_ime_mode_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ImeModeChanged"
		end

	frozen add_key_down (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_KeyDown"
		end

	frozen add_causes_validation_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_CausesValidationChanged"
		end

	frozen add_change_uicues (value: SYSTEM_WINDOWS_FORMS_UICUESEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.UICuesEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ChangeUICues"
		end

	frozen add_mouse_wheel (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseWheel"
		end

	frozen add_lost_focus (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_LostFocus"
		end

	frozen add_query_accessibility_help (value: SYSTEM_WINDOWS_FORMS_QUERYACCESSIBILITYHELPEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryAccessibilityHelpEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_QueryAccessibilityHelp"
		end

	frozen set_client_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.Control"
		alias
			"set_ClientSize"
		end

	set_right_to_left (value: SYSTEM_WINDOWS_FORMS_RIGHTTOLEFT) is
		external
			"IL signature (System.Windows.Forms.RightToLeft): System.Void use System.Windows.Forms.Control"
		alias
			"set_RightToLeft"
		end

	frozen remove_dock_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_DockChanged"
		end

	frozen remove_validating (value: SYSTEM_COMPONENTMODEL_CANCELEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CancelEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_Validating"
		end

	frozen add_resize (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Resize"
		end

	frozen add_move (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_Move"
		end

	frozen remove_query_accessibility_help (value: SYSTEM_WINDOWS_FORMS_QUERYACCESSIBILITYHELPEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.QueryAccessibilityHelpEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_QueryAccessibilityHelp"
		end

	frozen remove_key_up (value: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.KeyEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_KeyUp"
		end

	frozen add_text_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_TextChanged"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.Control"
		alias
			"set_BackgroundImage"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.Control"
		alias
			"set_BackColor"
		end

	frozen add_drag_drop (value: SYSTEM_WINDOWS_FORMS_DRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.DragEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_DragDrop"
		end

	frozen add_control_added (value: SYSTEM_WINDOWS_FORMS_CONTROLEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ControlEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_ControlAdded"
		end

	frozen remove_mouse_down (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseDown"
		end

	frozen add_mouse_down (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_MouseDown"
		end

	frozen remove_mouse_up (value: SYSTEM_WINDOWS_FORMS_MOUSEEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.MouseEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_MouseUp"
		end

	frozen add_tab_index_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_TabIndexChanged"
		end

	frozen remove_cursor_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_CursorChanged"
		end

	set_anchor (value: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES) is
		external
			"IL signature (System.Windows.Forms.AnchorStyles): System.Void use System.Windows.Forms.Control"
		alias
			"set_Anchor"
		end

	frozen set_bounds (value: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Control"
		alias
			"set_Bounds"
		end

	frozen remove_handle_destroyed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_HandleDestroyed"
		end

	frozen remove_help_requested (value: SYSTEM_WINDOWS_FORMS_HELPEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.HelpEventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_HelpRequested"
		end

	frozen add_tab_stop_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"add_TabStopChanged"
		end

	frozen remove_back_color_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Control"
		alias
			"remove_BackColorChanged"
		end

	frozen set_tag (value: ANY) is
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

	frozen perform_layout_control (affected_control: SYSTEM_WINDOWS_FORMS_CONTROL; affected_property: STRING) is
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

	frozen begin_invoke_delegate_array_object (method: SYSTEM_DELEGATE; args: ARRAY [ANY]): SYSTEM_IASYNCRESULT is
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

	frozen invoke_delegate_array_object (method: SYSTEM_DELEGATE; args: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Delegate, System.Object[]): System.Object use System.Windows.Forms.Control"
		alias
			"Invoke"
		end

	frozen begin_invoke (method: SYSTEM_DELEGATE): SYSTEM_IASYNCRESULT is
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

	frozen create_graphics: SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Windows.Forms.Control"
		alias
			"CreateGraphics"
		end

	frozen get_next_control (ctl: SYSTEM_WINDOWS_FORMS_CONTROL; forward: BOOLEAN): SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (System.Windows.Forms.Control, System.Boolean): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"GetNextControl"
		end

	frozen set_bounds_int32_int32_int32_int32_bounds_specified (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
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

	frozen invalidate_rectangle (rc: SYSTEM_DRAWING_RECTANGLE) is
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

	frozen point_to_client (p: SYSTEM_DRAWING_POINT): SYSTEM_DRAWING_POINT is
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

	frozen invalidate_rectangle_boolean (rc: SYSTEM_DRAWING_RECTANGLE; invalidate_children: BOOLEAN) is
		external
			"IL signature (System.Drawing.Rectangle, System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"Invalidate"
		end

	frozen call_wnd_proc (msg: INTEGER; wparam: POINTER; lparam: POINTER): POINTER is
		external
			"IL signature (System.Int32, System.IntPtr, System.IntPtr): System.IntPtr use System.Windows.Forms.Control"
		alias
			"CallWndProc"
		end

	frozen from_child_handle (handle: POINTER): SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL static signature (System.IntPtr): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"FromChildHandle"
		end

	frozen Select_ is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control"
		alias
			"Select"
		end

	frozen get_container_control: SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL is
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

	frozen select_next_control (ctl: SYSTEM_WINDOWS_FORMS_CONTROL; forward: BOOLEAN; tab_stop_only: BOOLEAN; nested: BOOLEAN; wrap: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Control, System.Boolean, System.Boolean, System.Boolean, System.Boolean): System.Boolean use System.Windows.Forms.Control"
		alias
			"SelectNextControl"
		end

	frozen rectangle_to_client (r: SYSTEM_DRAWING_RECTANGLE): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (System.Drawing.Rectangle): System.Drawing.Rectangle use System.Windows.Forms.Control"
		alias
			"RectangleToClient"
		end

	frozen create_graphics_int_ptr (dc: POINTER): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (System.IntPtr): System.Drawing.Graphics use System.Windows.Forms.Control"
		alias
			"CreateGraphics"
		end

	frozen rectangle_to_screen (r: SYSTEM_DRAWING_RECTANGLE): SYSTEM_DRAWING_RECTANGLE is
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

	frozen find_form: SYSTEM_WINDOWS_FORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.Control"
		alias
			"FindForm"
		end

	frozen invoke (method: SYSTEM_DELEGATE): ANY is
		external
			"IL signature (System.Delegate): System.Object use System.Windows.Forms.Control"
		alias
			"Invoke"
		end

	frozen invalidate_region_boolean (region: SYSTEM_DRAWING_REGION; invalidate_children: BOOLEAN) is
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

	pre_process_message (msg: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Control"
		alias
			"PreProcessMessage"
		end

	frozen invalidate_region (region: SYSTEM_DRAWING_REGION) is
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

	frozen do_drag_drop (data: ANY; allowed_effects: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS): SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL signature (System.Object, System.Windows.Forms.DragDropEffects): System.Windows.Forms.DragDropEffects use System.Windows.Forms.Control"
		alias
			"DoDragDrop"
		end

	frozen contains (ctl: SYSTEM_WINDOWS_FORMS_CONTROL): BOOLEAN is
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

	frozen get_child_at_point (pt: SYSTEM_DRAWING_POINT): SYSTEM_WINDOWS_FORMS_CONTROL is
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

	frozen from_handle (handle: POINTER): SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL static signature (System.IntPtr): System.Windows.Forms.Control use System.Windows.Forms.Control"
		alias
			"FromHandle"
		end

	frozen end_invoke (async_result: SYSTEM_IASYNCRESULT): ANY is
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

	frozen is_mnemonic (char_code: CHARACTER; text: STRING): BOOLEAN is
		external
			"IL static signature (System.Char, System.String): System.Boolean use System.Windows.Forms.Control"
		alias
			"IsMnemonic"
		end

	frozen point_to_screen (p: SYSTEM_DRAWING_POINT): SYSTEM_DRAWING_POINT is
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

	frozen raise_mouse_event (key: ANY; e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"RaiseMouseEvent"
		end

	on_paint_background (pevent: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnPaintBackground"
		end

	on_drag_enter (drgevent: SYSTEM_WINDOWS_FORMS_DRAGEVENTARGS) is
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

	on_parent_enabled_changed (e: SYSTEM_EVENTARGS) is
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

	def_wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
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

	create_accessibility_instance: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.Control"
		alias
			"CreateAccessibilityInstance"
		end

	on_invalidated (e: SYSTEM_WINDOWS_FORMS_INVALIDATEEVENTARGS) is
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

	on_control_removed (e: SYSTEM_WINDOWS_FORMS_CONTROLEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ControlEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnControlRemoved"
		end

	on_parent_background_image_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentBackgroundImageChanged"
		end

	frozen invoke_got_focus (to_invoke: SYSTEM_WINDOWS_FORMS_CONTROL; e: SYSTEM_EVENTARGS) is
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

	frozen invoke_on_click (to_invoke: SYSTEM_WINDOWS_FORMS_CONTROL; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Windows.Forms.Control, System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"InvokeOnClick"
		end

	on_lost_focus (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnLostFocus"
		end

	process_key_event_args (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessKeyEventArgs"
		end

	on_ime_mode_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnImeModeChanged"
		end

	frozen rtl_translate_alignment (align: SYSTEM_DRAWING_CONTENTALIGNMENT): SYSTEM_DRAWING_CONTENTALIGNMENT is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Drawing.ContentAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateAlignment"
		end

	frozen get_style (flag: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ControlStyles): System.Boolean use System.Windows.Forms.Control"
		alias
			"GetStyle"
		end

	on_parent_right_to_left_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentRightToLeftChanged"
		end

	on_visible_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnVisibleChanged"
		end

	on_layout (levent: SYSTEM_WINDOWS_FORMS_LAYOUTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.LayoutEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnLayout"
		end

	on_double_click (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDoubleClick"
		end

	on_give_feedback (gfbevent: SYSTEM_WINDOWS_FORMS_GIVEFEEDBACKEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.GiveFeedbackEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnGiveFeedback"
		end

	frozen accessibility_notify_clients (acc_event: SYSTEM_WINDOWS_FORMS_ACCESSIBLEEVENTS; child_id: INTEGER) is
		external
			"IL signature (System.Windows.Forms.AccessibleEvents, System.Int32): System.Void use System.Windows.Forms.Control"
		alias
			"AccessibilityNotifyClients"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnHandleCreated"
		end

	on_query_continue_drag (qcdevent: SYSTEM_WINDOWS_FORMS_QUERYCONTINUEDRAGEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.QueryContinueDragEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnQueryContinueDrag"
		end

	on_dock_changed (e: SYSTEM_EVENTARGS) is
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

	on_parent_binding_context_changed (e: SYSTEM_EVENTARGS) is
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

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Control"
		alias
			"get_DefaultSize"
		end

	on_help_requested (hevent: SYSTEM_WINDOWS_FORMS_HELPEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.HelpEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnHelpRequested"
		end

	on_back_color_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnBackColorChanged"
		end

	create_controls_instance: CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.Control"
		alias
			"CreateControlsInstance"
		end

	frozen invoke_lost_focus (to_invoke: SYSTEM_WINDOWS_FORMS_CONTROL; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Windows.Forms.Control, System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"InvokeLostFocus"
		end

	on_font_changed (e: SYSTEM_EVENTARGS) is
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

	on_text_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnTextChanged"
		end

	on_mouse_down (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseDown"
		end

	frozen rtl_translate_left_right (align: SYSTEM_WINDOWS_FORMS_LEFTRIGHTALIGNMENT): SYSTEM_WINDOWS_FORMS_LEFTRIGHTALIGNMENT is
		external
			"IL signature (System.Windows.Forms.LeftRightAlignment): System.Windows.Forms.LeftRightAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateLeftRight"
		end

	process_cmd_key (msg: SYSTEM_WINDOWS_FORMS_MESSAGE; key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&, System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessCmdKey"
		end

	on_context_menu_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnContextMenuChanged"
		end

	on_size_changed (e: SYSTEM_EVENTARGS) is
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

	frozen invoke_paint (c: SYSTEM_WINDOWS_FORMS_CONTROL; e: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.Control, System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"InvokePaint"
		end

	on_parent_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentChanged"
		end

	on_move (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMove"
		end

	on_validating (e: SYSTEM_COMPONENTMODEL_CANCELEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CancelEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnValidating"
		end

	frozen raise_paint_event (key: ANY; e: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"RaisePaintEvent"
		end

	on_background_image_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnBackgroundImageChanged"
		end

	on_mouse_up (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseUp"
		end

	on_paint (e: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnPaint"
		end

	on_mouse_hover (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseHover"
		end

	process_dialog_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
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

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
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

	on_enter (e: SYSTEM_EVENTARGS) is
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

	frozen reflect_message (h_wnd: POINTER; m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
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

	on_validated (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnValidated"
		end

	frozen rtl_translate_horizontal (align: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT): SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateHorizontal"
		end

	on_fore_color_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnForeColorChanged"
		end

	on_mouse_leave (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseLeave"
		end

	frozen raise_key_event (key: ANY; e: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"RaiseKeyEvent"
		end

	on_key_down (e: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnKeyDown"
		end

	on_binding_context_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnBindingContextChanged"
		end

	on_enabled_changed (e: SYSTEM_EVENTARGS) is
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

	on_parent_visible_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentVisibleChanged"
		end

	is_input_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Control"
		alias
			"IsInputKey"
		end

	on_drag_over (drgevent: SYSTEM_WINDOWS_FORMS_DRAGEVENTARGS) is
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

	on_location_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnLocationChanged"
		end

	on_resize (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnResize"
		end

	on_got_focus (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnGotFocus"
		end

	on_key_up (e: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnKeyUp"
		end

	on_change_uicues (e: SYSTEM_WINDOWS_FORMS_UICUESEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.UICuesEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnChangeUICues"
		end

	on_control_added (e: SYSTEM_WINDOWS_FORMS_CONTROLEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ControlEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnControlAdded"
		end

	on_mouse_enter (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseEnter"
		end

	frozen rtl_translate_content (align: SYSTEM_DRAWING_CONTENTALIGNMENT): SYSTEM_DRAWING_CONTENTALIGNMENT is
		external
			"IL signature (System.Drawing.ContentAlignment): System.Drawing.ContentAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateContent"
		end

	on_leave (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnLeave"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.Control"
		alias
			"WndProc"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
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

	on_right_to_left_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnRightToLeftChanged"
		end

	on_style_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnStyleChanged"
		end

	on_tab_index_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnTabIndexChanged"
		end

	frozen rtl_translate_alignment_left_right_alignment (align: SYSTEM_WINDOWS_FORMS_LEFTRIGHTALIGNMENT): SYSTEM_WINDOWS_FORMS_LEFTRIGHTALIGNMENT is
		external
			"IL signature (System.Windows.Forms.LeftRightAlignment): System.Windows.Forms.LeftRightAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateAlignment"
		end

	on_click (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnClick"
		end

	frozen invoke_paint_background (c: SYSTEM_WINDOWS_FORMS_CONTROL; e: SYSTEM_WINDOWS_FORMS_PAINTEVENTARGS) is
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

	process_key_message (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&): System.Boolean use System.Windows.Forms.Control"
		alias
			"ProcessKeyMessage"
		end

	on_notify_message (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
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

	on_parent_fore_color_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentForeColorChanged"
		end

	process_key_preview (m: SYSTEM_WINDOWS_FORMS_MESSAGE): BOOLEAN is
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

	on_drag_leave (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDragLeave"
		end

	frozen rtl_translate_alignment_horizontal_alignment (align: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT): SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT is
		external
			"IL signature (System.Windows.Forms.HorizontalAlignment): System.Windows.Forms.HorizontalAlignment use System.Windows.Forms.Control"
		alias
			"RtlTranslateAlignment"
		end

	on_causes_validation_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnCausesValidationChanged"
		end

	on_drag_drop (drgevent: SYSTEM_WINDOWS_FORMS_DRAGEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.DragEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnDragDrop"
		end

	on_handle_destroyed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnHandleDestroyed"
		end

	frozen set_style (flag: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES; value: BOOLEAN) is
		external
			"IL signature (System.Windows.Forms.ControlStyles, System.Boolean): System.Void use System.Windows.Forms.Control"
		alias
			"SetStyle"
		end

	on_mouse_wheel (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnMouseWheel"
		end

	on_parent_back_color_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentBackColorChanged"
		end

	notify_invalidate (invalidated_area: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Control"
		alias
			"NotifyInvalidate"
		end

	on_mouse_move (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
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

	on_cursor_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnCursorChanged"
		end

	on_key_press (e: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTARGS) is
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

	frozen raise_drag_event (key: ANY; e: SYSTEM_WINDOWS_FORMS_DRAGEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.DragEventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"RaiseDragEvent"
		end

	on_parent_font_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnParentFontChanged"
		end

	get_default_ime_mode: SYSTEM_WINDOWS_FORMS_IMEMODE is
		external
			"IL signature (): System.Windows.Forms.ImeMode use System.Windows.Forms.Control"
		alias
			"get_DefaultImeMode"
		end

	on_system_colors_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnSystemColorsChanged"
		end

	on_tab_stop_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Control"
		alias
			"OnTabStopChanged"
		end

end -- class SYSTEM_WINDOWS_FORMS_CONTROL
