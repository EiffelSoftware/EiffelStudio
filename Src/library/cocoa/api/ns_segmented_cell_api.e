note
	description: "Summary description for {NS_SEGMENTED_CELL_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SEGMENTED_CELL_API

feature -- Creation

	frozen new: POINTER
			-- + (id)new
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSSegmentedCell new];"
		end

feature --

	frozen set_segment_count (a_segmented_cell: POINTER; a_count: INTEGER)
			-- - (void)setSegmentCount: (NSInteger) count
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setSegmentCount: $a_count];"
		end

	frozen segment_count (a_segmented_cell: POINTER): INTEGER
			-- - (NSInteger)segmentCount
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell segmentCount];"
		end

	frozen set_selected_segment (a_segmented_cell: POINTER; a_selected_segment: INTEGER)
			-- - (void)setSelectedSegment: (NSInteger) selectedSegment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setSelectedSegment: $a_selected_segment];"
		end

	frozen selected_segment (a_segmented_cell: POINTER): INTEGER
			-- - (NSInteger)selectedSegment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell selectedSegment];"
		end

	frozen select_segment_with_tag (a_segmented_cell: POINTER; a_tag: INTEGER): BOOLEAN
			-- - (BOOL)selectSegmentWithTag: (NSInteger) tag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell selectSegmentWithTag: $a_tag];"
		end

	frozen make_next_segment_key (a_segmented_cell: POINTER)
			-- - (void)makeNextSegmentKey
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell makeNextSegmentKey];"
		end

	frozen make_previous_segment_key (a_segmented_cell: POINTER)
			-- - (void)makePreviousSegmentKey
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell makePreviousSegmentKey];"
		end

	frozen set_tracking_mode (a_segmented_cell: POINTER; a_tracking_mode: INTEGER)
			-- - (void)setTrackingMode: (NSSegmentSwitchTracking) trackingMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setTrackingMode: $a_tracking_mode];"
		end

	frozen tracking_mode (a_segmented_cell: POINTER): INTEGER
			-- - (NSSegmentSwitchTracking)trackingMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell trackingMode];"
		end

	frozen set_width_for_segment (a_segmented_cell: POINTER; a_width: REAL; a_segment: INTEGER)
			-- - (void)setWidth: (CGFloat) width forSegment: (CGFloat) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setWidth: $a_width forSegment: $a_segment];"
		end

	frozen width_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): REAL
			-- - (CGFloat)widthForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell widthForSegment: $a_segment];"
		end

	frozen set_image_for_segment (a_segmented_cell: POINTER; a_image: POINTER; a_segment: INTEGER)
			-- - (void)setImage: (NSImage *) image forSegment: (NSImage *) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setImage: $a_image forSegment: $a_segment];"
		end

	frozen image_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): POINTER
			-- - (NSImage *)imageForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell imageForSegment: $a_segment];"
		end

	frozen set_image_scaling_for_segment (a_segmented_cell: POINTER; a_scaling: INTEGER; a_segment: INTEGER)
			-- - (void)setImageScaling: (NSImageScaling) scaling forSegment: (NSIngeger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setImageScaling: $a_scaling forSegment: $a_segment];"
		end

	frozen image_scaling_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): INTEGER
			-- - (NSImageScaling)imageScalingForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell imageScalingForSegment: $a_segment];"
		end

	frozen set_label_for_segment (a_segmented_cell: POINTER; a_label: POINTER; a_segment: INTEGER)
			-- - (void)setLabel: (NSString *) label forSegment: (NSString *) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setLabel: $a_label forSegment: $a_segment];"
		end

	frozen label_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): POINTER
			-- - (NSString *)labelForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell labelForSegment: $a_segment];"
		end

	frozen set_selected_for_segment (a_segmented_cell: POINTER; a_selected: BOOLEAN; a_segment: INTEGER)
			-- - (void)setSelected: (BOOL) selected forSegment: (BOOL) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setSelected: $a_selected forSegment: $a_segment];"
		end

	frozen is_selected_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): BOOLEAN
			-- - (BOOL)isSelectedForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell isSelectedForSegment: $a_segment];"
		end

	frozen set_enabled_for_segment (a_segmented_cell: POINTER; a_enabled: BOOLEAN; a_segment: INTEGER)
			-- - (void)setEnabled: (BOOL) enabled forSegment: (BOOL) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setEnabled: $a_enabled forSegment: $a_segment];"
		end

	frozen is_enabled_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): BOOLEAN
			-- - (BOOL)isEnabledForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell isEnabledForSegment: $a_segment];"
		end

	frozen set_menu_for_segment (a_segmented_cell: POINTER; a_menu: POINTER; a_segment: INTEGER)
			-- - (void)setMenu: (NSMenu *) menu forSegment: (NSMenu *) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setMenu: $a_menu forSegment: $a_segment];"
		end

	frozen menu_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): POINTER
			-- - (NSMenu *)menuForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell menuForSegment: $a_segment];"
		end

	frozen set_tool_tip_for_segment (a_segmented_cell: POINTER; a_tool_tip: POINTER; a_segment: INTEGER)
			-- - (void)setToolTip: (NSString *) toolTip forSegment: (NSString *) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setToolTip: $a_tool_tip forSegment: $a_segment];"
		end

	frozen tool_tip_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): POINTER
			-- - (NSString *)toolTipForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell toolTipForSegment: $a_segment];"
		end

	frozen set_tag_for_segment (a_segmented_cell: POINTER; a_tag: INTEGER; a_segment: INTEGER)
			-- - (void)setTag: (NSInteger) tag forSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setTag: $a_tag forSegment: $a_segment];"
		end

	frozen tag_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): INTEGER
			-- - (NSInteger)tagForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell tagForSegment: $a_segment];"
		end

	frozen set_segment_style (a_segmented_cell: POINTER; a_segment_style: INTEGER)
			-- - (void)setSegmentStyle: (NSSegmentStyle) segmentStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell setSegmentStyle: $a_segment_style];"
		end

	frozen segment_style (a_segmented_cell: POINTER): INTEGER
			-- - (NSSegmentStyle)segmentStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell segmentStyle];"
		end

	frozen draw_segment_in_frame_with_view (a_segmented_cell: POINTER; a_segment: INTEGER; a_frame: POINTER; a_control_view: POINTER)
			-- - (void)drawSegment: (NSInteger) segment inFrame: (NSInteger) frame withView: (NSInteger) controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedCell*)$a_segmented_cell drawSegment: $a_segment inFrame: *(NSRect*)$a_frame withView: $a_control_view];"
		end

	frozen interior_background_style_for_segment (a_segmented_cell: POINTER; a_segment: INTEGER): INTEGER
			-- - (NSBackgroundStyle)interiorBackgroundStyleForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedCell*)$a_segmented_cell interiorBackgroundStyleForSegment: $a_segment];"
		end
end
