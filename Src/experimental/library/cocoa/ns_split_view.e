note
	description: "Wrapper for NSSplitView."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SPLIT_VIEW

inherit
	NS_VIEW
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_SPLIT_VIEW_API}.new)
			callback_marshal.register_object (Current)
		end

feature -- Managing Subviews

	adjust_subviews
			-- Adjusts the sizes of the receiver`s subviews so they (plus the dividers) fill the receiver.
		do
			{NS_SPLIT_VIEW_API}.adjust_subviews (item)
		end

	is_subview_collapsed (a_subview: NS_VIEW): BOOLEAN
			-- Returns <code>YES</code> if <em>subview</em> is in a collapsed state, <code>NO</code> otherwise.
		do
			Result := {NS_SPLIT_VIEW_API}.is_subview_collapsed (item, a_subview.item)
		end

	split_view_resize_subviews_with_old_size (a_split_view: NS_SPLIT_VIEW; a_old_size: NS_SIZE)
			-- Allows the delegate to specify custom sizing behavior for the subviews of the NSSplitView <em>sender</em>.
		do
			{NS_SPLIT_VIEW_API}.split_view_resize_subviews_with_old_size (item, a_split_view.item, a_old_size.item)
		end

	split_view_will_resize_subviews (a_notification: NS_NOTIFICATION)
			-- Invoked by the default notification center to notify the delegate that the splitview will resize its subviews.
		do
			{NS_SPLIT_VIEW_API}.split_view_will_resize_subviews (item, a_notification.item)
		end

	split_view_did_resize_subviews (a_notification: NS_NOTIFICATION)
			-- Invoked by the default notification center to notify the delegate that the splitview did resize its subviews.
		do
			{NS_SPLIT_VIEW_API}.split_view_did_resize_subviews (item, a_notification.item)
		end

	split_view_can_collapse_subview (a_split_view: NS_SPLIT_VIEW; a_subview: NS_VIEW): BOOLEAN
			-- Allows the delegate to determine whether the user can collapse and uncollapse <em>subview</em>.
		do
			Result := {NS_SPLIT_VIEW_API}.split_view_can_collapse_subview (item, a_split_view.item, a_subview.item)
		end

	split_view_should_collapse_subview_for_double_click_on_divider_at_index (a_split_view: NS_SPLIT_VIEW; a_subview: NS_VIEW; a_divider_index: INTEGER): BOOLEAN
			-- Invoked to allow a delegate to determine if a subview should collapse in response to a double click.
		do
			Result := {NS_SPLIT_VIEW_API}.split_view_should_collapse_subview_for_double_click_on_divider_at_index (item, a_split_view.item, a_subview.item, a_divider_index)
		end

feature -- Managing Split View Orientation

	is_vertical: BOOLEAN
			-- Returns <code>YES</code> if the split bars are vertical (subviews are side by side), <code>NO</code> if they are horizontal (views are one on top of the other).
		do
			Result := {NS_SPLIT_VIEW_API}.is_vertical (item)
		end

	set_vertical (a_flag: BOOLEAN)
			-- Sets whether the split bars are vertical.
		do
			{NS_SPLIT_VIEW_API}.set_vertical (item, a_flag)
		end

feature -- Assigning a Delegate

	delegate: NS_OBJECT
			-- Returns the receiver`s delegate.
		do
			create Result.share_from_pointer ({NS_SPLIT_VIEW_API}.delegate (item))
		end

	set_delegate (a_delegate: NS_OBJECT)
			-- Makes <em>anObject</em> the receiver`s delegate.
		do
			{NS_SPLIT_VIEW_API}.set_delegate (item, a_delegate.item)
		end

feature -- Configuring and Drawing View Dividers

	set_divider_style (a_divider_style: INTEGER)
			-- Sets the style of divider drawn between subviews.
		do
			{NS_SPLIT_VIEW_API}.set_divider_style (item, a_divider_style)
		end

	divider_style: INTEGER
			-- Returns the style of the divider drawn between subviews.
		do
			Result := {NS_SPLIT_VIEW_API}.divider_style (item)
		end

	divider_thickness: REAL
			-- Returns the thickness of the divider.
		do
			Result := {NS_SPLIT_VIEW_API}.divider_thickness (item)
		end

	divider_color: NS_COLOR
			-- Return the color of the dividers that the split view is drawing between subviews.
		do
			create Result.share_from_pointer ({NS_SPLIT_VIEW_API}.divider_color (item))
		end

	draw_divider_in_rect (a_rect: NS_RECT)
			-- Draws the divider between two of the receiver`s subviews.
		do
			{NS_SPLIT_VIEW_API}.draw_divider_in_rect (item, a_rect.item)
		end

	split_view_effective_rect_for_drawn_rect_of_divider_at_index (a_split_view: NS_SPLIT_VIEW; a_proposed_effective_rect: NS_RECT; a_drawn_rect: NS_RECT; a_divider_index: INTEGER): NS_RECT
			-- Allows the delegate to modify the rectangle in which mouse clicks initiate divider dragging.
		do
			create Result.make
			{NS_SPLIT_VIEW_API}.split_view_effective_rect_for_drawn_rect_of_divider_at_index (item, a_split_view.item, a_proposed_effective_rect.item, a_drawn_rect.item, a_divider_index, Result.item)
		end

	split_view_should_hide_divider_at_index (a_split_view: NS_SPLIT_VIEW; a_divider_index: INTEGER): BOOLEAN
			-- Allows the delegate to determine whether a divider can be dragged or adjusted off the edge of the split view.
		do
			Result := {NS_SPLIT_VIEW_API}.split_view_should_hide_divider_at_index (item, a_split_view.item, a_divider_index)
		end

	split_view_additional_effective_rect_of_divider_at_index (a_split_view: NS_SPLIT_VIEW; a_divider_index: INTEGER): NS_RECT
			-- Allows the delegate to return an additional rectangle in which mouse clicks will initiate divider dragging.
		do
			create Result.make
			{NS_SPLIT_VIEW_API}.split_view_additional_effective_rect_of_divider_at_index (item, a_split_view.item, a_divider_index, Result.item)
		end

feature -- Saving Subview Positions

	set_autosave_name (a_autosave_name: NS_STRING)
			-- Sets the name under which receiver`s divider position is automatically saved.
		do
			{NS_SPLIT_VIEW_API}.set_autosave_name (item, a_autosave_name.item)
		end

	autosave_name: NS_STRING
			-- Returns the name under which receiver`s divider position is automatically saved.
		do
			create Result.share_from_pointer ({NS_SPLIT_VIEW_API}.autosave_name (item))
		end

feature -- Configuring Pane Splitters

	is_pane_splitter: BOOLEAN
			-- Returns <code>YES</code> if the receiver`s splitter is a bar that goes across the split view. Returns <code>NO</code> if the splitter is a thumb on the regular background pattern.
		do
			Result := {NS_SPLIT_VIEW_API}.is_pane_splitter (item)
		end

	set_is_pane_splitter (a_flag: BOOLEAN)
			-- Sets the type of splitter.
		do
			{NS_SPLIT_VIEW_API}.set_is_pane_splitter (item, a_flag)
		end

feature -- Constraining Split Position

	min_possible_position_of_divider_at_index (a_divider_index: INTEGER): REAL
			-- Returns the minimum possible position of the divider at the specified index.
		do
			Result := {NS_SPLIT_VIEW_API}.min_possible_position_of_divider_at_index (item, a_divider_index)
		end

	max_possible_position_of_divider_at_index (a_divider_index: INTEGER): REAL
			-- Returns the maximum possible position of the divider at the specified index.
		do
			Result := {NS_SPLIT_VIEW_API}.max_possible_position_of_divider_at_index (item, a_divider_index)
		end

	set_position_of_divider_at_index (a_position: REAL; a_divider_index: INTEGER)
			-- Sets the position of the divider at the specified index.
		do
			{NS_SPLIT_VIEW_API}.set_position_of_divider_at_index (item, a_position, a_divider_index)
		end

	split_view_constrain_max_coordinate_of_subview_at (a_split_view: NS_SPLIT_VIEW; a_proposed_maximum_position: REAL; a_divider_index: INTEGER): REAL
			-- Allows the delegate for <em>sender</em> to constrain the maximum coordinate limit of a divider when the user drags it.
		do
			Result := {NS_SPLIT_VIEW_API}.split_view_constrain_max_coordinate_of_subview_at (item, a_split_view.item, a_proposed_maximum_position, a_divider_index)
		end

	split_view_constrain_min_coordinate_of_subview_at (a_split_view: NS_SPLIT_VIEW; a_proposed_minimum_position: REAL; a_divider_index: INTEGER): REAL
			-- Allows the delegate for <em>sender</em> to constrain the minimum coordinate limit of a divider when the user drags it.
		do
			Result := {NS_SPLIT_VIEW_API}.split_view_constrain_min_coordinate_of_subview_at (item, a_split_view.item, a_proposed_minimum_position, a_divider_index)
		end

	split_view_constrain_split_position_of_subview_at (a_split_view: NS_SPLIT_VIEW; a_proposed_position: REAL; a_divider_index: INTEGER): REAL
			-- Allows the delegate for <em>sender</em> to constrain the divider to certain positions.
		do
			Result := {NS_SPLIT_VIEW_API}.split_view_constrain_split_position_of_subview_at (item, a_split_view.item, a_proposed_position, a_divider_index)
		end

end
