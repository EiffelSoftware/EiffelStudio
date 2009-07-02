note
	description: "Summary description for {NS_BUTTON_CELL}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON_CELL

inherit
	NS_CELL -- should be NS_ACTION_CELL

create
	make

feature -- Creation

	make
		do
			make_from_pointer ({NS_BUTTON_CELL_API}.new)
		end

feature -- Managing Graphics Attributes

	set_bezel_style (a_bezel_style: INTEGER)
			-- Sets the appearance of the border, if the receiver has one.
		require
			valid_bezel_style: valid_bezel_style (a_bezel_style)
		do
			{NS_BUTTON_CELL_API}.set_bezel_style (item, a_bezel_style)
		end

feature -- Drawing the Button Content

	draw_bezel (a_frame: NS_RECT; a_view: NS_VIEW)
			-- Draws the border of the button using the current bezel style.
		do
			{NS_BUTTON_CELL_API}.draw_bezel_with_frame_in_view (item, a_frame.item, a_view.item)
		end

	draw_title (a_title: NS_ATTRIBUTED_STRING; a_frame: NS_RECT; a_view: NS_VIEW)
			-- Draws the button's title centered vertically in a specified rectangle.
		do
			{NS_BUTTON_CELL_API}.draw_title_with_frame_in_view (item, a_title.item, a_frame.item, a_view.item)
		end

	draw_image (a_image: NS_IMAGE; a_frame: NS_RECT; a_view: NS_VIEW)
			-- Draws the image associated with the button's current state.
		do
			{NS_BUTTON_CELL_API}.draw_image_with_frame_in_view (item, a_image.item, a_frame.item, a_view.item)
		end

feature -- Contrsact support

	valid_bezel_style (a_integer: INTEGER): BOOLEAN
		do
			Result := (<<rounded_bezel_style, regular_square_bezel_style, thick_square_bezel_style, thicker_square_bezel_style,
				disclosure_bezel_style, shadowless_square_bezel_style, circular_bezel_style, textured_square_bezel_style,
				help_button_bezel_style, small_square_bezel_style, textured_rounded_bezel_style, rounded_rect_bezel_style,
				recessed_bezel_style, rounded_disclosure_bezel_style>>).has (a_integer)
		end

feature -- NSBezelStyle Constants

	frozen rounded_bezel_style: INTEGER
			-- A rounded rectangle button, designed for text.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundedBezelStyle"
		end

	frozen regular_square_bezel_style: INTEGER
			-- A rectangular button with a 2 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRegularSquareBezelStyle"
		end

	frozen thick_square_bezel_style: INTEGER
			-- A rectangular button with a 3 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSThickSquareBezelStyle"
		end

	frozen thicker_square_bezel_style: INTEGER
			-- A rectangular button with a 4 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSThickerSquareBezelStyle"
		end

	frozen disclosure_bezel_style: INTEGER
			-- A bezel style for use with a disclosure triangle.
			-- To create the disclosure triangle, set the button bezel style to NSDisclosureBezelStyle and the button type to NSOnOffButton.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDisclosureBezelStyle"
		end

	frozen shadowless_square_bezel_style: INTEGER
			-- Similar to NSRegularSquareBezelStyle, but has no shadow so you can abut the cells without overlapping shadows.
			-- This style would be used in a tool palette, for example.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSShadowlessSquareBezelStyle"
		end

	frozen circular_bezel_style: INTEGER
			-- A round button with room for a small icon or a single character.
			-- This style has both regular and small variants, but the large variant is available only in gray at this time.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCircularBezelStyle"
		end

	frozen textured_square_bezel_style: INTEGER
			-- A bezel style appropriate for use with textured (metal) windows.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTexturedSquareBezelStyle"
		end

	frozen help_button_bezel_style: INTEGER
			-- A round button with a question mark providing the standard help button look.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSHelpButtonBezelStyle"
		end

	frozen small_square_bezel_style: INTEGER
			-- A simple square bezel style. Buttons using this style can be scaled to any size.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSmallSquareBezelStyle"
		end

	frozen textured_rounded_bezel_style: INTEGER
			-- A textured (metal) bezel style similar in appearance to the Finder's action (gear) button.
			-- The height of this button is fixed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTexturedRoundedBezelStyle"
		end

	frozen rounded_rect_bezel_style: INTEGER
			-- A bezel style that matches the search buttons in Finder and Mail.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundRectBezelStyle"
		end

	frozen recessed_bezel_style: INTEGER
			-- A bezel style that matches the recessed buttons in Mail, Finder and Safari.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRecessedBezelStyle"
		end

	frozen rounded_disclosure_bezel_style: INTEGER
			-- A bezel style that matches the disclosure style used in the standard Save panel.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundedDisclosureBezelStyle"
		end
end
