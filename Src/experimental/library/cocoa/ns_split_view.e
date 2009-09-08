note
	description: "Wrapper for NSSplitView."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
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
			-- Returns True if <em>subview</em> is in a collapsed state, False otherwise.
		do
			Result := {NS_SPLIT_VIEW_API}.is_subview_collapsed (item, a_subview.item)
		end

feature -- Managing Split View Orientation

	is_vertical: BOOLEAN
			-- Returns True if the split bars are vertical (subviews are side by side), False if they are horizontal (views are one on top of the other).
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

	set_delegate (a_delegate: NS_SPLIT_VIEW_DELEGATE)
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

end
