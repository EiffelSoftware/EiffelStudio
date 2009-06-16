indexing
	description: "Wrapper for NSView. An Eiffel abstraction for a Cocoa widget"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VIEW

inherit
	NS_RESPONDER

create
	make,
	make_custom,
	make_flipped
create {NS_OBJECT}
	make_shared

feature {NONE} -- Creation and Initialization

	make
		do
			make_shared ({NS_VIEW_API}.new)
		end

	make_custom (a_draw_action: PROCEDURE [ANY, TUPLE])
			-- Create an NSView which calls the passed draw_action when drawRect: is invoked
			-- require: target has been set up
		local
			oldmethod: PROCEDURE [ANY, TUPLE]
		do
			draw_action := a_draw_action
			make_shared ({NS_VIEW_API}.custom_new ($current, $draw))

			oldmethod := class_.replace_method ("mouseDown:", agent mouse_down_x)
		end

	mouse_down_x (a_event: POINTER)
		do
			io.put_string ("Mouse down in NSVIEW%N")
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
			l_ret: BOOLEAN
		do
			l_class := {NS_OBJC_RUNTIME}.objc_get_class ((create {C_STRING}.make ("FlippedView")).item)
			if l_class = {NS_OBJECT}.nil then
				-- If FlippedView doesn't exist yet create it as a new child class of NSView and override isFlipped
				l_superclass := {NS_OBJC_RUNTIME}.objc_get_class ((create {C_STRING}.make ("NSView")).item)
				l_name := (create {C_STRING}.make ("FlippedView")).item
				l_class := {NS_OBJC_RUNTIME}.objc_allocate_class_pair (l_superclass, l_name, 0)

				l_types := (create {C_STRING}.make ("b@:")).item
				l_sel := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make ("isFlipped")).item)
				l_imp := {NS_OBJC_RUNTIME}.class_get_method_implementation({NS_OBJC_RUNTIME}.objc_get_class ((create {C_STRING}.make ("CustomView")).item), l_sel)
				l_ret := {NS_OBJC_RUNTIME}.class_add_method (l_class, l_sel, l_imp, l_types)

				{NS_OBJC_RUNTIME}.objc_register_class_pair (l_class)
			end
			make_shared ({NS_OBJC_RUNTIME}.class_create_instance (l_class, 0))
			{NS_VIEW_API}.init (item)

--			redefine_method ("NSClipView", "isFlipped", agent: BOOLEAN do Result := True end)
		end

feature -- Managing the View Hierarchy

	window: NS_WINDOW
			-- Returns the receiver's window object, or void if it has none.
		local
			l_window: POINTER
		do
			l_window := {NS_VIEW_API}.window (item)
			if l_window /= nil then
				create Result.make_shared (l_window)
			end
		end

	superview: NS_VIEW
			-- Returns the receiver's superview, or nil if it has none.
			-- When applying this method iteratively or recursively, be sure to compare the returned view object to the content view of the window to avoid proceeding out of the view hierarchy.
		do
			create Result.make_shared ({NS_VIEW_API}.superview (item))
		end

	subviews: NS_ARRAY [NS_VIEW]
			-- Return the receiver's immediate subviews.
		do
			create Result.make_shared ({NS_VIEW_API}.subviews (item))
		end

	is_descendant_of (a_view: NS_VIEW): BOOLEAN
			-- Returns True if the receiver is a subview of a given view or if it's identical to that view; otherwise, it returns False.
		do
			Result := {NS_VIEW_API}.is_descendant_of (item, a_view.item)
		end

	ancestor_shared_with_view (a_view: NS_VIEW): NS_VIEW
			-- Returns the closest ancestor shared by the receiver and a given view.
			-- The closest ancestor or nil if there's no such object. Returns self if `a_view' is identical to the receiver.
		do
			create Result.make_shared ({NS_VIEW_API}.ancestor_shared_with_view (item, a_view.item))
		end

	add_subview (a_subview: NS_VIEW)
			-- Adds a view to the receiver's subviews so it's displayed above its siblings.
		do
			{NS_VIEW_API}.add_subview (item, a_subview.item)
		end

feature -- Modifying the Frame Rectangle

	set_frame (a_rect: NS_RECT)
			-- Sets the receiver's frame rectangle to the specified rectangle.
		do
			{NS_VIEW_API}.set_frame (item, a_rect.item)
		end

	frame: NS_RECT
			-- Returns the receiver's frame rectangle, which defines its position in its superview.
			-- The frame rectangle may be rotated; use the frame_rotation method to check this.
		do
			create Result.make
			{NS_VIEW_API}.frame (item, Result.item)
		end

feature -- Modifying the Bounds Rectangle

	set_bounds (a_rect: NS_RECT)
			-- Sets the receiver's bounds rectangle.
		do
			{NS_VIEW_API}.set_bounds (item, a_rect.item)
		end

	bounds: NS_RECT
			-- Returns the receiver's bounds rectangle, which expresses its location and size in its own coordinate system.
		do
			create Result.make
			{NS_VIEW_API}.bounds (item, Result.item)
		end

	set_bounds_origin (a_new_origin: NS_POINT)
		do
			{NS_VIEW_API}.set_bounds_origin (item, a_new_origin.item)
		end

	set_bounds_size (a_new_size: NS_SIZE)
		do
			{NS_VIEW_API}.set_bounds_size (item, a_new_size.item)
		end

	set_bounds_rotation (a_angle: REAL)
		do
			{NS_VIEW_API}.set_bounds_rotation (item, a_angle)
		end

	bounds_rotation: REAL
		do
			Result := {NS_VIEW_API}.bounds_rotation (item)
		end

feature -- Modifying the Coordinate System

	display
		do
			{NS_VIEW_API}.display (item)
		end

	set_needs_display (a_flag: BOOLEAN)
		do
			{NS_VIEW_API}.set_needs_display (item, a_flag)
		end

	set_hidden (a_flag: BOOLEAN)
		do
			{NS_VIEW_API}.set_hidden (item, a_flag)
		end

	is_hidden : BOOLEAN
		do
			Result := {NS_VIEW_API}.is_hidden (item)
		end

	is_flipped: BOOLEAN
		do
			Result := {NS_VIEW_API}.is_flipped (item)
		end

	remove_from_superview
		do
			{NS_VIEW_API}.remove_from_superview (item)
		end

	convert_point_to_base (a_point: NS_POINT): NS_POINT
		do
			create Result.make
			{NS_VIEW_API}.convert_point_to_base (item, a_point.item, Result.item)
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
			{NS_VIEW_API}.convert_point_to_view (item, a_point.item, l_view, Result.item)
		end

feature {NONE} -- callback

	draw (x, y, w, h: INTEGER)
		do
			draw_action.call([])
		end

	draw_action: PROCEDURE [ANY, TUPLE]

end
