indexing
	description: "EiffelVision label widget. Displays a text on%
				  % only one line. Mswindows implementation";
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LABEL_IMP

inherit
	EV_LABEL_I

	EV_PRIMITIVE_IMP
		undefine
			on_key_down
		redefine
			plateform_build
		end

	EV_BAR_ITEM_IMP

	EV_TEXTABLE_IMP
		redefine
			set_default_size,
			set_center_alignment,
			set_right_alignment,
			set_left_alignment
		end

	EV_FONTABLE_IMP

	WEL_STATIC
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			set_text as wel_set_text,
			destroy as wel_destroy
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up
		redefine
			default_style,
			wel_background_color,
			wel_foreground_color
		end

creation
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty label.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create the label with `txt' as label.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				par_imp /= Void
			end
			wel_make (par_imp, txt, 0, 0, 0, 0, 0)
		end

	plateform_build (par: EV_CONTAINER_IMP) is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			{EV_PRIMITIVE_IMP} Precursor (par)
			set_font (font)
			set_default_size
		end

feature -- Status setting

	set_center_alignment is
			-- Set text alignment of current label to center.
		do
			set_style (basic_style + Ss_center)
		end

	set_right_alignment is
			-- Set text alignment of current label to right.
		do
			set_style (basic_style + Ss_right)
		end

	set_left_alignment is
			-- Set text alignment of current label to left.
		do
			set_Style (basic_style + Ss_left)
		end

feature {NONE} -- Basic operation

	set_default_size is
		-- Resize to a default size.
		local
			fw: EV_FONT_IMP
		do
			fw ?= font.implementation
			check
				font_not_void: fw /= Void
			end
			set_minimum_width (fw.string_width (Current, text) + Extra_width)
			set_minimum_height (7 * fw.string_height (Current, text) // 4 - 2)
		end

	Extra_width: INTEGER is 10

feature {NONE} -- Implementation

	basic_style: INTEGER is
			-- Basic style without any option
		do
			Result := Ws_visible + Ws_child + Ws_group
		end

   	default_style: INTEGER is
   			-- Default style used to create the control
   		do
 			Result := basic_style + Ss_left
 		end

	wel_background_color: WEL_COLOR_REF is
		do
			Result := background_color_imp
		end

	wel_foreground_color: WEL_COLOR_REF is
		do
			Result := foreground_color_imp
		end

feature {NONE} -- Inapplicable

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

end -- class EV_LABEL_IMP

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
