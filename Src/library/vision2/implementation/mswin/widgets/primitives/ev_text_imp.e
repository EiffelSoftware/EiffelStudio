indexing
	description: "EiffelVision text area. %
				  %Mswindows implementation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_AREA_IMP

inherit
	EV_TEXT_AREA_I
		
	EV_TEXT_COMPONENT_IMP

	WEL_MULTIPLE_LINE_EDIT
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
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
			on_key_up,
			background_color,
			foreground_color
		redefine
			default_style
		end

creation

	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the label with an empty label.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create the label with `txt'.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				par_imp /= Void
			end
			wel_make (par_imp, txt, 0, 0, 0, 0, 0)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := {WEL_MULTIPLE_LINE_EDIT} Precursor
						+ Es_wantreturn
		end

end -- class EV_TEXT_AREA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
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
