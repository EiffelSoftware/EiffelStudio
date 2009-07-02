note
	description: "Summary description for {NS_VIEW_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VIEW_API

feature -- Creating Instances

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSView new];"
		end

	frozen custom_new (a_object, a_method: POINTER): POINTER
		external
			"C inline use %"custom_view.h%""
		alias
			"return [[CustomView new] initWithCallbackObject: $a_object andMethod: $a_method];"
		end

	frozen init (a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view init];"
		end

feature -- Managing the View Hierarchy

	frozen superview (a_view: POINTER): POINTER
			-- - (NSView *)superview
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view superview];"
		end

	frozen add_subview (a_view: POINTER; a_subview: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view addSubview: $a_subview];"
		end

	frozen window (a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view window];"
		end

	frozen subviews (a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view subviews];"
		end

	frozen is_descendant_of (a_target: POINTER; a_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_target isDescendantOf: $a_view];"
		end

	frozen ancestor_shared_with_view (a_target: POINTER; a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_target ancestorSharedWithView: $a_view];"
		end

	frozen opaque_ancestor (a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view opaqueAncestor];"
		end

feature -- Modifying the Frame Rectangle

	frozen set_frame (a_view: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setFrame: *(NSRect*)$a_res];"
		end

	frozen frame (a_view: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = [(NSView*)$a_view frame];
					memcpy($a_res, &frame, sizeof(NSRect));
				}
			]"
		end

	frozen set_autoresize (a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];"
		end

	frozen set_hidden (a_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setHidden: $a_flag];"
		end

	frozen is_hidden (a_view: POINTER) : BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view isHidden];"
		end

	frozen is_flipped (a_view: POINTER) : BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view isFlipped];"
		end

	frozen remove_from_superview (a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view removeFromSuperview];"
		end

feature -- Focusing

	frozen lock_focus (a_view: POINTER)
			-- - (void)lockFocus
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view lockFocus];"
		end

	frozen lock_focus_if_can_draw (a_view: POINTER): BOOLEAN
			-- - (BOOL)lockFocusIfCanDraw
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view lockFocusIfCanDraw];"
		end

	frozen unlock_focus (a_view: POINTER)
			-- - (void)unlockFocus
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view unlockFocus];"
		end

feature -- Displaying

	frozen display (a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view display];"
		end

	frozen set_needs_display (a_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setNeedsDisplay: $a_flag];"
		end

	frozen convert_point_to_base (a_view: POINTER; a_point: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSView*)$a_view convertPointToBase: *(NSPoint*)$a_point]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen convert_point_to_view (a_view: POINTER; a_point: POINTER; a_to_view: POINTER; res: POINTER)
			-- - (NSPoint)convertPoint:(NSPoint)aPoint toView:(NSView *)aView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSView*)$a_view convertPoint: *(NSPoint*)$a_point toView: $a_to_view]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen set_bounds_origin (a_view: POINTER; a_new_origin: POINTER)
			-- - (void)setBoundsOrigin:(NSPoint)newOrigin
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setBoundsOrigin: *(NSPoint*)$a_new_origin];"
		end

	frozen set_bounds_size (a_view: POINTER; a_new_size: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setBoundsSize: *(NSSize*)$a_new_size];"
		end

	frozen set_bounds_rotation (a_view: POINTER; a_angle: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setBoundsRotation: $a_angle];"
		end

	frozen bounds_rotation (a_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view boundsRotation];"
		end

	frozen set_bounds (a_view: POINTER; a_rect: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setBounds: *(NSRect*)$a_rect];"
		end

	frozen bounds (a_view: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect frame = [(NSView*)$a_view bounds]; memcpy($a_res, &frame, sizeof(NSRect));"
		end

feature -- Drawing

	frozen visible_rect (a_view: POINTER; a_res: POINTER)
			-- - (NSRect)visibleRect
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect frame = [(NSView*)$a_view visibleRect]; memcpy($a_res, &frame, sizeof(NSRect));"
		end

feature -- Tool Tips

	frozen set_tool_tip (a_view: POINTER; a_string: POINTER)
			-- - (void)setToolTip: (NSString *) string
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setToolTip: $a_string];"
		end

	frozen tool_tip (a_view: POINTER): POINTER
			-- - (NSString *)toolTip
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view toolTip];"
		end

	frozen add_tool_tip_rect_owner_user_data (a_view: POINTER; a_rect: POINTER; a_an_object: POINTER; a_data: POINTER): INTEGER
			-- - (NSToolTipTag)addToolTipRect: (NSRect) aRect owner: anObject userData: data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view addToolTipRect: *(NSRect*)$a_rect owner: $a_an_object userData: $a_data];"
		end

	frozen remove_tool_tip (a_view: POINTER; a_tag: INTEGER)
			-- - (void)removeToolTip: (NSToolTipTag) tag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view removeToolTip: $a_tag];"
		end

	frozen remove_all_tool_tips (a_view: POINTER)
			-- - (void)removeAllToolTips
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view removeAllToolTips];"
		end

feature -- Managing Cursor Tracking

	frozen add_cursor_rect_cursor (a_view: POINTER; a_rect: POINTER; a_an_obj: POINTER)
			-- - (void)addCursorRect: (NSRect) aRect cursor: anObj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view addCursorRect: *(NSRect*)$a_rect cursor: (NSCursor *)$a_an_obj];"
		end

	frozen remove_cursor_rect_cursor (a_view: POINTER; a_rect: POINTER; a_an_obj: POINTER)
			-- - (void)removeCursorRect: (NSRect) aRect cursor: anObj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view removeCursorRect: *(NSRect*)$a_rect cursor: (NSCursor*)$a_an_obj];"
		end

	frozen discard_cursor_rects (a_view: POINTER)
			-- - (void)discardCursorRects
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view discardCursorRects];"
		end

	frozen reset_cursor_rects (a_view: POINTER)
			-- - (void)resetCursorRects
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view resetCursorRects];"
		end

feature -- Event Handling

	frozen hit_test (a_view: POINTER; a_point: POINTER): POINTER
			-- - (NSView *)hitTest:(NSPoint)aPoint
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view hitTest: *(NSPoint*)$a_point];"
		end

end
