note
	description: "Wrapper for NSBox"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BOX

inherit
	NS_VIEW
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
			-- Create a new NSBox.
		do
			make_from_pointer ({NS_BOX_API}.new)
		end

feature -- Box

	content_view: NS_VIEW
			-- Returns the receiver's content view.
			-- The content view is created automatically when the box is created and resized as the box is resized
			-- (you should never send frame-altering messages directly to a box's content view). You can replace it
			-- with an NSView of your own through the set_content_view method.
		do
			create Result.share_from_pointer ({NS_BOX_API}.content_view (item))
		ensure
			result_not_void: Result /= void
		end

	set_border_type (a_border_type: INTEGER)
			-- Sets the border type to aType, which must be a valid border type.
			-- If the size of the new border is different from that of the old border, the content view is
			-- resized to absorb the difference, and the box is marked for redisplay.
		require
			valid_border_type: valid_border_type (a_border_type)
		do
			{NS_BOX_API}.set_border_type (item, a_border_type)
		ensure
			border_type_set: a_border_type = border_type
		end

	border_type: INTEGER
			-- Returns the receiver's border type.
			-- By default, the border type of an NSBox is NSGrooveBorder.
		do
			Result := {NS_BOX_API}.border_type (item)
		ensure
			valid_border_type: valid_border_type (Result)
		end

	set_border_width (a_border_width: REAL)
			-- Specifies the receiver's border width.
			-- Functional only when the receiver's box type (box_type) is NSBoxCustom and its border type (border_type) is NSLineBorder.
		do
			{NS_BOX_API}.set_border_width (item, a_border_width)
		ensure
			border_width_set: -- TODO
		end

	set_box_type (a_box_type: INTEGER)
			-- Sets the box type.
		require
			valid_box_type: valid_box_type (a_box_type)
		do
			{NS_BOX_API}.set_box_type (item, a_box_type)
		ensure
			box_type_set: -- TODO
		end

	set_content_view_margins (a_width, a_height: REAL)
			-- Sets the horizontal and vertical distance between the border of the receiver and its content view.
			-- The width and height of the offset between the box's border and content view. The horizontal value
			-- is applied (reckoned in the box's coordinate system) fully and equally to the left and right sides
			-- of the box. The vertical value is similarly applied to the top and bottom.
			-- Unlike changing a box's other attributes, such as its title position or border type, changing the
			-- offsets doesn't automatically resize the content view. In general, you should send a sizeToFit
			-- message to the box after changing the size of its offsets. This message causes the content view to
			-- remain unchanged while the box is sized to fit around it.
		require
			-- Are negative values allowed? Probably not
		do
			{NS_BOX_API}.set_content_view_margins (item, a_width, a_height)
		ensure
			content_view_margins_set: -- TODO
		end

	set_fill_color (a_color: NS_COLOR)
			-- Specifies the receiver's fill color.
			-- Functional only when the receiver's box type (boxType) is NSBoxCustom and its border type (borderType) is NSLineBorder.
			-- TODO: should this be enforced by the contracts? Probably, but maybe it's okay to set the fill color first and then change those attributes
		do
			{NS_BOX_API}.set_fill_color (item, a_color.item)
		ensure
			fill_color_set: -- TODO
		end

	set_title (a_string: STRING_GENERAL)
			-- Sets the title of the box and marks the region of the receiver within the title rectangle as needing display.
			-- The new title of the NSBox. The default title of an NSBox is "Title." If the size of the new title is different
			-- from that of the old title, the content view is resized to absorb the difference.
		require
			-- can it be void/nil?
		do
			{NS_BOX_API}.set_title (item, (create {NS_STRING}.make_with_string (a_string)).item)
		ensure
			title_set: -- TODO
		end

	set_title_position (a_position: INTEGER)
			-- Sets the position of the box's title.
			-- Takes a constant describing the position of the box's title. The default position is at_top.
		require
			valid_position: valid_position (a_position)
		do
			{NS_BOX_API}.set_title_position (item, a_position)
		ensure
			position_set: title_position = a_position
		end

	title_position: INTEGER
			-- Returns a constant representing the title position.
		do
			Result := {NS_BOX_API}.title_position (item)
		ensure
			valid_position: valid_position (Result)
		end

feature -- Contract support

	valid_position (a_integer: INTEGER): BOOLEAN
			-- Verifies if `a_integer' is a valid position constant
		do
			Result := (<<no_title, above_top, at_top, below_top, above_bottom, at_bottom, below_bottom>>).has(a_integer)
		end

	valid_border_type (a_integer: INTEGER): BOOLEAN
			-- Verifies if `a_integer' is a valid border-type constant
		do
			Result := (<<no_border, line_border, bezel_border, groove_border>>).has(a_integer)
		end

	valid_box_type (a_integer: INTEGER): BOOLEAN
			-- Verifies if `a_integer' is a valid box-type constant
		do
			Result := (<<box_primary, box_secondary, box_separator, box_custom>>).has(a_integer)
		end

feature -- NSTitlePosition constants

	frozen no_title : INTEGER
			-- The box has no title
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSNoTitle"
		end

	frozen above_top : INTEGER
			-- Title positioned above the box's top border
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSAboveTop"
		end

	frozen at_top : INTEGER
			-- Title positioned within the box's top border
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSAtTop"
		end

	frozen below_top : INTEGER
			-- Title positioned below the box's top border
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBelowTop"
		end


	frozen above_bottom : INTEGER
			-- Title positioned above the box's bottom border
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSAboveTop"
		end

	frozen at_bottom : INTEGER
			-- Title positioned within the box's bottom border
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSAtTop"
		end

	frozen below_bottom : INTEGER
			-- Title positioned below the box's bottom border
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBelowTop"
		end

feature -- NSBorderType constants

	frozen no_border : INTEGER
			-- No border.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSNoBorder"
		end

	frozen line_border : INTEGER
			-- A black line border around the view.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSLineBorder"
		end

	frozen bezel_border : INTEGER
			-- A concave border that makes the view look sunken.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBezelBorder"
		end

	frozen groove_border : INTEGER
			-- A thin border that looks etched around the image.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSGrooveBorder"
		end

feature -- NSBoxType constants

	frozen box_primary : INTEGER
			-- Specifies the primary box apparance. This is the default box type.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBoxPrimary"
		end

	frozen box_secondary : INTEGER
			--
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBoxSecondary"
		end

	frozen box_separator : INTEGER
			-- Specifies that the box is a spearator
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBoxSeparator"
		end

	frozen box_custom : INTEGER
			-- Specifies that the apparance of the box is determined entirely by the box-configuration methods, without automatically applying Apple human interface guidelines.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBoxCustom"
		end
end
