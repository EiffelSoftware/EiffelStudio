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
			make_from_pointer (split_view_new)
		end

feature -- Access

	set_vertical (a_flag: BOOLEAN)
		do
			split_view_set_vertical (item, a_flag)
		end

	is_vertical : BOOLEAN
		do
			Result := split_view_is_vertical (item)
		end

	set_divider_style (a_divider_style: INTEGER)
		do
			split_view_set_divider_style (item, a_divider_style)
		end

	divider_style : INTEGER
		do
			Result := split_view_divider_style (item)
		end

	set_autosave_name (a_autosave_name: NS_STRING)
		do
			split_view_set_autosave_name (item, a_autosave_name.item)
		end

--	autosave_name : NS_STRING
--		do
--			Result := split_view_autosave_name (cocoa_object)
--		end

	set_delegate (a_delegate: NS_SPLIT_VIEW_DELEGATE)
		do
			split_view_set_delegate (item, a_delegate.item)
		end

	delegate: NS_SPLIT_VIEW_DELEGATE
		do
--			Result := split_view_delegate (cocoa_object)
			check implement: FALSE end
		end

--	draw_divider_in_rect (a_rect: NS_RECT)
--		do
--			split_view_draw_divider_in_rect (cocoa_object, a_rect)
--		end

	divider_color: NS_COLOR
		do
--			Result := split_view_divider_color (cocoa_object)
			check implement: FALSE end
		end

	divider_thickness: REAL
		do
			Result := split_view_divider_thickness (item)
		end

	adjust_subviews
		do
			split_view_adjust_subviews (item)
		end

	is_subview_collapsed (a_subview: NS_VIEW): BOOLEAN
		do
			Result := split_view_is_subview_collapsed (item, a_subview.item)
		end

	min_possible_position_of_divider_at_index (a_divider_index: INTEGER): REAL
		do
			Result := split_view_min_possible_position_of_divider_at_index (item, a_divider_index)
		end

	max_possible_position_of_divider_at_index (a_divider_index: INTEGER): REAL
		do
			Result := split_view_max_possible_position_of_divider_at_index(item, a_divider_index)
		end

	set_position_of_divider_at_index (a_position: REAL; a_divider_index: INTEGER)
		do
			split_view_set_position_of_divider_at_index(item, a_position, a_divider_index)
		end

	set_is_pane_splitter (a_flag: BOOLEAN)
		do
			split_view_set_is_pane_splitter(item, a_flag)
		end

	is_pane_splitter: BOOLEAN
		do
			Result := split_view_is_pane_splitter(item)
		end

feature -- Objective-C implementation

	frozen split_view_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSSplitView new];"
		end
	frozen split_view_set_vertical (a_split_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_split_view setVertical: $a_flag];"
		end

	frozen split_view_is_vertical (a_split_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view isVertical];"
		end

	frozen split_view_set_divider_style (a_split_view: POINTER; a_divider_style: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_split_view setDividerStyle: $a_divider_style];"
		end

	frozen split_view_divider_style (a_split_view: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view dividerStyle];"
		end

	frozen split_view_set_autosave_name (a_split_view: POINTER; a_autosave_name: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_split_view setAutosaveName: $a_autosave_name];"
		end

	frozen split_view_autosave_name (a_split_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view autosaveName];"
		end

	frozen split_view_set_delegate (a_split_view: POINTER; a_delegate: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_split_view setDelegate: $a_delegate];"
		end

	frozen split_view_delegate (a_split_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view delegate];"
		end

--	frozen split_view_draw_divider_in_rect (a_split_view: POINTER; a_rect: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSSplitView*)$a_split_view drawDividerInRect: $a_rect];"
--		end

	frozen split_view_divider_color (a_split_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view dividerColor];"
		end

	frozen split_view_divider_thickness (a_split_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view dividerThickness];"
		end

	frozen split_view_adjust_subviews (a_split_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_split_view adjustSubviews];"
		end

	frozen split_view_is_subview_collapsed (a_split_view: POINTER; a_subview: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view isSubviewCollapsed: $a_subview];"
		end

	frozen split_view_min_possible_position_of_divider_at_index (a_split_view: POINTER; a_divider_index: INTEGER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view minPossiblePositionOfDividerAtIndex: $a_divider_index];"
		end

	frozen split_view_max_possible_position_of_divider_at_index (a_split_view: POINTER; a_divider_index: INTEGER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view maxPossiblePositionOfDividerAtIndex: $a_divider_index];"
		end

	frozen split_view_set_position_of_divider_at_index (a_split_view: POINTER; a_position: REAL; a_divider_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_split_view setPosition: $a_position ofDividerAtIndex: $a_divider_index];"
		end

	frozen split_view_set_is_pane_splitter (a_split_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSplitView*)$a_split_view setIsPaneSplitter: $a_flag];"
		end

	frozen split_view_is_pane_splitter (a_split_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSplitView*)$a_split_view isPaneSplitter];"
		end
end
