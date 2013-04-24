note
	description: "Summary description for {NS_BUTTON_CELL}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BUTTON_CELL

inherit
	NS_CELL -- should be NS_ACTION_CELL
		redefine
			title,
			set_title
		end

create
	make
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature -- Creation

	make
			-- Create a new NS_BUTTON_CELL
		do
			make_from_pointer ({NS_BUTTON_CELL_API}.new)
		end

feature -- Setting Titles

	alternate_mnemonic: NS_STRING
			-- Returns the character in the alternate title that`s marked as the "keyboard mnemonic."
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.alternate_mnemonic (item))
		end

	alternate_mnemonic_location: INTEGER
			-- Returns an unsigned integer indicating the character in the alternate title that`s marked as the "keyboard mnemonic."
		do
			Result := {NS_BUTTON_CELL_API}.alternate_mnemonic_location (item)
		end

	alternate_title: NS_STRING
			-- Returns the string displayed by the button when it`s in its alternate state.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.alternate_title (item))
		end

	attributed_alternate_title: NS_ATTRIBUTED_STRING
			-- Returns the title displayed by the button when it`s in its alternate state, as an attributed string.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.attributed_alternate_title (item))
		end

	attributed_title: NS_ATTRIBUTED_STRING
			-- Returns the title displayed by the button when it`s in its normal state as an attributed string.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.attributed_title (item))
		end

	set_alternate_mnemonic_location (a_location: INTEGER)
			-- Sets the character in the alternate title that should be the "keyboard mnemonic."
		do
			{NS_BUTTON_CELL_API}.set_alternate_mnemonic_location (item, a_location)
		end

	set_alternate_title (a_string: NS_STRING)
			-- Sets the title the button displays when it`s in its alternate state.
		do
			{NS_BUTTON_CELL_API}.set_alternate_title (item, a_string.item)
		end

	set_alternate_title_with_mnemonic (a_string_with_ampersand: NS_STRING)
			-- Sets the title the button displays when it`s in its alternate state to the given string with an embedded mnemonic.
		do
			{NS_BUTTON_CELL_API}.set_alternate_title_with_mnemonic (item, a_string_with_ampersand.item)
		end

	set_attributed_alternate_title (a_obj: NS_ATTRIBUTED_STRING)
			-- Sets the string the button displays when it`s in its alternate state to the given attributed string.
		do
			{NS_BUTTON_CELL_API}.set_attributed_alternate_title (item, a_obj.item)
		end

	set_attributed_title (a_obj: NS_ATTRIBUTED_STRING)
			-- Sets the string the button displays when it`s in its normal state to the given attributed string and redraws the button.
		do
			{NS_BUTTON_CELL_API}.set_attributed_title (item, a_obj.item)
		end

	set_font (a_font_obj: NS_FONT)
			-- Sets the font used to display the button`s title and alternate title.
		do
			{NS_BUTTON_CELL_API}.set_font (item, a_font_obj.item)
		end

	set_title (a_string: NS_STRING)
			-- Sets the title the button displays when in its normal state and, if necessary, redraws the receiver`s contents.
		do
			{NS_BUTTON_CELL_API}.set_title (item, a_string.item)
		end

	set_title_with_mnemonic (a_string_with_ampersand: NS_STRING)
			-- Sets the title the button displays when it`s in its normal state to the given string with an embedded mnemonic.
		do
			{NS_BUTTON_CELL_API}.set_title_with_mnemonic (item, a_string_with_ampersand.item)
		end

	title: NS_STRING
			-- Returns the title displayed on the receiver when it`s in its normal state.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.title (item))
		end

feature -- Managing Images

	alternate_image: NS_IMAGE
			-- Returns the image the button displays in its alternate state.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.alternate_image (item))
		end

	image_position: NATURAL
			-- Returns the position of the receiver`s image relative to its title.
		do
			Result := {NS_BUTTON_CELL_API}.image_position (item)
		end

	set_alternate_image (a_image: NS_IMAGE)
			-- Sets the image the button displays in its alternate state and, if necessary, redraws its contents.
		do
			{NS_BUTTON_CELL_API}.set_alternate_image (item, a_image.item)
		end

	set_image_position (a_position: NATURAL)
			-- Sets the position of the receiver`s image relative to its title.
		do
			{NS_BUTTON_CELL_API}.set_image_position (item, a_position)
		end

	image_scaling: NATURAL
			-- Returns the scale factor for the receiver`s image.
		do
			Result := {NS_BUTTON_CELL_API}.image_scaling (item)
		end

	set_image_scaling (a_scaling: NATURAL)
			-- Sets the scale factor for the receiver`s image.
		do
			{NS_BUTTON_CELL_API}.set_image_scaling (item, a_scaling)
		end

feature -- Managing the Repeat Interval

	get_periodic_delay_interval: TUPLE [a_delay: REAL; a_interval: REAL]
			-- Returns by reference the delay and interval periods for a continuous button.
		local
			l_delay, l_interval: REAL
		do
			{NS_BUTTON_CELL_API}.get_periodic_delay_interval (item, $l_delay, $l_interval)
			Result := [l_delay, l_interval]
		end

	set_periodic_delay_interval (a_delay: REAL; a_interval: REAL)
			-- Sets the message delay and interval for the receiver.
		do
			{NS_BUTTON_CELL_API}.set_periodic_delay_interval (item, a_delay, a_interval)
		end

feature -- Managing the Key Equivalent

	key_equivalent: NS_STRING
			-- Returns the receiver`s key-equivalent character.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.key_equivalent (item))
		end

	key_equivalent_font: NS_FONT
			-- Returns the font used to draw the key equivalent.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.key_equivalent_font (item))
		end

	key_equivalent_modifier_mask: INTEGER
			-- Returns the mask identifying the modifier keys for the button`s key equivalent.
		do
			Result := {NS_BUTTON_CELL_API}.key_equivalent_modifier_mask (item)
		end

	set_key_equivalent (a_key_equivalent: NS_STRING)
			-- Sets the key equivalent character of the receiver.
		do
			{NS_BUTTON_CELL_API}.set_key_equivalent (item, a_key_equivalent.item)
		end

	set_key_equivalent_modifier_mask (a_mask: INTEGER)
			-- Sets the mask identifying the modifier keys to use with the button`s key equivalent.
		do
			{NS_BUTTON_CELL_API}.set_key_equivalent_modifier_mask (item, a_mask)
		end

	set_key_equivalent_font (a_font_obj: NS_FONT)
			-- Sets the font used to draw the key equivalent and redisplays the receiver if necessary.
		do
			{NS_BUTTON_CELL_API}.set_key_equivalent_font (item, a_font_obj.item)
		end

	set_key_equivalent_font_size (a_font_name: NS_STRING; a_font_size: REAL)
			-- Sets by name and size of the font used to draw the key equivalent.
		do
			{NS_BUTTON_CELL_API}.set_key_equivalent_font_size (item, a_font_name.item, a_font_size)
		end

feature -- Managing Graphics Attributes

	background_color: NS_COLOR
			-- Returns the background color of the receiver.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.background_color (item))
		end

	set_background_color (a_color: NS_COLOR)
			-- Sets the background color of the receiver.
		do
			{NS_BUTTON_CELL_API}.set_background_color (item, a_color.item)
		end

	bezel_style: NATURAL
			-- Returns the appearance of the receiver`s border.
		do
			Result := {NS_BUTTON_CELL_API}.bezel_style (item)
		end

	set_bezel_style (a_bezel_style: NATURAL)
			-- Sets the appearance of the border, if the receiver has one.
		do
			{NS_BUTTON_CELL_API}.set_bezel_style (item, a_bezel_style)
		end

	gradient_type: NATURAL
			-- Returns the gradient of the receiver`s border.
		do
			Result := {NS_BUTTON_CELL_API}.gradient_type (item)
		end

	set_gradient_type (a_type: NATURAL)
			-- Sets the type of gradient to use for the receiver.
		do
			{NS_BUTTON_CELL_API}.set_gradient_type (item, a_type)
		end

	image_dims_when_disabled: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver`s image and text appear "dim" when the receiver is disabled.
		do
			Result := {NS_BUTTON_CELL_API}.image_dims_when_disabled (item)
		end

	set_image_dims_when_disabled (a_flag: BOOLEAN)
			-- Sets whether the receiver`s image appears "dim" when the button cell is disabled.
		do
			{NS_BUTTON_CELL_API}.set_image_dims_when_disabled (item, a_flag)
		end

	is_opaque: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver is opaque.
		do
			Result := {NS_BUTTON_CELL_API}.is_opaque (item)
		end

	is_transparent: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver is transparent.
		do
			Result := {NS_BUTTON_CELL_API}.is_transparent (item)
		end

	set_transparent (a_flag: BOOLEAN)
			-- Sets whether the receiver is transparent.
		do
			{NS_BUTTON_CELL_API}.set_transparent (item, a_flag)
		end

	shows_border_only_while_mouse_inside: BOOLEAN
			-- Returns a Boolean value indicating whether the button displays its border only when the cursor is over it.
		do
			Result := {NS_BUTTON_CELL_API}.shows_border_only_while_mouse_inside (item)
		end

	set_shows_border_only_while_mouse_inside (a_show: BOOLEAN)
			-- Sets whether the receiver`s border is displayed only when the cursor is over the button.
		do
			{NS_BUTTON_CELL_API}.set_shows_border_only_while_mouse_inside (item, a_show)
		end

feature -- Displaying the Cell

	highlights_by: INTEGER
			-- Returns flags indicating how the button highlights when it receives a mouse-down event.
		do
			Result := {NS_BUTTON_CELL_API}.highlights_by (item)
		end

	set_highlights_by (a_type: INTEGER)
			-- Sets the way the receiver highlights itself while pressed.
		do
			{NS_BUTTON_CELL_API}.set_highlights_by (item, a_type)
		end

	set_shows_state_by (a_type: INTEGER)
			-- Sets the way the receiver indicates its alternate state.
		do
			{NS_BUTTON_CELL_API}.set_shows_state_by (item, a_type)
		end

	set_button_type (a_type: NATURAL)
			-- Sets how the receiver highlights while pressed and how it shows its state.
		do
			{NS_BUTTON_CELL_API}.set_button_type (item, a_type)
		end

	shows_state_by: INTEGER
			-- Returns the flags indicating how the button cell shows its alternate state.
		do
			Result := {NS_BUTTON_CELL_API}.shows_state_by (item)
		end

feature -- Managing the Sound

	sound: NS_SOUND
			-- Returns the sound that`s played when the user presses the receiver.
		do
			create Result.share_from_pointer ({NS_BUTTON_CELL_API}.sound (item))
		end

	set_sound (a_sound: NS_SOUND)
			-- Sets the sound that`s played when the user presses the receiver.
		do
			{NS_BUTTON_CELL_API}.set_sound (item, a_sound.item)
		end

feature -- Handling Events and Action Messages

	mouse_entered (a_event: NS_EVENT)
			-- Draws the receiver`s border.
		do
			{NS_BUTTON_CELL_API}.mouse_entered (item, a_event.item)
		end

	mouse_exited (a_event: NS_EVENT)
			-- Erases the receiver`s border.
		do
			{NS_BUTTON_CELL_API}.mouse_exited (item, a_event.item)
		end

	perform_click (a_sender: NS_OBJECT)
			-- Simulates the user clicking the receiver with the cursor.
		do
			{NS_BUTTON_CELL_API}.perform_click (item, a_sender.item)
		end

feature -- Drawing the Button Content

	draw_bezel (a_frame: NS_RECT; a_control_view: NS_VIEW)
			-- Draws the border of the button using the current bezel style.
		do
			{NS_BUTTON_CELL_API}.draw_bezel_with_frame_in_view (item, a_frame.item, a_control_view.item)
		end

	draw_image (a_image: NS_IMAGE; a_frame: NS_RECT; a_control_view: NS_VIEW)
			-- Draws the image associated with the button`s current state.
		do
			{NS_BUTTON_CELL_API}.draw_image_with_frame_in_view (item, a_image.item, a_frame.item, a_control_view.item)
		end

	draw_title (a_title: NS_ATTRIBUTED_STRING; a_frame: NS_RECT; a_control_view: NS_VIEW): NS_RECT
			-- Draws the button`s title centered vertically in a specified rectangle.
			-- Returns the bounding rectangle of the text
		do
			create Result.make
			{NS_BUTTON_CELL_API}.draw_title_with_frame_in_view (item, a_title.item, a_frame.item, a_control_view.item, Result.item)
		end

feature -- Contract support

	valid_bezel_style (a_natural: NATURAL): BOOLEAN
		do
			Result := (<<rounded_bezel_style, regular_square_bezel_style, thick_square_bezel_style, thicker_square_bezel_style,
				disclosure_bezel_style, shadowless_square_bezel_style, circular_bezel_style, textured_square_bezel_style,
				help_button_bezel_style, small_square_bezel_style, textured_rounded_bezel_style, rounded_rect_bezel_style,
				recessed_bezel_style, rounded_disclosure_bezel_style>>).has (a_natural)
		end

feature -- NSBezelStyle Constants

	frozen rounded_bezel_style: NATURAL
			-- A rounded rectangle button, designed for text.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundedBezelStyle"
		end

	frozen regular_square_bezel_style: NATURAL
			-- A rectangular button with a 2 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRegularSquareBezelStyle"
		end

	frozen thick_square_bezel_style: NATURAL
			-- A rectangular button with a 3 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSThickSquareBezelStyle"
		end

	frozen thicker_square_bezel_style: NATURAL
			-- A rectangular button with a 4 point border, designed for icons.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSThickerSquareBezelStyle"
		end

	frozen disclosure_bezel_style: NATURAL
			-- A bezel style for use with a disclosure triangle.
			-- To create the disclosure triangle, set the button bezel style to NSDisclosureBezelStyle and the button type to NSOnOffButton.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDisclosureBezelStyle"
		end

	frozen shadowless_square_bezel_style: NATURAL
			-- Similar to NSRegularSquareBezelStyle, but has no shadow so you can abut the cells without overlapping shadows.
			-- This style would be used in a tool palette, for example.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSShadowlessSquareBezelStyle"
		end

	frozen circular_bezel_style: NATURAL
			-- A round button with room for a small icon or a single character.
			-- This style has both regular and small variants, but the large variant is available only in gray at this time.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSCircularBezelStyle"
		end

	frozen textured_square_bezel_style: NATURAL
			-- A bezel style appropriate for use with textured (metal) windows.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTexturedSquareBezelStyle"
		end

	frozen help_button_bezel_style: NATURAL
			-- A round button with a question mark providing the standard help button look.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSHelpButtonBezelStyle"
		end

	frozen small_square_bezel_style: NATURAL
			-- A simple square bezel style. Buttons using this style can be scaled to any size.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSSmallSquareBezelStyle"
		end

	frozen textured_rounded_bezel_style: NATURAL
			-- A textured (metal) bezel style similar in appearance to the Finder's action (gear) button.
			-- The height of this button is fixed.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTexturedRoundedBezelStyle"
		end

	frozen rounded_rect_bezel_style: NATURAL
			-- A bezel style that matches the search buttons in Finder and Mail.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundRectBezelStyle"
		end

	frozen recessed_bezel_style: NATURAL
			-- A bezel style that matches the recessed buttons in Mail, Finder and Safari.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRecessedBezelStyle"
		end

	frozen rounded_disclosure_bezel_style: NATURAL
			-- A bezel style that matches the disclosure style used in the standard Save panel.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRoundedDisclosureBezelStyle"
		end
end
