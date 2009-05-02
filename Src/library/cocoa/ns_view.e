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
	new_shared,
	new,
	new_custom

feature -- Creation

	new_shared (ptr: POINTER)
			--
		do
			cocoa_object := ptr
		end

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

feature -- Properties

	set_frame (a_rect: NS_RECT)
		do
			view_set_frame (cocoa_object, a_rect.item)
		end

	frame: NS_RECT
		do
			create Result.make
			view_frame (cocoa_object, Result.item)
		end

	bounds: NS_RECT
		do
			create Result.make
			view_bounds (cocoa_object, Result.item)
		end

	add_subview (a_subview: NS_VIEW)
		do
			view_add_subview (cocoa_object, a_subview.cocoa_object)
		end

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

	frozen view_bounds (a_view: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect frame = [(NSView*)$a_view bounds];   memcpy($a_res, &frame, sizeof(NSRect));"
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

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end
