note
	description: "Summary description for {NS_SEGMENTED_CELL}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SEGMENTED_CELL

inherit
	NS_CELL -- TODO: should be NS_ACTION_CELL

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_SEGMENTED_CELL_API}.new)
		end

feature -- Specifying the Number of Segments

feature -- Specifying the Selected Segment

feature -- Specifying the Tracking Mode

feature -- Configuring Individual Segments

feature -- Drawing Custom Content

	draw_segment (a_segment: INTEGER; a_frame: NS_RECT; a_control_view: NS_VIEW)
			-- Draws the segment in the specified view.
		do
			{NS_SEGMENTED_CELL_API}.draw_segment_in_frame_with_view (item, a_segment, a_frame.item, a_control_view.item)
		end

feature -- Specifying Segment Visual Styles

	set_segment_count (a_count: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_segment_count (item, a_count)
		end

	segment_count: INTEGER
		do
			Result := {NS_SEGMENTED_CELL_API}.segment_count (item)
		end

	set_selected_segment (a_selected_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_selected_segment (item, a_selected_segment)
		end

	selected_segment: INTEGER
		do
			Result := {NS_SEGMENTED_CELL_API}.selected_segment (item)
		end

	select_segment_with_tag (a_tag: INTEGER): BOOLEAN
		do
			Result := {NS_SEGMENTED_CELL_API}.select_segment_with_tag (item, a_tag)
		end

	make_next_segment_key
		do
			{NS_SEGMENTED_CELL_API}.make_next_segment_key (item)
		end

	make_previous_segment_key
		do
			{NS_SEGMENTED_CELL_API}.make_previous_segment_key (item)
		end

	set_tracking_mode (a_tracking_mode: INTEGER)
		require
			-- NS_SEGMENT_SWITCH_TRACKING
		do
			{NS_SEGMENTED_CELL_API}.set_tracking_mode (item, a_tracking_mode)
		end

	tracking_mode: INTEGER
		do
			Result := {NS_SEGMENTED_CELL_API}.tracking_mode (item)
		ensure
			-- NS_SEGMENT_SWITCH_TRACKING
		end

	set_width_for_segment (a_width: REAL; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_width_for_segment (item, a_width, a_segment)
		end

	width_for_segment (a_segment: INTEGER): REAL
		do
			Result := {NS_SEGMENTED_CELL_API}.width_for_segment (item, a_segment)
		end

	set_image_for_segment (a_image: NS_IMAGE; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_image_for_segment (item, a_image.item, a_segment)
		end

	image_for_segment (a_segment: INTEGER): NS_IMAGE
		do
			create Result.share_from_pointer ({NS_SEGMENTED_CELL_API}.image_for_segment (item, a_segment))
		end

--	set_image_scaling_for_segment (a_scaling: NS_IMAGE_SCALING; a_segment: INTEGER)
--		do
--			{NS_SEGMENTED_CELL_API}.set_image_scaling_for_segment (item, a_scaling.item, a_segment)
--		end

--	image_scaling_for_segment (a_segment: INTEGER): NS_IMAGE_SCALING
--		do
--			create Result.make
--			{NS_SEGMENTED_CELL_API}.image_scaling_for_segment (item, a_segment, Result.item)
--		end

	set_label_for_segment (a_label: NS_STRING; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_label_for_segment (item, a_label.item, a_segment)
		end

	label_for_segment (a_segment: INTEGER): NS_STRING
		do
			create Result.share_from_pointer ({NS_SEGMENTED_CELL_API}.label_for_segment (item, a_segment))
		end

	set_selected_for_segment (a_selected: BOOLEAN; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_selected_for_segment (item, a_selected, a_segment)
		end

	is_selected_for_segment (a_segment: INTEGER): BOOLEAN
		do
			Result := {NS_SEGMENTED_CELL_API}.is_selected_for_segment (item, a_segment)
		end

	set_enabled_for_segment (a_enabled: BOOLEAN; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_enabled_for_segment (item, a_enabled, a_segment)
		end

	is_enabled_for_segment (a_segment: INTEGER): BOOLEAN
		do
			Result := {NS_SEGMENTED_CELL_API}.is_enabled_for_segment (item, a_segment)
		end

	set_menu_for_segment (a_menu: NS_MENU; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_menu_for_segment (item, a_menu.item, a_segment)
		end

	menu_for_segment (a_segment: INTEGER): NS_MENU
		do
			create Result.share_from_pointer ({NS_SEGMENTED_CELL_API}.menu_for_segment (item, a_segment))
		end

	set_tool_tip_for_segment (a_tool_tip: NS_STRING; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_tool_tip_for_segment (item, a_tool_tip.item, a_segment)
		end

	tool_tip_for_segment (a_segment: INTEGER): NS_STRING
		do
			create Result.share_from_pointer ({NS_SEGMENTED_CELL_API}.tool_tip_for_segment (item, a_segment))
		end

	set_tag_for_segment (a_tag: INTEGER; a_segment: INTEGER)
		do
			{NS_SEGMENTED_CELL_API}.set_tag_for_segment (item, a_tag, a_segment)
		end

	tag_for_segment (a_segment: INTEGER): INTEGER
		do
			Result := {NS_SEGMENTED_CELL_API}.tag_for_segment (item, a_segment)
		end

	set_segment_style (a_segment_style: INTEGER)
		require
			valid_segment_style: --NS_SEGMENT_STYLE
		do
			{NS_SEGMENTED_CELL_API}.set_segment_style (item, a_segment_style)
		end

	segment_style: INTEGER
		do
			Result := {NS_SEGMENTED_CELL_API}.segment_style (item)
		ensure
			valid_segment_style: --NS_SEGMENT_STYLE
		end

	interior_background_style_for_segment (a_segment: INTEGER): INTEGER
		do
			Result := {NS_SEGMENTED_CELL_API}.interior_background_style_for_segment (item, a_segment)
		ensure
			valid_background_style:-- NS_BACKGROUND_STYLE
		end

end
