indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ScrollableControl"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_SCROLLABLE_CONTROL

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			scale_core,
			on_mouse_wheel,
			on_layout,
			on_visible_changed,
			get_display_rectangle,
			get_create_params
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
	make_winforms_scrollable_control

feature {NONE} -- Initialization

	frozen make_winforms_scrollable_control is
		external
			"IL creator use System.Windows.Forms.ScrollableControl"
		end

feature -- Access

	frozen get_auto_scroll_min_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ScrollableControl"
		alias
			"get_AutoScrollMinSize"
		end

	frozen get_auto_scroll_margin: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ScrollableControl"
		alias
			"get_AutoScrollMargin"
		end

	get_display_rectangle: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.ScrollableControl"
		alias
			"get_DisplayRectangle"
		end

	frozen get_dock_padding: WINFORMS_DOCK_PADDING_EDGES_IN_WINFORMS_SCROLLABLE_CONTROL is
		external
			"IL signature (): System.Windows.Forms.ScrollableControl+DockPaddingEdges use System.Windows.Forms.ScrollableControl"
		alias
			"get_DockPadding"
		end

	get_auto_scroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ScrollableControl"
		alias
			"get_AutoScroll"
		end

	frozen get_auto_scroll_position: DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.ScrollableControl"
		alias
			"get_AutoScrollPosition"
		end

feature -- Element Change

	frozen set_auto_scroll_position (value: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"set_AutoScrollPosition"
		end

	frozen set_auto_scroll_min_size (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"set_AutoScrollMinSize"
		end

	set_auto_scroll (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"set_AutoScroll"
		end

	frozen set_auto_scroll_margin (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"set_AutoScrollMargin"
		end

feature -- Basic Operations

	frozen scroll_control_into_view (active_control: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"ScrollControlIntoView"
		end

	frozen set_auto_scroll_margin_int32 (x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"SetAutoScrollMargin"
		end

feature {NONE} -- Implementation

	frozen set_vscroll (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"set_VScroll"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ScrollableControl"
		alias
			"get_CreateParams"
		end

	on_mouse_wheel (e: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"OnMouseWheel"
		end

	frozen set_display_rect_location (x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"SetDisplayRectLocation"
		end

	frozen get_hscroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ScrollableControl"
		alias
			"get_HScroll"
		end

	adjust_form_scrollbars (display_scrollbars: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"AdjustFormScrollbars"
		end

	scale_core (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"ScaleCore"
		end

	on_layout (levent: WINFORMS_LAYOUT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.LayoutEventArgs): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"OnLayout"
		end

	frozen set_hscroll (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"set_HScroll"
		end

	frozen get_scroll_state (bit_: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Windows.Forms.ScrollableControl"
		alias
			"GetScrollState"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"WndProc"
		end

	frozen set_scroll_state (bit_: INTEGER; value: BOOLEAN) is
		external
			"IL signature (System.Int32, System.Boolean): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"SetScrollState"
		end

	on_visible_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"OnVisibleChanged"
		end

	frozen get_vscroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ScrollableControl"
		alias
			"get_VScroll"
		end

end -- class WINFORMS_SCROLLABLE_CONTROL
