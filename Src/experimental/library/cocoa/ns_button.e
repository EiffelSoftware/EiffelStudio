note
	description: "Wrapper for NSButton"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON

inherit
	NS_CONTROL
		redefine
			make
		end

create
	make
create {NS_OBJECT}
	share_from_pointer

feature {NONE} -- Creation

	make
			-- Create a new NSButton
		do
			make_from_pointer ({NS_BUTTON_API}.new)
			insert_in_table
		end

feature -- Configuring Buttons

	set_button_type (a_button_type: INTEGER)
			-- Sets how the receiver button highlights while pressed and how it shows its state.
			-- setButtonType: redisplays the button before returning.
			-- You can configure different behavior with the NS_BUTTON_CELL methods set_highlights_by and set_shows_state_by
			-- Note that there is no button_type method. The set method sets various button properties that together establish the behavior of the type.
		require
			valid_button_type: valid_button_type (a_button_type)
		do
			{NS_BUTTON_API}.set_button_type (item, a_button_type)
		end

	set_title (a_title: STRING_GENERAL)
			-- Sets the title displayed by the receiver when in its normal state and, if necessary, redraws the button's contents.
    		-- This title is always shown on buttons that don't use their alternate contents when highlighting or displaying their alternate state.
    	do
			{NS_BUTTON_API}.set_title (item, (create {NS_STRING}.make_with_string (a_title)).item)
		ensure
			title_set: a_title.as_string_8.is_equal (title.to_string)
		end

	title: NS_STRING
			-- Returns the title displayed on the button when it's in its normal state.
			-- The title displayed on the receiver when it's in its normal state or the empty string if the button doesn't display a title.
			-- This title is always displayed if the button doesn't use its alternate contents for highlighting or displaying the alternate state.
			-- By default, a button's title is "Button."
		do
			create Result.make_from_pointer ({NS_BUTTON_API}.title (item))
		ensure
			result_not_void: Result /= void
		end

feature -- Configuring Button Images

	image_position: INTEGER
			-- Returns the position of the image relative to the title.
		do
			Result := {NS_BUTTON_API}.image_position (item)
		end

	set_image_position (a_position: INTEGER)
			-- Sets the position of the button's image relative to its title.
		require
			valid_position:
		do
			{NS_BUTTON_API}.set_image_position (item, a_position)
		ensure
			position_set: a_position = image_position
		end

	image: detachable NS_IMAGE
			-- Returns the image that appears on the receiver when it's in its normal state, Void if there is no such image.
			-- This image is always displayed on a button that doesn't change its contents when highlighting or showing its alternate state. Buttons don't display images by default.
		local
			l_image: POINTER
		do
			l_image := {NS_BUTTON_API}.image (item)
			if l_image /= default_pointer then
				create Result.make_from_pointer (l_image)
			end
		end

	set_image (a_image: NS_IMAGE)
			-- Sets the receiver's image and redraws the button.
			-- The button's image. A button's image is displayed when the button is in its normal state, or all the time for a button that
			-- doesn't change its contents when highlighting or displaying its alternate state.
		do
			{NS_BUTTON_API}.set_image (item, a_image.item)
		ensure
			--image_set: a_image = image -- not true for every button type it seems
		end

	set_bezel_style (a_style: INTEGER)
			-- Sets the appearance of the border, if the receiver has one.
			-- If the button is not bordered, the bezel style is ignored.
			-- The button uses shading to look like it's sticking out or pushed in.
			-- You can set the shading with the NS_BUTTON_CELL method set_gradient_type.
		require
			valid_style: valid_bezel_style (a_style)
		do
			{NS_BUTTON_API}.set_bezel_style (item, a_style)
		ensure
			bezel_style_set: -- TODO
		end

feature -- Managing the button state

	state: INTEGER
			-- Returns the receiver's state.
			-- The button's state. A button can have two or three states. If it has two, this value is either NSOffState (the normal or unpressed state) or NSOnState (the alternate or pressed state). If it has three, this value can be NSOnState (the feature is in effect everywhere), NSOffState (the feature is in effect nowhere), or NSMixedState (the feature is in effect somewhere).
			-- To check whether the button uses the mixed state, use the method allowsMixedState.
		do
			Result := {NS_BUTTON_API}.state (item)
		end

	set_state (a_state: INTEGER)
			-- Sets the cell's state to the specified value. This can be NSOnState, NSOffState,NSMixedState. See the discussion for a more detailed explanation.
			-- If necessary, this method also redraws the receiver.
			-- The cell can have two or three states. If it has two, value can be NSOffState (the normal or unpressed state) and NSOnState (the alternate or pressed state).
			-- If it has three, value can be NSOnState (the feature is in effect everywhere), NSOffState (the feature is in effect nowhere), or NSMixedState (the feature is in effect somewhere).
			-- Note that if the cell has only two states and value is NSMixedState, this method sets the cell's state to NSOnState.
			-- Although using the enumerated constants is preferred, value can also be an integer. If the cell has two states, 0 is treated as NSOffState, and a nonzero value is treated as NSOnState.
			-- If the cell has three states, 0 is treated as NSOffState; a negative value, as NSMixedState; and a positive value, as NSOnState.
			-- To check whether the button uses the mixed state, use the method allowsMixedState.
		require
			valid_state:
		do
			{NS_BUTTON_API}.set_state (item, a_state)
		ensure
			state_set: state = a_state
		end

feature -- Accessing Key Equivalents

	set_key_equivalent (a_string: STRING_GENERAL)
			-- Sets the key equivalent character of the receiver to the given character.
			-- This method redraws the button's interior if it displays a key equivalent instead of an image.
			-- The key equivalent isn't displayed if the image position is set to NSNoImage, NSImageOnly, or NSImageOverlaps; that is,
			-- the button must display both its title and its "image" (the key equivalent in this case), and they must not overlap.
			-- To display a key equivalent on a button, set the image and alternate image to nil, then set the key equivalent, then set the image position.
		do
			{NS_BUTTON_API}.set_key_equivalent (item, (create {NS_STRING}.make_with_string (a_string)).item)
		ensure
			key_equivalent_set: -- TODO
		end

feature -- Handling Keyboard Events



feature -- Contract support

	valid_button_type (a_integer: INTEGER): BOOLEAN
		do
			Result := (<<push_on_push_off_button, toggle_button, switch_button, radio_button>>).has (a_integer)
		end

	valid_bezel_style (a_integer: INTEGER): BOOLEAN
		do
			Result := (<<rounded_bezel_style, rectangular_square_bezel_style, thick_square_bezel_style, thicker_square_bezel_style,
				disclosure_bezel_style, shadowless_square_bezel_style, circular_bezel_style, textured_square_bezel_style,
				help_button_bezel_style, small_square_bezel_style, textured_rounded_bezel_style, rounded_rect_bezel_style,
				recessed_bezel_style, rounded_disclosure_bezel_style>>).has (a_integer)
		end

feature -- NSButtonType Constants

--    NSMomentaryLightButton		= 0,	// was NSMomentaryPushButton

	frozen push_on_push_off_button: INTEGER
			--    NSPushOnPushOffButton
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPushOnPushOffButton"
		end

	frozen toggle_button: INTEGER
    		-- NSToggleButton
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSToggleButton"
		end

	frozen switch_button: INTEGER
			-- NSSwitchButton
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSwitchButton"
		end

	frozen radio_button: INTEGER
			-- NSRadioButton
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRadioButton"
		end
--    NSMomentaryChangeButton		= 5,
--    NSOnOffButton			= 6,
--    NSMomentaryPushInButton		= 7,	// was NSMomentaryLight

--    /* These constants were accidentally reversed so that NSMomentaryPushButton lit and
--       NSMomentaryLight pushed. These names are now deprecated */
--
--    NSMomentaryPushButton		= 0,
--    NSMomentaryLight			= 7


feature -- NSBezelStyle Constants

	frozen rounded_bezel_style: INTEGER
			-- NSRoundedBezelStyle
			-- A rounded rectangle button, designed for text.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundedBezelStyle"
		end

	frozen rectangular_square_bezel_style: INTEGER
			-- NSRegularSquareBezelStyle
			-- A rectangular button with a 2 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRegularSquareBezelStyle"
		end

	frozen thick_square_bezel_style: INTEGER
			-- NSThickSquareBezelStyle
			-- A rectangular button with a 3 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSThickSquareBezelStyle"
		end

	frozen thicker_square_bezel_style: INTEGER
			-- NSThickerSquareBezelStyle
			-- A rectangular button with a 4 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSThickerSquareBezelStyle"
		end

	frozen disclosure_bezel_style: INTEGER
			-- NSDisclosureBezelStyle
			-- A bezel style for use with a disclosure triangle.
			-- To create the disclosure triangle, set the button bezel style to NSDisclosureBezelStyle and the button type to NSOnOffButton.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDisclosureBezelStyle"
		end

	frozen shadowless_square_bezel_style: INTEGER
			-- NSShadowlessSquareBezelStyle
			-- Similar to NSRegularSquareBezelStyle, but has no shadow so you can abut the cells without overlapping shadows.
			-- This style would be used in a tool palette, for example.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSShadowlessSquareBezelStyle"
		end

	frozen circular_bezel_style: INTEGER
			-- NSCircularBezelStyle
			-- A round button with room for a small icon or a single character.
			-- This style has both regular and small variants, but the large variant is available only in gray at this time.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCircularBezelStyle"
		end

	frozen textured_square_bezel_style: INTEGER
			-- NSTexturedSquareBezelStyle
			-- A bezel style appropriate for use with textured (metal) windows.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTexturedSquareBezelStyle"
		end

	frozen help_button_bezel_style: INTEGER
			-- NSHelpButtonBezelStyle
			-- A round button with a question mark providing the standard help button look.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSHelpButtonBezelStyle"
		end

	frozen small_square_bezel_style: INTEGER
			-- NSSmallSquareBezelStyle
			-- A simple square bezel style. Buttons using this style can be scaled to any size.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSmallSquareBezelStyle"
		end

	frozen textured_rounded_bezel_style: INTEGER
			-- NSTexturedRoundedBezelStyle
			-- A textured (metal) bezel style similar in appearance to the Finder's action (gear) button.
			-- The height of this button is fixed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTexturedRoundedBezelStyle"
		end

	frozen rounded_rect_bezel_style: INTEGER
			-- NSRoundRectBezelStyle
			-- A bezel style that matches the search buttons in Finder and Mail.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundRectBezelStyle"
		end

	frozen recessed_bezel_style: INTEGER
			-- NSRecessedBezelStyle
			-- A bezel style that matches the recessed buttons in Mail, Finder and Safari.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRecessedBezelStyle"
		end

	frozen rounded_disclosure_bezel_style: INTEGER
			-- NSRoundedDisclosureBezelStyle
			-- A bezel style that matches the disclosure style used in the standard Save panel.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundedDisclosureBezelStyle"
		end

end
