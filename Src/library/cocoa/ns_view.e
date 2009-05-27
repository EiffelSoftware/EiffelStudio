indexing
	description: "Wrapper for NSView. An Eiffel abstraction for a Cocoa widget"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VIEW

inherit
	NS_RESPONDER

	OBJECTIVE_C
		export
			{NONE} all
		end

create
	make,
	make_custom,
	make_flipped
create {NS_OBJECT}
	make_shared

feature {NONE} -- Creation and Initialization

	make
		do
			make_shared (view_new)
		end

	make_custom (a_draw_action: PROCEDURE [ANY, TUPLE])
			-- Create an NSView which calls the passed draw_action when drawRect: is invoked
			-- require: target has been set up
		do
			draw_action := a_draw_action
			make_shared (custom_view_new ($current, $draw))
		end

	make_flipped
			-- Create an NSView with flipped coordinates (i.e. redefine the isFlipped method to return True)
		local
			l_superclass: POINTER
			l_name: POINTER
			l_class: POINTER
			l_types: POINTER
			l_sel: POINTER
			l_imp: POINTER
		do
			l_class := objc_get_class ((create {C_STRING}.make ("FlippedView")).item)
			if l_class = {NS_OBJECT}.nil then
				-- If FlippedView doesn't exist yet create it as a new child class of NSView and override isFlipped
				l_superclass := objc_get_class ((create {C_STRING}.make ("NSView")).item)
				l_name := (create {C_STRING}.make ("FlippedView")).item
				l_class := objc_allocate_class_pair (l_superclass, l_name, 0)

				l_types := (create {C_STRING}.make ("b@:")).item
				l_sel := sel_register_name ((create {C_STRING}.make ("isFlipped")).item)
				l_imp := class_get_method_implementation(objc_get_class ((create {C_STRING}.make ("CustomView")).item), l_sel)
				class_add_method (l_class, l_sel, l_imp, l_types)

				objc_register_class_pair (l_class)
			end
			make_shared (class_create_instance (l_class, 0))
			view_init (item)
		end

feature -- Managing the View Hierarchy

	window: NS_WINDOW
			-- Returns the receiver's window object, or void if it has none.
		local
			l_window: POINTER
		do
			l_window := view_window (item)
			if l_window /= nil then
				create Result.make_shared (l_window)
			end
		end

	superview: NS_VIEW
			-- Returns the receiver's superview, or nil if it has none.
			-- When applying this method iteratively or recursively, be sure to compare the returned view object to the content view of the window to avoid proceeding out of the view hierarchy.
		do
			create Result.make_shared (view_superview (item))
		end

	subviews: NS_ARRAY [NS_VIEW]
			-- Return the receiver's immediate subviews.
		do
			create Result.make_shared (view_subviews (item))
		end

	is_descendant_of (a_view: NS_VIEW): BOOLEAN
			-- Returns True if the receiver is a subview of a given view or if it's identical to that view; otherwise, it returns False.
		do
			Result := view_is_descendant_of (item, a_view.item)
		end

	ancestor_shared_with_view (a_view: NS_VIEW): NS_VIEW
			-- Returns the closest ancestor shared by the receiver and a given view.
			-- The closest ancestor or nil if there's no such object. Returns self if `a_view' is identical to the receiver.
		do
			create Result.make_shared (view_ancestor_shared_with_view (item, a_view.item))
		end

	add_subview (a_subview: NS_VIEW)
			-- Adds a view to the receiver's subviews so it's displayed above its siblings.
		do
			view_add_subview (item, a_subview.item)
		end

feature -- Modifying the Frame Rectangle

	set_frame (a_rect: NS_RECT)
			-- Sets the receiver's frame rectangle to the specified rectangle.
		do
			view_set_frame (item, a_rect.item)
		end

	frame: NS_RECT
			-- Returns the receiver's frame rectangle, which defines its position in its superview.
			-- The frame rectangle may be rotated; use the frame_rotation method to check this.
		do
			create Result.make
			view_frame (item, Result.item)
		end

feature -- Modifying the Bounds Rectangle

	set_bounds (a_rect: NS_RECT)
			-- Sets the receiver's bounds rectangle.
		do
			view_set_bounds (item, a_rect.item)
		end

	bounds: NS_RECT
			-- Returns the receiver's bounds rectangle, which expresses its location and size in its own coordinate system.
		do
			create Result.make
			view_bounds (item, Result.item)
		end

	set_bounds_origin (a_new_origin: NS_POINT)
		do
			view_set_bounds_origin (item, a_new_origin.item)
		end

	set_bounds_size (a_new_size: NS_SIZE)
		do
			view_set_bounds_size (item, a_new_size.item)
		end

	set_bounds_rotation (a_angle: REAL)
		do
			view_set_bounds_rotation (item, a_angle)
		end

	bounds_rotation: REAL
		do
			Result := view_bounds_rotation (item)
		end

feature -- Modifying the Coordinate System

	display
		do
			view_display (item)
		end

	set_needs_display (a_flag: BOOLEAN)
		do
			view_set_needs_display (item, a_flag)
		end

	set_hidden (a_flag: BOOLEAN)
		do
			view_set_hidden (item, a_flag)
		end

	is_hidden : BOOLEAN
		do
			Result := view_is_hidden (item)
		end

	is_flipped : BOOLEAN
		do
			Result := view_is_flipped (item)
		end

	remove_from_superview
		do
			view_remove_from_superview (item)
		end

	convert_point_to_base (a_point: NS_POINT): NS_POINT
		do
			create Result.make
			view_convert_point_to_base (item, a_point.item, Result.item)
		end

	convert_point_to_view (a_point: NS_POINT; a_view: NS_VIEW): NS_POINT
		local
			l_view: POINTER
		do
			create Result.make
			if a_view /= void then
				l_view := a_view.item
			else
				l_view := nil
			end
			view_convert_point_to_view (item, a_point.item, l_view, Result.item)
		end

feature {NONE} -- callback

	draw (x, y, w, h: INTEGER)
		do
			draw_action.call([])
		end

	draw_action: PROCEDURE [ANY, TUPLE]

feature {NONE} -- Objective-C interface

	frozen view_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSView new];"
		end

	frozen custom_view_new (a_object, a_method: POINTER): POINTER
		external
			"C inline use %"custom_view.h%""
		alias
			"return [[CustomView new] initWithCallbackObject: $a_object andMethod: $a_method];"
		end

	frozen view_init (a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view init];"
		end

	frozen view_superview (a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view superview];"
		end

	frozen view_set_frame (a_view: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setFrame: *(NSRect*)$a_res];"
		end

	frozen view_frame (a_view: POINTER; a_res: POINTER)
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

	frozen view_add_subview (a_view: POINTER; a_subview: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view addSubview: $a_subview];"
		end

	frozen view_set_autoresize (a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];"
		end

	frozen view_set_hidden (a_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setHidden: $a_flag];"
		end

	frozen view_is_hidden (a_view: POINTER) : BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view isHidden];"
		end

	frozen view_is_flipped (a_view: POINTER) : BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view isFlipped];"
		end

	frozen view_remove_from_superview (a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view removeFromSuperview];"
		end

	frozen view_display (a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view display];"
		end

	frozen view_set_needs_display (a_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setNeedsDisplay: $a_flag];"
		end

	frozen view_convert_point_to_base (a_view: POINTER; a_point: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSView*)$a_view convertPointToBase: *(NSPoint*)$a_point]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen view_convert_point_to_view (a_view: POINTER; a_point: POINTER; a_to_view: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSView*)$a_view convertPoint: *(NSPoint*)$a_point toView: $a_to_view]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen view_set_bounds_origin (a_view: POINTER; a_new_origin: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setBoundsOrigin: *(NSPoint*)$a_new_origin];"
		end

	frozen view_set_bounds_size (a_view: POINTER; a_new_size: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setBoundsSize: *(NSSize*)$a_new_size];"
		end

	frozen view_set_bounds_rotation (a_view: POINTER; a_angle: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setBoundsRotation: $a_angle];"
		end

	frozen view_bounds_rotation (a_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view boundsRotation];"
		end

	frozen view_set_bounds (a_view: POINTER; a_rect: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSView*)$a_view setBounds: *(NSRect*)$a_rect];"
		end

	frozen view_bounds (a_view: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect frame = [(NSView*)$a_view bounds];   memcpy($a_res, &frame, sizeof(NSRect));"
		end

	frozen view_window (a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view window];"
		end

	frozen view_subviews (a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view subviews];"
		end

	frozen view_is_descendant_of (a_target: POINTER; a_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_target isDescendantOf: $a_view];"
		end

	frozen view_ancestor_shared_with_view (a_target: POINTER; a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_target ancestorSharedWithView: $a_view];"
		end

	frozen view_opaque_ancestor (a_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSView*)$a_view opaqueAncestor];"
		end
end
