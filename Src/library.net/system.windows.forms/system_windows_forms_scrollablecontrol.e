indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ScrollableControl"

external class
	SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL

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
			on_mouse_wheel,
			on_layout,
			on_visible_changed,
			get_display_rectangle,
			get_create_params
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_scrollablecontrol

feature {NONE} -- Initialization

	frozen make_scrollablecontrol is
		external
			"IL creator use System.Windows.Forms.ScrollableControl"
		end

feature -- Access

	frozen get_auto_scroll_min_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ScrollableControl"
		alias
			"get_AutoScrollMinSize"
		end

	frozen get_auto_scroll_margin: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ScrollableControl"
		alias
			"get_AutoScrollMargin"
		end

	get_display_rectangle: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.ScrollableControl"
		alias
			"get_DisplayRectangle"
		end

	frozen get_dock_padding: DOCKPADDINGEDGES_IN_SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL is
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

	frozen get_auto_scroll_position: SYSTEM_DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.ScrollableControl"
		alias
			"get_AutoScrollPosition"
		end

feature -- Element Change

	frozen set_auto_scroll_position (value: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"set_AutoScrollPosition"
		end

	frozen set_auto_scroll_min_size (value: SYSTEM_DRAWING_SIZE) is
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

	frozen set_auto_scroll_margin (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"set_AutoScrollMargin"
		end

feature -- Basic Operations

	frozen scroll_control_into_view (active_control: SYSTEM_WINDOWS_FORMS_CONTROL) is
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

	on_mouse_wheel (e: SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"OnMouseWheel"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ScrollableControl"
		alias
			"get_CreateParams"
		end

	frozen get_hscroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ScrollableControl"
		alias
			"get_HScroll"
		end

	frozen get_scroll_state (bit_: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Windows.Forms.ScrollableControl"
		alias
			"GetScrollState"
		end

	adjust_form_scrollbars (display_scrollbars: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"AdjustFormScrollbars"
		end

	on_layout (levent: SYSTEM_WINDOWS_FORMS_LAYOUTEVENTARGS) is
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

	frozen set_display_rect_location (x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Windows.Forms.ScrollableControl"
		alias
			"SetDisplayRectLocation"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
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

	on_visible_changed (e: SYSTEM_EVENTARGS) is
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

end -- class SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL
