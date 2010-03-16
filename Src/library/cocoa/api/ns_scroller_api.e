note
	description: "Summary description for {NS_SCROLLER_API}."
	author: "Daniel  Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLLER_API

feature -- Creation

	frozen new: POINTER
			-- Create a new NSScroller
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScroller new];"
		end

	frozen alloc: POINTER
			-- Create a new NSScroller
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScroller alloc];"
		end

	frozen init_with_frame (a_ns_scroller: POINTER; a_rect: POINTER): POINTER
			-- Create a new NSScroller
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScroller*)$a_ns_scroller initWithFrame: *(NSRect*)$a_rect];"
		end


feature -- Determining NSScroller Size

	frozen scroller_width: REAL
			-- + (CGFloat)scrollerWidth
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScroller scrollerWidth];"
		end

	frozen scroller_width_for_control_size (a_control_size: NATURAL): REAL
			-- + (CGFloat)scrollerWidthForControlSize: (NSControlSize) controlSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScroller scrollerWidthForControlSize: $a_control_size];"
		end

	frozen set_control_size (a_ns_scroller: POINTER; a_control_size: NATURAL)
			-- - (void)setControlSize: (NSControlSize) controlSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller setControlSize: $a_control_size];"
		end

	frozen control_size (a_ns_scroller: POINTER): NATURAL
			-- - (NSControlSize)controlSize
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScroller*)$a_ns_scroller controlSize];"
		end

feature -- Laying out an NSScroller

	frozen set_arrows_position (a_ns_scroller: POINTER; a_where: NATURAL)
			-- - (void)setArrowsPosition: (NSScrollArrowPosition) where
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller setArrowsPosition: $a_where];"
		end

	frozen arrows_position (a_ns_scroller: POINTER): NATURAL
			-- - (NSScrollArrowPosition)arrowsPosition
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScroller*)$a_ns_scroller arrowsPosition];"
		end

feature -- Setting the Knob Position

	frozen set_knob_proportion (a_ns_scroller: POINTER; a_proportion: REAL)
			-- - (void)setKnobProportion: (CGFloat) proportion
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller setKnobProportion: $a_proportion];"
		end

	frozen knob_proportion (a_ns_scroller: POINTER): REAL
			-- - (CGFloat)knobProportion
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScroller*)$a_ns_scroller knobProportion];"
		end

feature -- Calculating Layout

	frozen rect_for_part (a_ns_scroller: POINTER; a_part_code: NATURAL; res: POINTER)
			-- - (NSRect)rectForPart: (NSScrollerPart) partCode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSScroller*)$a_ns_scroller rectForPart: $a_part_code]; memcpy($res, &rect, sizeof(NSRect));"
		end

	frozen test_part (a_ns_scroller: POINTER; a_the_point: POINTER): NATURAL
			-- - (NSScrollerPart)testPart: (NSPoint) thePoint
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScroller*)$a_ns_scroller testPart: *(NSPoint*)$a_the_point];"
		end

	frozen check_space_for_parts (a_ns_scroller: POINTER)
			-- - (void)checkSpaceForParts
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller checkSpaceForParts];"
		end

	frozen usable_parts (a_ns_scroller: POINTER): NATURAL
			-- - (NSUsableScrollerParts)usableParts
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScroller*)$a_ns_scroller usableParts];"
		end

feature -- Drawing the Parts

	frozen draw_arrow_highlight (a_ns_scroller: POINTER; a_which_arrow: NATURAL; a_flag: BOOLEAN)
			-- - (void)drawArrow: (NSScrollerArrow) whichArrow highlight: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller drawArrow: $a_which_arrow highlight: $a_flag];"
		end

	frozen draw_knob_slot_in_rect_highlight (a_ns_scroller: POINTER; a_slot_rect: POINTER; a_flag: BOOLEAN)
			-- - (void)drawKnobSlotInRect: (NSRect) slotRect highlight: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller drawKnobSlotInRect: *(NSRect*)$a_slot_rect highlight: $a_flag];"
		end

	frozen draw_knob (a_ns_scroller: POINTER)
			-- - (void)drawKnob
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller drawKnob];"
		end

	frozen draw_parts (a_ns_scroller: POINTER)
			-- - (void)drawParts
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller drawParts];"
		end

	frozen highlight (a_ns_scroller: POINTER; a_flag: BOOLEAN)
			-- - (void)highlight: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller highlight: $a_flag];"
		end

feature -- Event Handling

	frozen hit_part (a_ns_scroller: POINTER): NATURAL
			-- - (NSScrollerPart)hitPart
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScroller*)$a_ns_scroller hitPart];"
		end

	frozen track_knob (a_ns_scroller: POINTER; a_the_event: POINTER)
			-- - (void)trackKnob: (NSEvent *) theEvent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller trackKnob: $a_the_event];"
		end

	frozen track_scroll_buttons (a_ns_scroller: POINTER; a_the_event: POINTER)
			-- - (void)trackScrollButtons: (NSEvent *) theEvent
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller trackScrollButtons: $a_the_event];"
		end

feature -- Setting Control Tint

	frozen control_tint (a_ns_scroller: POINTER): NATURAL
			-- - (NSControlTint)controlTint
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScroller*)$a_ns_scroller controlTint];"
		end

	frozen set_control_tint (a_ns_scroller: POINTER; a_control_tint: NATURAL)
			-- - (void)setControlTint: (NSControlTint) controlTint
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScroller*)$a_ns_scroller setControlTint: $a_control_tint];"
		end
end
