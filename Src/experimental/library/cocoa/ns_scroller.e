note
	description: "Wrapper for NSScroller."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLLER

inherit
	NS_CONTROL
		redefine
			make
		end

create
	make,
	make_with_frame

create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_SCROLLER_API}.new)
		end

	make_with_frame (a_rect: NS_RECT)
			-- Note: The dimensions with which the NSScroller gets initialized define its orientation (vertical/horizontal)
		do
			make_from_pointer ({NS_SCROLLER_API}.init_with_frame ({NS_SCROLLER_API}.alloc, a_rect.item))
		end

feature -- Determining NSScroller Size

--	scroller_width_for_control_size (a_control_size: NATURAL): REAL
--			-- Returns the width of the scroller based on <em>controlSize</em>.
--		do
--			Result := {NS_SCROLLER_API}.scroller_width_for_control_size (a_control_size)
--		end

	set_control_size (a_control_size: NATURAL)
			-- Sets the size of the receiver.
		do
			{NS_SCROLLER_API}.set_control_size (item, a_control_size)
		end

	control_size: NATURAL
			-- Returns the size of the receiver.
		do
			Result := {NS_SCROLLER_API}.control_size (item)
		end

feature -- Laying out an NSScroller

	set_arrows_position (a_where: NATURAL)
			-- Sets the location of the scroll buttons within the receiver to <em>location</em>, or inhibits their display.
		do
			{NS_SCROLLER_API}.set_arrows_position (item, a_where)
		end

	arrows_position: NATURAL
			-- Returns the location of the scroll buttons within the receiver, as described in `NSScrollArrowPosition'.
		do
			Result := {NS_SCROLLER_API}.arrows_position (item)
		end

feature -- Setting the Knob Position

	set_knob_proportion (a_proportion: REAL)
			-- Sets the proportion of the knob slot the knob should fill.
		do
			{NS_SCROLLER_API}.set_knob_proportion (item, a_proportion)
		end

	knob_proportion: REAL
			-- Returns the portion of the knob slot the knob should fill, as a floating-point value from 0.0 (minimal size) to 1.0 (fills the slot).
		do
			Result := {NS_SCROLLER_API}.knob_proportion (item)
		end

feature -- Calculating Layout

	rect_for_part (a_part_code: NATURAL): NS_RECT
			-- Returns the rectangle occupied by <em>aPart</em>, which for this method is interpreted literally rather than as an indicator of scrolling direction.
		do
			create Result.make
			{NS_SCROLLER_API}.rect_for_part (item, a_part_code, Result.item)
		end

	test_part (a_the_point: NS_POINT): NATURAL
			-- Returns the part that would be hit by a mouse-down event at <em>aPoint</em> (expressed in the window`s coordinate system).
		do
			Result := {NS_SCROLLER_API}.test_part (item, a_the_point.item)
		end

	check_space_for_parts
			-- Checks to see if there is enough room in the receiver to display the knob and buttons.
		do
			{NS_SCROLLER_API}.check_space_for_parts (item)
		end

	usable_parts: NATURAL
			-- Returns a value indicating which parts of the receiver are displayed and usable.
		do
			Result := {NS_SCROLLER_API}.usable_parts (item)
		end

feature -- Drawing the Parts

	draw_arrow_highlight (a_which_arrow: NATURAL; a_flag: BOOLEAN)
			-- Draws the scroll button indicated by <em>arrow</em>, which is either `NSScrollerIncrementArrow' (the down or right scroll button) or `NSScrollerDecrementArrow' (up or left).
		do
			{NS_SCROLLER_API}.draw_arrow_highlight (item, a_which_arrow, a_flag)
		end

	draw_knob_slot_in_rect_highlight (a_slot_rect: NS_RECT; a_flag: BOOLEAN)
			-- Draws the portion of the scroller`s track, possibly including the line increment and decrement arrow buttons, that falls in the given slotRect.
		do
			{NS_SCROLLER_API}.draw_knob_slot_in_rect_highlight (item, a_slot_rect.item, a_flag)
		end

	draw_knob
			-- Draws the knob.
		do
			{NS_SCROLLER_API}.draw_knob (item)
		end

	draw_parts
			-- Caches images for the scroll buttons and knob.
		do
			{NS_SCROLLER_API}.draw_parts (item)
		end

	highlight (a_flag: BOOLEAN)
			-- Highlights or unhighlights the scroll button the user clicked.
		do
			{NS_SCROLLER_API}.highlight (item, a_flag)
		end

feature -- Event Handling

	hit_part: NATURAL
			-- Returns a part code indicating the manner in which the scrolling should be performed.
		do
			Result := {NS_SCROLLER_API}.hit_part (item)
		end

	track_knob (a_the_event: NS_EVENT)
			-- Tracks the knob and sends action messages to the receiver`s target.
		do
			{NS_SCROLLER_API}.track_knob (item, a_the_event.item)
		end

	track_scroll_buttons (a_the_event: NS_EVENT)
			-- Tracks the scroll buttons and sends action messages to the receiver`s target.
		do
			{NS_SCROLLER_API}.track_scroll_buttons (item, a_the_event.item)
		end

feature -- Setting Control Tint

	control_tint: NATURAL
			-- Returns the receiver`s control tint.
		do
			Result := {NS_SCROLLER_API}.control_tint (item)
		end

	set_control_tint (a_control_tint: NATURAL)
			-- Sets the receiver`s control tint.
		do
			{NS_SCROLLER_API}.set_control_tint (item, a_control_tint)
		end

feature -- Constant

	frozen scroller_width: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScroller scrollerWidth];"
		end

end
