note
	description: "Summary description for {NS_TEXT_FIELD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_FIELD

inherit
	NS_CONTROL

create
	new

feature

	new
			--
		do
			cocoa_object := text_field_new
		end

	set_background_color (a_color: NS_COLOR)
		do
			text_field_set_background_color (cocoa_object, a_color.cocoa_object)
		end

	set_bezel_style (a_style: INTEGER)
		do
			text_field_set_bezel_style (cocoa_object, a_style)
		end

	set_bordered (a_flag: BOOLEAN)
		do
			text_field_set_bordered (cocoa_object, a_flag)
		end

	set_draws_background (a_flag: BOOLEAN)
		do
			text_field_set_draws_background (cocoa_object, a_flag)
		end

	set_editable (a_flag: BOOLEAN)
			--
		do
			text_field_set_editable (cocoa_object, a_flag)
		end

feature {NONE} -- Objective-C implementation

	frozen text_field_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTextField new];"
		end

	frozen text_field_set_background_color (a_text_field: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setBackgroundColor: $a_color];"
		end

	frozen text_field_set_bezel_style (a_text_field: POINTER; a_style: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setBezelStyle: $a_style];"
		end

	frozen text_field_set_bordered (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setBordered: $a_flag];"
		end

	frozen text_field_set_draws_background (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setDrawsBackground: $a_flag];"
		end

	frozen text_field_set_editable (a_text_field: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field setEditable: $a_flag];"
		end

feature -- NSTextFieldBezelStyle constants

	frozen square_bezel: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSTextFieldSquareBezel;"
		end

	frozen rounded_bezel: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSTextFieldSquareBezel;"
		end
end
