note
	description: "Summary description for {NS_BUTTON_CELL_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON_CELL_API

feature -- Creation

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSButtonCell new];"
		end

feature -- Managing Graphics Attributes

	frozen set_bezel_style (target: POINTER; a_bezel_style: INTEGER)
			-- - (void)setBezelStyle:(NSBezelStyle)bezelStyle
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$target setBezelStyle: $a_bezel_style];"
		end

feature -- Drawing the Button Content

	frozen draw_bezel_with_frame_in_view (target: POINTER; a_rect: POINTER; a_view: POINTER)
			-- - (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$target drawBezelWithFrame: *(NSRect*)$a_rect inView: $a_view];"
		end

	frozen draw_title_with_frame_in_view (target: POINTER; a_title: POINTER; a_rect: POINTER; a_view: POINTER)
			-- - (NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$target drawTitle: $a_title withFrame:*(NSRect*)$a_rect inView: $a_view];"
		end

	frozen draw_image_with_frame_in_view (target: POINTER; a_image: POINTER; a_rect: POINTER; a_view: POINTER)
			-- - (void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSButtonCell*)$target drawImage: $a_image withFrame:*(NSRect*)$a_rect inView: $a_view];"
		end

end
