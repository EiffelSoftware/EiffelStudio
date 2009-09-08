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

end
