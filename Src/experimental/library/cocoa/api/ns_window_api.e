note
	description: "Summary description for {NS_WINDOW_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW_API

feature -- Creating Windows

	frozen alloc: POINTER
			-- + (id)alloc
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSWindow alloc];"
		end


	frozen init_with_control_rect_style_mask_backing_defer (target: POINTER; a_rect: POINTER; a_style_mask: NATURAL; a_defer: BOOLEAN): POINTER
			-- - (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				return (EIF_POINTER)[$target initWithContentRect: *(NSRect*)$a_rect
				                        styleMask: $a_style_mask
				                        backing: NSBackingStoreBuffered
				                        defer: $a_defer];
			 ]"
		end

feature -- Configuring Windows



feature -- Creating Windows

feature -- Configuring Windows

feature -- Accessing Window Information

feature -- Getting Layout Information

	frozen content_rect_for_frame_rect (a_window: POINTER; a_rect: POINTER; a_res: POINTER)
			-- - (NSRect)contentRectForFrameRect:(NSRect)windowFrame
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

	frozen frame_rect_for_content_rect (a_window: POINTER; a_rect: POINTER; a_res: POINTER)
			-- - (NSRect)frameRectForContentRect:(NSRect)windowContent
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

feature -- Managing Windows

feature -- Managing Sheets

feature -- Sizing

	frozen frame (a_window: POINTER; a_res: POINTER)
			-- - (NSRect)frame
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

	frozen set_frame (a_window: POINTER; a_rect: POINTER; a_display: BOOLEAN)
			-- - (void)setFrame:(NSRect)windowFrame display:(BOOL)displayViews
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setFrame: *(NSRect*)$a_rect display: $a_display];"
		end

	frozen set_frame_top_left_point (a_window: POINTER; a_point: POINTER)
			-- - (void)setFrameTopLeftPoint:(NSPoint)point
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setFrameTopLeftPoint: *(NSPoint*)$a_point];"
		end

feature -- Sizing Content

	frozen set_content_min_size (a_window: POINTER; a_width, a_height: INTEGER)
			-- - (void)setContentMaxSize:(NSSize)contentMaxSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setContentMinSize: NSMakeSize($a_width, $a_height)];"
		end

feature -- Managing Window Layers

	frozen is_visible (a_window: POINTER): BOOLEAN
			-- - (BOOL)isVisible
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window isVisible];"
		end

feature -- Managing Window Frames in User Defaults

feature -- Managing Key Status

feature -- Managing Main Status

feature -- Managing Toolbars

feature -- Managing Attached Windows

feature -- Managing Window Buffers

feature -- Managing Default Buttons

	frozen default_button_cell (a_window: POINTER): POINTER
			--- (NSButtonCell *)defaultButtonCell
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window defaultButtonCell];"
		end

	frozen set_default_button_cell (a_window: POINTER; a_button_cell: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setDefaultButtonCell: $a_button_cell];"
		end

feature -- Managing Field Editors

feature -- Managing the Window Menu

feature -- Managing Cursor Rectangles

feature -- Managing Title Bars

	frozen standdard_window_button (a_window: POINTER; a_window_button_kind: INTEGER): POINTER
			-- - (NSButton *)standardWindowButton:(NSWindowButton)windowButtonKind
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window standardWindowButton: $a_window_button_kind];"
		end

feature -- Managing Tooltips

feature -- Handling Events

feature -- Managing Responders

feature -- Managing the Key View Loop

feature -- Handling Keyboard Events

feature -- Handling Mouse Events

	frozen set_accepts_mouse_moved_events (a_application: POINTER; a_flag: BOOLEAN)
			-- - (void)setAcceptsMouseMovedEvents:(BOOL)acceptMouseMovedEvents
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_application setAcceptsMouseMovedEvents: $a_flag];"
		end

	frozen accepts_mouse_moved_events (a_application: POINTER): BOOLEAN
			-- - (BOOL)acceptsMouseMovedEvents
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_application acceptsMouseMovedEvents];"
		end

feature -- Bracketing Drawing Operations

feature -- Drawing Windows

	frozen display (a_window: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window display];"
		end

feature -- Updating Windows

feature -- Exposing Windows

feature -- Dragging

feature -- Converting Coordinates

feature -- Getting the Undo Manager

feature -- Accessing Edited Status

feature -- Managing Titles

	frozen title (a_window: POINTER): POINTER
			-- - (NSString *)title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window title];"
		end

	frozen set_title (a_window: POINTER; a_nsstring: POINTER)
			-- - (void)setTitle:(NSString *)title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setTitle: $a_nsstring];"
		end

feature -- Accessing Screen Information

feature -- Moving

feature -- Closing Windows

feature -- Minimizing Windows

feature -- Getting the Dock Tile

feature -- Printing

feature -- Providing Services

feature -- Working with Carbon

	frozen set_content_view (a_window: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setContentView: $a_view];"
		end

	frozen content_view (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window contentView];"
		end

	frozen set_delegate (a_window: POINTER; a_delegate: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setDelegate: $a_delegate];"
		end

	frozen set_min_size (a_window: POINTER; a_width, a_height: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setMinSize: NSMakeSize($a_width, $a_height)];"
		end

	frozen set_shows_resize_indicator (a_window: POINTER; a_flag: BOOLEAN)
			-- show/hide resize corner (does not affect whether window is resizable)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setShowsResizeIndicator: $a_flag];"
		end

	frozen convert_base_to_screen (a_window: POINTER; a_point: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSWindow*)$a_window convertBaseToScreen: *(NSPoint*)$a_point]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen set_alpha_value (a_window: POINTER; a_alpha: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setAlphaValue: $a_alpha];"
		end

	frozen alpha_value (a_window: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window alphaValue];"
		end

	frozen set_background_color (a_window: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setBackgroundColor: $a_color];"
		end

	frozen background_color (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window backgroundColor];"
		end

	frozen set_ignores_mouse_events (a_window: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setIgnoresMouseEvents: $a_flag];"
		end

	frozen ignores_mouse_events (a_window: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window ignoresMouseEvents];"
		end

	frozen set_level (a_window: POINTER; a_new_level: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setLevel: $a_new_level];"
		end

	frozen level (a_window: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window level];"
		end

	frozen screen (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window screen];"
		end

	frozen deepest_screen (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window deepestScreen];"
		end

	frozen miniaturize (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window miniaturize: $a_sender];"
		end

	frozen deminiaturize (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window deminiaturize: $a_sender];"
		end

	frozen is_zoomed (a_window: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window isZoomed];"
		end

	frozen zoom (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window zoom: $a_sender];"
		end

	frozen is_miniaturized (a_window: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window isMiniaturized];"
		end

	frozen make_key_and_order_front (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window makeKeyAndOrderFront: $a_sender];"
		end

	frozen order_front (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderFront: $a_sender];"
		end

	frozen order_back (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderBack: $a_sender];"
		end

	frozen order_out (a_window: POINTER; a_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderOut: $a_sender];"
		end

	frozen order_window_relative_to (a_window: POINTER; a_place: INTEGER; a_other_win: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderWindow: $a_place relativeTo: $a_other_win];"
		end

	frozen order_front_regardless (a_window: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window orderFrontRegardless];"
		end

	frozen add_child_window_ordered (a_window: POINTER; a_child_win: POINTER; a_place: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window addChildWindow: $a_child_win ordered: $a_place];"
		end

	frozen remove_child_window (a_window: POINTER; a_child_win: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window removeChildWindow: $a_child_win];"
		end

	frozen child_windows (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window childWindows];"
		end

	frozen parent_window (a_window: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_window parentWindow];"
		end

	frozen set_parent_window (a_target: POINTER; a_window: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_target setParentWindow: $a_window];"
		end

end
