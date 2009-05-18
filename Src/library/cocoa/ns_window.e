note
	description: "Wrapper for NSWindow."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW

inherit
	NS_OBJECT

	NS_ANIMATION

create
	make_shared,
	init_with_control_rect_style_mask_backing_defer

feature -- Creating Windows

	init_with_control_rect_style_mask_backing_defer (a_rect: NS_RECT; a_style_mask: INTEGER; a_defer: BOOLEAN)
			-- Create a new window
		do
			cocoa_object := window_init_with_control_rect_style_mask_backing_defer (a_rect.item, a_style_mask, a_defer)
		end

feature -- Configuring Windows

feature -- ...

	display
		do
			window_display (cocoa_object)
		end

	is_visible: BOOLEAN
			-- Indicates whether the window is visible onscreen (even when it's obscured by other windows)
		do
			Result := window_is_visible (cocoa_object)
		end

	frame: NS_RECT
		do
			create Result.make
			window_frame (cocoa_object, Result.item)
		end

	set_content_view (a_view: NS_VIEW)
		do
			window_set_content_view (cocoa_object, a_view.cocoa_object)
		end

	set_content_min_size (a_width, a_height: INTEGER)
		do
			window_set_content_min_size (cocoa_object, a_width, a_height)
		end

	set_default_button_cell (a_button_cell: POINTER)
		do
			window_set_default_button_cell (cocoa_object, a_button_cell)
		end

	set_frame (a_rect: NS_RECT)
		do
			window_set_frame (cocoa_object, a_rect.item)
		end

	title: STRING
		local
			c_title: POINTER
		do
			c_title := window_title (cocoa_object)
			if c_title /= {NS_OBJECT}.nil then
				Result := (create {NS_STRING}.make_shared (c_title)).to_string
			else
				create Result.make_empty
			end
		end

	set_title (a_title: STRING_GENERAL)
			--
		do
			window_set_title (cocoa_object, (create {NS_STRING}.make_with_string (a_title)).cocoa_object)
		end

	set_min_size (a_width, a_height: INTEGER)
		do
			window_set_min_size (cocoa_object, a_width, a_height)
		end

	set_shows_resize_indicator (a_flag: BOOLEAN)
		do
			window_set_shows_resize_indicator (cocoa_object, a_flag)
		end

	content_rect_for_frame_rect (a_rect: NS_RECT): NS_RECT
		do
			create Result.make
			window_content_rect_for_frame_rect (cocoa_object, a_rect.item, Result.item)
		end

	frame_rect_for_content_rect (a_rect: NS_RECT): NS_RECT
		do
			create Result.make
			window_frame_rect_for_content_rect (cocoa_object, a_rect.item, Result.item)
		end

	set_delegate (a_delegate: NS_WINDOW_DELEGATE)
			--
		do
			window_set_delegate (cocoa_object, a_delegate.cocoa_object)
		end

	convert_base_to_screen (a_point: NS_POINT): NS_POINT
		do
			create Result.make
			window_convert_base_to_screen (cocoa_object, a_point.item, Result.item)
		end

	set_alpha_value (a_window_alpha: REAL)
		do
			window_set_alpha_value (cocoa_object, a_window_alpha)
		end

	alpha_value: REAL
		do
			Result := window_alpha_value (cocoa_object)
		end

	set_background_color (a_color: NS_COLOR)
		do
			window_set_background_color (cocoa_object, a_color.cocoa_object)
		end

	background_color: NS_COLOR
		do
			create Result.make_shared (window_background_color (cocoa_object))
		end

	set_ignores_mouse_events (a_flag: BOOLEAN)
		do
			window_set_ignores_mouse_events (cocoa_object, a_flag)
		end

	ignores_mouse_events: BOOLEAN
		do
			Result := window_ignores_mouse_events (cocoa_object)
		end

	set_level (a_new_level: INTEGER)
		do
			window_set_level (cocoa_object, a_new_level)
		end

	level: INTEGER
		do
			Result := window_level (cocoa_object)
		end

	screen: NS_SCREEN
		do
			create Result.make_shared (window_screen (cocoa_object))
		end

	deepest_screen: NS_SCREEN
		do
			create Result.make_shared (window_deepest_screen (cocoa_object))
		end

	miniaturize
		do
			window_miniaturize (cocoa_object, nil)
		end

	deminiaturize
		do
			window_deminiaturize (cocoa_object, nil)
		end

	is_zoomed: BOOLEAN
		do
			Result := window_is_zoomed (cocoa_object)
		end

	zoom
		do
			window_zoom (cocoa_object, nil)
		end

	is_miniaturized: BOOLEAN
		do
			Result := window_is_miniaturized (cocoa_object)
		end

	make_key_and_order_front
		do
			window_make_key_and_order_front (cocoa_object, nil)
		end

	order_front
		do
			window_order_front (cocoa_object, nil)
		end

	order_back
		do
			window_order_back (cocoa_object, nil)
		end

	order_out
		do
			window_order_out (cocoa_object, nil)
		end

	order_window_relative_to (a_place: INTEGER; a_other_win: INTEGER)
		do
			window_order_window_relative_to (cocoa_object, a_place, a_other_win)
		end

	order_front_regardless
		do
			window_order_front_regardless (cocoa_object)
		end

feature -- Managing Attached Windows

	add_child_window_ordered (a_child_win: NS_WINDOW; a_place: INTEGER)
		do
			window_add_child_window_ordered (cocoa_object, a_child_win.cocoa_object, a_place)
		end

	remove_child_window (a_child_win: NS_WINDOW)
		do
			window_remove_child_window (cocoa_object, a_child_win.cocoa_object)
		end

	child_windows: NS_ARRAY [NS_WINDOW]
		do
			create Result.make_shared (window_child_windows (cocoa_object))
		end

	parent_window: NS_WINDOW
		do
			create Result.make_shared (window_parent_window (cocoa_object))
		end

	set_parent_window (a_window: NS_WINDOW)
		do
			window_set_parent_window (cocoa_object, a_window.cocoa_object)
		end

feature -- Animation

	animator: NS_WINDOW
		do
			create Result.make_shared (animation_animator (cocoa_object))
		end

feature {NONE} -- Objective-C implementation

	frozen window_init_with_control_rect_style_mask_backing_defer (a_rect: POINTER; a_style_mask: INTEGER; a_defer: BOOLEAN): POINTER
			-- - (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				return [[NSWindow alloc] initWithContentRect: *(NSRect*)$a_rect
				                        styleMask: $a_style_mask
				                        backing: NSBackingStoreBuffered
				                        defer: $a_defer];
			 ]"
		end

	frozen window_content_rect_for_frame_rect (a_window: POINTER; a_rect: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = [(NSWindow*)$a_window contentRectForFrameRect: *(NSRect*)$a_rect];
					memcpy ($a_res, &frame, sizeof(NSRect));
				}
			]"
		end

	frozen window_frame_rect_for_content_rect (a_window: POINTER; a_rect: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = [(NSWindow*)$a_window frameRectForContentRect: *(NSRect*)$a_rect];
					memcpy ($a_res, &frame, sizeof(NSRect));
				}
			]"
		end

	frozen window_display (a_window: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window display];"
		end

	frozen window_frame (a_window: POINTER; a_res: POINTER)
			-- Get the frame.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = [(NSWindow*)$a_window frame];
					memcpy ($a_res, &frame, sizeof(NSRect));
				}
			]"
		end

	frozen window_is_visible (a_window: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window isVisible];"
		end

	frozen window_set_default_button_cell (a_window: POINTER; a_button_cell: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setDefaultButtonCell: $a_button_cell];"
		end

	frozen window_set_content_min_size (a_window: POINTER; a_width, a_height: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setContentMinSize: NSMakeSize($a_width, $a_height)];"
		end

	frozen window_set_content_view (a_window: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setContentView: $a_view];"
		end

	frozen window_set_delegate (a_window: POINTER; a_delegate: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setDelegate: $a_delegate];"
		end

	frozen window_title (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window title];"
		end

	frozen window_set_title (a_window: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setTitle: $a_nsstring];"
		end

	frozen window_set_frame (a_window: POINTER; a_rect: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setFrame: *(NSRect*)$a_rect display: YES];"
		end

	frozen window_set_min_size (a_window: POINTER; a_width, a_height: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setMinSize: NSMakeSize($a_width, $a_height)];"
		end

	frozen window_set_shows_resize_indicator (a_window: POINTER; a_flag: BOOLEAN)
			-- show/hide resize corner (does not affect whether window is resizable)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setShowsResizeIndicator: $a_flag];"
		end

	frozen window_convert_base_to_screen (a_window: POINTER; a_point: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSWindow*)$a_window convertBaseToScreen: *(NSPoint*)$a_point]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen window_set_alpha_value (a_window: POINTER; a_window_alpha: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setAlphaValue: $a_window_alpha];"
		end

	frozen window_alpha_value (a_window: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window alphaValue];"
		end

	frozen window_set_background_color (a_window: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setBackgroundColor: $a_color];"
		end

	frozen window_background_color (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window backgroundColor];"
		end

	frozen window_set_ignores_mouse_events (a_window: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setIgnoresMouseEvents: $a_flag];"
		end

	frozen window_ignores_mouse_events (a_window: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window ignoresMouseEvents];"
		end

	frozen window_set_level (a_window: POINTER; a_new_level: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setLevel: $a_new_level];"
		end

	frozen window_level (a_window: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window level];"
		end

	frozen window_screen (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window screen];"
		end

	frozen window_deepest_screen (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window deepestScreen];"
		end

	frozen window_miniaturize (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window miniaturize: $a_sender];"
		end

	frozen window_deminiaturize (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window deminiaturize: $a_sender];"
		end

	frozen window_is_zoomed (a_window: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window isZoomed];"
		end

	frozen window_zoom (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window zoom: $a_sender];"
		end

	frozen window_is_miniaturized (a_window: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window isMiniaturized];"
		end

	frozen window_make_key_and_order_front (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window makeKeyAndOrderFront: $a_sender];"
		end

	frozen window_order_front (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderFront: $a_sender];"
		end

	frozen window_order_back (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderBack: $a_sender];"
		end

	frozen window_order_out (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderOut: $a_sender];"
		end

	frozen window_order_window_relative_to (a_window: POINTER; a_place: INTEGER; a_other_win: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderWindow: $a_place relativeTo: $a_other_win];"
		end

	frozen window_order_front_regardless (a_window: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderFrontRegardless];"
		end

	frozen window_add_child_window_ordered (a_window: POINTER; a_child_win: POINTER; a_place: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window addChildWindow: $a_child_win ordered: $a_place];"
		end

	frozen window_remove_child_window (a_window: POINTER; a_child_win: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window removeChildWindow: $a_child_win];"
		end

	frozen window_child_windows (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window childWindows];"
		end

	frozen window_parent_window (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window parentWindow];"
		end

	frozen window_set_parent_window (a_target: POINTER; a_window: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_target setParentWindow: $a_window];"
		end

feature -- Style Mask Constants

	frozen borderless_window_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSBorderlessWindowMask;"
		end

	frozen titled_window_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSTitledWindowMask;"
		end

	frozen closable_window_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSTitledWindowMask;"
		end

	frozen miniaturizable_window_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSMiniaturizableWindowMask;"
		end

	frozen resizable_window_mask: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSResizableWindowMask;"
		end

feature -- Window Levels

	frozen floating_window_level: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSFloatingWindowLevel"
		end

feature -- Window Ordering Mode

	frozen window_above: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowAbove"
		end

	frozen window_below: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowBelow"
		end

	frozen window_out: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowOut"
		end
end
