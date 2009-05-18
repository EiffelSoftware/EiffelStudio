note
	description: "Summary description for {NS_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BOX

inherit
	NS_VIEW
		redefine
			new
		end

create
	new

feature -- Box

	new
			-- Create the window.
		do
			cocoa_object := box_new
		end

	content_view: NS_VIEW
		do
			create Result.make_shared (box_content_view (cocoa_object))
		end

	set_border_type (a_border_type: INTEGER)
		require
			a_border_type = no_border or
			a_border_type = line_border or
			a_border_type = bezel_border or
			a_border_type = groove_border
		do
			box_set_border_type (cocoa_object, a_border_type)
		end

	set_border_width (a_border_width: REAL)
		do
			box_set_border_width (cocoa_object, a_border_width)
		end

	set_box_type (a_box_type: INTEGER)
		do
			box_set_box_type (cocoa_object, a_box_type)
		end

	set_content_view_margins (a_width, a_height: REAL)
		do
			box_set_content_view_margins (cocoa_object, a_width, a_height)
		end

	set_fill_color (a_color: NS_COLOR)
		do
			box_set_fill_color (cocoa_object, a_color.cocoa_object)
		end

	set_title (a_string: STRING_GENERAL)
		do
			box_set_title (cocoa_object, (create {NS_STRING}.make_with_string (a_string)).cocoa_object)
		end

	set_title_position (a_position: INTEGER)
		do
			box_set_title_position (cocoa_object, a_position)
		end

feature {NONE} -- Objective-C implementation

	frozen box_new: POINTER
			-- Create a new NSBox
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBox new];"
		end

	frozen box_content_view (a_box: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBox*)$a_box contentView];"
		end

	frozen box_set_border_type (a_box: POINTER; a_border_type: INTEGER)
			-- Sets the border type
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setBorderType: $a_border_type];"
		end

	frozen box_set_border_width (a_box: POINTER; a_border_width: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setBorderWidth: $a_border_width];"
		end

	frozen box_set_content_view (a_box: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setContentView: $a_view];"
		end

	frozen box_set_content_view_margins (a_box: POINTER; a_width, a_height: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setContentViewMargins: NSMakeSize($a_width, $a_height)];"
		end

	frozen box_set_corner_radius (a_box: POINTER; a_corner_radius: REAL)
			-- Specifies the receiver's corner radius.
			-- Functional only when the receiver's box type is NSBoxCustom and its boder type is NSLineBorder
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setCornerRadius: $a_corner_radius];"
		end

	frozen box_set_fill_color (a_box: POINTER; a_fill_color: POINTER)
			-- Works only in custom mode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setFillColor: $a_fill_color];"
		end

	frozen box_set_title (a_box: POINTER; a_nsstring: POINTER)
			-- Sets the position of the box's title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setTitle: $a_nsstring];"
		end

	frozen box_set_title_position (a_box: POINTER; a_position: INTEGER)
			-- Sets the position of the box's title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setTitlePosition: $a_position];"
		end

	frozen box_set_box_type (a_box: POINTER; a_box_type: INTEGER)
			-- Sets the box type
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBox*)$a_box setBoxType: $a_box_type];"
		end

feature -- NSTitlePosition constants

	frozen no_title : INTEGER
			-- The box has no title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSNoTitle;"
		end

	frozen above_top : INTEGER
			-- Title positioned above the box's top border
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSAboveTop;"
		end

	frozen at_top : INTEGER
			-- Title positioned within the box's top border
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSAtTop;"
		end

	frozen below_top : INTEGER
			-- Title positioned below the box's top border
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSBelowTop;"
		end


	frozen above_bottom : INTEGER
			-- Title positioned above the box's bottom border
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSAboveTop;"
		end

	frozen at_bottom : INTEGER
			-- Title positioned within the box's bottom border
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSAtTop;"
		end

	frozen below_bottom : INTEGER
			-- Title positioned below the box's bottom border
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSBelowTop;"
		end

feature -- NSBorderType constants

	frozen no_border : INTEGER
			-- Sets the position of the box's title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSNoBorder;"
		end

	frozen line_border : INTEGER
			-- Sets the position of the box's title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSLineBorder;"
		end

	frozen bezel_border : INTEGER
			-- Sets the position of the box's title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSBezelBorder;"
		end

	frozen groove_border : INTEGER
			-- Sets the position of the box's title
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSGrooveBorder;"
		end

feature -- NSBoxType constants

	frozen box_primary : INTEGER
			-- Specifies the primary box apparance. This is the default box type.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSBoxPrimary;"
		end

	frozen box_secondary : INTEGER
			--
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSBoxSecondary;"
		end

	frozen box_separator : INTEGER
			-- Specifies that the box is a spearator
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSBoxSeparator"
		end

	frozen box_custom : INTEGER
			-- Specifies that the apparance of the box is determined entirely by the box-configuration methods, without automatically applying Apple human interface guidelines.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSBoxCustom"
		end
end
