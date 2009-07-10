note
	description: "Summary description for {NS_CELL_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CELL_API

feature -- Initialization

	frozen init_text_cell (a_cell: POINTER; a_string: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell initTextCell: $a_string];"
		end

	frozen init_image_cell (a_cell: POINTER; a_image: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell initImageCell: $a_image];"
		end

feature -- Managing Cell Values

--	frozen object_value (a_cell: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSCell*)$a_cell objectValue];"
--		end

--	frozen set_object_value (a_cell: POINTER; a_obj: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSCell*)$a_cell setObjectValue: $a_obj];"
--		end

	frozen has_valid_object_value (a_cell: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell hasValidObjectValue];"
		end

	frozen string_value (a_cell: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell stringValue];"
		end

	frozen set_string_value (a_cell: POINTER; a_string: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setStringValue: $a_string];"
		end

	frozen int_value (a_cell: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell intValue];"
		end

	frozen set_int_value (a_cell: POINTER; a_an_int: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setIntValue: $a_an_int];"
		end

	frozen float_value (a_cell: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell floatValue];"
		end

	frozen set_float_value (a_cell: POINTER; a_float: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setFloatValue: $a_float];"
		end

	frozen double_value (a_cell: POINTER): REAL_64
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell doubleValue];"
		end

	frozen set_double_value (a_cell: POINTER; a_double: REAL_64)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setDoubleValue: $a_double];"
		end

feature -- Managing Cell Attributes

feature -- Managing Display Attributes

feature -- Managing Cell State

	frozen set_state (a_cell: POINTER; a_state: INTEGER)
			-- - (void)setState:(NSInteger)value
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setState: $a_state];"
		end

feature -- Modifying Textual Attributes

	frozen set_line_break_mode (a_cell: POINTER; a_mode: INTEGER)
			-- - (void)setLineBreakMode:(NSLineBreakMode)mode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setLineBreakMode: $a_mode];"
		end

	frozen set_wraps (a_cell: POINTER; a_flag: BOOLEAN)
			-- - (void)setWraps:(BOOL)flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setWraps: $a_flag];"
		end

	frozen wraps (a_cell: POINTER): BOOLEAN
			-- - (BOOL)wraps
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell wraps];"
		end

feature -- Managing the Target and Action

feature -- Managing the Image

feature -- Managing the Tag

feature -- Formatting and Validating Data

feature -- Managing Menus

feature -- Comparing Cells

feature -- Respond to Keyboard Events

feature -- Deriving Values

feature -- Representing an Object

feature -- Tracking the Mouse

feature -- Hit Testing

feature -- Managing the Cursor

feature -- Handling Keyboard Alternatives

feature -- Managing Focus Rings

feature -- Determining Cell Size

feature -- Drawing and Highlighting

	frozen draw_with_frame_in_view (a_cell: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- - (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell drawWithFrame: *(NSRect*)$a_cell_frame inView: $a_control_view];"
		end

	frozen set_highlighted (a_cell: POINTER; a_flag: BOOLEAN)
			-- - (void)setHighlighted:(BOOL)flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setHighlighted: $a_flag];"
		end

feature -- Editing and Selecting Text

feature -- Managing Expansion Frames



--	frozen compare (a_cell: POINTER; a_other_cell: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSCell*)$a_cell compare: $a_other_cell];"
--		end

	frozen title (a_cell: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSCell*)$a_cell title];"
		end

	frozen set_title (a_cell: POINTER; a_string: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSCell*)$a_cell setTitle: $a_string];"
		end

end
