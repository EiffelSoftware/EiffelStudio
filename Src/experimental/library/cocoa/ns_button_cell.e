note
	description: "Summary description for {NS_BUTTON_CELL}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON_CELL

inherit
	NS_CELL -- should be NS_ACZTION_CELL

create
	make

feature -- Creation

	make
		do
			make_from_pointer (new)
		end

feature -- Drawing the Button Content

	draw_bezel (a_frame: NS_RECT; a_view: NS_VIEW)
			-- Draws the border of the button using the current bezel style.
		do
			draw_bezel_with_frame_in_view (item, a_frame.item, a_view.item)
		end

feature -- Objective-C implementation

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSView new];"
		end

	frozen draw_bezel_with_frame_in_view (target: POINTER; a_rect: POINTER; a_view: POINTER)
			-- - (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$target drawBezelWithFrame: *(NSRect*)$a_rect inView: $a_view];"
		end


end
