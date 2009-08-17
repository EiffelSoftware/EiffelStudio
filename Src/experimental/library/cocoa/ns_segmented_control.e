note
	description: "Summary description for {NS_SEGMENTED_CONTROL}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SEGMENTED_CONTROL

inherit
	NS_CONTROL
		redefine
			make
		end
create
	make

feature -- Creation

	make
		do
			make_from_pointer ({NS_SEGMENTED_CONTROL_API}.new)
		end

feature -- Specifying Number of Segments

	set_segment_count (a_count: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_segment_count (item, a_count.item)
		end

	segment_count: INTEGER
		do
			Result := {NS_SEGMENTED_CONTROL_API}.segment_count (item)
		end

feature -- Specifying Selected Segment

	set_selected_segment (a_selected_segment: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_selected_segment (item, a_selected_segment.item)
		end

	selected_segment: INTEGER
		do
			Result := {NS_SEGMENTED_CONTROL_API}.selected_segment (item)
		end

	select_segment_with_tag (a_tag: INTEGER): BOOLEAN
		do
			Result := {NS_SEGMENTED_CONTROL_API}.select_segment_with_tag (item, a_tag.item)
		end

feature -- Working with Individual Segments

	set_width_for_segment (a_width: REAL; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_width_for_segment (item, a_width.item, a_segment.item)
		end

	width_for_segment (a_segment: INTEGER): REAL
		do
			Result := {NS_SEGMENTED_CONTROL_API}.width_for_segment (item, a_segment.item)
		end

	set_image_for_segment (a_image: NS_IMAGE; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_image_for_segment (item, a_image.item, a_segment.item)
		end

	image_for_segment (a_segment: INTEGER): NS_IMAGE
		do
			create Result.share_from_pointer ({NS_SEGMENTED_CONTROL_API}.image_for_segment (item, a_segment.item))
		end

	set_image_scaling_for_segment (a_scaling: INTEGER; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_image_scaling_for_segment (item, a_scaling.item, a_segment.item)
		end

	image_scaling_for_segment (a_segment: INTEGER): INTEGER
		do
			Result := {NS_SEGMENTED_CONTROL_API}.image_scaling_for_segment (item, a_segment.item)
		end

	set_label_for_segment (a_label: NS_STRING; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_label_for_segment (item, a_label.item, a_segment.item)
		end

	label_for_segment (a_segment: INTEGER): NS_STRING
		do
			create Result.share_from_pointer ({NS_SEGMENTED_CONTROL_API}.label_for_segment (item, a_segment.item))
		end

	set_menu_for_segment (a_menu: NS_MENU; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_menu_for_segment (item, a_menu.item, a_segment.item)
		end

	menu_for_segment (a_segment: INTEGER): NS_MENU
		do
			create Result.share_from_pointer ({NS_SEGMENTED_CONTROL_API}.menu_for_segment (item, a_segment.item))
		end

	set_selected_for_segment (a_selected: BOOLEAN; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_selected_for_segment (item, a_selected.item, a_segment.item)
		end

	is_selected_for_segment (a_segment: INTEGER): BOOLEAN
		do
			Result := {NS_SEGMENTED_CONTROL_API}.is_selected_for_segment (item, a_segment.item)
		end

	set_enabled_for_segment (a_enabled: BOOLEAN; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CONTROL_API}.set_enabled_for_segment (item, a_enabled.item, a_segment.item)
		end

	is_enabled_for_segment (a_segment: INTEGER): BOOLEAN
		do
			Result := {NS_SEGMENTED_CONTROL_API}.is_enabled_for_segment (item, a_segment.item)
		end

feature -- Specifying Segment Display


	set_segment_style (a_segment_style: INTEGER)
		require
			valid_segment_style (a_segment_style)
		do
			{NS_SEGMENTED_CONTROL_API}.set_segment_style (item, a_segment_style)
		end

	segment_style: INTEGER
		do
			Result := {NS_SEGMENTED_CONTROL_API}.segment_style (item)
		ensure
			valid_segment_style (Result)
		end

feature -- Contract support

	valid_segment_style (a_integer: INTEGER): BOOLEAN
		do
			Result := (<<segment_style_automatic, segment_style_rounded, segment_style_textured_rounded,
						segment_style_round_rect, segment_style_capsule, segment_style_small_square>>).has (a_integer)
		end

feature -- NSSegmentStyle constants

	frozen segment_style_automatic: INTEGER
			-- The appearance of the segmented control is automatically determined based on the type of window in which the control is displayed and the position within the window.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSegmentStyleAutomatic"
		end

	frozen segment_style_rounded: INTEGER
			-- The control is displayed using the rounded style.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSegmentStyleRounded"
		end

	frozen segment_style_textured_rounded: INTEGER
			-- The control is displayed using the textured rounded style.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSegmentStyleTexturedRounded"
		end

	frozen segment_style_round_rect: INTEGER
			-- The control is displayed using the round rect style.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSegmentStyleRoundRect"
		end

	frozen segment_style_textured_square: INTEGER
			-- The control is displayed using the round rect style.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSegmentStyleTexturedSquare"
		end

	frozen segment_style_capsule: INTEGER
			-- The control is displayed using the capsule style.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSegmentStyleCapsule"
		end

	frozen segment_style_small_square: INTEGER
			-- The control is displayed using the small square style.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSegmentStyleSmallSquare"
		end
end
