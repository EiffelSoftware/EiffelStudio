note
	description: "Wrapper for NSWindow."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW

inherit
	NS_OBJECT

create
	init_with_control_rect_style_mask_backing_defer

feature -- Box

	init_with_control_rect_style_mask_backing_defer (x, y, w, h: INTEGER; a_style_mask: INTEGER; a_defer: BOOLEAN)
			-- Create a new window
		do
			cocoa_object := window_init_with_control_rect_style_mask_backing_defer (x, y, w, h, a_style_mask, a_defer)
		end

	display
		do
			window_display (cocoa_object)
		end

	is_visible: BOOLEAN
			-- Indicates whether the window is visible onscreen (even when it's obscured by other windows)
		do
			Result := window_is_visible (cocoa_object)
		end

	make_key_and_order_front (a_sender: POINTER)
		do
			window_make_key_and_order_front (cocoa_object, a_sender)
		end


	frame: NS_RECT
			--
		do
			create Result.make
			window_frame (cocoa_object, Result.item)
		end

	order_out (a_sender: POINTER)
		do
			window_order_out (cocoa_object, a_sender)
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

	set_frame (a_x, a_y, a_w, a_h: INTEGER)
			--
		do
			window_set_frame (cocoa_object, a_x, a_y, a_w, a_h)
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

feature {NONE} -- Objective-C implementation

	frozen window_init_with_control_rect_style_mask_backing_defer (x, y, w, h: INTEGER; a_style_mask: INTEGER; a_defer: BOOLEAN): POINTER
			-- - (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				return [[NSWindow alloc] initWithContentRect: NSMakeRect($x, $y, $w, $h)
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

	frozen window_set_title (a_window: POINTER; a_nsstring: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setTitle: $a_nsstring];"
		end

	frozen window_set_frame (a_window: POINTER; a_x, a_y, a_w, a_h: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = NSMakeRect($a_x, $a_y, $a_w, $a_h);
					[(NSWindow*)$a_window setFrame: frame display: YES];
				}
			]"
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

	frozen window_make_key_and_order_front (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window makeKeyAndOrderFront: $a_sender];"
		end

	frozen window_order_out (a_window: POINTER; a_sender: POINTER)
			-- - (void)orderOut:(id)sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderOut: $a_sender];"
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
end
