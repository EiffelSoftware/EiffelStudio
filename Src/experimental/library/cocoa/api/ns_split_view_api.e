note
	description: "Summary description for {NS_SPLIT_VIEW_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SPLIT_VIEW_API

feature -- Creation

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSSplitView new];"
		end

feature -- Managing Subviews

	frozen adjust_subviews (a_ns_split_view: POINTER)
			-- - (void)adjustSubviews
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view adjustSubviews];"
		end

	frozen is_subview_collapsed (a_ns_split_view: POINTER; a_subview: POINTER): BOOLEAN
			-- - (BOOL)isSubviewCollapsed: (NSView *) subview
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view isSubviewCollapsed: $a_subview];"
		end

	frozen split_view_resize_subviews_with_old_size (a_ns_split_view: POINTER; a_split_view: POINTER; a_old_size: POINTER)
			-- - (void)splitView: (NSSplitView *) splitView resizeSubviewsWithOldSize: (NSSplitView *) oldSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view splitView: $a_split_view resizeSubviewsWithOldSize: *(NSSize*)$a_old_size];"
		end

	frozen split_view_will_resize_subviews (a_ns_split_view: POINTER; a_notification: POINTER)
			-- - (void)splitViewWillResizeSubviews: (NSNotification *) notification
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view splitViewWillResizeSubviews: $a_notification];"
		end

	frozen split_view_did_resize_subviews (a_ns_split_view: POINTER; a_notification: POINTER)
			-- - (void)splitViewDidResizeSubviews: (NSNotification *) notification
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view splitViewDidResizeSubviews: $a_notification];"
		end

	frozen split_view_can_collapse_subview (a_ns_split_view: POINTER; a_split_view: POINTER; a_subview: POINTER): BOOLEAN
			-- - (BOOL)splitView: (NSSplitView *) splitView canCollapseSubview: (NSSplitView *) subview
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view splitView: $a_split_view canCollapseSubview: $a_subview];"
		end

	frozen split_view_should_collapse_subview_for_double_click_on_divider_at_index (a_ns_split_view: POINTER; a_split_view: POINTER; a_subview: POINTER; a_divider_index: INTEGER): BOOLEAN
			-- - (BOOL)splitView: (NSSplitView *) splitView shouldCollapseSubview: (NSSplitView *) subview forDoubleClickOnDividerAtIndex: (NSSplitView *) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view splitView: $a_split_view shouldCollapseSubview: $a_subview forDoubleClickOnDividerAtIndex: $a_divider_index];"
		end

feature -- Managing Split View Orientation

	frozen is_vertical (a_ns_split_view: POINTER): BOOLEAN
			-- - (BOOL)isVertical
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view isVertical];"
		end

	frozen set_vertical (a_ns_split_view: POINTER; a_flag: BOOLEAN)
			-- - (void)setVertical: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view setVertical: $a_flag];"
		end

feature -- Assigning a Delegate

	frozen delegate (a_ns_split_view: POINTER): POINTER
			-- - (id)delegate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view delegate];"
		end

	frozen set_delegate (a_ns_split_view: POINTER; a_delegate: POINTER)
			-- - (void)setDelegate: (id) delegate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view setDelegate: *(id*)$a_delegate];"
		end

feature -- Configuring and Drawing View Dividers

	frozen set_divider_style (a_ns_split_view: POINTER; a_divider_style: INTEGER)
			-- - (void)setDividerStyle: (NSSplitViewDividerStyle) dividerStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view setDividerStyle: $a_divider_style];"
		end

	frozen divider_style (a_ns_split_view: POINTER): INTEGER
			-- - (NSSplitViewDividerStyle)dividerStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view dividerStyle];"
		end

	frozen divider_thickness (a_ns_split_view: POINTER): REAL
			-- - (CGFloat)dividerThickness
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view dividerThickness];"
		end

	frozen divider_color (a_ns_split_view: POINTER): POINTER
			-- - (NSColor *)dividerColor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view dividerColor];"
		end

	frozen draw_divider_in_rect (a_ns_split_view: POINTER; a_rect: POINTER)
			-- - (void)drawDividerInRect: (NSRect) rect
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view drawDividerInRect: *(NSRect*)$a_rect];"
		end

	frozen split_view_effective_rect_for_drawn_rect_of_divider_at_index (a_ns_split_view: POINTER; a_split_view: POINTER; a_proposed_effective_rect: POINTER; a_drawn_rect: POINTER; a_divider_index: INTEGER; res: POINTER)
			-- - (NSRect)splitView: (NSSplitView *) splitView effectiveRect: (NSSplitView *) proposedEffectiveRect forDrawnRect: (NSSplitView *) drawnRect ofDividerAtIndex: (NSSplitView *) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSSplitView*)$a_ns_split_view splitView: $a_split_view effectiveRect: *(NSRect*)$a_proposed_effective_rect forDrawnRect: *(NSRect*)$a_drawn_rect ofDividerAtIndex: $a_divider_index]; memcpy($res, &rect, sizeof(NSRect));"
		end

	frozen split_view_should_hide_divider_at_index (a_ns_split_view: POINTER; a_split_view: POINTER; a_divider_index: INTEGER): BOOLEAN
			-- - (BOOL)splitView: (NSSplitView *) splitView shouldHideDividerAtIndex: (NSSplitView *) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view splitView: $a_split_view shouldHideDividerAtIndex: $a_divider_index];"
		end

	frozen split_view_additional_effective_rect_of_divider_at_index (a_ns_split_view: POINTER; a_split_view: POINTER; a_divider_index: INTEGER; res: POINTER)
			-- - (NSRect)splitView: (NSSplitView *) splitView additionalEffectiveRectOfDividerAtIndex: (NSSplitView *) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSSplitView*)$a_ns_split_view splitView: $a_split_view additionalEffectiveRectOfDividerAtIndex: $a_divider_index]; memcpy($res, &rect, sizeof(NSRect));"
		end

feature -- Saving Subview Positions

	frozen set_autosave_name (a_ns_split_view: POINTER; a_autosave_name: POINTER)
			-- - (void)setAutosaveName: (NSString *) autosaveName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view setAutosaveName: $a_autosave_name];"
		end

	frozen autosave_name (a_ns_split_view: POINTER): POINTER
			-- - (NSString *)autosaveName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view autosaveName];"
		end

feature -- Configuring Pane Splitters

	frozen is_pane_splitter (a_ns_split_view: POINTER): BOOLEAN
			-- - (BOOL)isPaneSplitter
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view isPaneSplitter];"
		end

	frozen set_is_pane_splitter (a_ns_split_view: POINTER; a_flag: BOOLEAN)
			-- - (void)setIsPaneSplitter: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view setIsPaneSplitter: $a_flag];"
		end

feature -- Constraining Split Position

	frozen min_possible_position_of_divider_at_index (a_ns_split_view: POINTER; a_divider_index: INTEGER): REAL
			-- - (CGFloat)minPossiblePositionOfDividerAtIndex: (NSInteger) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view minPossiblePositionOfDividerAtIndex: $a_divider_index];"
		end

	frozen max_possible_position_of_divider_at_index (a_ns_split_view: POINTER; a_divider_index: INTEGER): REAL
			-- - (CGFloat)maxPossiblePositionOfDividerAtIndex: (NSInteger) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view maxPossiblePositionOfDividerAtIndex: $a_divider_index];"
		end

	frozen set_position_of_divider_at_index (a_ns_split_view: POINTER; a_position: REAL; a_divider_index: INTEGER)
			-- - (void)setPosition: (CGFloat) position ofDividerAtIndex: (CGFloat) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_ns_split_view setPosition: $a_position ofDividerAtIndex: $a_divider_index];"
		end

	frozen split_view_constrain_max_coordinate_of_subview_at (a_ns_split_view: POINTER; a_split_view: POINTER; a_proposed_maximum_position: REAL; a_divider_index: INTEGER): REAL
			-- - (CGFloat)splitView: (NSSplitView *) splitView constrainMaxCoordinate: (NSSplitView *) proposedMaximumPosition ofSubviewAt: (NSSplitView *) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view splitView: $a_split_view constrainMaxCoordinate: $a_proposed_maximum_position ofSubviewAt: $a_divider_index];"
		end

	frozen split_view_constrain_min_coordinate_of_subview_at (a_ns_split_view: POINTER; a_split_view: POINTER; a_proposed_minimum_position: REAL; a_divider_index: INTEGER): REAL
			-- - (CGFloat)splitView: (NSSplitView *) splitView constrainMinCoordinate: (NSSplitView *) proposedMinimumPosition ofSubviewAt: (NSSplitView *) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view splitView: $a_split_view constrainMinCoordinate: $a_proposed_minimum_position ofSubviewAt: $a_divider_index];"
		end

	frozen split_view_constrain_split_position_of_subview_at (a_ns_split_view: POINTER; a_split_view: POINTER; a_proposed_position: REAL; a_divider_index: INTEGER): REAL
			-- - (CGFloat)splitView: (NSSplitView *) splitView constrainSplitPosition: (NSSplitView *) proposedPosition ofSubviewAt: (NSSplitView *) dividerIndex
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_ns_split_view splitView: $a_split_view constrainSplitPosition: $a_proposed_position ofSubviewAt: $a_divider_index];"
		end

end
