indexing
	description: "EiffelVision drawing attributes."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING_ATTRIBUTES

feature -- Status report 

	background_color: EV_COLOR
			-- background color of current figure

	foreground_color: EV_COLOR
			-- Foreground color of current figure

	logical_function_mode: INTEGER
			-- Logical function to be used in Graphic Context.

	line_width: INTEGER
			-- width of line of current figure

feature -- Status setting

	set_line_width (a_line_width: INTEGER) is
			-- Set `line_width' of current figure to `a_line_width'.
		require
			a_line_width_positive: a_line_width >= 0
		do
			line_width := a_line_width
		ensure
			line_width = a_line_width
		end

	set_background_color (a_color: EV_COLOR) is
			-- Set `background_color' to `a_color'.
		do
			background_color := a_color
		ensure
			background_color = a_color
		end


	set_foreground_color (a_color: EV_COLOR) is
			-- Set `foreground_color' to `a_color'.
		require
			color_not_void: a_color /= Void
		do
			foreground_color := a_color
		end

	set_and_inverted_mode is
			-- Set drawing logical function to
			-- (NOT source) AND destination.
		do
			logical_function_mode := GXandInverted
		end

	set_and_mode is
			-- Set drawing logical function to
			-- source AND destination
		do
			logical_function_mode := GXand
		end

	set_and_reverse_mode is
			-- Set drawing logical function to
			-- source AND (NOT destination)
		do
			logical_function_mode := GXandReverse
		end

	set_clear_mode is
			-- Set drawing logical function to
			-- 0.
		do
			logical_function_mode := GXclear
		end

	set_copy_inverted_mode is
			-- Set drawing logical function to
			-- (NOT source).
		do
			logical_function_mode := GXcopyInverted
		end

	set_copy_mode is
			-- Set drawing logical function to
			-- source.
		do
			logical_function_mode := GXcopy
		end

	set_equiv_mode is
			-- Set drawing logical function to
			-- (NOT source) XOR destination.
		do
			logical_function_mode := GXequiv
		end

	set_invert_mode is
			-- Set drawing logical function to
			-- (NOT destination).
		do
			logical_function_mode := GXinvert
		end

	set_nand_mode is
			-- Set drawing logical function to
			-- (NOT source) OR (NOT destination).
		do
			logical_function_mode := GXnand
		end

	set_no_op_mode is
			-- Set drawing logical function to
			-- destination.
		do
			logical_function_mode := GXnoop
		end

	set_nor_mode is
			-- Set drawing logical function to
			-- (NOT source) AND (NOT destination).
		do
			logical_function_mode := GXnor
		end

	set_one_mode is
			-- Set drawing logical function to
			-- 1.
		do
			logical_function_mode := GXset
		end

	set_or_inverted_mode is
			-- Set drawing logical function to
			-- (NOT source) OR destination.
		do
			logical_function_mode := GXorInverted
		end

	set_or_mode is
			-- Set drawing logical function to
			-- source OR destination.
		do
			logical_function_mode := GXor
		end

	set_or_reverse_mode is
			-- Set drawing logical function to
			-- source OR (NOT destination).
		do
			logical_function_mode := GXorReverse
		end

	set_xor_mode is
			-- Set drawing logical function to
			-- source XOR destination.
		do
			logical_function_mode := GXxor
		end

feature {NONE} -- Access

	GXand: INTEGER is 1
			-- X code to define logical function
			-- source AND destination for drawing

	GXandInverted: INTEGER is 4
			-- X code to define logical function
			-- (NOTsource) AND destination for drawing

	GXandReverse: INTEGER is 2
			-- X code to define logical function
			-- source AND (NOTdestination) for drawing

	GXclear: INTEGER is 0
			-- X code to clear drawing

	GXcopy: INTEGER is 3
			-- X code to define logical function
			-- source  for drawing

	GXcopyInverted: INTEGER is 12
			-- X code to define logical function
			-- (NOTsource) for drawing

	GXequiv: INTEGER is 9
			-- X code to define logical function
			-- (NOTsource) XOR destination for drawing

	GXinvert: INTEGER is 10
			-- X code to define logical function
			-- (NOTdestination) for drawing

	GXnand: INTEGER is 14
			-- X code to define logical function
			-- (NOTsource OR NOTdestination) for drawing

	GXnoop: INTEGER is 5
			-- X code to define logical function
			-- destination for drawing

	GXnor: INTEGER is 8
			-- X code to define logical function
			-- (NOTsource) AND (NOTdestination) for drawing

	GXor: INTEGER is 7
			-- X code to define logical function
			-- source OR destination for drawing

	GXorInverted: INTEGER is 13
			-- X code to define logical function
			-- (NOTsource) OR destination for drawing

	GXorReverse: INTEGER is 11
			-- X code to define logical function
			-- source OR NOT (destination) for drawing

	GXset: INTEGER is 15
			-- X code to define logical function
			-- to set drawing

	GXxor: INTEGER is 6
			-- X code to define logical function
			-- source XOR destination for drawing

end -- class EV_DRAWING_ATTRIBUTES

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

