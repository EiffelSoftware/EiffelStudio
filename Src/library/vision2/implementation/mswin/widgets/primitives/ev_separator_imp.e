indexing 
	description: "EiffelVision horizontal separator,%
			% windows implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_SEPARATOR_IMP

inherit
	EV_SEPARATOR_I

	EV_PRIMITIVE_IMP
		undefine
			build,
			on_key_down
		end

	EV_SYSTEM_PEN_IMP

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			destroy as wel_destroy
		undefine
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_char,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_paint
		redefine
			background_brush
		end

feature {NONE} -- Initialization

 	make (par: EV_CONTAINER) is
 			-- Make seperator
		local
			par_imp: WEL_COMPOSITE_WINDOW
		do
			par_imp ?= par.implementation
			make_with_coordinates (par_imp, "Separator", 0, 0, 2, 0)
 		end

feature {NONE} -- Implementation

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
			if background_color /= Void then
				!! Result.make_solid (background_color_imp)
			end
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

end -- class EV_SEPARATOR_IMP

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
