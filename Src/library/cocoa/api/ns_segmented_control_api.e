note
	description: "Summary description for {NS_SEGMENTED_CONTROL_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SEGMENTED_CONTROL_API

feature -- Creation

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSSegmentedControl new];"
		end

feature -- Specifying Number of Segments

	frozen set_segment_count (a_segmented_control: POINTER; a_count: INTEGER)
			-- - (void)setSegmentCount: (NSInteger) count
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setSegmentCount: $a_count];"
		end

	frozen segment_count (a_segmented_control: POINTER): INTEGER
			-- - (NSInteger)segmentCount
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control segmentCount];"
		end

feature -- Specifying Selected Segment

	frozen set_selected_segment (a_segmented_control: POINTER; a_selected_segment: INTEGER)
			-- - (void)setSelectedSegment: (NSInteger) selectedSegment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setSelectedSegment: $a_selected_segment];"
		end

	frozen selected_segment (a_segmented_control: POINTER): INTEGER
			-- - (NSInteger)selectedSegment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control selectedSegment];"
		end

	frozen select_segment_with_tag (a_segmented_control: POINTER; a_tag: INTEGER): BOOLEAN
			-- - (BOOL)selectSegmentWithTag: (NSInteger) tag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control selectSegmentWithTag: $a_tag];"
		end

feature -- Working with Individual Segments

	frozen set_width_for_segment (a_segmented_control: POINTER; a_width: REAL; a_segment: INTEGER)
			-- - (void)setWidth: (CGFloat) width forSegment: (CGFloat) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setWidth: $a_width forSegment: $a_segment];"
		end

	frozen width_for_segment (a_segmented_control: POINTER; a_segment: INTEGER): REAL
			-- - (CGFloat)widthForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control widthForSegment: $a_segment];"
		end

	frozen set_image_for_segment (a_segmented_control: POINTER; a_image: POINTER; a_segment: INTEGER)
			-- - (void)setImage: (NSImage *) image forSegment: (NSImage *) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setImage: $a_image forSegment: $a_segment];"
		end

	frozen image_for_segment (a_segmented_control: POINTER; a_segment: INTEGER): POINTER
			-- - (NSImage *)imageForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control imageForSegment: $a_segment];"
		end

	frozen set_image_scaling_for_segment (a_segmented_control: POINTER; a_scaling: INTEGER; a_segment: INTEGER)
			-- - (void)setImageScaling: (NSImageScaling) scaling forSegment: (NSImageScaling) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setImageScaling: $a_scaling forSegment: $a_segment];"
		end

	frozen image_scaling_for_segment (a_segmented_control: POINTER; a_segment: INTEGER): INTEGER
			-- - (NSImageScaling)imageScalingForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control imageScalingForSegment: $a_segment];"
		end

	frozen set_label_for_segment (a_segmented_control: POINTER; a_label: POINTER; a_segment: INTEGER)
			-- - (void)setLabel: (NSString *) label forSegment: (NSString *) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setLabel: $a_label forSegment: $a_segment];"
		end

	frozen label_for_segment (a_segmented_control: POINTER; a_segment: INTEGER): POINTER
			-- - (NSString *)labelForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control labelForSegment: $a_segment];"
		end

	frozen set_menu_for_segment (a_segmented_control: POINTER; a_menu: POINTER; a_segment: INTEGER)
			-- - (void)setMenu: (NSMenu *) menu forSegment: (NSMenu *) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setMenu: $a_menu forSegment: $a_segment];"
		end

	frozen menu_for_segment (a_segmented_control: POINTER; a_segment: INTEGER): POINTER
			-- - (NSMenu *)menuForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control menuForSegment: $a_segment];"
		end

	frozen set_selected_for_segment (a_segmented_control: POINTER; a_selected: BOOLEAN; a_segment: INTEGER)
			-- - (void)setSelected: (BOOL) selected forSegment: (BOOL) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setSelected: $a_selected forSegment: $a_segment];"
		end

	frozen is_selected_for_segment (a_segmented_control: POINTER; a_segment: INTEGER): BOOLEAN
			-- - (BOOL)isSelectedForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control isSelectedForSegment: $a_segment];"
		end

	frozen set_enabled_for_segment (a_segmented_control: POINTER; a_enabled: BOOLEAN; a_segment: INTEGER)
			-- - (void)setEnabled: (BOOL) enabled forSegment: (BOOL) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setEnabled: $a_enabled forSegment: $a_segment];"
		end

	frozen is_enabled_for_segment (a_segmented_control: POINTER; a_segment: INTEGER): BOOLEAN
			-- - (BOOL)isEnabledForSegment: (NSInteger) segment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control isEnabledForSegment: $a_segment];"
		end

feature -- Specifying Segment Display

	frozen set_segment_style (a_segmented_control: POINTER; a_segment_style: INTEGER)
			-- - (void)setSegmentStyle: (NSSegmentStyle) segmentStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSSegmentedControl*)$a_segmented_control setSegmentStyle: $a_segment_style];"
		end

	frozen segment_style (a_segmented_control: POINTER): INTEGER
			-- - (NSSegmentStyle)segmentStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSSegmentedControl*)$a_segmented_control segmentStyle];"
		end

end
