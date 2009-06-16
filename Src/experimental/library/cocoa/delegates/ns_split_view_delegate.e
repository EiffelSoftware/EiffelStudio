note
	description: "Wrapper for delegate methods of NSSplitView."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_SPLIT_VIEW_DELEGATE

inherit
	NS_OBJECT

feature

	make
		do
			make_from_pointer (split_view_delegate_new ($current, $split_view_did_resize_subviews))
		end

	split_view_can_collapse_subview (a_split_view: NS_SPLIT_VIEW; a_subview: NS_VIEW): BOOLEAN
			-- - (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview;
			-- Return YES if a subview can be collapsed, NO otherwise. If a split view has no delegate, or if its delegate does not respond to this message, none of the split view's subviews can be collapsed. If a split view has a delegate, and the delegate responds to this message, it will be sent at least twice when the user clicks or double-clicks on one of the split view's dividers, once per subview on either side of the divider, and may be resent as the user continues to drag the divider. If a subview is collapsible, the current implementation of NSSplitView will collapse it when the user has dragged the divider more than halfway between the position that would make the subview its minimum size and the position that would make it zero size. The subview will become uncollapsed if the user drags the divider back past that point. The comments for -splitView:constrainMinCoordinate:ofSubviewAt: and -splitView:constrainMaxCoordinate:ofSubviewAt: describe how subviews' minimum sizes are determined. Collapsed subviews are hidden but retained by the split view. Collapsing of a subview will not change its bounds, but may set its frame to zero pixels high (in horizontal split views) or zero pixels wide (vertical).
		do
		end

	split_view_should_collapse_subview_for_double_click_on_divider_at_index (a_split_view: NS_SPLIT_VIEW; a_subview: NS_VIEW; a_divider_index: INTEGER): BOOLEAN
		do
		end

	split_view_constrain_min_coordinate_of_subview_at (a_split_view: NS_SPLIT_VIEW; a_proposed_minimum_position: REAL; a_divider_index: INTEGER): REAL
		do
		end

	split_view_constrain_max_coordinate_of_subview_at (a_split_view: NS_SPLIT_VIEW; a_proposed_maximum_position: REAL; a_divider_index: INTEGER): REAL
		do
		end

	split_view_constrain_split_position_of_subview_at (a_split_view: NS_SPLIT_VIEW; a_proposed_position: REAL; a_divider_index: INTEGER): REAL
		do
		end

--	split_view_resize_subviews_with_old_size (a_split_view: NS_SPLIT_VIEW; a_old_size: NS_SIZE)
--		deferred
--		end

	split_view_should_hide_divider_at_index (a_split_view: NS_SPLIT_VIEW; a_divider_index: INTEGER): BOOLEAN
		do
		end

--	split_view_effective_rect_for_drawn_rect_of_divider_at_index (a_split_view: NS_SPLIT_VIEW; a_proposed_effective_rect: NS_RECT; a_drawn_rect: NS_RECT; a_divider_index: INTEGER): NS_RECT
--		do
--		end

--	split_view_additional_effective_rect_of_divider_at_index (a_split_view: NS_SPLIT_VIEW; a_divider_index: INTEGER): NS_RECT
--		do
--		end

	split_view_will_resize_subviews (a_notification: NS_OBJECT) --NS_NOTIFICATION
		do
		end

	split_view_did_resize_subviews -- (a_notification: NS_NOTIFICATION)
		do
		end

feature {NONE} -- Objective-C implementation

	frozen split_view_delegate_new (an_object: POINTER; a_split_view_did_resize_subviews: POINTER): POINTER
		external
			"C inline use %"ns_split_view_delegate.h%""
		alias
			"return [[SplitViewDelegate new] initWithCallbackObject: $an_object andMethod: $a_split_view_did_resize_subviews];"
		end

end
