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
--			make_from_pointer ({NS_VIEW_API}.new)
			make_from_pointer (view_class.create_instance.item)
 			{NS_VIEW_API}.init (item)
			--insert_in_table
		end

	make_custom (a_draw_action: PROCEDURE [ANY, TUPLE])
			-- Create an NSView which calls the passed draw_action when drawRect: is invoked
			-- require: target has been set up
		do
			draw_action := a_draw_action
			make_from_pointer ({NS_VIEW_API}.custom_new ($current, $draw_old))
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
			Result.add_method ("viewDidEndLiveResize", agent do io.put_string ("%NXXX%N") end)
			Result.register
		end

	view_class: OBJC_CLASS
		once
			create Result.make_with_name ("EiffelWrapperView")
			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSView"))
			Result.add_method ("viewDidEndLiveResize", agent do io.put_string ("XXX") end)
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

	set_subviews (a_subviews: NS_ARRAY [NS_VIEW])
			-- Sets the receiver's subviews to the specified subviews.
		do
			{NS_VIEW_API}.set_subviews (item, a_subviews.object_item)
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

	set_hidden (a_flag: BOOLEAN)
		do
			{NS_VIEW_API}.set_hidden (item, a_flag)
		end

	is_hidden : BOOLEAN
		do
			Result := {NS_VIEW_API}.is_hidden (item)
		end

feature -- Focusing

	lock_focus
			-- Locks the focus on the receiver, so subsequent commands take effect in the receiver's window and coordinate system.
		do
			{NS_VIEW_API}.lock_focus (item)
		end

	lock_focus_if_can_draw: BOOLEAN
			-- Locks the focus to the receiver atomically if the `can_draw' method returns True and returns the value of `can_draw'.
		do
			Result := {NS_VIEW_API}.lock_focus_if_can_draw (item)
		end

	unlock_focus
			-- Balances an earlier `lock_focus' or `lock_focus_if_can_draw' message; restoring the focus to the previously focused view is necessary.
		do
			{NS_VIEW_API}.unlock_focus (item)
		end

feature -- Drawing

	draw_rect (a_rect: NS_RECT)
			-- Overridden by subclasses to draw the receiver's image within the passed-in rectangle.
		do
			{NS_VIEW_API}.draw_rect (item, a_rect.item)
		end


	visible_rect: NS_RECT
			-- Returns the portion of the receiver not clipped by its superviews.
		do
			create Result.make
			{NS_VIEW_API}.visible_rect (item, Result.item)
		end

feature -- Displaying

	display
			-- Displays the receiver and all its subviews if possible, invoking each the NSView methods lockFocus, drawRect:, and unlockFocus as necessary.
		do
			{NS_VIEW_API}.display (item)
		end

	set_needs_display (a_flag: BOOLEAN)
			-- Controls whether the receiver's entire bounds is marked as needing display.
		do
			{NS_VIEW_API}.set_needs_display (item, a_flag)
		end

feature -- Examining Coordinate System Modifications

	is_flipped: BOOLEAN
			-- Returns `True' if the receiver uses flipped drawing coordinates or `False' if it uses native coordinates.
		do
			Result := {NS_VIEW_API}.is_flipped (item)
		end

feature -- Base Coordinate Conversion

	convert_point_to_base (a_point: NS_POINT): NS_POINT
		do
			create Result.make
			{NS_VIEW_API}.convert_point_to_base (item, a_point.item, Result.item)
		end

	convert_point_to_view (a_point: NS_POINT; a_view: detachable NS_VIEW): NS_POINT
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

feature -- Tool Tips

	set_tool_tip (a_string: NS_STRING)
			-- Sets the tool tip text for the view to `a_string'.
		do
			{NS_VIEW_API}.set_tool_tip (item, a_string.item)
		end

	tool_tip: detachable NS_STRING
			-- The text for the view's tool tip or `Void' if the view doesn't currently display a tool tip.
		local
			l_tooltip: POINTER
		do
			l_tooltip := {NS_VIEW_API}.tool_tip (item)
			if l_tooltip /= default_pointer then
				create Result.share_from_pointer (l_tooltip)
			end
		end

	add_tool_tip_rect_owner_user_data (a_rect: NS_RECT; a_an_object: NS_OBJECT; a_data: POINTER): INTEGER
			-- Creates a tool tip for a defined area and returns a tag that identifies the tool tip rectangle.
		do
			Result := {NS_VIEW_API}.add_tool_tip_rect_owner_user_data (item, a_rect.item, a_an_object.item, a_data.item)
		end

	remove_tool_tip (a_tag: INTEGER)
			-- Removes the tool tip identified by `a_tag'.
		do
			{NS_VIEW_API}.remove_tool_tip (item, a_tag)
		end

	remove_all_tool_tips
			-- Removes all assigned tool tips.
		do
			{NS_VIEW_API}.remove_all_tool_tips (item)
		end

feature -- Managing Cursor Tracking

	add_cursor_rect (a_rect: NS_RECT; a_an_obj: NS_CURSOR)
			-- Establishes the cursor to be used when the mouse pointer lies within a specified region.
		do
			{NS_VIEW_API}.add_cursor_rect_cursor (item, a_rect.item, a_an_obj.item)
		end

	remove_cursor_rect (a_rect: NS_RECT; a_an_obj: NS_CURSOR)
			-- Completely removes a cursor rectangle from the receiver.
		do
			{NS_VIEW_API}.remove_cursor_rect_cursor (item, a_rect.item, a_an_obj.item)
		end

	discard_cursor_rects
			-- Invalidates all cursor rectangles set up using add_cursor_rect.
		do
			{NS_VIEW_API}.discard_cursor_rects (item)
		end

feature -- Event Handling

	hit_test (a_point: NS_POINT): detachable NS_VIEW
			-- Returns the farthest descendant of the receiver in the view hierarchy (including itself) that contains a specified point,
			-- or Void if that point lies completely outside the receiver.
		local
			view_ptr: POINTER
		do
			view_ptr := {NS_VIEW_API}.hit_test (item, a_point.item)
			if view_ptr /= default_pointer then
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
		end

feature --

	frozen view_frame_did_change_notification: POINTER
			-- Posted whenever the view's frame rectangle changes, if the view is configured using setPostsFrameChangedNotifications: to post such notifications.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSViewFrameDidChangeNotification"
		end

feature {NONE} -- Callback

	draw_old (x, y, w, h: INTEGER)
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
