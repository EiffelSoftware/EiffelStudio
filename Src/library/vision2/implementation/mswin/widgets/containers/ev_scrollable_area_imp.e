indexing
	description: "EiffelVision scrollable area. %
				% Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit

	EV_SCROLLABLE_AREA_I

	EV_CONTAINER_IMP

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent
		undefine
				-- We undefine the features refined by EV_CONTAINER_IMP
			set_width,
			set_height,
			remove_command,
			destroy,
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
			default_style
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			par_imp: EV_CONTAINER_IMP
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void 
			end
			wel_make (par_imp, "Scrollable Area")
		end

feature {NONE} -- Implementation : WEL features

	default_style: INTEGER is
		once
			Result := {WEL_CONTROL_WINDOW} Precursor
				+ Ws_clipchildren + Ws_clipsiblings
				+ Ws_hscroll + Ws_vscroll
		end

end -- class EV_SCROLLABLE_AREA_IMP

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
