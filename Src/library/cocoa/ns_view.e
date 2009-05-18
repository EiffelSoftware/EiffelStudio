indexing
	description: "An Eiffel abstraction for a Cocoa widget"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VIEW

inherit
	NS_OBJECT

create
	make_shared,
	new,
	new_custom

feature -- Creation and Initialization

	new
		do
			cocoa_object := view_new
		end

	new_custom (a_draw_action: PROCEDURE [ANY, TUPLE])
			-- require: target has been set up
		do
			draw_action := a_draw_action
			cocoa_object := custom_view_new ($current, $draw)
		end

	init
		do
			view_init (cocoa_object)
		end

feature -- Managing the View Hierarchy

	window: NS_WINDOW
		do
			create Result.make_shared (view_window (cocoa_object))
		end

	superview: NS_VIEW
		do
			create Result.make_shared (view_superview (cocoa_object))
		end

	subviews: NS_ARRAY [NS_VIEW]
		do
			create Result.make_shared (view_subviews (cocoa_object))
		end

	is_descendant_of (a_view: NS_VIEW): BOOLEAN
		do
			Result := view_is_descendant_of (cocoa_object, a_view.cocoa_object)
		end

	ancestor_shared_with_view (a_view: NS_VIEW): NS_VIEW
		do
			create Result.make_shared (view_ancestor_shared_with_view (cocoa_object, a_view.cocoa_object))
		end

	add_subview (a_subview: NS_VIEW)
		do
			view_add_subview (cocoa_object, a_subview.cocoa_object)
		end

feature -- Modifying the Frame Rectangle

	set_frame (a_rect: NS_RECT)
		do
			view_set_frame (cocoa_object, a_rect.item)
		end

	frame: NS_RECT
		do
			create Result.make
			view_frame (cocoa_object, Result.item)
		end

feature -- Modifying the Bounds Rectangle

	set_bounds (a_rect: NS_RECT)
		do
			view_set_bounds (cocoa_object, a_rect.item)
		end

	bounds: NS_RECT
		do
			create Result.make
			view_bounds (cocoa_object, Result.item)
		end

	set_bounds_origin (a_new_origin: NS_POINT)
		do
			view_set_bounds_origin (cocoa_object, a_new_origin.item)
		end

	set_bounds_size (a_new_size: NS_SIZE)
		do
			view_set_bounds_size (cocoa_object, a_new_size.item)
		end

	set_bounds_rotation (a_angle: REAL)
		do
			view_set_bounds_rotation (cocoa_object, a_angle)
		end

	bounds_rotation: REAL
		do
			Result := view_bounds_rotation (cocoa_object)
		end

feature -- Modifying the Coordinate System

	display
		do
			view_display (cocoa_object)
		end

	set_needs_display (a_flag: BOOLEAN)
		do
			view_set_needs_display (cocoa_object, a_flag)
		end

	set_hidden (a_flag: BOOLEAN)
		do
			view_set_hidden (cocoa_object, a_flag)
		end

	is_hidden : BOOLEAN
		do
			Result := view_is_hidden (cocoa_object)
		end

	is_flipped : BOOLEAN
		do
			Result := view_is_flipped (cocoa_object)
		end

	remove_from_superview
		do
			view_remove_from_superview (cocoa_object)
		end

	convert_point_to_base (a_point: NS_POINT): NS_POINT
		do
			create Result.make
			view_convert_point_to_base (cocoa_object, a_point.item, Result.item)
		end

	convert_point_to_view (a_point: NS_POINT; a_view: NS_VIEW): NS_POINT
		local
			l_view: POINTER
		do
			create Result.make
			if a_view /= void then
				l_view := a_view.cocoa_object
			else
				l_view := nil
			end
			view_convert_point_to_view (cocoa_object, a_point.item, l_view, Result.item)
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
			-- Get the frame.
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
indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end
