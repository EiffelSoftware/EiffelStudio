indexing
	description: "Wrapper for NSView. An Eiffel abstraction for a Cocoa widget"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VIEW

inherit
	NS_RESPONDER
		redefine
			dispose
		end

	IDENTIFIED
		undefine
			is_equal,
			copy
		redefine
			dispose
		end

create
	make,
	make_custom,
	make_flipped
create {NS_OBJECT}
	share_from_pointer

feature {NONE} -- Creation and Initialization

	make
		do
			make_from_pointer ({NS_VIEW_API}.new)
			--insert_in_table
		end

	make_custom (a_draw_action: PROCEDURE [ANY, TUPLE])
			-- Create an NSView which calls the passed draw_action when drawRect: is invoked
			-- require: target has been set up
		do
			draw_action := a_draw_action
			make_from_pointer ({NS_VIEW_API}.custom_new ($current, $draw))
			insert_in_table
		end

	make_flipped
			-- Create an NSView with flipped coordinates (i.e. redefine the isFlipped method to return True)
		do
			make_from_pointer (flipped_view_class.create_instance.item)
 			{NS_VIEW_API}.init (item)
			--insert_in_table
		end

	flipped_view_class: OBJC_CLASS
		once
			create Result.make_with_name ("FlippedView")
			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSView"))
			Result.add_method ("isFlipped", agent : BOOLEAN do Result := True end)
			Result.register
		end

	object_table: HASH_TABLE [INTEGER, POINTER]
		once
			create Result.make (1000)
			-- FIXME: perform cleanup after a number of insertions
		end

	insert_in_table
		do
			object_table.force (object_id, item)
		end

feature -- Managing the View Hierarchy

	window: detachable NS_WINDOW
			-- Returns the receiver's window object, or `Void' if it has none.
		local
			l_window: POINTER
		do
			l_window := {NS_VIEW_API}.window (item)
			if l_window /= default_pointer then
				create Result.share_from_pointer (l_window)
			end
		end

	superview: NS_VIEW
			-- Returns the receiver's superview, or nil if it has none.
			-- When applying this method iteratively or recursively, be sure to compare the returned view object to the content view of the window to avoid proceeding out of the view hierarchy.
		do
			create Result.share_from_pointer ({NS_VIEW_API}.superview (item))
		end

	subviews: NS_ARRAY [NS_VIEW]
			-- Return the receiver's immediate subviews.
		do
			create Result.share_from_pointer ({NS_VIEW_API}.subviews (item))
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
			create Result.share_from_pointer ({NS_VIEW_API}.ancestor_shared_with_view (item, a_view.item))
		end

	add_subview (a_subview: NS_VIEW)
			-- Adds a view to the receiver's subviews so it's displayed above its siblings.
		do
			{NS_VIEW_API}.add_subview (item, a_subview.item)
		end

	remove_from_superview
		do
			{NS_VIEW_API}.remove_from_superview (item)
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
			-- Sets the origin of the receiver's bounds rectangle to a specified point,
			-- In setting the new bounds origin, this method effectively shifts the receiver's coordinate system so newOrigin lies at the origin of the receiver's frame rectangle.
			-- It neither redisplays the receiver nor marks it as needing display. You must do this yourself with display or setNeedsDisplay:.
			-- This method posts an NSViewBoundsDidChangeNotification to the default notification center if the receiver is configured to do so.
			-- After calling this method, NSView creates an internal transform (or appends these changes to an existing internal transform)
			-- to convert from frame coordinates to bounds coordinates in your view. As long as the width-to-height ratio of the two coordinate systems remains the same,
			-- your content appears normal. If the ratios differ, your content may appear skewed.
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

feature -- Examining Coordinate System Modifications

	is_flipped: BOOLEAN
		do
			Result := {NS_VIEW_API}.is_flipped (item)
		end

feature -- Base Coordinate Conversion

	convert_point_to_base (a_point: NS_POINT): NS_POINT
		do
			create Result.make
			{NS_VIEW_API}.convert_point_to_base (item, a_point.item, Result.item)
		end

	convert_point_to_view (a_point: NS_POINT; a_view: NS_VIEW): NS_POINT
			-- Converts a point from the receiver's coordinate system to that of a given view.
			-- If `a_view' is `Void', this method instead converts to window base coordinates. Otherwise, both `a_view' and the receiver must belong to the same NS_WINDOW object.
		local
			l_view: POINTER
		do
			create Result.make
			if a_view /= void then
				l_view := a_view.item
			else
				l_view := default_pointer
			end
			{NS_VIEW_API}.convert_point_to_view (item, a_point.item, l_view, Result.item)
		end

feature -- Event Handling

	hit_test (a_point: NS_POINT): NS_VIEW
			-- Returns the farthest descendant of the receiver in the view hierarchy (including itself) that contains a specified point,
			-- or Void if that point lies completely outside the receiver.
		local
			view_ptr: POINTER
		do
			view_ptr := {NS_VIEW_API}.hit_test (item, a_point.item)
			object_table.search (view_ptr)
			if object_table.found then
				if attached {NS_VIEW} id_object (object_table.found_item) as l_view then
					Result := l_view
				else
					io.put_string ("View not valid anymore. Returning new.%N")
					create Result.share_from_pointer (view_ptr)
				end
			else
				create Result.share_from_pointer (view_ptr)
				io.put_string ("View not found: " + view_ptr.out + " (" + Result.class_.name.out + ")" + " Returning new.%N")
			end
		end

feature {NONE} -- Callback

	draw (x, y, w, h: INTEGER)
		do
			if attached {PROCEDURE [ANY, TUPLE]} draw_action as l_draw_action then
				l_draw_action.call([])
			end
		end

	draw_action: detachable PROCEDURE [ANY, TUPLE]

feature {NONE} -- Implementation

	dispose
		do
			Precursor {NS_RESPONDER}
			Precursor {IDENTIFIED}
		end

end
