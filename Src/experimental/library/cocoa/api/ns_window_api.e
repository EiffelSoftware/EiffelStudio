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
				return [(id)$target initWithContentRect: *(NSRect*)$a_rect
				                        styleMask: $a_style_mask
				                        backing: NSBackingStoreBuffered
				                        defer: $a_defer];
			 ]"
		end

feature -- Configuring Windows

	frozen style_mask (a_ns_window: POINTER): NATURAL
			-- - (NSUInteger)styleMask
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window styleMask];"
		end

	frozen set_style_mask (a_ns_window: POINTER; a_style_mask: NATURAL)
			-- - (void)setStyleMask: (NSUInteger) styleMask
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setStyleMask: $a_style_mask];"
		end

	frozen works_when_modal (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)worksWhenModal
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window worksWhenModal];"
		end

	frozen alpha_value (a_ns_window: POINTER): REAL
			-- - (CGFloat)alphaValue
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window alphaValue];"
		end

	frozen set_alpha_value (a_ns_window: POINTER; a_window_alpha: REAL)
			-- - (void)setAlphaValue: (CGFloat) windowAlpha
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setAlphaValue: $a_window_alpha];"
		end

	frozen background_color (a_ns_window: POINTER): POINTER
			-- - (NSColor *)backgroundColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window backgroundColor];"
		end

	frozen set_background_color (a_ns_window: POINTER; a_color: POINTER)
			-- - (void)setBackgroundColor: (NSColor *) color
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setBackgroundColor: $a_color];"
		end

	frozen color_space (a_ns_window: POINTER): POINTER
			-- - (NSColorSpace *)colorSpace
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window colorSpace];"
		end

	frozen set_color_space (a_ns_window: POINTER; a_color_space: POINTER)
			-- - (void)setColorSpace: (NSColorSpace *) colorSpace
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setColorSpace: $a_color_space];"
		end

	frozen content_view (a_ns_window: POINTER): POINTER
			-- - (id)contentView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window contentView];"
		end

	frozen set_content_view (a_ns_window: POINTER; a_view: POINTER)
			-- - (void)setContentView: (NSView *) aView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setContentView: $a_view];"
		end

	frozen can_hide (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)canHide
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window canHide];"
		end

	frozen set_can_hide (a_ns_window: POINTER; a_flag: BOOLEAN)
			-- - (void)setCanHide: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setCanHide: $a_flag];"
		end

	frozen is_on_active_space (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)isOnActiveSpace
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window isOnActiveSpace];"
		end

	frozen hides_on_deactivate (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)hidesOnDeactivate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window hidesOnDeactivate];"
		end

	frozen set_hides_on_deactivate (a_ns_window: POINTER; a_flag: BOOLEAN)
			-- - (void)setHidesOnDeactivate: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setHidesOnDeactivate: $a_flag];"
		end

	frozen collection_behavior (a_ns_window: POINTER): NATURAL
			-- - (NSWindowCollectionBehavior)collectionBehavior
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window collectionBehavior];"
		end

	frozen set_collection_behavior (a_ns_window: POINTER; a_behavior: NATURAL)
			-- - (void)setCollectionBehavior: (NSWindowCollectionBehavior) behavior
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setCollectionBehavior: $a_behavior];"
		end

	frozen is_opaque (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)isOpaque
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window isOpaque];"
		end

	frozen set_opaque (a_ns_window: POINTER; a_is_opaque: BOOLEAN)
			-- - (void)setOpaque: (BOOL) isOpaque
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setOpaque: $a_is_opaque];"
		end

	frozen has_shadow (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)hasShadow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window hasShadow];"
		end

	frozen set_has_shadow (a_ns_window: POINTER; a_has_shadow: BOOLEAN)
			-- - (void)setHasShadow: (BOOL) hasShadow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setHasShadow: $a_has_shadow];"
		end

	frozen invalidate_shadow (a_ns_window: POINTER)
			-- - (void)invalidateShadow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window invalidateShadow];"
		end

--	frozen autorecalculates_content_border_thickness_for_edge (a_ns_window: POINTER; a_edge: POINTER): BOOLEAN
--			-- - (BOOL)autorecalculatesContentBorderThicknessForEdge: (NSRectEdge) edge
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSWindow*)$a_ns_window autorecalculatesContentBorderThicknessForEdge: *(NSRectEdge*)$a_edge];"
--		end

--	frozen set_autorecalculates_content_border_thickness_for_edge (a_ns_window: POINTER; a_flag: BOOLEAN; a_edge: POINTER)
--			-- - (void)setAutorecalculatesContentBorderThickness: (BOOL) flag forEdge: (NSRectEdge) edge
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSWindow*)$a_ns_window setAutorecalculatesContentBorderThickness: $a_flag forEdge: *(NSRectEdge*)$a_edge];"
--		end

--	frozen content_border_thickness_for_edge (a_ns_window: POINTER; a_edge: POINTER): REAL
--			-- - (CGFloat)contentBorderThicknessForEdge: (NSRectEdge) edge
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSWindow*)$a_ns_window contentBorderThicknessForEdge: *(NSRectEdge*)$a_edge];"
--		end

--	frozen set_content_border_thickness_for_edge (a_ns_window: POINTER; a_thickness: REAL; a_edge: POINTER)
--			-- - (void)setContentBorderThickness: (CGFloat) thickness forEdge: (NSRectEdge) edge
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSWindow*)$a_ns_window setContentBorderThickness: $a_thickness forEdge: *(NSRectEdge*)$a_edge];"
--		end

	frozen prevents_application_termination_when_modal (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)preventsApplicationTerminationWhenModal
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window preventsApplicationTerminationWhenModal];"
		end

	frozen set_prevents_application_termination_when_modal (a_ns_window: POINTER; a_flag: BOOLEAN)
			-- - (void)setPreventsApplicationTerminationWhenModal: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setPreventsApplicationTerminationWhenModal: $a_flag];"
		end

	frozen set_delegate (a_window: POINTER; a_delegate: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_window setDelegate: $a_delegate];"
		end

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

	frozen is_key_window (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)isKeyWindow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window isKeyWindow];"
		end

	frozen can_become_key_window (a_ns_window: POINTER): BOOLEAN
			-- - (BOOL)canBecomeKeyWindow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window canBecomeKeyWindow];"
		end

	frozen make_key_window (a_ns_window: POINTER)
			-- - (void)makeKeyWindow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window makeKeyWindow];"
		end

	frozen make_key_and_order_front (a_ns_window: POINTER; a_sender: POINTER)
			-- - (void)makeKeyAndOrderFront: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window makeKeyAndOrderFront: $a_sender];"
		end

	frozen become_key_window (a_ns_window: POINTER)
			-- - (void)becomeKeyWindow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window becomeKeyWindow];"
		end

	frozen resign_key_window (a_ns_window: POINTER)
			-- - (void)resignKeyWindow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window resignKeyWindow];"
		end

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

	frozen initial_first_responder (a_ns_window: POINTER): POINTER
			-- - (NSView *)initialFirstResponder
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window initialFirstResponder];"
		end

	frozen first_responder (a_ns_window: POINTER): POINTER
			-- - (NSResponder *)firstResponder
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window firstResponder];"
		end

	frozen set_initial_first_responder (a_ns_window: POINTER; a_view: POINTER)
			-- - (void)setInitialFirstResponder: (NSView *) view
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSWindow*)$a_ns_window setInitialFirstResponder: $a_view];"
		end

	frozen make_first_responder (a_ns_window: POINTER; a_responder: POINTER): BOOLEAN
			-- - (BOOL)makeFirstResponder: (NSResponder *) aResponder
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSWindow*)$a_ns_window makeFirstResponder: $a_responder];"
		end

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
