indexing
	description: "EiffelVision drawing attributes."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING_ATTRIBUTES

feature -- Status report 

	background_color: EV_COLOR

	foreground_color: EV_COLOR

	logical_function_mode: INTEGER

feature {EV_FIGURE} -- Element change

	get_drawing_attributes (drawing: EV_DRAWABLE) is do end

	set_drawing_attributes (drawing: EV_DRAWABLE) is do end

feature -- Status setting

	set_background_color (a_color: EV_COLOR) is do end

	set_foreground_color (a_color: EV_COLOR) is do end

	set_and_inverted_mode is do end

	set_and_mode is do end

	set_and_reverse_mode is do end

	set_clear_mode is do end

	set_copy_inverted_mode is do end

	set_copy_mode is do end

	set_equiv_mode is do end

	set_invert_mode is do end

	set_nand_mode is do end

	set_no_op_mode is do end

	set_nor_mode is do end

	set_one_mode is do end

	set_or_inverted_mode is do end

	set_or_mode is do end

	set_or_reverse_mode is do end

	set_xor_mode is do end

feature {NONE} -- Access

	GXand: INTEGER is 1

	GXandInverted: INTEGER is 4

	GXandReverse: INTEGER is 2

	GXclear: INTEGER is 0

	GXcopy: INTEGER is 3

	GXcopyInverted: INTEGER is 12

	GXequiv: INTEGER is 9

	GXinvert: INTEGER is 10

	GXnand: INTEGER is 14

	GXnoop: INTEGER is 5

	GXnor: INTEGER is 8

	GXor: INTEGER is 7

	GXorInverted: INTEGER is 13

	GXorReverse: INTEGER is 11

	GXset: INTEGER is 15

	GXxor: INTEGER is 6

end -- class EV_DRAWING_ATTRIBUTES
