note
	description: "Wrapper for NSCell."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CELL

inherit
	NS_OBJECT

create {NS_OBJECT}
	make_from_pointer

feature -- Initialization

	init_text_cell (a_string: NS_STRING)
		do
			{NS_CELL_API}.init_text_cell (item, a_string.item)
		end

	init_image_cell (a_image: NS_IMAGE)
		do
			{NS_CELL_API}.init_image_cell (item, a_image.item)
		end

feature -- Managing Cell Values

--	object_value: NS_OBJECT
--		do
--			Result := {NS_CELL_API}.object_value (cocoa_object)
--		end

--	set_object_value (a_obj: NS_COPYING)
--		do
--			{NS_CELL_API}.set_object_value (cocoa_object, a_obj)
--		end

	has_valid_object_value: BOOLEAN
		do
			Result := {NS_CELL_API}.has_valid_object_value (item)
		end

	string_value: NS_STRING
		do
			create Result.make_from_pointer ({NS_CELL_API}.string_value (item))
		end

	set_string_value (a_string: NS_STRING)
		do
			{NS_CELL_API}.set_string_value (item, a_string.item)
		end

	int_value: INTEGER
		do
			Result := {NS_CELL_API}.int_value (item)
		end

	set_int_value (a_an_int: INTEGER)
		do
			{NS_CELL_API}.set_int_value (item, a_an_int)
		end

	float_value: REAL
		do
			Result := {NS_CELL_API}.float_value (item)
		end

	set_float_value (a_float: REAL)
		do
			{NS_CELL_API}.set_float_value (item, a_float)
		end

	double_value: REAL_64
		do
			Result := {NS_CELL_API}.double_value (item)
		end

	set_double_value (a_double: REAL_64)
		do
			{NS_CELL_API}.set_double_value (item, a_double)
		end

feature -- Managing Cell Attributes

feature -- Managing Display Attributes

feature -- Managing Cell State

	set_state (a_state: INTEGER)
			-- Sets the receiver's state to the specified value.
		do
			{NS_CELL_API}.set_state (item, a_state)
		end

feature -- Modifying Textual Attributes

	set_line_break_mode (a_mode: INTEGER)
			-- Sets the line break mode to use when drawing text
			-- The line break mode can also be modified by calling the setWraps: method.
		require
			valid_mode:
		do
			{NS_CELL_API}.set_line_break_mode (item, a_mode)
		end

	set_wraps (a_flag: BOOLEAN)
			-- Sets whether text in the receiver wraps when its length exceeds the frame of the cell.
			-- If the text of the receiver is an attributed string value you must explicitly set the paragraph style line break mode.
			-- Calling this method with the value YES is equivalent to calling the setLineBreakMode: method with the value NSLineBreakByWordWrapping
		do
			{NS_CELL_API}.set_wraps (item, a_flag)
		ensure
			wraps_set: wraps = a_flag
		end

	wraps: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver wraps its text when the text exceeds the borders of the cell.
		do
			Result := {NS_CELL_API}.wraps (item)
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

	cell_size: NS_SIZE
			-- Returns the minimum size needed to display the receiver.
		do
			create Result.make
			{NS_CELL_API}.cell_size (item, Result.item)
		end

feature -- Drawing and Highlighting

	draw (a_cell_frame: NS_RECT; a_control_view: NS_VIEW)
			-- Draws the receiver's border and then draws the interior of the cell. 			
		do
			{NS_CELL_API}.draw_with_frame_in_view (item, a_cell_frame.item, a_control_view.item)
		end

	set_highlighted (a_flag: BOOLEAN)
			-- Sets whether the receiver has a highlighted appearance.
		do
			{NS_CELL_API}.set_highlighted (item, a_flag)
		end

feature -- Editing and Selecting Text

feature -- Managing Expansion Frames

--	compare (a_other_cell: NS_OBJECT): NS_COMPARISON_RESULT
--		do
--			Result := {NS_CELL_API}.compare (cocoa_object, a_other_cell)
--		end

	title: NS_STRING
			-- Returns the receiver's title.
		do
			create Result.make_from_pointer ({NS_CELL_API}.title (item))
		end

	set_title (a_string: NS_STRING)
			-- Sets the title of the receiver.
		do
			{NS_CELL_API}.set_title (item, a_string.item)
		end

feature -- Contract Suppoer



feature -- Cell States (NSCellStateValue)

	frozen mixed_state: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMixedState"
		end

	frozen off_state: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSOffState"
		end

	frozen on_state: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSOnState"
		end

feature -- Image Position

	frozen no_image: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSNoImage"
		end

	frozen image_only: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSImageOnly"
		end

	frozen image_left: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSImageLeft"
		end

	frozen image_right: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSImageRight"
		end

	frozen image_below: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSImageBelow"
		end

	frozen image_above: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSImageAbove"
		end
end
